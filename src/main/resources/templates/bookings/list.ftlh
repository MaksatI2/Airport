<#include "../layout.ftlh">

<@page title="Мои бронирования">

    <div class="container py-5">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-ticket-alt me-2"></i>Мои бронирования</h2>
                    <a href="/flights" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Новое бронирование
                    </a>
                </div>
                  <#if bookings?? && bookings?size gt 0>
                    <div class="row">
                        <#list bookings as booking>
                            <div class="col-md-6 col-lg-4 mb-4">
                                <div class="card booking-card h-100">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <h6 class="mb-0">
                                            <i class="fas fa-plane me-2"></i>
                                            ${booking.flightNumber}
                                        </h6>

                                    </div>
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <small class="text-muted">Откуда:</small>
                                            <h6 class="text-primary">${booking.departureAirport}</h6>
                                        </div>
                                        <div class="mb-3">
                                            <small class="text-muted">Куда:</small>
                                            <h6 class="text-primary">${booking.destination}</h6>
                                        </div>

                                        <div class="row mb-3">
                                            <div class="col-6">
                                                <strong>Место:</strong><br>
                                                <span class="badge bg-info">${booking.seatNumber}</span>
                                            </div>
                                            <div class="col-6">
                                                <strong>Цена:</strong><br>
                                                <span class="text-success fw-bold">${booking.price} $</span>
                                            </div>
                                        </div>

                                        <div class="mb-3">
                                            <small class="text-muted">Вылет</small><br>
                                            <strong>${booking.departureTime?string('dd.MM.yyyy HH:mm')}</strong>
                                        </div>

                                        <div class="mb-3">
                                            <small class="text-muted">Прилет</small><br>
                                            <strong>${booking.arrivalTime?string('dd.MM.yyyy HH:mm')}</strong>
                                        </div>

                                        <div class="mb-3">
                                            <small class="text-muted">Забронировано</small><br>
                                            <strong>${booking.bookingTime?string('dd.MM.yyyy HH:mm')}</strong>
                                        </div>
                                    </div>
                                    <div class="card-footer">
                                        <div class="d-flex gap-2">
                                            <a href="/bookings/${booking.id}" class="btn btn-outline-primary btn-sm flex-fill">
                                                <i class="fas fa-info-circle me-1"></i>Детали
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </#list>
                    </div>
                  <#else>
                      <div class="text-center py-4">
                          <i class="fas fa-ticket-alt fa-3x text-muted mb-3"></i>
                          <h5>У вас нет бронирований</h5>
                          <p>Начните поиск рейсов, чтобы создать первое бронирование</p>
                          <a href="/flights" class="btn btn-primary">
                              <i class="fas fa-search me-2"></i>Найти рейсы
                          </a>
                      </div>
                  </#if>
            </div>
        </div>
    </div>

    <style>
        .booking-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: none;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .booking-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .booking-card .card-header {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border-bottom: none;
        }

        .booking-card .badge {
            font-size: 0.75rem;
        }

        .booking-card .card-footer {
            background-color: #f8f9fa;
            border-top: 1px solid #dee2e6;
        }

        @media (max-width: 768px) {
            .booking-card .card-body {
                padding: 1rem;
            }

            .booking-card .row {
                margin: 0;
            }

            .booking-card .col-6 {
                padding: 0.25rem;
            }
        }
    </style>
</@page>