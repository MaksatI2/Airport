package airport.controller.api;

import airport.service.DestinationService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/destinations")
public class DestinationApiController {

    private final DestinationService destinationService;

    public DestinationApiController(DestinationService destinationService) {
        this.destinationService = destinationService;
    }

    @GetMapping
    public List<DestinationDto> searchDestinations(@RequestParam String query) {
        return destinationService.searchDestinations(query).stream()
                .map(d -> new DestinationDto(d.getId(), d.getName()))
                .collect(Collectors.toList());
    }

    public record DestinationDto(Long id, String name) {}
}