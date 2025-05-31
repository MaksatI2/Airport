package airport.repository;

import airport.model.Flight;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface FlightRepository extends JpaRepository<Flight, Long> {

    @Query("SELECT f FROM Flight f WHERE f.user.id = :airlineId")
    List<Flight> findFlightsByAirlineId(@Param("airlineId") Long airlineId);

    @Query("SELECT f FROM Flight f WHERE f.user.enabled = true")
    Page<Flight> findAll(Pageable pageable);

    @Query("SELECT MAX(CAST(SUBSTRING(f.flightNumber, 4) AS int)) FROM Flight f WHERE f.flightNumber LIKE 'SU-%'")
    Integer findMaxFlightNumberSuffix();

    @Query("SELECT CASE WHEN COUNT(f) > 0 THEN true ELSE false END FROM Flight f WHERE f.flightNumber = :flightNumber")
    boolean existsByFlightNumber(@Param("flightNumber") String flightNumber);
    @Query("SELECT f FROM Flight f WHERE f.placeDeparture.id = :departureId AND f.destination.id = :destinationId AND FORMATDATETIME(f.departureTime, 'yyyy-MM-dd') = FORMATDATETIME(:date, 'yyyy-MM-dd')")
    Page<Flight> findByPlaceDepartureIdAndDestinationIdAndDepartureDate(
            @Param("departureId") Long departureId,
            @Param("destinationId") Long destinationId,
            @Param("date") LocalDate date,
            Pageable pageable);

    @Query("SELECT f FROM Flight f WHERE f.placeDeparture.id = :departureId AND f.destination.id = :destinationId AND FORMATDATETIME(f.departureTime, 'yyyy-MM-dd') BETWEEN FORMATDATETIME(:startDate, 'yyyy-MM-dd') AND FORMATDATETIME(:endDate, 'yyyy-MM-dd')")
    Page<Flight> findByPlaceDepartureIdAndDestinationIdAndDateRange(
            @Param("departureId") Long departureId,
            @Param("destinationId") Long destinationId,
            @Param("startDate") LocalDate startDate,
            @Param("endDate") LocalDate endDate,
            Pageable pageable);

    Page<Flight> findByPlaceDepartureIdAndDestinationId(Long departureId, Long destinationId, Pageable pageable);
}