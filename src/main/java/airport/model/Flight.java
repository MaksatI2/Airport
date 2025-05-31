package airport.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Entity
@Table(name = "flights")
@Getter
@Setter
public class Flight {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "flight_number", length = 20, unique = true)
    private String flightNumber;

    @ManyToOne
    @JoinColumn(name = "place_departure")
    private Destination placeDeparture;

    @ManyToOne
    @JoinColumn(name = "destination")
    private Destination destination;

    @Column(name = "departure_time")
    private Timestamp departureTime;

    @Column(name = "arrival_time")
    private Timestamp arrivalTime;

    private Double price;

    @Column(name = "business_price")
    private Double businessPrice;

    @ManyToOne
    @JoinColumn(name = "airplane_id")
    private Airplane airplane;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}
