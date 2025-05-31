package airport.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateBookingRequest {
    @NotNull
    private Long flightId;

    @NotNull
    private String seatNumber;

    @NotNull
    private Long classTypeId;
}