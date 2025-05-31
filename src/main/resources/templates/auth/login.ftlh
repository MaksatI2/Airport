<#import "../layout.ftlh" as layout>

<@layout.page title="Вход в систему - AirportBooking">

    <section class="py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-4">
                    <div class="card shadow-lg border-0">
                        <div class="card-body p-5">
                            <div class="text-center mb-4">
                                <i class="fas fa-sign-in-alt fa-3x text-primary mb-3"></i>
                                <h2 class="fw-bold">Добро пожаловать</h2>
                                <p class="text-muted">Войдите в свой аккаунт</p>
                            </div>

                            <#if loginError??>
                                <div class="alert alert-danger" role="alert">
                                    <i class="fas fa-exclamation-triangle me-2"></i>${loginError}
                                </div>
                            </#if>

                            <#if registrationSuccess??>
                                <div class="alert alert-success" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>${registrationSuccess}
                                </div>
                            </#if>

                            <form action="/login" method="post">
                                <#if _csrf??>
                                    <input type="hidden" name="${(_csrf.parameterName)!'csrf-param-name'}"
                                           value="${(_csrf.token)!'csrf-token'}"/>
                                </#if>
                                <div class="mb-3">
                                    <label for="username" class="form-label fw-bold">
                                        <i class="fas fa-envelope me-2"></i>Email
                                    </label>
                                    <input type="email"
                                           class="form-control form-control-lg"
                                           id="username"
                                           name="username"
                                           placeholder="Введите ваш email"
                                           required>
                                </div>

                                <div class="mb-3">
                                    <label for="password" class="form-label fw-bold">
                                        <i class="fas fa-lock me-2"></i>Пароль
                                    </label>
                                    <div class="input-group">
                                        <input type="password"
                                               class="form-control form-control-lg"
                                               id="password"
                                               name="password"
                                               placeholder="Введите пароль"
                                               required>
                                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="d-grid mb-4">
                                    <button type="submit" class="btn btn-primary btn-lg">
                                        <i class="fas fa-sign-in-alt me-2"></i>Войти
                                    </button>
                                </div>

                                <div class="text-center">
                                    <p class="text-muted">
                                        Нет аккаунта?
                                        <a href="/auth/register" class="text-decoration-none fw-bold">Зарегистрироваться</a>
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
        // Показать/скрыть пароль
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