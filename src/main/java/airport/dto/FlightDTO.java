package airport.dto;

import jakarta.validation.constraints.*;
import lombok.Data;

import java.sql.Timestamp;

@Data
public class FlightDTO {
    private Long id;

    private Long userId;

    private String flightNumber;

    private String departureAirport;

    private String destination;

    @NotNull(message = "Выберите аэропорт отправления")
    private Long departureAirportId;

    @NotNull(message = "Выберите аэропорт назначения")
    private Long destinationId;

    @NotNull(message = "Укажите время вылета")
    @Future(message = "Время вылета должно быть в будущем")
    private Timestamp departureTime;

    @NotNull(message = "Укажите время прилета")
    private Timestamp arrivalTime;

    private String status;
    private String airplaneModel;

    @NotNull(message = "Выберите самолет")
    private Long airplaneId;

    @NotNull(message = "Укажите цену")
    @DecimalMin(value = "0.0", inclusive = false, message = "Цена должна быть больше 0")
    @Digits(integer = 10, fraction = 2, message = "Неверный формат цены")
    private Double price;

    @NotNull(message = "Укажите цену")
    @DecimalMin(value = "0.0", inclusive = false, message = "Цена должна быть больше 0")
    @Digits(integer = 10, fraction = 2, message = "Неверный формат цены")
    private Double businessPrice;

    @AssertTrue(message = "Время прилета должно быть позже времени вылета")
    public boolean isValidFlightTime() {
        if (departureTime != null && arrivalTime != null) {
            return arrivalTime.after(departureTime);
        }
        return true;
    }

    @AssertTrue(message = "Аэропорт назначения должен отличаться от аэропорта отправления")
    public boolean isValidRoute() {
        if (departureAirportId != null && destinationId != null) {
            return !departureAirportId.equals(destinationId);
        }
        return true;
    }

}