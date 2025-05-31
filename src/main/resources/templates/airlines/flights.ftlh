<#import "../layout.ftlh" as layout>
<@layout.page title="Рейсы авиакомпании" activeNav="admin">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-plane me-2"></i>Рейсы авиакомпании</h2>
            <#if Session.SPRING_SECURITY_CONTEXT.authentication.authorities?seq_contains('ADMIN')>
                <a href="/admin/airlines" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-1"></i> Назад к списку авиакомпаний
                </a>
            </#if>
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

        <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="page-size-selector">
                <select class="form-select form-select-sm" onchange="location = '?page=1&size=' + this.value;">
                    <option value="5" <#if pageSize == 5>selected</#if>>5 на странице</option>
                    <option value="10" <#if pageSize == 10>selected</#if>>10 на странице</option>
                    <option value="20" <#if pageSize == 20>selected</#if>>20 на странице</option>
                    <option value="50" <#if pageSize == 50>selected</#if>>50 на странице</option>
                </select>
            </div>
        </div>

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
                            <th>Места</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list flights as flight>
                            <tr>
                                <td>${flight.flightNumber}</td>
                                <td>${flight.departureAirport} → ${flight.destination}</td>
                                <td>${flight.departureTime?datetime}</td>
                                <td>${flight.arrivalTime?datetime}</td>
                                <td>${flight.price} $</td>
                                <td>${flight.businessPrice} $</td>
                                <td>${flight.airplaneModel!''}</td>
                                <td>
                                    <#assign totalSeats = totalSeatsMap[flight.id?string]!0>
                                    <#assign bookedSeats = bookedSeatsMap[flight.id?string]!0>
                                    <#assign availableSeats = totalSeats - bookedSeats>
                                    <div class="d-flex flex-column">
                                        <small class="text-muted">Всего: ${totalSeats}</small>
                                        <small class="text-success">Свободно: ${availableSeats}</small>
                                        <small class="text-warning">Занято: ${bookedSeats}</small>
                                    </div>
                                    <#if totalSeats gt 0>
                                        <div class="progress mt-1" style="height: 6px;">
                                            <div class="progress-bar bg-warning"
                                                 role="progressbar"
                                                 style="width: ${(bookedSeats * 100 / totalSeats)?round}%"
                                                 aria-valuenow="${bookedSeats}"
                                                 aria-valuemin="0"
                                                 aria-valuemax="${totalSeats}">
                                            </div>
                                        </div>
                                    </#if>
                                </td>
                            </tr>
                        <#else>
                            <tr>
                                <td colspan="8" class="text-center text-muted">Нет рейсов для отображения</td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>

                <#if flights?? && flights?size gt 0>
                    <div class="d-flex justify-content-between align-items-center mt-3">
                        <div class="text-muted">
                            Показано ${(currentPage - 1) * pageSize + 1}-${((currentPage - 1) * pageSize + flights?size)} из ${totalItems} рейсов
                        </div>
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <#if currentPage lte 1>
                                    <li class="page-item disabled">
                                        <span class="page-link">Предыдущая</span>
                                    </li>
                                <#else>
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage - 1}&size=${pageSize}">Предыдущая</a>
                                    </li>
                                </#if>

                                <#list 1..totalPages as i>
                                    <li class="page-item ${(i == currentPage)?then('active','')}">
                                        <a class="page-link" href="?page=${i}&size=${pageSize}">${i}</a>
                                    </li>
                                </#list>

                                <#if currentPage gte totalPages>
                                    <li class="page-item disabled">
                                        <span class="page-link">Следующая</span>
                                    </li>
                                <#else>
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage + 1}&size=${pageSize}">Следующая</a>
                                    </li>
                                </#if>
                            </ul>
                        </nav>
                    </div>
                </#if>
            </div>
        </div>
    </div>

    <style>
        .table-hover tbody tr:hover {
            background-color: rgba(102, 126, 234, 0.1);
        }

        .progress {
            background-color: #e9ecef;
        }

        .progress-bar {
            transition: width 0.3s ease;
        }

        .page-size-selector {
            width: 150px;
        }
    </style>
</@layout.page>