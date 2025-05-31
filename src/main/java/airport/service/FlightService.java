package airport.service;

import airport.dto.CreateFlightDTO;
import airport.dto.FlightDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

public interface FlightService {

    @Transactional
    FlightDTO createFlight(CreateFlightDTO flightDTO);

    Page<FlightDTO> findFlightsByCitiesAndDateRange(Long departureId, Long destinationId, LocalDate startDate, LocalDate endDate, Pageable pageable);
    Page<FlightDTO> findFlightsByCitiesAndDate(Long departureId, Long destinationId, LocalDate date, Pageable pageable);
    Page<FlightDTO> findFlightsByCities(Long departureId, Long destinationId, Pageable pageable);

    List<FlightDTO> getFlightsByAirlineId(Long airlineId);

}