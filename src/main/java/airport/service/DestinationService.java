package airport.service;

import airport.model.Destination;

import java.util.List;

public interface DestinationService {
    List<Destination> getAllAirports();
    Destination getDestinationById(Long id);
    List<Destination> searchDestinations(String query);
}