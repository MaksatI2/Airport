package airport.controller;

import airport.dto.UserDTO;
import airport.exception.InvalidRegisterException;
import airport.model.User;
import airport.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthViewController {

    private final UserService userService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        return "auth/register";
    }

    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("user") UserDTO userDTO,
                               BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "auth/register";
        }

        try {
            userService.registerUser(userDTO);
            return "redirect:/auth/login?success";
        } catch (InvalidRegisterException e) {
            bindingResult.rejectValue(e.getFieldName(),"error", e.getMessage());
            return "auth/register";
        }

    }

    @GetMapping("/login")
    public String showLoginForm(
            @RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "registered", required = false) String registered,
            Model model) {

        if (error != null) {
            model.addAttribute("loginError", "Неверный email или пароль");
        }

        if (registered != null) {
            model.addAttribute("registrationSuccess", "Регистрация прошла успешно! Войдите в систему.");
        }

        return "auth/login";
    }

}