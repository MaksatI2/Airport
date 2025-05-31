<#include "../layout.ftlh">

<@page title="Выбор места - ${seatMap.flightNumber}">

    <div class="container py-5">
        <div class="row">
            <div class="col-12">
                <div class="card mb-4 shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-plane-departure me-2"></i>
                            Рейс ${seatMap.flightNumber} - ${seatMap.destination}
                        </h4>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="flight-info-item">
                                    <i class="fas fa-map-marker-alt text-primary me-2"></i>
                                    <span><strong>Направление:</strong> ${seatMap.destination}</span>
                                </div>
                                <div class="flight-info-item">
                                    <i class="fas fa-plane-departure text-primary me-2"></i>
                                    <span><strong>Вылет:</strong> ${seatMap.departureTime?string('dd.MM.yyyy HH:mm')}</span>
                                </div>
                                <div class="flight-info-item">
                                    <i class="fas fa-plane-arrival text-primary me-2"></i>
                                    <span><strong>Прилет:</strong> ${seatMap.arrivalTime?string('dd.MM.yyyy HH:mm')}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="flight-info-item">
                                    <i class="fas fa-fighter-jet text-primary me-2"></i>
                                    <span><strong>Самолет:</strong> ${seatMap.aircraftModel}</span>
                                </div>
                                <div class="flight-info-item">
                                    <i class="fas fa-tag text-success me-2"></i>
                                    <span><strong>Цена эконом:</strong> <span class="text-success fw-bold">${seatMap.price} $</span></span>
                                </div>
                                <div class="flight-info-item">
                                    <i class="fas fa-star text-warning me-2"></i>
                                    <span><strong>Цена бизнес:</strong> <span class="text-warning fw-bold">${seatMap.businessPrice} $</span></span>
                                </div>
                                <div class="flight-info-item">
                                    <i class="fas fa-chair text-info me-2"></i>
                                    <span><strong>Свободно мест:</strong> ${seatMap.availableSeats} из ${seatMap.totalSeats}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card mb-4 shadow-sm">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="mb-0"><i class="fas fa-map-marked-alt me-2 text-primary"></i>Доступные места</h5>
                                <small class="text-muted">Выберите удобное место в салоне самолета</small>
                            </div>
                            <#if Session.SPRING_SECURITY_CONTEXT.authentication.authorities?seq_contains('USER')>
                                <button type="button" class="btn btn-primary btn-lg rounded-pill" data-bs-toggle="modal" data-bs-target="#seatSelectionModal">
                                    <i class="fas fa-chair me-2"></i>
                                    Выбрать место
                                </button>
                            <#else>
                                <div class="alert alert-warning mb-0 py-2">
                                    <i class="fas fa-exclamation-circle me-2"></i>
                                    Для бронирования <a href="/login" class="alert-link">войдите</a> в систему
                                </div>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="seatSelectionModal" tabindex="-1" aria-labelledby="seatSelectionModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg">
                <div class="modal-header bg-gradient-primary text-white">
                    <h5 class="modal-title" id="seatSelectionModalLabel">
                        <i class="fas fa-ticket-alt me-2"></i>
                        Выбор места на рейс ${seatMap.flightNumber}
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-8">
                            <div class="card mb-4 border-0 shadow-sm">
                                <div class="card-header bg-light">
                                    <h6 class="mb-0"><i class="fas fa-plane me-2 text-primary"></i>Схема салона</h6>
                                </div>
                                <div class="card-body p-4">
                                    <div class="airplane-container">
                                        <div class="airplane-nose text-center mb-3">
                                            <div class="plane-front">
                                                <div class="plane-windows"></div>
                                            </div>
                                        </div>

                                        <div class="cabin-section business-class mb-4">
                                            <div class="section-label">Бизнес-класс</div>
                                            <div class="seats-container">
                                                <#assign currentRow = 0>
                                                <#list seatMap.seats as seat>
                                                <#if seat.seatClass == 'BUSINESS'>
                                                <#assign row = seat.seatNumber?substring(0, seat.seatNumber?length-1)?number>

                                                <#if row != currentRow>
                                                <#if currentRow != 0></div></#if>
                                            <div class="seat-row" data-row="${row}">
                                                <div class="row-number">${row}</div>
                                                </#if>

                                                <#assign currentRow = row>
                                                <#assign seatLetter = seat.seatNumber?substring(seat.seatNumber?length-1)>

                                                <div class="seat-wrapper">
                                                    <button type="button"
                                                            class="seat ${seat.occupied?then('occupied', 'available')} business"
                                                            data-seat="${seat.seatNumber}"
                                                            data-seat-class="${seat.seatClass}"
                                                            data-price="${seatMap.businessPrice}"
                                                            ${seat.occupied?then('disabled', '')}
                                                            onclick="selectSeat('${seat.seatNumber}', '${seat.seatClass}', ${seatMap.businessPrice})">
                                                        ${seat.seatNumber}
                                                    </button>
                                                </div>

                                                <#if seatLetter == 'C'>
                                                    <div class="aisle"></div>
                                                </#if>
                                                </#if>
                                                </#list>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="cabin-section economy-class">
                                        <div class="section-label">Эконом-класс</div>
                                        <div class="seats-container">
                                            <#assign currentRow = 0>
                                            <#list seatMap.seats as seat>
                                            <#if seat.seatClass == 'ECONOMY'>
                                            <#assign row = seat.seatNumber?substring(0, seat.seatNumber?length-1)?number>

                                            <#if row != currentRow>
                                            <#if currentRow != 0></div></#if>
                                        <div class="seat-row" data-row="${row}">
                                            <div class="row-number">${row}</div>
                                            </#if>

                                            <#assign currentRow = row>
                                            <#assign seatLetter = seat.seatNumber?substring(seat.seatNumber?length-1)>

                                            <div class="seat-wrapper">
                                                <button type="button"
                                                        class="seat ${seat.occupied?then('occupied', 'available')} economy"
                                                        data-seat="${seat.seatNumber}"
                                                        data-seat-class="${seat.seatClass}"
                                                        data-price="${seatMap.price}"
                                                        ${seat.occupied?then('disabled', '')}
                                                        onclick="selectSeat('${seat.seatNumber}', '${seat.seatClass}', ${seatMap.price})">
                                                    ${seat.seatNumber}
                                                </button>
                                            </div>

                                            <#if seatLetter == 'C'>
                                                <div class="aisle"></div>
                                            </#if>
                                            </#if>
                                            </#list>
                                        </div>
                                    </div>
                                </div>

                                <div class="airplane-tail text-center mt-3">
                                    <div class="plane-tail"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card sticky-top border-0 shadow-sm" style="top: 20px;">
                        <div class="card-header bg-light">
                            <h6 class="mb-0"><i class="fas fa-info-circle me-2 text-primary"></i>Информация о бронировании</h6>
                        </div>
                        <div class="card-body">
                            <div class="mb-4">
                                <h6><i class="fas fa-key me-2"></i>Статус мест:</h6>
                                <div class="d-flex flex-column gap-2">
                                    <div class="d-flex align-items-center">
                                        <div class="seat-legend available economy me-2"></div>
                                        <span>Эконом (свободно)</span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <div class="seat-legend available business me-2"></div>
                                        <span>Бизнес (свободно)</span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <div class="seat-legend occupied me-2"></div>
                                        <span>Занято</span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <div class="seat-legend selected me-2"></div>
                                        <span>Выбрано</span>
                                    </div>
                                </div>
                            </div>

                            <hr>

                            <div id="selectedSeatInfo" class="mb-4" style="display: none;">
                                <h6><i class="fas fa-check-circle me-2 text-success"></i>Выбранное место:</h6>
                                <div class="selected-seat-card p-3 rounded mb-3">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="fw-bold">Место:</span>
                                        <span id="selectedSeatNumber" class="fw-bold fs-5">-</span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="fw-bold">Класс:</span>
                                        <span id="selectedSeatClass" class="badge">-</span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="fw-bold">Стоимость:</span>
                                        <span id="selectedSeatPrice" class="fw-bold fs-5 text-success">0 $</span>
                                    </div>
                                </div>
                            </div>

                            <div id="bookingConfirmationBlock" class="border rounded p-3 mb-3 bg-light" style="display: none;">
                                <h6 class="mb-3"><i class="fas fa-clipboard-check me-2 text-primary"></i>Подтверждение бронирования</h6>
                                <div class="booking-details">
                                    <div class="detail-item mb-2">
                                        <small class="text-muted">Рейс:</small>
                                        <div class="fw-bold">${seatMap.flightNumber}</div>
                                    </div>
                                    <div class="detail-item mb-2">
                                        <small class="text-muted">Место:</small>
                                        <div id="confirmSeatNumber" class="fw-bold">-</div>
                                    </div>
                                    <div class="detail-item mb-2">
                                        <small class="text-muted">Класс:</small>
                                        <div id="confirmSeatClass" class="fw-bold">-</div>
                                    </div>
                                    <div class="detail-item mb-3">
                                        <small class="text-muted">Стоимость:</small>
                                        <div id="confirmSeatPrice" class="fw-bold text-success">0 $</div>
                                    </div>
                                    <div class="d-flex gap-2">
                                        <button type="button" class="btn btn-outline-secondary btn-sm flex-grow-1 rounded-pill" id="cancelBookingBtn">
                                            <i class="fas fa-times me-1"></i> Отмена
                                        </button>
                                        <button type="button" class="btn btn-success btn-sm flex-grow-1 rounded-pill" id="confirmBookingBtn">
                                            <i class="fas fa-check me-1"></i> Подтвердить
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="alert alert-info mt-3">
                                <small>
                                    <i class="fas fa-info-circle me-2"></i>
                                    Доступно бизнес-мест: <strong>${seatMap.availableBusinessSeats}</strong><br>
                                    Доступно эконом-мест: <strong>${seatMap.availableEconomySeats}</strong>
                                </small>
                            </div>
                        </div>
                        <div class="card-footer bg-light">
                            <button type="button" class="btn btn-success w-100 rounded-pill py-2" id="confirmSelectionBtn" disabled>
                                <i class="fas fa-check-circle me-2"></i>
                                Подтвердить выбор
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    </div>

    <form action="/bookings/create" method="post" id="bookingForm" style="display: none;">
        <#if _csrf??>
            <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
                   value="${(_csrf.token)!'csrf-token'}"/>
        </#if>
        <input type="hidden" name="flightId" value="${seatMap.flightId}">
        <input type="hidden" name="seatNumber" id="selectedSeat" value="">
        <input type="hidden" name="classTypeId" id="selectedClassType" value="">
    </form>

    <style>
        .flight-info-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .seat-legend {
            width: 20px;
            height: 20px;
            border-radius: 4px;
            display: inline-block;
            border: 2px solid;
        }

        .seat-legend.available.economy {
            border-color: #28a745;
            background-color: #e8f5e8;
        }

        .seat-legend.available.business {
            border-color: #ffc107;
            background-color: #fff3cd;
        }

        .seat-legend.occupied {
            border-color: #dc3545;
            background-color: #f8d7da;
        }

        .seat-legend.selected {
            border-color: #17a2b8;
            background-color: #17a2b8;
        }

        .airplane-container {
            max-width: 100%;
            margin: 0 auto;
            background: linear-gradient(180deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 50px 50px 10px 10px;
            padding: 20px;
            position: relative;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .airplane-nose {
            margin-bottom: 20px;
        }

        .plane-front {
            width: 80px;
            height: 40px;
            background: #6c757d;
            border-radius: 40px 40px 0 0;
            margin: 0 auto;
            position: relative;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .plane-windows {
            position: absolute;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 10px;
            background: #d1d1d1;
            border-radius: 5px;
            display: flex;
            justify-content: space-around;
        }

        .plane-windows::before,
        .plane-windows::after {
            content: '';
            width: 8px;
            height: 8px;
            background: #f8f9fa;
            border-radius: 50%;
            margin: 0 2px;
        }

        .cabin-section {
            margin-bottom: 20px;
            position: relative;
        }

        .section-label {
            position: absolute;
            top: -10px;
            left: 50%;
            transform: translateX(-50%);
            background: #fff;
            padding: 0 10px;
            font-size: 12px;
            font-weight: bold;
            color: #6c757d;
            z-index: 1;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .business-class .section-label {
            color: #856404;
            background: #fff3cd;
        }

        .economy-class .section-label {
            color: #155724;
            background: #d4edda;
        }

        .seats-container {
            display: flex;
            flex-direction: column;
            gap: 10px;
            padding: 15px 0;
            border: 1px dashed #dee2e6;
            border-radius: 8px;
            background: #fff;
        }

        .seat-row {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            position: relative;
        }

        .row-number {
            position: absolute;
            left: -30px;
            font-weight: bold;
            color: #6c757d;
            font-size: 12px;
            background: #f8f9fa;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }

        .seat-wrapper {
            position: relative;
        }

        .seat {
            width: 40px;
            height: 40px;
            border: 2px solid;
            border-radius: 8px;
            background: white;
            font-size: 12px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .seat.economy.available {
            border-color: #28a745;
            color: #28a745;
            background: #e8f5e8;
        }

        .seat.economy.available:hover {
            background: #28a745;
            color: white;
            transform: scale(1.1);
        }

        .seat.business.available {
            border-color: #ffc107;
            background: #fff3cd;
            color: #856404;
        }

        .seat.business.available:hover {
            background: #ffc107;
            color: white;
            transform: scale(1.1);
        }

        .seat.occupied {
            border-color: #dc3545;
            color: #dc3545;
            background: #f8d7da;
            cursor: not-allowed;
            opacity: 0.7;
            box-shadow: none;
        }

        .seat.selected {
            border-color: #17a2b8;
            background: #17a2b8;
            color: white;
            transform: scale(1.1);
            box-shadow: 0 0 10px rgba(23, 162, 184, 0.5);
        }

        .aisle {
            width: 30px;
            height: 40px;
            border-left: 2px dashed #dee2e6;
            border-right: 2px dashed #dee2e6;
            background: linear-gradient(90deg, transparent 0%, #f8f9fa 50%, transparent 100%);
        }

        .airplane-tail {
            margin-top: 20px;
        }

        .plane-tail {
            width: 60px;
            height: 30px;
            background: #6c757d;
            border-radius: 0 0 30px 30px;
            margin: 0 auto;
            position: relative;
            box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.2);
        }

        #bookingConfirmationBlock {
            border-color: #dee2e6;
            transition: all 0.3s ease;
        }

        .selected-seat-card {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
        }

        .detail-item {
            padding-bottom: 5px;
            border-bottom: 1px dashed #eee;
        }

        @media (max-width: 768px) {
            .airplane-container {
                padding: 10px;
            }

            .seat {
                width: 30px;
                height: 30px;
                font-size: 10px;
            }

            .row-number {
                left: -25px;
            }
        }
    </style>

    <script>
        let selectedSeatNumber = null;
        let selectedSeatClass = null;
        let selectedSeatPrice = null;

        function selectSeat(seatNumber, seatClass, price) {
            if (selectedSeatNumber) {
                const prevSeat = document.querySelector('[data-seat="' + selectedSeatNumber + '"]');
                if (prevSeat) {
                    prevSeat.classList.remove('selected');
                }
            }

            const seat = document.querySelector('[data-seat="' + seatNumber + '"]');
            if (seat && !seat.classList.contains('occupied')) {
                seat.classList.add('selected');
                selectedSeatNumber = seatNumber;
                selectedSeatClass = seatClass;
                selectedSeatPrice = price;

                document.getElementById('selectedSeat').value = seatNumber;
                document.getElementById('selectedClassType').value = seatClass === 'BUSINESS' ? 1 : 2;

                updateSelectedSeatInfo(seatNumber, seatClass, price);

                document.getElementById('confirmSelectionBtn').disabled = false;

                document.getElementById('bookingConfirmationBlock').style.display = 'none';
            }
        }

        function updateSelectedSeatInfo(seatNumber, seatClass, price) {
            const seatInfo = document.getElementById('selectedSeatInfo');
            const seatNumberElement = document.getElementById('selectedSeatNumber');
            const seatClassElement = document.getElementById('selectedSeatClass');
            const seatPriceElement = document.getElementById('selectedSeatPrice');

            seatNumberElement.textContent = seatNumber;

            if (seatClass === 'BUSINESS') {
                seatClassElement.textContent = 'Бизнес';
                seatClassElement.className = 'badge bg-warning text-dark';
            } else {
                seatClassElement.textContent = 'Эконом';
                seatClassElement.className = 'badge bg-success';
            }

            seatPriceElement.textContent = price + ' $';
            seatInfo.style.display = 'block';
        }

        document.getElementById('confirmSelectionBtn').addEventListener('click', function() {
            if (selectedSeatNumber && selectedSeatClass && selectedSeatPrice) {
                document.getElementById('confirmSeatNumber').textContent = selectedSeatNumber;
                document.getElementById('confirmSeatClass').textContent =
                    selectedSeatClass === 'BUSINESS' ? 'Бизнес-класс' : 'Эконом-класс';
                document.getElementById('confirmSeatPrice').textContent = selectedSeatPrice + ' $';

                document.getElementById('bookingConfirmationBlock').style.display = 'block';

                document.getElementById('bookingConfirmationBlock').scrollIntoView({ behavior: 'smooth', block: 'nearest' });
            }
        });

        document.getElementById('confirmBookingBtn').addEventListener('click', function() {
            if (selectedSeatNumber) {
                document.getElementById('bookingForm').submit();
            }
        });

        document.getElementById('cancelBookingBtn').addEventListener('click', function() {
            document.getElementById('bookingConfirmationBlock').style.display = 'none';

            if (selectedSeatNumber) {
                const seat = document.querySelector('[data-seat="' + selectedSeatNumber + '"]');
                if (seat) {
                    seat.classList.remove('selected');
                }
                selectedSeatNumber = null;
                selectedSeatClass = null;
                selectedSeatPrice = null;

                document.getElementById('selectedSeat').value = '';
                document.getElementById('selectedClassType').value = '';

                document.getElementById('selectedSeatInfo').style.display = 'none';

                document.getElementById('confirmSelectionBtn').disabled = true;
            }
        });

        document.getElementById('seatSelectionModal').addEventListener('shown.bs.modal', function() {
            const firstAvailableSeat = document.querySelector('.seat.available:not(.occupied)');
            if (firstAvailableSeat && !selectedSeatNumber) {
                const seatNumber = firstAvailableSeat.getAttribute('data-seat');
                const seatClass = firstAvailableSeat.getAttribute('data-seat-class');
                const price = parseFloat(firstAvailableSeat.getAttribute('data-price'));

                selectSeat(seatNumber, seatClass, price);
            }
        });
    </script>

</@page>