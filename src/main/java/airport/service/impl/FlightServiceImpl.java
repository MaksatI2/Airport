package airport.service.impl;

import airport.dto.CreateFlightDTO;
import airport.dto.FlightDTO;
import airport.model.Booking;
import airport.model.ClassTypeAirplane;
import airport.model.Flight;
import airport.repository.BookingRepository;
import airport.repository.ClassTypeAirplaneRepository;
import airport.repository.FlightRepository;
import airport.service.AirplaneService;
import airport.service.DestinationService;
import airport.service.FlightService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class FlightServiceImpl implements FlightService {

    private final FlightRepository flightRepository;
    private final BookingRepository bookingRepository;
    private final ClassTypeAirplaneRepository classTypeAirplaneRepository;
    private final DestinationService destinationService;
    private final AirplaneService airplaneService;
    private final Random random = new Random();

    @Transactional
    @Override
    public FlightDTO createFlight(CreateFlightDTO flightDTO) {
        if (flightDTO.getArrivalTime() != null && flightDTO.getDepartureTime() != null) {
            if (!flightDTO.getArrivalTime().isAfter(flightDTO.getDepartureTime())) {
                throw new IllegalArgumentException("Время прилета должно быть позже времени вылета");
            }
        }

        Flight flight = new Flight();

        String newFlightNumber = generateUniqueFlightNumber();
        flight.setFlightNumber(newFlightNumber);

        flight.setPlaceDeparture(destinationService.getDestinationById(flightDTO.getDepartureAirportId()));
        flight.setDestination(destinationService.getDestinationById(flightDTO.getDestinationId()));

        flight.setDepartureTime(Timestamp.valueOf(flightDTO.getDepartureTime()));
        flight.setArrivalTime(Timestamp.valueOf(flightDTO.getArrivalTime()));

        Double economyPrice = generateRandomPrice(200, 1000);
        Double businessPrice = economyPrice * 2;

        flight.setPrice(economyPrice);
        flight.setBusinessPrice(businessPrice);
        flight.setAirplane(airplaneService.getAirplaneById(flightDTO.getAirplaneId()));
        flight.setUser(flight.getUser());

        Flight savedFlight = flightRepository.save(flight);

        generateTicketsForFlight(savedFlight);

        return convertToDto(savedFlight);
    }

    private String generateUniqueFlightNumber() {
        String flightNumber;
        do {
            Integer maxNumber = flightRepository.findMaxFlightNumberSuffix();
            if (maxNumber == null) {
                maxNumber = 20;
            }
            flightNumber = "SU-" + (maxNumber + 1);
        } while (flightRepository.existsByFlightNumber(flightNumber));

        return flightNumber;
    }

    private Double generateRandomPrice(int min, int max) {
        return (double) (random.nextInt(max - min + 1) + min);
    }

    @Transactional
    public void generateTicketsForFlight(Flight flight) {
        ClassTypeAirplane economyClass = classTypeAirplaneRepository.findByName("ECONOMY")
                .orElseThrow(() -> new RuntimeException("Тип класса ECONOMY не найден"));
        ClassTypeAirplane businessClass = classTypeAirplaneRepository.findByName("BUSINESS")
                .orElseThrow(() -> new RuntimeException("Тип класса BUSINESS не найден"));

        char[] seatLetters = {'A', 'B', 'C', 'D', 'E', 'F'};

        for (int i = 0; i < 3; i++) {
            Booking ticket = new Booking();
            ticket.setFlight(flight);
            ticket.setSeatNumber("1" + seatLetters[i]);
            ticket.setClassType(businessClass);
            bookingRepository.save(ticket);
        }

        int economyTicketsCreated = 0;
        int row = 1;
        int letterIndex = 3;

        while (economyTicketsCreated < 7) {
            Booking ticket = new Booking();
            ticket.setFlight(flight);
            ticket.setSeatNumber(row + String.valueOf(seatLetters[letterIndex]));
            ticket.setClassType(economyClass);
            bookingRepository.save(ticket);

            economyTicketsCreated++;
            letterIndex++;

            if (letterIndex >= seatLetters.length) {
                row++;
                letterIndex = 0;
            }
        }
    }

    private FlightDTO convertToDto(Flight flight) {
        FlightDTO dto = new FlightDTO();
        dto.setUserId(flight.getUser().getId());
        dto.setId(flight.getId());
        dto.setFlightNumber(flight.getFlightNumber());
        dto.setDepartureAirport(flight.getPlaceDeparture().getName());
        dto.setDestination(flight.getDestination().getName());
        dto.setDepartureTime(flight.getDepartureTime());
        dto.setArrivalTime(flight.getArrivalTime());
        dto.setPrice(flight.getPrice());
        dto.setBusinessPrice(flight.getBusinessPrice());
        dto.setAirplaneModel(flight.getAirplane() != null ? flight.getAirplane().getModel() : null);
        dto.setAirplaneId(flight.getAirplane() != null ? flight.getAirplane().getId() : null);
        dto.setDepartureAirportId(flight.getPlaceDeparture().getId());
        dto.setDestinationId(flight.getDestination().getId());
        return dto;
    }

    @Override
    public Page<FlightDTO> findFlightsByCitiesAndDateRange(Long departureId, Long destinationId, LocalDate startDate, LocalDate endDate, Pageable pageable) {
        return flightRepository.findByPlaceDepartureIdAndDestinationIdAndDateRange(departureId, destinationId, startDate, endDate, pageable)
                .map(this::convertToDto);
    }

    @Override
    public Page<FlightDTO> findFlightsByCitiesAndDate(Long departureId, Long destinationId, LocalDate date, Pageable pageable) {
        return flightRepository.findByPlaceDepartureIdAndDestinationIdAndDepartureDate(departureId, destinationId, date, pageable)
                .map(this::convertToDto);
    }

    @Override
    public Page<FlightDTO> findFlightsByCities(Long departureId, Long destinationId, Pageable pageable) {
        return flightRepository.findByPlaceDepartureIdAndDestinationId(departureId, destinationId, pageable)
                .map(this::convertToDto);
    }

    @Override
    public List<FlightDTO> getFlightsByAirlineId(Long airlineId) {
        return flightRepository.findFlightsByAirlineId(airlineId)
                .stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

}