package airport.controller;

import airport.dto.BookingDTO;
import airport.dto.CreateBookingRequest;
import airport.dto.FlightSeatMapDTO;
import airport.model.User;
import airport.service.BookingService;
import airport.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/bookings")
@RequiredArgsConstructor
public class BookingController {

    private final BookingService bookingService;
    private final UserService userService;

    @GetMapping
    public String getUserBookings(Principal principal, Model model) {
        List<BookingDTO> bookings = bookingService.getUserBookings(principal.getName());
        model.addAttribute("bookings", bookings);
        return "bookings/list";
    }

    @GetMapping("/flight/{flightId}/seats")
    public String showFlightSeats(@PathVariable Long flightId, Model model) {
        try {
            FlightSeatMapDTO seatMap = bookingService.getFlightSeatMap(flightId);
            model.addAttribute("seatMap", seatMap);
            return "bookings/seat-selection";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/flights";
        }
    }

    @PostMapping("/create")
    public String createBooking(@Valid @ModelAttribute CreateBookingRequest request,
                                BindingResult bindingResult,
                                Principal principal,
                                RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors() || request.getSeatNumber() == null || request.getSeatNumber().trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Пожалуйста, выберите место");
            return "redirect:/flights/" + request.getFlightId();
        }

        User user = userService.findUserByEmail(principal.getName());

        try {
            BookingDTO booking = bookingService.createBooking(request, user);
            redirectAttributes.addFlashAttribute("success",
                    "Бронирование успешно оформлено! Номер бронирования: " + booking.getId());
            return "redirect:/profile";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/flights/" + request.getFlightId();
        }
    }

    @PostMapping("/{bookingId}/cancel")
    public String cancelBooking(@PathVariable Long bookingId,
                                Principal principal,
                                RedirectAttributes redirectAttributes) {
        User user = userService.findUserByEmail(principal.getName());

        try {
            bookingService.cancelBooking(bookingId, user);
            redirectAttributes.addFlashAttribute("success", "Бронирование успешно отменено");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/bookings";
    }

    @GetMapping("/{bookingId}")
    public String getBookingDetails(@PathVariable Long bookingId,
                                    Principal principal,
                                    Model model) {
        User user = userService.findUserByEmail(principal.getName());

        try {
            BookingDTO booking = bookingService.getBookingById(bookingId, user);
            model.addAttribute("booking", booking);
            return "bookings/details";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/bookings";
        }
    }
}