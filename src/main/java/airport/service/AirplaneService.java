package airport.service;

import airport.model.Airplane;

import java.util.List;

public interface AirplaneService {
    List<Airplane> getAvailableAirplanes();
    Airplane getAirplaneById(Long id);
}