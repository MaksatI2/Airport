<#import "../layout.ftlh" as layout>

<@layout.page title="Профиль - AirportBooking">

    <#if success??>
        <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
            <i class="fas fa-check-circle me-2"></i>
            <strong>Поздравляем!</strong> ${success}
            <#if bookingId??>
                <br><small>Вы можете найти детали бронирования в разделе "Мои бронирования"</small>
            </#if>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </#if>

    <#if error??>
        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>
            <strong>Ошибка!</strong> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </#if>

    <section class="py-5 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-lg-4">
                    <div class="card shadow-sm mb-4">
                        <div class="card-body text-center">
                            <div class="position-relative d-inline-block mb-3">
                                <img id="avatar-preview"
                                     src="/api/users/${user.id}/avatar"
                                     alt="Фото профиля"
                                     class="rounded-circle"
                                     style="width: 120px; height: 120px; object-fit: cover;">
                                <div class="position-absolute bottom-0 end-0">
                                    <form id="avatar-form" enctype="multipart/form-data">
                                        <input type="file" id="avatar-input" name="file" accept="image/*" style="display: none;">
                                        <label for="avatar-input" class="btn btn-sm btn-primary rounded-circle p-2">
                                            <i class="fas fa-camera"></i>
                                        </label>
                                    </form>
                                </div>
                            </div>
                            <h4 class="fw-bold">${user.username}</h4>
                            <p class="text-muted">${user.email}</p>
                            <div class="d-flex justify-content-center gap-2">
                                <span class="badge bg-primary">
                                    <i class="fas fa-user me-1"></i>${user.accountType!'USER'}
                                </span>
                                <#if user.enabled>
                                    <span class="badge bg-success">
                                        <i class="fas fa-check-circle me-1"></i>Активен
                                    </span>
                                <#else>
                                    <span class="badge bg-warning">
                                        <i class="fas fa-exclamation-triangle me-1"></i>Неактивен
                                    </span>
                                </#if>
                            </div>
                        </div>
                    </div>

                    <#if user.accountType == 'ADMIN' || user.accountType == 'AIRLINE'>
                        <div class="card shadow-sm mb-4">
                            <div class="card-header">
                                <h6 class="mb-0">
                                    <i class="fas fa-cog me-2"></i>Панель управления
                                </h6>
                            </div>
                            <div class="card-body">
                                <#if user.accountType == 'ADMIN'>
                                    <a href="/admin/flights" class="btn btn-outline-primary w-100 mb-2">
                                        <i class="fas fa-plane me-2"></i>Управление рейсами
                                    </a>
                                    <a href="/admin/airlines" class="btn btn-outline-primary w-100">
                                        <i class="fas fa-building me-2"></i>Управление авиакомпаниями
                                    </a>
                                <#elseif user.accountType == 'AIRLINE'>
                                    <a href="/airline/flights" class="btn btn-outline-primary w-100 mb-2">
                                        <i class="fas fa-list me-2"></i>Мои рейсы
                                    </a>
                                    <a href="/airline/flights/create" class="btn btn-outline-primary w-100">
                                        <i class="fas fa-plus me-2"></i>Добавить рейс
                                    </a>
                                </#if>
                            </div>
                        </div>
                    </#if>
                </div>

                <div class="col-lg-8">
                    <#if user.accountType == 'ADMIN'>
                        <div class="card shadow-sm">
                            <div class="card-header">
                                <h6 class="mb-0">
                                    <i class="fas fa-user-shield me-2"></i>Административная панель
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="text-center py-4">
                                    <i class="fas fa-user-shield fa-3x text-primary mb-3"></i>
                                    <h5>Добро пожаловать, администратор!</h5>
                                    <p>Используйте панель управления для администрирования системы</p>
                                </div>
                            </div>
                        </div>
                    <#elseif user.accountType == 'AIRLINE'>
                        <div class="card shadow-sm">
                            <div class="card-header">
                                <h6 class="mb-0">
                                    <i class="fas fa-plane me-2"></i>Информация для авиакомпании
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="text-center py-4">
                                    <i class="fas fa-plane fa-3x text-primary mb-3"></i>
                                    <h5>Добро пожаловать, ${user.username}!</h5>
                                    <p>Используйте панель управления для работы с рейсами вашей авиакомпании</p>
                                    <a href="/airline/flights" class="btn btn-primary">
                                        <i class="fas fa-list me-2"></i>Просмотреть рейсы
                                    </a>
                                </div>
                            </div>
                        </div>
                    <#else>
                        <div class="card shadow-sm">
                            <div class="card-header">
                                <h6 class="mb-0">
                                    <i class="fas fa-ticket-alt me-2"></i>Мои бронирования
                                    <#if bookings?size gt 0>
                                        <span class="badge bg-primary rounded-pill ms-1">${bookings?size}</span>
                                    </#if>
                                </h6>
                            </div>
                            <div class="card-body">
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
                    </#if>
                </div>
            </div>
        </div>
    </section>

    <script>
        document.getElementById('avatar-input').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (!file) return;

            const formData = new FormData();
            formData.append('file', file);

            const csrfToken = document.querySelector('meta[name="_csrf"]').content;
            const csrfHeader = document.querySelector('meta[name="_csrf_header"]').content;

            fetch(`/api/users/${user.id}/avatar`, {
                method: 'POST',
                body: formData,
                headers: {
                    [csrfHeader]: csrfToken
                }
            })
                .then(data => {
                    const avatarPreview = document.getElementById('avatar-preview');
                    avatarPreview.src = `/api/users/${user.id}/avatar`;

                    setTimeout(() => {
                        window.location.reload();
                    }, 1000);
                })
                .catch(error => {
                    alert(error.message);
                });
        });
    </script>

</@layout.page>