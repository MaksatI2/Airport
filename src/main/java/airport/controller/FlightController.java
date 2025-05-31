package airport.controller;

import airport.dto.FlightDTO;
import airport.service.BookingService;
import airport.service.FlightService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/flights")
@RequiredArgsConstructor
public class FlightController {

    private final FlightService flightService;
    private final BookingService bookingService;
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

    @GetMapping("/airline/{id}")
    public String showAirlineFlights(
            @PathVariable Long id,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size,
            Model model) {

        Pageable pageable = PageRequest.of(page - 1, size);
        Page<FlightDTO> flightsPage = flightService.getFlightsByAirlineId(id, pageable);

        Map<String, Integer> totalSeatsMap = new HashMap<>();
        Map<String, Integer> bookedSeatsMap = new HashMap<>();

        for (FlightDTO flight : flightsPage.getContent()) {
            String flightIdStr = flight.getId().toString();

            int totalSeats = flightService.getTotalSeatsByFlightId(flight.getId());
            totalSeatsMap.put(flightIdStr, totalSeats);

            int bookedSeats = bookingService.getBookedSeatsByFlightId(flight.getId());
            bookedSeatsMap.put(flightIdStr, bookedSeats);
        }

        model.addAttribute("flights", flightsPage.getContent());
        model.addAttribute("totalSeatsMap", totalSeatsMap);
        model.addAttribute("bookedSeatsMap", bookedSeatsMap);
        model.addAttribute("title", "Рейсы авиакомпании");
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", flightsPage.getTotalPages());
        model.addAttribute("totalItems", flightsPage.getTotalElements());
        model.addAttribute("pageSize", size);

        return "airlines/flights";
    }
}
