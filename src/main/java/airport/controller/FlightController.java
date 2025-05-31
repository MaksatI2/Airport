package airport.controller;

import airport.dto.FlightDTO;
import airport.service.FlightService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

@Controller
@RequestMapping("/flights")
@RequiredArgsConstructor
public class FlightController {

    private final FlightService flightService;
    private static final int DEFAULT_PAGE_SIZE = 10;

    @GetMapping("/search")
    public String searchFlights(
            @RequestParam(required = false) Long from,
            @RequestParam(required = false) Long to,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "price") String sortBy,
            @RequestParam(defaultValue = "asc") String direction,
            Model model) {

        List<FlightDTO> flights;
        int totalFlights = 0;

        try {
            if (from == null || to == null) {
                model.addAttribute("error", "Пожалуйста, выберите города отправления и назначения");
                return "search-result";
            }

            Sort.Direction sortDirection = direction.equalsIgnoreCase("desc") ? Sort.Direction.DESC : Sort.Direction.ASC;
            Pageable pageable = PageRequest.of(page - 1, DEFAULT_PAGE_SIZE, Sort.by(sortDirection, sortBy));

            Page<FlightDTO> flightPage;

            if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
                LocalDate start = LocalDate.parse(startDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                LocalDate end = LocalDate.parse(endDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

                if (end.isBefore(start)) {
                    model.addAttribute("error", "Дата окончания не может быть раньше даты начала");
                    return "search-result";
                }

                flightPage = flightService.findFlightsByCitiesAndDateRange(from, to, start, end, pageable);
                model.addAttribute("searchType", "range");
                model.addAttribute("startDate", start.format(DateTimeFormatter.ofPattern("dd.MM.yyyy")));
                model.addAttribute("endDate", end.format(DateTimeFormatter.ofPattern("dd.MM.yyyy")));

            } else if (startDate != null && !startDate.isEmpty()) {
                LocalDate date = LocalDate.parse(startDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                flightPage = flightService.findFlightsByCitiesAndDate(from, to, date, pageable);
                model.addAttribute("searchType", "single");
                model.addAttribute("searchDate", date.format(DateTimeFormatter.ofPattern("dd.MM.yyyy")));

            } else {
                flightPage = flightService.findFlightsByCities(from, to, pageable);
                model.addAttribute("searchType", "all");
            }

            flights = flightPage.getContent();
            totalFlights = (int) flightPage.getTotalElements();

            model.addAttribute("flights", flights);
            model.addAttribute("flightCount", totalFlights);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", flightPage.getTotalPages());
            model.addAttribute("sortBy", sortBy);
            model.addAttribute("direction", direction);

            model.addAttribute("fromId", from);
            model.addAttribute("toId", to);

        } catch (DateTimeParseException e) {
            model.addAttribute("error", "Неверный формат даты");
            return "search-result";
        } catch (Exception e) {
            model.addAttribute("error", "Произошла ошибка при поиске рейсов: " + e.getMessage());
            return "search-result";
        }

        return "search-result";
    }
}
