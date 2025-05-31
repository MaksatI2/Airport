package airport.controller;

import airport.dto.CreateFlightDTO;
import airport.service.AirplaneService;
import airport.service.DestinationService;
import airport.service.FlightService;
import airport.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/airline")
@RequiredArgsConstructor
public class AirlineController {

    private final FlightService flightService;
    private final DestinationService destinationService;
    private final AirplaneService airplaneService;
    private final UserService userService;


    @GetMapping("/flights/create")
    public String showCreateFlightForm(Model model) {
        model.addAttribute("flight", new CreateFlightDTO());
        model.addAttribute("destinations", destinationService.getAllAirports());
        model.addAttribute("airplanes", airplaneService.getAvailableAirplanes());
        return "airlines/create";
    }

    @PostMapping("/flights/create")
    public String createFlight(@Valid @ModelAttribute("flight") CreateFlightDTO flightDTO,
                               BindingResult result,
                               Model model,
                               RedirectAttributes redirectAttributes) {

        if (flightDTO.getDepartureTime() != null && flightDTO.getArrivalTime() != null) {
            if (!flightDTO.getArrivalTime().isAfter(flightDTO.getDepartureTime())) {
                result.rejectValue("arrivalTime", "error.arrivalTime", "Время прилета должно быть позже времени вылета");
            }
        }

        if (result.hasErrors()) {
            model.addAttribute("destinations", destinationService.getAllAirports());
            model.addAttribute("airplanes", airplaneService.getAvailableAirplanes());
            return "airlines/create";
        }

        try {
            flightService.createFlight(flightDTO);
            redirectAttributes.addFlashAttribute("successMessage", "Рейс успешно создан!");
            return "redirect:/profile";
        } catch (IllegalArgumentException e) {
            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("destinations", destinationService.getAllAirports());
            model.addAttribute("airplanes", airplaneService.getAvailableAirplanes());
            return "airlines/create";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Ошибка при создании рейса: " + e.getMessage());
            model.addAttribute("destinations", destinationService.getAllAirports());
            model.addAttribute("airplanes", airplaneService.getAvailableAirplanes());
            return "airlines/create";
        }
    }

}
