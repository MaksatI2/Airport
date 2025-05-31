<#import "/spring.ftl" as spring>
<#import "../layout.ftlh" as layout>

<@layout.page title="Регистрация - AirportBooking">

    <section class="py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-5">
                    <div class="card shadow-lg border-0">
                        <div class="card-body p-5">
                            <div class="text-center mb-4">
                                <i class="fas fa-user-plus fa-3x text-primary mb-3"></i>
                                <h2 class="fw-bold">Создать аккаунт</h2>
                                <p class="text-muted">Присоединяйтесь к нашему сервису бронирования</p>
                            </div>

                            <#if registrationSuccess??>
                                <div class="alert alert-success" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>${registrationSuccess}
                                </div>
                            </#if>

                            <#if error??>
                                <div class="alert alert-danger d-flex align-items-center" role="alert">
                                    <i class="fas fa-exclamation-circle me-2"></i>
                                    <div>${error}</div>
                                </div>
                            </#if>

                            <form action="/auth/register" method="post">
                                <#if _csrf??>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                </#if>

                                <div class="mb-3">
                                    <label for="username" class="form-label fw-bold">
                                        <i class="fas fa-user me-2"></i>Имя пользователя
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        <@spring.bind "user.username" />
                                        <input type="text" class="form-control form-control-lg <#if spring.status.error??>is-invalid</#if>"
                                               id="username" name="username" value="${spring.status.value!}" placeholder="Введите ваше имя">
                                    </div>
                                    <#if spring.status.error??>
                                        <div class="invalid-feedback d-block mt-1">${spring.status.errorMessage}</div>
                                    </#if>
                                </div>

                                <div class="mb-3">
                                    <label for="email" class="form-label fw-bold">
                                        <i class="fas fa-envelope me-2"></i>Email
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                        <@spring.bind "user.email" />
                                        <input type="email" class="form-control form-control-lg <#if spring.status.error??>is-invalid</#if>"
                                               id="email" name="email" value="${spring.status.value!}" placeholder="Введите ваш email">
                                    </div>
                                    <#if spring.status.error??>
                                        <div class="invalid-feedback d-block mt-1">${spring.status.errorMessage}</div>
                                    </#if>
                                </div>

                                <div class="mb-3">
                                    <label for="password" class="form-label fw-bold">
                                        <i class="fas fa-lock me-2"></i>Пароль
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                        <@spring.bind "user.password" />
                                        <input type="password" class="form-control form-control-lg <#if spring.status.error??>is-invalid</#if>"
                                               id="password" name="password" placeholder="Минимум 6 символов">
                                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                    <#if spring.status.error??>
                                        <div class="invalid-feedback d-block mt-1">${spring.status.errorMessage}</div>
                                    </#if>
                                </div>

                                <div class="mb-4">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="terms" required>
                                        <label class="form-check-label" for="terms">
                                            Я согласен с условиями использования
                                            и политикой конфиденциальности
                                        </label>
                                    </div>
                                </div>

                                <div class="d-grid mb-4">
                                    <button type="submit" class="btn btn-primary btn-lg">
                                        <i class="fas fa-user-plus me-2"></i>Создать аккаунт
                                    </button>
                                </div>

                                <div class="text-center">
                                    <p class="text-muted">
                                        Уже есть аккаунт?
                                        <a href="/auth/login" class="text-decoration-none fw-bold">Войти</a>
                                    </p>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script>
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const icon = this.querySelector('i');

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.className = 'fas fa-eye-slash';
            } else {
                passwordInput.type = 'password';
                icon.className = 'fas fa-eye';
            }
        });
    </script>

</@layout.page>
