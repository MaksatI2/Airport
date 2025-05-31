package airport.controller;

import airport.dto.FlightDTO;
import airport.dto.UserDTO;
import airport.exception.UserNotFoundException;
import airport.model.AccountType;
import airport.service.FlightService;
import airport.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

    private final UserService userService;
    private final FlightService flightService;

    @GetMapping("/airlines")
    public String showAirlines(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size,
            Model model) {

        Pageable pageable = PageRequest.of(page - 1, size);
        Page<UserDTO> airlinePage = userService.getAllUsersByAccountType(AccountType.AIRLINE, pageable);

        List<UserDTO> airlines = airlinePage.getContent();

        for (UserDTO airline : airlines) {
            Page<FlightDTO> flights = flightService.getFlightsByAirlineId(airline.getId(), pageable);
            airline.setFlightCount(flights.getContent().size());
        }

        model.addAttribute("airlines", airlines);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", airlinePage.getTotalPages());
        model.addAttribute("totalItems", airlinePage.getTotalElements());
        model.addAttribute("pageSize", size);

        return "admin/airlines";
    }

    @GetMapping("/airlines/create")
    public String showCreateAirlineForm(Model model) {
        UserDTO airline = new UserDTO();
        airline.setAccountType(AccountType.AIRLINE);
        model.addAttribute("airline", airline);
        return "admin/create-airline";
    }

    @PostMapping("/airlines/create")
    public String createAirline(@Valid @ModelAttribute("airline") UserDTO airlineDTO,
                                BindingResult result,
                                Model model,
                                RedirectAttributes redirectAttributes) {

        if (result.hasErrors()) {
            return "admin/create-airline";
        }

        try {
            airlineDTO.setAccountType(AccountType.AIRLINE);
            airlineDTO.setEnabled(true);

            userService.registerUser(airlineDTO);
            redirectAttributes.addFlashAttribute("successMessage", "Авиакомпания успешно создана!");
            return "redirect:/admin/airlines";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Ошибка при создании авиакомпании: " + e.getMessage());
            return "admin/create-airline";
        }
    }

    @GetMapping("/airlines/{id}/toggle-status")
    public String toggleAirlineStatus(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            userService.toggleUserStatus(id);
            redirectAttributes.addFlashAttribute("successMessage", "Статус авиакомпании изменен!");
        } catch (UserNotFoundException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Ошибка: " + e.getMessage());
        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Ошибка: " + e.getMessage());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Произошла непредвиденная ошибка");
        }
        return "redirect:/admin/airlines";
    }
}