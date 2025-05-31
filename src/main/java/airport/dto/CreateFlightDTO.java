package airport.dto;

import jakarta.validation.constraints.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class CreateFlightDTO {
    private Long id;
    private String flightNumber;
    private String departureAirport;
    private String destination;

    @NotNull(message = "Выберите аэропорт отправления")
    private Long departureAirportId;

    @NotNull(message = "Выберите аэропорт назначения")
    private Long destinationId;

    @NotNull(message = "Укажите время вылета")
    @Future(message = "Время вылета должно быть в будущем")
    private LocalDateTime departureTime;

    @NotNull(message = "Укажите время прилета")
    private LocalDateTime arrivalTime;

    @NotNull(message = "Выберите самолет")
    private Long airplaneId;

    private Long userId;

    @AssertTrue(message = "Время прилета должно быть позже времени вылета")
    public boolean isValidFlightTime() {
        if (departureTime != null && arrivalTime != null) {
            return arrivalTime.isAfter(departureTime);
        }
        return true;
    }

}