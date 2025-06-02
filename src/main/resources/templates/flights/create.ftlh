<#include "../layout.ftlh">
<#import "/spring.ftl" as spring>

<@page title="Создание рейса">
    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="d-flex align-items-center mb-4">
                    <a href="/admin/flights" class="btn btn-outline-secondary me-3">
                        <i class="fas fa-arrow-left"></i>
                    </a>
                    <h1>
                        <i class="fas fa-plane me-2"></i>
                        Создание рейса
                    </h1>
                </div>

                <#if errorMessage??>
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                    </div>
                </#if>

                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <i class="fas fa-plus me-2"></i>
                            Информация о новом рейсе
                        </h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="/airline/flights/create" novalidate>
                            <#if _csrf??>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </#if>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="departureAirportId" class="form-label">
                                        <i class="fas fa-plane-departure me-2"></i>Откуда *
                                    </label>
                                    <@spring.bind "flight.departureAirportId"/>
                                    <select class="form-select <#if spring.status.error>is-invalid</#if>"
                                            id="departureAirportId"
                                            name="departureAirportId"
                                            required>
                                        <option value="">Выберите аэропорт отправления</option>
                                        <#if destinations??>
                                            <#list destinations as destination>
                                                <option value="${destination.id}"
                                                        <#if spring.status.value?? && spring.status.value == destination.id?string>selected</#if>>
                                                    ${destination.name}
                                                </option>
                                            </#list>
                                        </#if>
                                    </select>
                                    <#if spring.status.error>
                                        <div class="invalid-feedback">
                                            <#list spring.status.errorMessages as error>${error}<#sep>, </#list>
                                        </div>
                                    </#if>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="destinationId" class="form-label">
                                        <i class="fas fa-plane-arrival me-2"></i>Куда *
                                    </label>
                                    <@spring.bind "flight.destinationId"/>
                                    <select class="form-select <#if spring.status.error>is-invalid</#if>"
                                            id="destinationId"
                                            name="destinationId"
                                            required>
                                        <option value="">Выберите аэропорт назначения</option>
                                        <#if destinations??>
                                            <#list destinations as destination>
                                                <option value="${destination.id}"
                                                        <#if spring.status.value?? && spring.status.value == destination.id?string>selected</#if>>
                                                    ${destination.name}
                                                </option>
                                            </#list>
                                        </#if>
                                    </select>
                                    <#if spring.status.error>
                                        <div class="invalid-feedback">
                                            <#list spring.status.errorMessages as error>${error}<#sep>, </#list>
                                        </div>
                                    </#if>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="departureTime" class="form-label">
                                        <i class="fas fa-clock me-2"></i>Время вылета *
                                    </label>
                                    <@spring.bind "flight.departureTime"/>
                                    <input type="datetime-local"
                                           class="form-control <#if spring.status.error>is-invalid</#if>"
                                           id="departureTime"
                                           name="departureTime"
                                            <#if spring.status.value??>
                                                <#assign departureValue = spring.status.value>
                                                <#if departureValue?is_string>
                                                    value="${departureValue}"
                                                <#elseif departureValue?has_content>
                                                    value="${departureValue?string('yyyy-MM-dd\'T\'HH:mm')}"
                                                </#if>
                                            </#if>
                                           required>
                                    <#if spring.status.error>
                                        <div class="invalid-feedback">
                                            <#list spring.status.errorMessages as error>${error}<#sep>, </#list>
                                        </div>
                                    </#if>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="arrivalTime" class="form-label">
                                        <i class="fas fa-clock me-2"></i>Время прилета *
                                    </label>
                                    <@spring.bind "flight.arrivalTime"/>
                                    <input type="datetime-local"
                                           class="form-control <#if spring.status.error>is-invalid</#if>"
                                           id="arrivalTime"
                                           name="arrivalTime"
                                            <#if spring.status.value??>
                                                <#assign arrivalValue = spring.status.value>
                                                <#if arrivalValue?is_string>
                                                    value="${arrivalValue}"
                                                <#elseif arrivalValue?has_content>
                                                    value="${arrivalValue?string('yyyy-MM-dd\'T\'HH:mm')}"
                                                </#if>
                                            </#if>
                                           required>
                                    <#if spring.status.error>
                                        <div class="invalid-feedback">
                                            <#list spring.status.errorMessages as error>${error}<#sep>, </#list>
                                        </div>
                                    </#if>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="airplaneId" class="form-label">
                                    <i class="fas fa-plane me-2"></i>Самолет *
                                </label>
                                <@spring.bind "flight.airplaneId"/>
                                <select class="form-select <#if spring.status.error>is-invalid</#if>"
                                        id="airplaneId"
                                        name="airplaneId"
                                        required>
                                    <option value="">Выберите самолет</option>
                                    <#if airplanes??>
                                        <#list airplanes as airplane>
                                            <option value="${airplane.id}"
                                                    <#if spring.status.value?? && spring.status.value == airplane.id?string>selected</#if>>
                                                ${airplane.model} (Вместимость: ${airplane.capacity} мест)
                                            </option>
                                        </#list>
                                    </#if>
                                </select>
                                <#if spring.status.error>
                                    <div class="invalid-feedback">
                                        <#list spring.status.errorMessages as error>${error}<#sep>, </#list>
                                    </div>
                                </#if>
                                <div class="form-text">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Показаны только доступные самолеты (не занятые другими рейсами)
                                </div>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="/profile" class="btn btn-secondary">
                                    <i class="fas fa-times me-2"></i>Отмена
                                </a>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-plus me-2"></i>
                                    Создать рейс
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-md-4">
                        <div class="card border-primary">
                            <div class="card-body text-center">
                                <i class="fas fa-info-circle fa-2x text-primary mb-2"></i>
                                <h6>Время вылета</h6>
                                <small class="text-muted">Указывается в местном времени аэропорта отправления</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card border-success">
                            <div class="card-body text-center">
                                <i class="fas fa-plane fa-2x text-success mb-2"></i>
                                <h6>Самолет</h6>
                                <small class="text-muted">Доступны только свободные самолеты</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card border-warning">
                            <div class="card-body text-center">
                                <i class="fas fa-exclamation-triangle fa-2x text-warning mb-2"></i>
                                <h6>Важно</h6>
                                <small class="text-muted">Все поля обязательны для заполнения</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            const departureTime = document.getElementById('departureTime');
            const arrivalTime = document.getElementById('arrivalTime');
            const departureSelect = document.getElementById('departureAirportId');
            const destinationSelect = document.getElementById('destinationId');

            const allDestinationOptions = Array.from(destinationSelect.options);
            const allDepartureOptions = Array.from(departureSelect.options);

            function validateTimes() {
                if (departureTime.value && arrivalTime.value) {
                    const departure = new Date(departureTime.value);
                    const arrival = new Date(arrivalTime.value);

                    if (arrival <= departure) {
                        arrivalTime.setCustomValidity('Время прилета должно быть позже времени вылета');
                    } else {
                        arrivalTime.setCustomValidity('');
                    }
                }
            }

            function updateDestinationOptions() {
                const selectedDeparture = departureSelect.value;
                const currentDestination = destinationSelect.value;

                destinationSelect.innerHTML = '';

                allDestinationOptions.forEach(option => {
                    if (option.value === '' || option.value !== selectedDeparture) {
                        const newOption = option.cloneNode(true);
                        destinationSelect.appendChild(newOption);
                    }
                });

                if (currentDestination && currentDestination !== selectedDeparture) {
                    destinationSelect.value = currentDestination;
                }
            }

            function updateDepartureOptions() {
                const selectedDestination = destinationSelect.value;
                const currentDeparture = departureSelect.value;

                departureSelect.innerHTML = '';

                allDepartureOptions.forEach(option => {
                    if (option.value === '' || option.value !== selectedDestination) {
                        const newOption = option.cloneNode(true);
                        departureSelect.appendChild(newOption);
                    }
                });

                if (currentDeparture && currentDeparture !== selectedDestination) {
                    departureSelect.value = currentDeparture;
                }
            }

            function validateAirports() {
                if (departureSelect.value && destinationSelect.value &&
                    departureSelect.value === destinationSelect.value) {
                    destinationSelect.setCustomValidity('Аэропорт назначения должен отличаться от аэропорта отправления');
                } else {
                    destinationSelect.setCustomValidity('');
                }
            }

            departureTime.addEventListener('change', validateTimes);
            arrivalTime.addEventListener('change', validateTimes);

            departureSelect.addEventListener('change', function() {
                updateDestinationOptions();
                validateAirports();
            });

            destinationSelect.addEventListener('change', function() {
                updateDepartureOptions();
                validateAirports();
            });

            const now = new Date();
            now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
            departureTime.min = now.toISOString().slice(0, 16);

            if (departureSelect.value) {
                updateDestinationOptions();
            }
            if (destinationSelect.value) {
                updateDepartureOptions();
            }
        });
    </script>
</@page>