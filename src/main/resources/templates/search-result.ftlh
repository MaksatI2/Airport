<#import "layout.ftlh" as layout>

<@layout.page title="Результаты поиска">
    <section class="py-5">
        <div class="container">
            <div class="row mb-4">
                <div class="col-12">
                    <h2 class="fw-bold">Результаты поиска</h2>
                    <p class="lead">
                    </p>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <#if flights?? && flights?size gt 0>
                        <div class="card mb-3">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <div>
                                    Найдено рейсов: ${flightCount}
                                </div>
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                        Сортировка:
                                        <#if sortBy == "price">
                                            По цене
                                        <#else>
                                            По времени
                                        </#if>
                                        (<#if direction == "asc">по возрастанию<#else>по убыванию</#if>)
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="sortDropdown">
                                        <li><a class="dropdown-item" href="?from=${fromId!}&to=${toId!}&startDate=${startDate!}&endDate=${endDate!}&sortBy=price&direction=asc">Цена (по возрастанию)</a></li>
                                        <li><a class="dropdown-item" href="?from=${fromId!}&to=${toId!}&startDate=${startDate!}&endDate=${endDate!}&sortBy=price&direction=desc">Цена (по убыванию)</a></li>
                                        <li><a class="dropdown-item" href="?from=${fromId!}&to=${toId!}&startDate=${startDate!}&endDate=${endDate!}&sortBy=departureTime&direction=asc">Время вылета (по возрастанию)</a></li>
                                        <li><a class="dropdown-item" href="?from=${fromId!}&to=${toId!}&startDate=${startDate!}&endDate=${endDate!}&sortBy=departureTime&direction=desc">Время вылета (по убыванию)</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead class="table-light">
                                        <tr>
                                            <th>Рейс</th>
                                            <th>Отправление</th>
                                            <th>Прибытие</th>
                                            <th>Цена</th>
                                            <th></th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <#list flights as flight>
                                            <tr>
                                                <td class="fw-bold">${flight.flightNumber}</td>
                                                <td>
                                                    <div class="fw-bold">${flight.departureTime?datetime?string("HH:mm")}</div>
                                                    <div class="text-muted small">${flight.departureAirport}</div>
                                                </td>
                                                <td>
                                                    <div class="fw-bold">${flight.arrivalTime?datetime?string("HH:mm")}</div>
                                                    <div class="text-muted small">${flight.destination}</div>
                                                </td>
                                                <td class="fw-bold text-primary">${flight.price} $</td>
                                                <td class="text-end">
                                                    <#if !Session.SPRING_SECURITY_CONTEXT?? || (Session.SPRING_SECURITY_CONTEXT.authentication.authorities?seq_contains('USER'))>
                                                        <a href="/bookings/flight/${flight.id}/seats" class="btn btn-sm btn-primary">
                                                            Выбрать <i class="fas fa-chevron-right ms-1"></i>
                                                        </a>
                                                    </#if>
                                                </td>
                                            </tr>
                                        </#list>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <#if totalPages gt 1>
                            <nav aria-label="Page navigation">
                                <ul class="pagination justify-content-center">
                                    <#if currentPage gt 1>
                                        <li class="page-item">
                                            <a class="page-link" href="?from=${fromId!}&to=${toId!}&startDate=${startDate!}&endDate=${endDate!}&sortBy=${sortBy!}&direction=${direction!}&page=${currentPage - 1}" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                    </#if>

                                    <#list 1..totalPages as p>
                                        <li class="page-item <#if p == currentPage>active</#if>">
                                            <a class="page-link" href="?from=${fromId!}&to=${toId!}&startDate=${startDate!}&endDate=${endDate!}&sortBy=${sortBy!}&direction=${direction!}&page=${p}">${p}</a>
                                        </li>
                                    </#list>

                                    <#if currentPage lt totalPages>
                                        <li class="page-item">
                                            <a class="page-link" href="?from=${fromId!}&to=${toId!}&startDate=${startDate!}&endDate=${endDate!}&sortBy=${sortBy!}&direction=${direction!}&page=${currentPage + 1}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </#if>
                                </ul>
                            </nav>
                        </#if>
                    <#else>
                        <div class="alert alert-info">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-info-circle fa-2x me-3"></i>
                                <div>
                                    <h5 class="mb-1">Рейсы не найдены</h5>
                                    <p class="mb-0">Попробуйте изменить параметры поиска</p>
                                </div>
                            </div>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </section>
</@layout.page>