package airport.controller;

import airport.service.DestinationService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    private final DestinationService destinationService;

    public MainController(DestinationService destinationService) {
        this.destinationService = destinationService;
    }

    @GetMapping("/")
    public String mainPage(Model model) {
        model.addAttribute("popularDestinations", destinationService.getAllAirports());
        return "main";
    }

}