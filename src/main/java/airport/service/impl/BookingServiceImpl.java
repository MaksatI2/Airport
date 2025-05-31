package airport.service.impl;

import airport.dto.BookingDTO;
import airport.dto.CreateBookingRequest;
import airport.dto.FlightSeatMapDTO;
import airport.dto.SeatDTO;
import airport.model.Booking;
import airport.model.Flight;
import airport.model.User;
import airport.repository.BookingRepository;
import airport.repository.FlightRepository;
import airport.service.BookingService;
import airport.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BookingServiceImpl implements BookingService {

    private final BookingRepository bookingRepository;
    private final FlightRepository flightRepository;
    private final UserService userService;

    @Override
    public FlightSeatMapDTO getFlightSeatMap(Long flightId) {
        Flight flight = flightRepository.findById(flightId)
                .orElseThrow(() -> new RuntimeException("Flight not found"));

        List<Booking> allTickets = bookingRepository.findByFlightId(flightId);

        Set<String> occupiedSeats = allTickets.stream()
                .filter(ticket -> ticket.getUser() != null)
                .map(Booking::getSeatNumber)
                .collect(Collectors.toSet());

        List<SeatDTO> seats = generateSeatMapFromTickets(allTickets, occupiedSeats);

        FlightSeatMapDTO seatMap = new FlightSeatMapDTO();
        seatMap.setFlightId(flight.getId());
        seatMap.setFlightNumber(flight.getFlightNumber());
        seatMap.setDestination(flight.getDestination().getName());
        seatMap.setDepartureTime(flight.getDepartureTime());
        seatMap.setArrivalTime(flight.getArrivalTime());
        seatMap.setAircraftModel(flight.getAirplane().getModel());
        seatMap.setAircraftCapacity(flight.getAirplane().getCapacity());
        seatMap.setBusinessSeats(flight.getAirplane().getBusiness_capacity());
        seatMap.setSeats(seats);
        seatMap.setTotalSeats(seats.size());
        seatMap.setOccupiedSeats(occupiedSeats.size());
        seatMap.setAvailableSeats(seats.size() - occupiedSeats.size());

        long availableBusinessSeats = seats.stream()
                .filter(seat -> "BUSINESS".equals(seat.getSeatClass()) && !seat.isOccupied())
                .count();
        seatMap.setAvailableBusinessSeats((int) availableBusinessSeats);
        seatMap.setAvailableEconomySeats(seatMap.getAvailableSeats() - (int) availableBusinessSeats);

        seatMap.setPrice(flight.getPrice());
        seatMap.setBusinessPrice(flight.getBusinessPrice());

        return seatMap;
    }

    private List<SeatDTO> generateSeatMapFromTickets(List<Booking> tickets, Set<String> occupiedSeats) {
        List<SeatDTO> seats = new ArrayList<>();

        for (Booking ticket : tickets) {
            boolean isOccupied = occupiedSeats.contains(ticket.getSeatNumber());
            String seatClass = ticket.getClassType().getName();

            Double seatPrice;
            if ("BUSINESS".equals(seatClass)) {
                seatPrice = ticket.getFlight().getBusinessPrice();
            } else {
                seatPrice = ticket.getFlight().getPrice();
            }

            seats.add(new SeatDTO(ticket.getSeatNumber(), isOccupied, seatClass, seatPrice));
        }

        return seats;
    }

    @Override
    @Transactional
    public BookingDTO createBooking(CreateBookingRequest request, User user) {
        Booking ticket = bookingRepository.findByFlightIdAndSeatNumber(request.getFlightId(), request.getSeatNumber())
                .orElseThrow(() -> new RuntimeException("Билет не найден"));

        if (ticket.getUser() != null) {
            throw new RuntimeException("Место уже занято");
        }

        ticket.setUser(user);
        ticket.setBookingTime(Timestamp.valueOf(LocalDateTime.now()));

        ticket = bookingRepository.save(ticket);

        return convertToDTO(ticket);
    }

    @Override
    public List<BookingDTO> getUserBookings(String email) {
        User user = userService.findUserByEmail(email);
        List<Booking> bookings = bookingRepository.findByUserIdOrderByBookingTimeDesc(user.getId());
        return bookings.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void cancelBooking(Long bookingId, User user) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Бронирование не найдено"));

        if (!booking.getUser().getId().equals(user.getId())) {
            throw new RuntimeException("Доступ запрещён");
        }

        LocalDateTime now = LocalDateTime.now();
        LocalDateTime departureTime = booking.getFlight().getDepartureTime().toLocalDateTime();

        if (departureTime == null) {
            throw new RuntimeException("Дата вылета не указана");
        }

        Duration timeLeft = Duration.between(now, departureTime);
        if (timeLeft.toHours() < 24) {
            throw new RuntimeException("Нельзя отменить бронирование менее чем за 24 часа до вылета");
        }

        booking.setUser(null);
        booking.setBookingTime(null);
        bookingRepository.save(booking);
    }

    @Override
    public BookingDTO getBookingById(Long bookingId, User user) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        if (!booking.getUser().getId().equals(user.getId())) {
            throw new RuntimeException("Access denied");
        }

        return convertToDTO(booking);
    }

    private BookingDTO convertToDTO(Booking booking) {
        BookingDTO dto = new BookingDTO();
        dto.setId(booking.getId());
        dto.setUserId(booking.getUser() != null ? booking.getUser().getId() : null);
        dto.setFlightId(booking.getFlight().getId());
        dto.setFlightUserId(booking.getFlight().getUser().getId());
        dto.setSeatNumber(booking.getSeatNumber());
        dto.setBookingTime(booking.getBookingTime());
        dto.setUserFullName(booking.getUser() != null ? booking.getUser().getUsername() : null);
        dto.setFlightNumber(booking.getFlight().getFlightNumber());
        dto.setDepartureAirport(booking.getFlight().getPlaceDeparture().getName());
        dto.setDestination(booking.getFlight().getDestination().getName());
        dto.setDepartureTime(booking.getFlight().getDepartureTime());
        dto.setArrivalTime(booking.getFlight().getArrivalTime());
        dto.setPrice(booking.getFlight().getPrice());
        dto.setBusinessPrice(booking.getFlight().getBusinessPrice());
        dto.setClassTypeName(booking.getClassType().getName());

        if ("BUSINESS".equals(booking.getClassType().getName())) {
            dto.setActualPrice(booking.getFlight().getBusinessPrice());
        } else {
            dto.setActualPrice(booking.getFlight().getPrice());
        }

        return dto;
    }
}