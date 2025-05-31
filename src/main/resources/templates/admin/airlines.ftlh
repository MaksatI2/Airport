<#import "../layout.ftlh" as layout>

<@layout.page title="Управление авиакомпаниями">
    <div class="container my-5">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-building me-2"></i>Управление авиакомпаниями</h2>
                    <a href="/admin/airlines/create" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Создать авиакомпанию
                    </a>
                </div>

                <#if successMessage??>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </#if>

                <#if errorMessage??>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </#if>

                <div class="card">
                    <div class="card-body">
                        <#if airlines??>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Название</th>
                                        <th>Email</th>
                                        <th>Количество рейсов</th>
                                        <th>Статус</th>
                                        <th>Рейсы</th>
                                        <th>Действия</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <#list airlines as airline>
                                        <tr>
                                            <td>${airline.id}</td>
                                            <td>
                                                <i class="fas fa-plane me-2 text-primary"></i>
                                                ${airline.username}
                                            </td>
                                            <td>${airline.email}</td>
                                            <td>
                                                <span class="badge bg-info text-dark">
                                                    <i class="fas fa-list me-1"></i>
                                                    <#if airline.flightCount??>
                                                        ${airline.flightCount}
                                                    <#else>
                                                        0
                                                    </#if>
                                                </span>
                                            </td>
                                            <td>
                                                <#if airline.enabled>
                                                    <span class="badge bg-success">
                                                            <i class="fas fa-check me-1"></i>Активна
                                                        </span>
                                                <#else>
                                                    <span class="badge bg-danger">
                                                            <i class="fas fa-times me-1"></i>Заблокирована
                                                        </span>
                                                </#if>
                                            </td>
                                            <td>
                                                <a href="/admin/airline/${airline.id}"
                                                   class="btn btn-sm btn-outline-primary"
                                                   title="Просмотреть рейсы авиакомпании">
                                                    <i class="fas fa-plane me-1"></i>Рейсы
                                                </a>
                                            </td>
                                            <td>
                                                <a href="/admin/airlines/${airline.id}/toggle-status"
                                                   class="btn btn-sm <#if airline.enabled>btn-warning<#else>btn-success</#if>"
                                                   onclick="return confirm('Вы уверены, что хотите изменить статус этой авиакомпании?')">
                                                    <#if airline.enabled>
                                                        <i class="fas fa-ban me-1"></i>Заблокировать
                                                    <#else>
                                                        <i class="fas fa-check me-1"></i>Активировать
                                                    </#if>
                                                </a>
                                            </td>
                                        </tr>
                                    </#list>
                                    </tbody>
                                </table>
                            </div>
                        <#else>
                            <div class="text-center py-5">
                                <i class="fas fa-building fa-3x text-muted mb-3"></i>
                                <h4 class="text-muted">Авиакомпании не найдены</h4>
                                <p class="text-muted">Создайте первую авиакомпанию, нажав на кнопку выше</p>
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</@layout.page>