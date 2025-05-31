<#import "/spring.ftl" as spring>
<#import "../layout.ftlh" as layout>

<@layout.page title="Создание авиакомпании - AirportBooking">

    <section class="py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-7">
                    <div class="card shadow-lg border-0">
                        <div class="card-body p-5">
                            <div class="text-center mb-4">
                                <i class="fas fa-plane fa-3x text-primary mb-3"></i>
                                <h2 class="fw-bold">Создать авиакомпанию</h2>
                                <p class="text-muted">Добавить новую авиакомпанию в систему</p>
                            </div>

                            <#if successMessage??>
                                <div class="alert alert-success" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>${successMessage}
                                </div>
                            </#if>

                            <#if errorMessage??>
                                <div class="alert alert-danger d-flex align-items-center" role="alert">
                                    <i class="fas fa-exclamation-circle me-2"></i>
                                    <div>${errorMessage}</div>
                                </div>
                            </#if>

                            <form action="/admin/airlines/create" method="post">
                                <#if _csrf??>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                </#if>

                                <div class="mb-3">
                                    <label for="username" class="form-label fw-bold">
                                        <i class="fas fa-building me-2"></i>Название авиакомпании
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-building"></i></span>
                                        <@spring.bind "airline.username" />
                                        <input type="text" class="form-control form-control-lg <#if spring.status.error??>is-invalid</#if>"
                                               id="username" name="username" value="${spring.status.value!}"
                                               placeholder="Введите название авиакомпании" required>
                                    </div>
                                    <#if spring.status.error??>
                                        <div class="invalid-feedback d-block mt-1">${spring.status.errorMessage}</div>
                                    </#if>
                                    <div class="form-text">
                                        <i class="fas fa-info-circle me-1"></i>Это будет отображаться как имя авиакомпании
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="email" class="form-label fw-bold">
                                        <i class="fas fa-envelope me-2"></i>Email
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                        <@spring.bind "airline.email" />
                                        <input type="email" class="form-control form-control-lg <#if spring.status.error??>is-invalid</#if>"
                                               id="email" name="email" value="${spring.status.value!}"
                                               placeholder="Введите email авиакомпании" required>
                                    </div>
                                    <#if spring.status.error??>
                                        <div class="invalid-feedback d-block mt-1">${spring.status.errorMessage}</div>
                                    </#if>
                                    <div class="form-text">
                                        <i class="fas fa-info-circle me-1"></i>Будет использоваться для входа в систему
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="password" class="form-label fw-bold">
                                        <i class="fas fa-lock me-2"></i>Пароль
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                        <@spring.bind "airline.password" />
                                        <input type="password" class="form-control form-control-lg <#if spring.status.error??>is-invalid</#if>"
                                               id="password" name="password" placeholder="Минимум 6 символов" required>
                                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                    <#if spring.status.error??>
                                        <div class="invalid-feedback d-block mt-1">${spring.status.errorMessage}</div>
                                    </#if>
                                    <div class="form-text">
                                        <i class="fas fa-info-circle me-1"></i>Пароль должен содержать не менее 6 символов
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="confirmPassword" class="form-label fw-bold">
                                        <i class="fas fa-lock me-2"></i>Подтверждение пароля
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                        <input type="password" class="form-control form-control-lg"
                                               id="confirmPassword" name="confirmPassword"
                                               placeholder="Повторите пароль" required>
                                        <button class="btn btn-outline-secondary" type="button" id="toggleConfirmPassword">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                    <div id="passwordMismatch" class="invalid-feedback d-block mt-1" style="display: none;">
                                        Пароли не совпадают
                                    </div>
                                </div>

                                <div class="d-grid gap-2 d-md-flex justify-content-md-end mb-4">
                                    <a href="/admin/airlines" class="btn btn-secondary btn-lg me-md-2">
                                        <i class="fas fa-arrow-left me-2"></i>Отмена
                                    </a>
                                    <button type="submit" class="btn btn-primary btn-lg">
                                        <i class="fas fa-plane me-2"></i>Создать авиакомпанию
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script>
        function togglePasswordVisibility(passwordFieldId, toggleButtonId) {
            document.getElementById(toggleButtonId).addEventListener('click', function() {
                const passwordInput = document.getElementById(passwordFieldId);
                const icon = this.querySelector('i');

                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    icon.className = 'fas fa-eye-slash';
                } else {
                    passwordInput.type = 'password';
                    icon.className = 'fas fa-eye';
                }
            });
        }

        togglePasswordVisibility('password', 'togglePassword');
        togglePasswordVisibility('confirmPassword', 'toggleConfirmPassword');

        function validatePasswordMatch() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const mismatchDiv = document.getElementById('passwordMismatch');
            const confirmPasswordField = document.getElementById('confirmPassword');

            if (confirmPassword && password !== confirmPassword) {
                confirmPasswordField.classList.add('is-invalid');
                mismatchDiv.style.display = 'block';
                return false;
            } else {
                confirmPasswordField.classList.remove('is-invalid');
                mismatchDiv.style.display = 'none';
                return true;
            }
        }

        document.getElementById('password').addEventListener('input', validatePasswordMatch);
        document.getElementById('confirmPassword').addEventListener('input', validatePasswordMatch);

        document.querySelector('form').addEventListener('submit', function(e) {
            const username = document.getElementById('username').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (!username || !email || !password || !confirmPassword) {
                e.preventDefault();
                alert('Пожалуйста, заполните все обязательные поля');
                return;
            }

            if (password.length < 6) {
                e.preventDefault();
                alert('Пароль должен содержать не менее 6 символов');
                return;
            }

            if (!validatePasswordMatch()) {
                e.preventDefault();
                alert('Пароли не совпадают');
                return;
            }

            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Пожалуйста, введите корректный email адрес');
                return;
            }

            if (!confirm('Вы уверены, что хотите создать эту авиакомпанию?')) {
                e.preventDefault();
            }
        });

        document.querySelectorAll('.form-control').forEach(function(input) {
            input.addEventListener('focus', function() {
                const icon = this.parentElement.querySelector('.input-group-text i');
                if (icon) {
                    icon.style.color = '#0d6efd';
                    icon.style.transform = 'scale(1.1)';
                    icon.style.transition = 'all 0.2s ease';
                }
            });

            input.addEventListener('blur', function() {
                const icon = this.parentElement.querySelector('.input-group-text i');
                if (icon) {
                    icon.style.color = '';
                    icon.style.transform = '';
                }
            });
        });
    </script>

</@layout.page>