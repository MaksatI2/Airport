package airport.service;

import airport.dto.BookingDTO;
import airport.dto.CreateBookingRequest;
import airport.dto.FlightSeatMapDTO;
import airport.model.User;

import java.util.List;

public interface BookingService {
    FlightSeatMapDTO getFlightSeatMap(Long flightId);
    BookingDTO createBooking(CreateBookingRequest request, User user);
    List<BookingDTO> getUserBookings(String email);
    void cancelBooking(Long bookingId, User user);
    BookingDTO getBookingById(Long bookingId, User user);

    int getBookedSeatsByFlightId(Long flightId);
}