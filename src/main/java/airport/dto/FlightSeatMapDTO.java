package airport.dto;

import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;
import java.util.List;

@Getter
@Setter
public class FlightSeatMapDTO {
    private Long flightId;
    private String flightNumber;
    private String destination;
    private String departureAirport;
    private Timestamp departureTime;
    private Timestamp arrivalTime;
    private String aircraftModel;
    private Integer aircraftCapacity;
    private Integer businessSeats;
    private List<SeatDTO> seats;
    private Integer totalSeats;
    private Integer occupiedSeats;
    private Integer availableSeats;
    private Integer availableEconomySeats;
    private Integer availableBusinessSeats;
    private Double price;
    private Double businessPrice;
}