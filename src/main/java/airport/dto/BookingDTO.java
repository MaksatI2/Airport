package airport.dto;

import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Getter
@Setter
public class BookingDTO {
    private Long id;
    private Long userId;
    private Long flightId;
    private Long flightUserId;
    private String seatNumber;
    private Timestamp bookingTime;
    private String statusName;
    private String userFullName;
    private String flightNumber;
    private String departureAirport;
    private String destination;
    private Timestamp departureTime;
    private Timestamp arrivalTime;
    private Double price;
    private Double businessPrice;
    private String classTypeName;
    private Double actualPrice;
}