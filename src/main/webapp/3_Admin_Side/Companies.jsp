
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Pathway - Companies</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/3_Admin_Side/Companies.css">
    </head>

    <body>

        <div class="dashboard-container">

            <!-- SIDEBAR -->
            <aside class="sidebar">

                <div class="logo">
                    <img src="${pageContext.request.contextPath}/3_Admin_Side/image/pathway%20logo.png"
                         width="150"
                         height="75"
                         alt="Pathway Logo">
                </div>

                <p class="menu-title">OPERATIONS CONSOLE</p>

                <nav>
                    <a href="${pageContext.request.contextPath}/admin-dashboard">🎛️ Overview</a>
                    <a href="${pageContext.request.contextPath}/admin-students">👥 Students</a>
                    <a href="${pageContext.request.contextPath}/admin-companies" class="active">🏢 Companies</a>
                    <a href="${pageContext.request.contextPath}/admin-opportunities">💼 Opportunities</a>
                    <a href="${pageContext.request.contextPath}/admin-applications">📋 Applications</a>
                </nav>

                <a href="${pageContext.request.contextPath}/admin-logout" class="signout">
                    [→ Sign out
                </a>

            </aside>


            <!-- MAIN CONTENT -->
            <main class="main-content">

                <!-- TOP BAR -->
                <header class="topbar">

                    <div>
                        <p>Partner network</p>
                        <h1>Companies</h1>
                    </div>

                    <div class="user">

                        <c:choose>

                            <c:when test="${not empty sessionScope.adminName}">
                                <c:out value="${fn:substring(sessionScope.adminName, 0, 1)}"/>
                            </c:when>

                            <c:otherwise>
                                AR
                            </c:otherwise>

                        </c:choose>

                    </div>

                </header>


                <!-- PAGE CONTENT -->
                <section class="page-content">

                    <div class="intro">

                        <p>The partners who make the first yes possible.</p>

                        <button type="button"
                                class="add-company"
                                id="addCompanyBtn">
                            + Add company
                        </button>

                    </div>


                    <!-- SUCCESS MESSAGE -->
                    <c:if test="${param.message eq 'success'}">

                        <div class="company-success">
                            Company added successfully!
                        </div>

                    </c:if>


                    <!-- ERROR MESSAGE -->
                    <c:if test="${not empty requestScope.companyLoadError}">

                        <div class="company-error">
                            <c:out value="${requestScope.companyLoadError}"/>
                        </div>

                    </c:if>


                    <!-- SEARCH -->
                    <div class="search-section">

                        <div class="search-box">

                            <span class="search-icon">⌕</span>

                            <input type="text"
                                   id="companySearch"
                                   placeholder="Search companies..."
                                   autocomplete="off">

                        </div>

                    </div>


                    <!-- COMPANY CARDS -->
                    <div class="company-list" id="companyList">

                        <c:choose>

                            <c:when test="${not empty requestScope.companies}">

                                <c:forEach var="company"
                                           items="${requestScope.companies}"
                                           varStatus="companyLoop">

                                    <c:set var="iconClass" value="orange"/>

                                    <c:choose>

                                        <c:when test="${companyLoop.index % 5 == 1}">
                                            <c:set var="iconClass" value="green"/>
                                        </c:when>

                                        <c:when test="${companyLoop.index % 5 == 2}">
                                            <c:set var="iconClass" value="pink"/>
                                        </c:when>

                                        <c:when test="${companyLoop.index % 5 == 3}">
                                            <c:set var="iconClass" value="blue"/>
                                        </c:when>

                                        <c:when test="${companyLoop.index % 5 == 4}">
                                            <c:set var="iconClass" value="purple"/>
                                        </c:when>

                                    </c:choose>


                                    <article class="company-card"
                                             data-company-id="${company.companyId}">


                                        <!-- CARD TOP -->
                                        <div class="card-top">

                                            <div class="company-icon ${iconClass}">

                                                <c:choose>

                                                    <c:when test="${not empty company.companyName}">
                                                        <c:out value="${fn:substring(company.companyName, 0, 1)}"/>
                                                    </c:when>

                                                    <c:otherwise>
                                                        C
                                                    </c:otherwise>

                                                </c:choose>

                                            </div>


                                            <!-- CARD ACTIONS -->
                                            <div class="card-actions">

                                                <button type="button"
                                                        class="edit-button"
                                                        title="Edit company"
                                                        data-id="${company.companyId}"
                                                        data-name="${fn:escapeXml(company.companyName)}"
                                                        data-email="${fn:escapeXml(company.contactEmail)}"
                                                        data-location="${fn:escapeXml(company.location)}"
                                                        data-website="${fn:escapeXml(company.website)}"
                                                        data-description="${fn:escapeXml(company.description)}">
                                                    ✎
                                                </button>


                                                <button type="button"
                                                        class="delete-button"
                                                        title="Delete company"
                                                        data-id="${company.companyId}">
                                                    🗑️
                                                </button>

                                            </div>

                                        </div>


                                        <!-- COMPANY DETAILS -->
                                        <div class="company-details">

                                            <h2>
                                                <c:out value="${company.companyName}"/>
                                            </h2>


                                            <c:if test="${not empty company.location}">

                                                <p class="company-info">
                                                    <c:out value="${company.location}"/>
                                                </p>

                                            </c:if>

                                        </div>


                                        <!-- CARD FOOTER -->
                                        <div class="card-footer">

                                            <div class="open-roles">
                                                Company_ID:
                                                <c:out value="${company.companyId}"/>
                                            </div>


                                            <c:if test="${not empty company.website}">

                                                <c:choose>

                                                    <c:when test="${fn:startsWith(company.website, 'https://') or fn:startsWith(company.website, 'http://')}">

                                                        <a href="${fn:escapeXml(company.website)}"
                                                           target="_blank"
                                                           rel="noopener noreferrer"
                                                           class="website">
                                                            Website ↗
                                                        </a>

                                                    </c:when>

                                                    <c:otherwise>

                                                        <span class="website">
                                                            Website
                                                        </span>

                                                    </c:otherwise>

                                                </c:choose>

                                            </c:if>

                                        </div>

                                    </article>

                                </c:forEach>

                            </c:when>


                            <c:otherwise>

                                <div class="empty-state" id="emptyState">

                                    <h2>No companies found</h2>

                                    <p>No company records are currently available.</p>

                                </div>

                            </c:otherwise>

                        </c:choose>

                    </div>


                    <!-- NO SEARCH RESULTS -->
                    <div class="empty-state"
                         id="noSearchResults"
                         style="display: none;">

                        <h2>No matching companies</h2>

                        <p>
                            Try searching with a different company name,
                            email, description, or location.
                        </p>

                    </div>

                </section>

            </main>

        </div>


        <!-- ADD / EDIT COMPANY MODAL -->
        <div class="company-modal"
             id="companyModal"
             style="display: none;">

            <div class="company-modal-content">

                <div class="modal-header">

                    <h2 id="modalTitle">Add company</h2>

                    <button type="button"
                            id="closeModalBtn"
                            class="modal-close">
                        ×
                    </button>

                </div>


                <form id="companyForm"
                      method="post"
                      action="${pageContext.request.contextPath}/admin-companies">

                    <input type="hidden"
                           name="action"
                           id="companyAction"
                           value="add">

                    <input type="hidden"
                           name="companyId"
                           id="companyId">


                    <div class="form-group">

                        <label for="companyName">Company name *</label>

                        <input type="text"
                               id="companyName"
                               name="companyName"
                               maxlength="150"
                               required>

                    </div>


                    <div class="form-group">

                        <label for="companyEmail">Contact email</label>

                        <input type="email"
                               id="companyEmail"
                               name="email"
                               maxlength="100">

                    </div>


                    <div class="form-group">

                        <label for="companyLocation">Location</label>

                        <input type="text"
                               id="companyLocation"
                               name="location"
                               maxlength="150">

                    </div>


                    <div class="form-group">

                        <label for="companyWebsite">Website</label>

                        <input type="url"
                               id="companyWebsite"
                               name="website"
                               maxlength="255"
                               placeholder="https://example.com">

                    </div>


                    <div class="form-group">

                        <label for="companyDescription">Description</label>

                        <textarea id="companyDescription"
                                  name="description"
                                  rows="4"></textarea>

                    </div>


                    <div class="modal-actions">

                        <button type="button"
                                id="cancelModalBtn">
                            Cancel
                        </button>

                        <button type="submit"
                                id="saveCompanyBtn">
                            Save company
                        </button>

                    </div>

                </form>

            </div>

        </div>


        <!-- DELETE FORM -->
        <form id="deleteForm"
              action="${pageContext.request.contextPath}/admin-companies"
              method="post"
              style="display:none;">

            <input type="hidden"
                   name="action"
                   value="delete">

            <input type="hidden"
                   name="companyId"
                   id="deleteCompanyId">

        </form>


        <!-- JAVASCRIPT -->
        <script>

            document.addEventListener("DOMContentLoaded", function () {

                // ==========================================
                // GET HTML ELEMENTS
                // ==========================================

                const searchInput = document.getElementById("companySearch");

                const companyCards = Array.from(
                        document.querySelectorAll(".company-card")
                        );

                const noSearchResults =
                        document.getElementById("noSearchResults");

                const modal = document.getElementById("companyModal");

                const companyForm = document.getElementById("companyForm");

                const modalTitle = document.getElementById("modalTitle");

                const companyAction = document.getElementById("companyAction");

                const companyId = document.getElementById("companyId");

                const companyName = document.getElementById("companyName");

                const companyEmail = document.getElementById("companyEmail");

                const companyLocation = document.getElementById("companyLocation");

                const companyWebsite = document.getElementById("companyWebsite");

                const companyDescription =
                        document.getElementById("companyDescription");

                const deleteForm = document.getElementById("deleteForm");

                const deleteCompanyId =
                        document.getElementById("deleteCompanyId");


                // ==========================================
                // SEARCH COMPANIES
                // ==========================================

                function filterCompanies() {

                    const searchTerm =
                            searchInput.value.trim().toLowerCase();

                    let visibleCount = 0;

                    companyCards.forEach(function (card) {

                        const matches = card.textContent
                                .toLowerCase()
                                .includes(searchTerm);

                        card.style.display = matches ? "" : "none";

                        if (matches) {
                            visibleCount++;
                        }

                    });

                    if (noSearchResults) {

                        noSearchResults.style.display =
                                visibleCount === 0 && companyCards.length > 0
                                ? "block"
                                : "none";

                    }

                }

                searchInput.addEventListener("input", filterCompanies);


                // ==========================================
                // OPEN MODAL
                // ==========================================

                function openModal() {

                    modal.style.display = "flex";

                }


                // ==========================================
                // CLOSE MODAL
                // ==========================================

                function closeModal() {

                    modal.style.display = "none";

                    companyForm.reset();

                    companyId.value = "";

                    companyAction.value = "add";

                    modalTitle.textContent = "Add company";

                }


                document.getElementById("closeModalBtn")
                        .addEventListener("click", closeModal);

                document.getElementById("cancelModalBtn")
                        .addEventListener("click", closeModal);


                modal.addEventListener("click", function (event) {

                    if (event.target === modal) {
                        closeModal();
                    }

                });


                // ==========================================
                // ADD COMPANY
                // ==========================================

                document.getElementById("addCompanyBtn")
                        .addEventListener("click", function () {

                            companyForm.reset();

                            companyId.value = "";

                            companyAction.value = "add";

                            modalTitle.textContent = "Add company";

                            openModal();

                        });


                // ==========================================
                // EDIT COMPANY
                // ==========================================

                document.querySelectorAll(".edit-button")
                        .forEach(function (button) {

                            button.addEventListener("click", function () {

                                // Get company information from card button

                                const id = button.dataset.id;

                                const name = button.dataset.name;

                                const email = button.dataset.email;

                                const location = button.dataset.location;

                                const website = button.dataset.website;

                                const description = button.dataset.description;


                                // Fill existing company information

                                companyId.value = id;

                                companyName.value = name || "";

                                companyEmail.value = email || "";

                                companyLocation.value = location || "";

                                companyWebsite.value = website || "";

                                companyDescription.value = description || "";


                                // Change form action to UPDATE

                                companyAction.value = "update";

                                modalTitle.textContent = "Edit company";


                                // Open modal

                                openModal();

                            });

                        });


                // ==========================================
                // DELETE COMPANY
                // ==========================================

                document.querySelectorAll(".delete-button")
                        .forEach(function (button) {

                            button.addEventListener("click", function () {

                                const id = button.dataset.id;

                                const confirmDelete = confirm(
                                        "Are you sure you want to delete this company?"
                                        );

                                if (confirmDelete) {

                                    // Set company ID in hidden delete form

                                    deleteCompanyId.value = id;

                                    // Submit form to AdminCompanyServlet

                                    deleteForm.submit();

                                }

                            });

                        });


                // ==========================================
                // FORM VALIDATION
                // ==========================================

                companyForm.addEventListener("submit", function (event) {

                    const name = companyName.value.trim();

                    if (name === "") {

                        event.preventDefault();

                        alert("Please enter a company name.");

                        companyName.focus();

                        return;

                    }

                    // Allow BOTH add and update operations.

                    if (
                            companyAction.value !== "add" &&
                            companyAction.value !== "update"
                            ) {

                        event.preventDefault();

                        alert("Invalid company operation.");

                    }

                });


                // ==========================================
                // ESCAPE KEY CLOSES MODAL
                // ==========================================

                document.addEventListener("keydown", function (event) {

                    if (
                            event.key === "Escape" &&
                            modal.style.display !== "none"
                            ) {

                        closeModal();

                    }

                });

            });

        </script>


        <!-- INTERNAL CSS -->
        <style>

            .company-modal {
                position: fixed;
                inset: 0;
                z-index: 1000;
                background: rgba(0, 0, 0, 0.45);
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
                overflow-y: auto;
            }

            .company-modal-content {
                background: #fff;
                width: 100%;
                max-width: 540px;
                max-height: 90vh;
                overflow-y: auto;
                padding: 25px;
                border-radius: 12px;
                box-sizing: border-box;
            }

            .company-modal-content h2 {
                margin-top: 0;
                margin-bottom: 20px;
            }

            .company-modal-content label {
                display: block;
                margin-top: 12px;
                margin-bottom: 5px;
                font-weight: 600;
            }

            .company-modal-content input,
            .company-modal-content textarea {
                display: block;
                width: 100%;
                padding: 10px;
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 5px;
                font: inherit;
            }

            .modal-actions {
                display: flex;
                gap: 10px;
                margin-top: 20px;
            }

            .modal-actions button {
                cursor: pointer;
                padding: 10px 15px;
                border-radius: 20px;
                border-right: 2px solid goldenrod;
                border-bottom: 2px solid goldenrod;
                background: #01605c;
                color: white;
            }

            .modal-actions button:hover {
                border: 2px solid goldenrod;
            }

            .company-error {
                margin: 15px 0;
                padding: 12px;
                color: #842029;
                background: #f8d7da;
                border-radius: 5px;
            }

            .company-success {
                margin: 15px 0;
                padding: 12px;
                color: #0f5132;
                background: #d1e7dd;
                border-radius: 5px;
            }

        </style>

    </body>

</html>
