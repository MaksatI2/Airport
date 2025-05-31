<#import "layout.ftlh" as layout>

<@layout.page title="AirportBooking - Найдите лучшие авиабилеты">
    <script src="https://cdn.jsdelivr.net/npm/autocomplete.js@2.3.2/dist/autocomplete.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ru.js"></script>

    <section class="hero-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 text-center">
                    <h1 class="display-4 fw-bold mb-4 text-white">Найдите лучшие авиабилеты</h1>
                    <p class="lead mb-5 text-white">Сравнивайте цены и выбирайте удобные рейсы</p>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="search-card p-4 bg-white rounded-3 shadow">
                        <form id="searchForm" action="/flights/search" method="GET">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label fw-bold">Откуда</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-plane-departure"></i></span>
                                        <input type="text" id="fromInput" class="form-control" name="fromQuery" placeholder="Город отправления" autocomplete="off">
                                        <input type="hidden" id="fromId" name="from">
                                        <div id="fromResults" class="autocomplete-results position-relative"></div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label fw-bold">Куда</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-plane-arrival"></i></span>
                                        <input type="text" id="toInput" class="form-control" name="toQuery" placeholder="Город назначения" autocomplete="off">
                                        <input type="hidden" id="toId" name="to">
                                        <div id="toResults" class="autocomplete-results position-relative"></div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label fw-bold">Даты вылета</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
                                        <input type="text" id="dateRange" class="form-control" placeholder="Выберите период" readonly>
                                        <input type="hidden" id="startDate" name="startDate">
                                        <input type="hidden" id="endDate" name="endDate">
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div class="col-12 text-center">
                                    <button type="submit" class="btn btn-primary btn-lg px-5">
                                        <i class="fas fa-search me-2"></i>Найти рейсы
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5 bg-white">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center mb-5">
                    <h2 class="fw-bold">Популярные направления</h2>
                    <p class="text-muted">Откройте для себя самые востребованные маршруты</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-md-6 col-lg-4">
                    <div class="card feature-card h-100 border-0 shadow-sm">
                        <img src="/static/images/moscow.jpg" class="card-img-top" alt="Москва" style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Москва</h5>
                            <p class="card-text text-muted">Столица России с богатой историей</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="fw-bold text-primary">от 350 $</span>
                                <small class="text-muted">2ч 30м</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="card feature-card h-100 border-0 shadow-sm">
                        <img src="/static/images/stambul.jpeg" class="card-img-top" alt="Стамбул" style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Стамбул</h5>
                            <p class="card-text text-muted">Мост между Европой и Азией</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="fw-bold text-primary">от 450 $</span>
                                <small class="text-muted">3ч 45м</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="card feature-card h-100 border-0 shadow-sm">
                        <img src="/static/images/dubai.avif" class="card-img-top" alt="Дубай" style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Дубай</h5>
                            <p class="card-text text-muted">Город будущего в пустыне</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="fw-bold text-primary">от 550 $</span>
                                <small class="text-muted">4ч 15м</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center mb-5">
                    <h2 class="fw-bold">Почему выбирают нас</h2>
                    <p class="text-muted">Мы делаем путешествия проще и доступнее</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-md-6 col-lg-3">
                    <div class="text-center p-3 bg-white rounded-3 shadow-sm h-100">
                        <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 80px; height: 80px;">
                            <i class="fas fa-dollar-sign fa-2x"></i>
                        </div>
                        <h5 class="mt-3">Лучшие цены</h5>
                        <p class="text-muted">Сравниваем предложения авиакомпаний для поиска лучших цен</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="text-center p-3 bg-white rounded-3 shadow-sm h-100">
                        <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 80px; height: 80px;">
                            <i class="fas fa-clock fa-2x"></i>
                        </div>
                        <h5 class="mt-3">Быстрое бронирование</h5>
                        <p class="text-muted">Забронируйте билет всего в несколько кликов</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="text-center p-3 bg-white rounded-3 shadow-sm h-100">
                        <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 80px; height: 80px;">
                            <i class="fas fa-shield-alt fa-2x"></i>
                        </div>
                        <h5 class="mt-3">Безопасность</h5>
                        <p class="text-muted">Ваши данные защищены современными технологиями шифрования</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="text-center p-3 bg-white rounded-3 shadow-sm h-100">
                        <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 80px; height: 80px;">
                            <i class="fas fa-headset fa-2x"></i>
                        </div>
                        <h5 class="mt-3">Поддержка 24/7</h5>
                        <p class="text-muted">Наша служба поддержки работает круглосуточно</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5 bg-white">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-3 col-6">
                    <div class="mb-3 p-3">
                        <h2 class="fw-bold text-primary">1M+</h2>
                        <p class="text-muted">Довольных клиентов</p>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="mb-3 p-3">
                        <h2 class="fw-bold text-primary">500+</h2>
                        <p class="text-muted">Направлений</p>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="mb-3 p-3">
                        <h2 class="fw-bold text-primary">100+</h2>
                        <p class="text-muted">Авиакомпаний</p>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="mb-3 p-3">
                        <h2 class="fw-bold text-primary">24/7</h2>
                        <p class="text-muted">Поддержка</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <style>
        .hero-section {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            padding: 5rem 0;
        }

        .search-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .autocomplete-results {
            position: absolute;
            z-index: 1000;
            width: 100%;
            max-height: 200px;
            overflow-y: auto;
            background: #ffffff;
            border: 1px solid #ced4da;
            border-top: none;
            border-radius: 0 0 4px 4px;
            display: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-top: -1px;
            left: 0;
            box-sizing: border-box;
        }

        .autocomplete-item {
            padding: 10px 15px;
            cursor: pointer;
            transition: background-color 0.2s;
            color: #212529;
            font-size: 16px;
            border-bottom: 1px solid #f8f9fa;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .autocomplete-item:last-child {
            border-bottom: none;
        }

        .autocomplete-item:hover {
            background-color: #f8f9fa;
            color: #0d6efd;
        }

        .feature-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
        }

        .card-img-top {
            border-radius: 8px 8px 0 0 !important;
        }

        .flatpickr-calendar {
            border-radius: 8px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            border: none;
        }

        .flatpickr-current-month .flatpickr-monthDropdown-months {
            background: #2a5298;
            color: white;
            border: none;
        }

        .flatpickr-weekday {
            background: #f8f9fa;
            color: #6c757d;
            font-weight: 600;
        }

        .flatpickr-day.selected, .flatpickr-day.startRange, .flatpickr-day.endRange {
            background: #2a5298;
            border-color: #2a5298;
        }

        .flatpickr-day.inRange {
            background: rgba(42, 82, 152, 0.1);
            border-color: rgba(42, 82, 152, 0.3);
        }

        .flatpickr-day:hover {
            background: rgba(42, 82, 152, 0.2);
        }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Инициализация календаря с выбором диапазона дат
            const dateRangeInput = document.getElementById('dateRange');
            const startDateInput = document.getElementById('startDate');
            const endDateInput = document.getElementById('endDate');

            const fp = flatpickr(dateRangeInput, {
                mode: "range",
                locale: "ru",
                dateFormat: "d.m.Y",
                minDate: "today",
                showMonths: 2,
                static: true,
                monthSelectorType: "static",
                onChange: function(selectedDates, dateStr, instance) {
                    if (selectedDates.length === 2) {
                        // Форматируем даты для отправки на сервер (YYYY-MM-DD)
                        const startDate = selectedDates[0];
                        const endDate = selectedDates[1];

                        startDateInput.value = startDate.getFullYear() + '-' +
                            String(startDate.getMonth() + 1).padStart(2, '0') + '-' +
                            String(startDate.getDate()).padStart(2, '0');

                        endDateInput.value = endDate.getFullYear() + '-' +
                            String(endDate.getMonth() + 1).padStart(2, '0') + '-' +
                            String(endDate.getDate()).padStart(2, '0');
                    } else if (selectedDates.length === 1) {
                        // Если выбрана только одна дата, используем её как начальную
                        const startDate = selectedDates[0];
                        startDateInput.value = startDate.getFullYear() + '-' +
                            String(startDate.getMonth() + 1).padStart(2, '0') + '-' +
                            String(startDate.getDate()).padStart(2, '0');
                        endDateInput.value = '';
                    } else {
                        // Очищаем скрытые поля если даты не выбраны
                        startDateInput.value = '';
                        endDateInput.value = '';
                    }
                }
            });

            // Автокомплит для поля "Откуда"
            const fromInput = document.getElementById('fromInput');
            const fromResults = document.getElementById('fromResults');
            const fromIdInput = document.getElementById('fromId');

            fromInput.addEventListener('input', function() {
                const query = this.value.trim();
                if (query.length === 0) {
                    fromResults.style.display = 'none';
                    return;
                }

                fetch('/api/destinations?query=' + encodeURIComponent(query))
                    .then(response => response.json())
                    .then(data => {
                        fromResults.innerHTML = '';
                        if (data.length > 0) {
                            data.forEach(item => {
                                const div = document.createElement('div');
                                div.className = 'autocomplete-item';
                                div.textContent = item.name;
                                div.addEventListener('click', function() {
                                    fromInput.value = item.name;
                                    fromIdInput.value = item.id;
                                    fromResults.style.display = 'none';
                                });
                                fromResults.appendChild(div);
                            });
                            fromResults.style.display = 'block';
                        } else {
                            fromResults.style.display = 'none';
                        }
                    })
                    .catch(error => {
                        console.error('Error fetching destinations:', error);
                        fromResults.style.display = 'none';
                    });
            });

            // Автокомплит для поля "Куда"
            const toInput = document.getElementById('toInput');
            const toResults = document.getElementById('toResults');
            const toIdInput = document.getElementById('toId');

            toInput.addEventListener('input', function() {
                const query = this.value.trim();
                if (query.length === 0) {
                    toResults.style.display = 'none';
                    return;
                }

                fetch('/api/destinations?query=' + encodeURIComponent(query))
                    .then(response => response.json())
                    .then(data => {
                        toResults.innerHTML = '';
                        if (data.length > 0) {
                            data.forEach(item => {
                                const div = document.createElement('div');
                                div.className = 'autocomplete-item';
                                div.textContent = item.name;
                                div.addEventListener('click', function() {
                                    toInput.value = item.name;
                                    toIdInput.value = item.id;
                                    toResults.style.display = 'none';
                                });
                                toResults.appendChild(div);
                            });
                            toResults.style.display = 'block';
                        } else {
                            toResults.style.display = 'none';
                        }
                    })
                    .catch(error => {
                        console.error('Error fetching destinations:', error);
                        toResults.style.display = 'none';
                    });
            });

            // Скрываем автокомплит при клике вне элементов
            document.addEventListener('click', function(e) {
                if (e.target !== fromInput && !fromResults.contains(e.target)) {
                    fromResults.style.display = 'none';
                }
                if (e.target !== toInput && !toResults.contains(e.target)) {
                    toResults.style.display = 'none';
                }
            });

            document.getElementById('searchForm').addEventListener('submit', function(e) {
                const from = fromIdInput.value;
                const to = toIdInput.value;

                if (!from || !to) {
                    e.preventDefault();
                    alert('Пожалуйста, выберите города отправления и назначения');
                    return false;
                }

                if (from === to) {
                    e.preventDefault();
                    alert('Города отправления и назначения не могут совпадать');
                    return false;
                }
            });
        });
    </script>
</@layout.page>