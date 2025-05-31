<#import "../layout.ftlh" as layout>
<@layout.page title="Рейсы авиакомпании" activeNav="admin">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-plane me-2"></i>Рейсы авиакомпании</h2>
            <a href="/airline/flights/create" class="btn btn-primary">
                <i class="fas fa-plus me-1"></i> Создать рейс
            </a>
        </div>

        <#if successMessage??>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </#if>

        <#if errorMessage??>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </#if>

        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                        <tr>
                            <th>Номер рейса</th>
                            <th>Маршрут</th>
                            <th>Дата/время вылета</th>
                            <th>Дата/время прилета</th>
                            <th>Цена (эконом)</th>
                            <th>Цена (бизнес)</th>
                            <th>Самолет</th>
                            <th>Забронировано</th>
                            <th>Свободно</th>
                            <th>Действия</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list flights as flightStats>
                            <#assign flight = flightStats.flight>
                            <tr>
                                <td>${flight.flightNumber}</td>
                                <td>${flight.departureAirport} → ${flight.destination}</td>
                                <td>${flight.departureTime?datetime}</td>
                                <td>${flight.arrivalTime?datetime}</td>
                                <td>${flight.price} $</td>
                                <td>${flight.businessPrice} $</td>
                                <td>${flight.airplaneModel!''}</td>
                                <td>
                                    <span class="badge bg-danger">${flightStats.bookedSeats}</span>
                                </td>
                                <td>
                                    <span class="badge bg-success">${flightStats.availableSeats}</span>
                                </td>
                                <td>
                                    <a href="/flights/${flight.id}/bookings" class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-list"></i> Бронирования
                                    </a>
                                </td>
                            </tr>
                        <#else>
                            <tr>
                                <td colspan="10" class="text-center text-muted">Нет рейсов для отображения</td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <style>
        .table-hover tbody tr:hover {
            background-color: rgba(102, 126, 234, 0.1);
        }
        .badge {
            font-size: 0.9em;
            padding: 0.35em 0.65em;
        }
    </style>
</@layout.page>