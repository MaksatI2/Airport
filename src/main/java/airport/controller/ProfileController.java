package airport.controller;

import airport.dto.BookingDTO;
import airport.dto.UserDTO;
import airport.service.BookingService;
import airport.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/profile")
@RequiredArgsConstructor
public class ProfileController {

    private final UserService userService;
    private final BookingService bookingService;

    @GetMapping
    public String showProfile(@AuthenticationPrincipal UserDetails userDetails, Principal principal, Model model) {
        String email = userDetails.getUsername();
        UserDTO user = userService.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Пользователь не найден"));

        List<BookingDTO> bookings = bookingService.getUserBookings(principal.getName());

        model.addAttribute("bookings", bookings);
        model.addAttribute("user", user);
        return "user/profile";
    }
}