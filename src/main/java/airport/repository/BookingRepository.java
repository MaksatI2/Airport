package airport.repository;

import airport.model.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {

    List<Booking> findByUserIdOrderByBookingTimeDesc(Long userId);

    @Query("SELECT COUNT(b) FROM Booking b WHERE b.flight.id = :flightId AND b.user IS NOT NULL")
    int countBookedSeatsByFlightId(@Param("flightId") Long flightId);

    @Query("SELECT b FROM Booking b WHERE b.flight.id = :flightId")
    List<Booking> findByFlightId(@Param("flightId") Long flightId);

    @Query("SELECT b FROM Booking b WHERE b.flight.id = :flightId AND b.seatNumber = :seatNumber")
    Optional<Booking> findByFlightIdAndSeatNumber(@Param("flightId") Long flightId, @Param("seatNumber") String seatNumber);


}
