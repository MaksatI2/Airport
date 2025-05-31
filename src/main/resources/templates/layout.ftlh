<#macro page title="" styles="" activeNav="">
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        <title>${title!"AirportBooking - Бронирование авиабилетов"}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            .navbar-brand {
                font-weight: bold;
                font-size: 1.5rem;
            }
            .hero-section {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 100px 0;
            }
            .search-card {
                background: rgba(255, 255, 255, 0.95);
                border-radius: 15px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            }
            .feature-card {
                transition: transform 0.3s ease;
                border: none;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }
            .feature-card:hover {
                transform: translateY(-5px);
            }
            .btn-primary {
                background: linear-gradient(45deg, #667eea, #764ba2);
                border: none;
            }
            .btn-primary:hover {
                background: linear-gradient(45deg, #5a6fd8, #6b4190);
            }
            footer {
                background-color: #2c3e50;
                color: white;
            }
            .profile-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
            }
        </style>
    </head>
    <body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-plane me-2"></i>AirportBooking
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/">Главная</a>
                    </li>
                    <#if Session.SPRING_SECURITY_CONTEXT??>
                        <#if Session.SPRING_SECURITY_CONTEXT.authentication.authorities?seq_contains('ADMIN')>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-cog me-2"></i>Управление
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="/admin/flights">
                                            <i class="fas fa-plane me-2"></i>Управление рейсами
                                        </a></li>
                                    <li><a class="dropdown-item" href="/admin/airlines">
                                            <i class="fas fa-building me-2"></i>Управление авиакомпаниями
                                        </a></li>
                                </ul>
                            </li>
                        <#elseif Session.SPRING_SECURITY_CONTEXT.authentication.authorities?seq_contains('AIRLINE')>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-plane-departure me-2"></i>Управление рейсами
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="/airline/flights">
                                            <i class="fas fa-list me-2"></i>Мои рейсы
                                        </a></li>
                                    <li><a class="dropdown-item" href="/airline/flights/create">
                                            <i class="fas fa-plus me-2"></i>Добавить рейс
                                        </a></li>
                                </ul>
                            </li>
                        <#else>
                            <li class="nav-item">
                                <a class="nav-link" href="/flights">Рейсы</a>
                            </li>
                        </#if>
                    <#else>
                        <li class="nav-item">
                            <a class="nav-link" href="/flights">Рейсы</a>
                        </li>
                    </#if>
                    <#if Session.SPRING_SECURITY_CONTEXT??>
                        <#if Session.SPRING_SECURITY_CONTEXT.authentication.authorities?seq_contains('USER')>
                            <li class="nav-item">
                                <a class="nav-link" href="/bookings">Мои бронирования</a>
                            </li>
                        </#if>
                    </#if>
                </ul>

                <ul class="navbar-nav">
                    <#if Session.SPRING_SECURITY_CONTEXT??>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                                <img src="/static/avatar/default_avatar.jpg" alt="Avatar" class="profile-avatar me-2">
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="/profile"><i class="fas fa-user me-2"></i>Профиль</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <form action="/logout" method="post" class="dropdown-item">
                                    <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
                                    <button type="submit"><i class="fas fa-sign-out-alt me-2"></i>Выйти</button>
                                </form>
                            </ul>
                        </li>
                    <#else>
                        <li class="nav-item">
                            <a class="nav-link" href="/auth/login">Войти</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-primary ms-2" href="/auth/register">Регистрация</a>
                        </li>
                    </#if>
                </ul>
            </div>
        </div>
    </nav>

    <main style="margin-top: 76px;">
        <#nested>
    </main>

    <footer class="py-5 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <h5><i class="fas fa-plane me-2"></i>AirportBooking</h5>
                    <p class="text-muted">Лучший сервис для бронирования авиабилетов</p>
                </div>
                <div class="col-md-3">
                    <h6>Компания</h6>
                    <ul class="list-unstyled">
                        <li><a href="/about" class="text-muted text-decoration-none">О нас</a></li>
                        <li><a href="/contact" class="text-muted text-decoration-none">Контакты</a></li>
                        <li><a href="/careers" class="text-muted text-decoration-none">Карьера</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h6>Поддержка</h6>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-muted text-decoration-none">Помощь</a></li>
                        <li><a href="#" class="text-muted text-decoration-none">FAQ</a></li>
                        <li><a href="#" class="text-muted text-decoration-none">Условия</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h6>Следите за нами</h6>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-muted"><i class="fab fa-facebook fa-lg"></i></a>
                        <a href="#" class="text-muted"><i class="fab fa-twitter fa-lg"></i></a>
                        <a href="#" class="text-muted"><i class="fab fa-instagram fa-lg"></i></a>
                    </div>
                </div>
            </div>
            <hr class="my-4">
            <div class="text-center text-muted">
                <p>&copy; 2025 AirportBooking. Все права защищены.</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>
</#macro>