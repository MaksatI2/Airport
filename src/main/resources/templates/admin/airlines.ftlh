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
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="page-size-selector">
                                <select class="form-select form-select-sm" onchange="location = '?page=1&size=' + this.value;">
                                    <option value="5" <#if pageSize == 5>selected</#if>>5 на странице</option>
                                    <option value="10" <#if pageSize == 10>selected</#if>>10 на странице</option>
                                    <option value="20" <#if pageSize == 20>selected</#if>>20 на странице</option>
                                    <option value="50" <#if pageSize == 50>selected</#if>>50 на странице</option>
                                </select>
                            </div>
                        </div>

                        <#if airlines?? && airlines?size gt 0>
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
                                                <a href="/flights/airline/${airline.id}?page=1&size=10"
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

                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <div class="text-muted">
                                    Показано ${(currentPage - 1) * pageSize + 1}-${((currentPage - 1) * pageSize + airlines?size)} из ${totalItems} авиакомпаний
                                </div>
                                <nav aria-label="Page navigation">
                                    <ul class="pagination">
                                        <#if currentPage lte 1>
                                            <li class="page-item disabled">
                                                <span class="page-link">Предыдущая</span>
                                            </li>
                                        <#else>
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage - 1}&size=${pageSize}">Предыдущая</a>
                                            </li>
                                        </#if>

                                        <#list 1..totalPages as i>
                                            <li class="page-item ${(i == currentPage)?then('active','')}">
                                                <a class="page-link" href="?page=${i}&size=${pageSize}">${i}</a>
                                            </li>
                                        </#list>

                                        <#if currentPage gte totalPages>
                                            <li class="page-item disabled">
                                                <span class="page-link">Следующая</span>
                                            </li>
                                        <#else>
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage + 1}&size=${pageSize}">Следующая</a>
                                            </li>
                                        </#if>
                                    </ul>
                                </nav>
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