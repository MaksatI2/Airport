package airport.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Entity
@Table(name = "bookings")
@Getter
@Setter
public class Booking {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "flight_id")
    private Flight flight;

    @Column(name = "seat_number", length = 5)
    private String seatNumber;

    @Column(name = "booking_time")
    private Timestamp bookingTime;

    @ManyToOne
    @JoinColumn(name = "class_type_id")
    private ClassTypeAirplane classType;
}
