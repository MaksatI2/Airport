package airport.service.impl;

import airport.model.Destination;
import airport.repository.DestinationRepository;
import airport.service.DestinationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
@RequiredArgsConstructor
public class DestinationServiceImpl implements DestinationService {

    private final DestinationRepository destinationRepository;

    @Override
    public List<Destination> getAllAirports() {
        return destinationRepository.findAllByOrderByNameAsc();
    }

    @Override
    public Destination getDestinationById(Long id) {
        return destinationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Аэропорт не найден"));
    }

    @Override
    public List<Destination> searchDestinations(String query) {
        List<Destination> startsWithResults = destinationRepository.findByNameStartingWithIgnoreCase(query);
        List<Destination> containsResults = destinationRepository.findByNameContainingIgnoreCaseOrderByNameAsc(query);

        return Stream.concat(startsWithResults.stream(), containsResults.stream())
                .distinct()
                .sorted((d1, d2) -> d1.getName().compareToIgnoreCase(d2.getName()))
                .collect(Collectors.toList());
    }
}