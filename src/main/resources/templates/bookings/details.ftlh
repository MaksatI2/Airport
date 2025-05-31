<#include "../layout.ftlh">

<@page title="Детали бронирования #${booking.id}">

    <div class="container py-5">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>
                        <i class="fas fa-ticket-alt me-2"></i>
                        Бронирование #${booking.id}
                    </h2>
                    <div>
                        <a href="/bookings" class="btn btn-outline-secondary me-2">
                            <i class="fas fa-arrow-left me-2"></i>Назад к списку
                        </a>
                        <button onclick="window.print()" class="btn btn-primary">
                            <i class="fas fa-print me-2"></i>Печать
                        </button>
                    </div>
                </div>


                <div class="row">
                    <div class="col-lg-8">
                        <div class="card mb-4">
                            <div class="card-header ${(booking.classTypeName == 'BUSINESS')?then('bg-warning text-dark', 'bg-primary text-white')}">
                                <div class="d-flex align-items-center">
                                    <div class="flex-shrink-0 me-3">
                                        <img src="/api/users/${booking.flightUserId}/avatar"
                                             alt="Логотип авиакомпании"
                                             class="rounded-circle border border-2 border-white"
                                             width="40" height="40"
                                             onerror="this.src='https://via.placeholder.com/40?text=LOGO';this.onerror=null;">
                                    </div>
                                    <div>
                                        <h5 class="mb-0">
                                            <i class="fas fa-plane me-2"></i>
                                            Информация о рейсе (${booking.classTypeName})
                                        </h5>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="info-item mb-3">
                                            <label class="text-muted small">Номер рейса</label>
                                            <div class="fw-bold fs-5">${booking.flightNumber}</div>
                                        </div>

                                        <div class="info-item mb-3">
                                            <label class="text-muted small">Направление</label>
                                            <div class="fw-bold fs-5 text-primary">${booking.destination}</div>
                                        </div>

                                        <div class="info-item mb-3">
                                            <label class="text-muted small">Место</label>
                                            <div>
                                                <span class="badge ${(booking.classTypeName == 'BUSINESS')?then('bg-warning', 'bg-info')} fs-6 px-3 py-2">
                                                    ${booking.seatNumber}
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="info-item mb-3">
                                            <label class="text-muted small">Вылет</label>
                                            <div class="fw-bold">${booking.departureTime?string('dd.MM.yyyy HH:mm')}</div>
                                        </div>

                                        <div class="info-item mb-3">
                                            <label class="text-muted small">Прилет</label>
                                            <div class="fw-bold">${booking.arrivalTime?string('dd.MM.yyyy HH:mm')}</div>
                                        </div>

                                        <div class="info-item mb-3">
                                            <label class="text-muted small">Стоимость</label>
                                            <div class="fw-bold fs-4 ${(booking.classTypeName == 'BUSINESS')?then('text-warning', 'text-success')}">
                                                ${booking.actualPrice} $
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mt-4">
                                    <div class="col-12">
                                        <div class="flight-timeline">
                                            <div class="timeline-item">
                                                <div class="timeline-marker bg-success"></div>
                                                <div class="timeline-content">
                                                    <h6 class="mb-1">Вылет</h6>
                                                    <p class="mb-0 text-muted">${booking.departureTime?string('dd MMMM yyyy, HH:mm')}</p>
                                                </div>
                                            </div>
                                            <div class="timeline-line"></div>
                                            <div class="timeline-item">
                                                <div class="timeline-marker ${(booking.classTypeName == 'BUSINESS')?then('bg-warning', 'bg-primary')}"></div>
                                                <div class="timeline-content">
                                                    <h6 class="mb-1">Прилет в ${booking.destination}</h6>
                                                    <p class="mb-0 text-muted">${booking.arrivalTime?string('dd MMMM yyyy, HH:mm')}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-header">
                                <h6 class="mb-0">
                                    <i class="fas fa-info-circle me-2"></i>
                                    Важная информация
                                </h6>
                            </div>
                            <div class="card-body">
                                <#if booking.classTypeName == 'BUSINESS'>
                                    <div class="alert alert-warning mb-4">
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-crown me-3 fs-4 text-warning"></i>
                                            <div>
                                                <h5 class="mb-1">Бизнес-класс</h5>
                                                <p class="mb-0">Вы выбрали бизнес-класс. Включены все привилегии: отдельная регистрация, доступ в бизнес-зал, повышенный багаж и улучшенное питание.</p>
                                            </div>
                                        </div>
                                    </div>
                                </#if>
                                <div class="row">
                                    <div class="col-md-6">
                                        <ul class="list-unstyled">
                                            <li class="mb-2">
                                                <i class="fas fa-clock text-warning me-2"></i>
                                                Прибытие в аэропорт за 2 часа до вылета
                                            </li>
                                            <li class="mb-2">
                                                <i class="fas fa-id-card text-info me-2"></i>
                                                Наличие документа, удостоверяющего личность
                                            </li>
                                            <li class="mb-2">
                                                <i class="fas fa-suitcase text-secondary me-2"></i>
                                                Проверка ограничений по багажу
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="list-unstyled">
                                            <li class="mb-2">
                                                <i class="fas fa-mobile-alt text-success me-2"></i>
                                                Электронная регистрация доступна
                                            </li>
                                            <li class="mb-2">
                                                <i class="fas fa-utensils text-primary me-2"></i>
                                                Питание включено в стоимость
                                            </li>
                                            <li class="mb-2">
                                                <i class="fas fa-wifi text-info me-2"></i>
                                                Wi-Fi на борту самолета
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="card mb-4">
                            <div class="card-header">
                                <h6 class="mb-0">
                                    <i class="fas fa-user me-2"></i>
                                    Детали бронирования
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="info-item mb-3">
                                    <label class="text-muted small">Номер бронирования</label>
                                    <div class="fw-bold">#${booking.id}</div>
                                </div>

                                <div class="info-item mb-3">
                                    <label class="text-muted small">Пассажир</label>
                                    <div class="fw-bold">${booking.userFullName}</div>
                                </div>

                                <div class="info-item mb-3">
                                    <label class="text-muted small">Дата бронирования</label>
                                    <div>${booking.bookingTime?string('dd.MM.yyyy HH:mm')}</div>
                                </div>

                                <div class="info-item mb-3">
                                    <label class="text-muted small">Класс</label>
                                    <div>
                                        <span class="badge ${(booking.classTypeName == 'BUSINESS')?then('bg-warning', 'bg-info')} fs-6">
                                            ${booking.classTypeName}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card mb-4">
                            <div class="card-header">
                                <h6 class="mb-0">
                                    <i class="fas fa-qrcode me-2"></i>
                                    Электронный билет
                                </h6>
                            </div>
                            <div class="card-body text-center">
                                <div class="qr-code-placeholder mb-3">
                                    <i class="fas fa-qrcode text-muted" style="font-size: 80px;"></i>
                                </div>
                                <p class="text-muted small">
                                    Покажите этот QR-код при регистрации на рейс
                                </p>
                            </div>
                        </div>


                        <div class="card">
                            <div class="card-header">
                                <h6 class="mb-0">
                                    <i class="fas fa-cog me-2"></i>
                                    Управление бронированием
                                </h6>
                            </div>
                            <div class="card-body">
                                <button class="btn btn-outline-primary w-100 mb-3"
                                        onclick="window.print()">
                                    <i class="fas fa-download me-2"></i>
                                    Скачать билет
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="cancelModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title text-danger">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Отмена бронирования
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body pt-0">
                    <div class="text-center mb-4">
                        <i class="fas fa-plane text-muted mb-3" style="font-size: 48px;"></i>
                        <h6>Вы действительно хотите отменить бронирование?</h6>
                        <p class="text-muted mb-0">Бронирование #${booking.id}</p>
                        <p class="text-muted small">${booking.flightNumber} • ${booking.destination}</p>
                        <p class="text-danger fw-bold">Сумма к возврату: ${booking.actualPrice} $</p>
                    </div>

                    <div class="alert alert-warning border-warning">
                        <div class="d-flex align-items-start">
                            <i class="fas fa-exclamation-triangle text-warning me-3 mt-1"></i>
                            <div>
                                <strong>Внимание!</strong>
                                <ul class="mb-0 mt-2 ps-3">
                                    <li>Отмененное бронирование нельзя восстановить</li>
                                    <li>Возврат средств производится согласно тарифным условиям</li>
                                    <li>Обработка возврата может занять до 10 рабочих дней</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-arrow-left me-2"></i>Вернуться
                    </button>
                    <form action="/bookings/${booking.id}/cancel" method="post" style="display: inline;" id="cancelForm">
                        <#if _csrf??>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </#if>
                        <button type="submit" class="btn btn-danger" id="confirmCancelButton">
                            <i class="fas fa-times me-2"></i>
                            <span class="button-text">Отменить бронирование</span>
                            <span class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <style>
        .info-item label {
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .flight-timeline {
            display: flex;
            align-items: center;
            position: relative;
            padding: 20px 0;
        }

        .timeline-item {
            display: flex;
            align-items: center;
            flex: 1;
            z-index: 2;
        }

        .timeline-marker {
            width: 20px;
            height: 20px;
            border-radius: 50%;
            margin-right: 15px;
            border: 3px solid white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .timeline-line {
            position: absolute;
            top: 50%;
            left: 20px;
            right: 20px;
            height: 2px;
            background: linear-gradient(to right, #28a745, #007bff);
            z-index: 1;
        }

        .qr-code-placeholder {
            background: #f8f9fa;
            border: 2px dashed #dee2e6;
            border-radius: 10px;
            padding: 20px;
        }

        .modal-content {
            border: none;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
        }

        .alert-warning {
            background-color: rgba(255, 193, 7, 0.1);
        }

        .btn-danger:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
        }

        .btn-outline-primary:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.2);
        }

        #cancelButton {
            transition: all 0.3s ease;
        }

        #cancelButton:hover {
            background-color: #dc3545;
            border-color: #dc3545;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
        }

        @media print {
            .btn, .modal, .card-header {
                display: none !important;
            }

            .container {
                max-width: 100% !important;
                margin: 0 !important;
                padding: 0 !important;
            }

            .card {
                border: none !important;
                box-shadow: none !important;
            }
        }

        @media (max-width: 768px) {
            .flight-timeline {
                flex-direction: column;
                align-items: flex-start;
            }

            .timeline-line {
                display: none;
            }

            .timeline-item {
                margin-bottom: 20px;
            }
        }
    </style>

</@page>