<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Pathway - Opportunities</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/3_Admin_Side/Opportunities.css">
    </head>

    <body>

        <!-- SIDEBAR -->

        <aside class="sidebar">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/3_Admin_Side/image/pathway%20logo.png"
                     width="150px"
                     height="75px"
                     alt="logo">
            </div>

            <p class="menu-title">OPERATIONS CONSOLE</p>

            <nav>
                <a href="${pageContext.request.contextPath}/admin-dashboard">🎛️ Overview</a>
                <a href="${pageContext.request.contextPath}/admin-students">👥 Students</a>
                <a href="${pageContext.request.contextPath}/admin-companies">🏢 Companies</a>
                <a href="${pageContext.request.contextPath}/admin-opportunities" class="active">💼 Opportunities</a>
                <a href="${pageContext.request.contextPath}/admin-applications">📋 Applications</a>
            </nav>

            <a href="${pageContext.request.contextPath}/admin-logout" class="signout"> [→ Sign out </a>
        </aside>


        <!-- MAIN CONTENT -->

        <main class="main-content">


            <!-- TOP HEADER -->

            <header class="topbar">
                <div>
                    <p>The roles students can say yes to</p>
                    <h1>Opportunities</h1>
                </div>

                <span class="user">
                    <c:choose>
                        <c:when test="${not empty sessionScope.adminName}">
                            <c:out value="${fn:substring(sessionScope.adminName, 0, 1)}"/>
                        </c:when>
                        <c:otherwise>AR</c:otherwise>
                    </c:choose>
                </span>
            </header>


            <!-- PAGE CONTENT -->

            <section class="page-content">


                <!-- INTRO -->

                <div class="intro">

                    <p>
                        Publish roles with enough detail for a considered application.
                    </p>

                    <button type="button" class="add-button">
                        <span class="plus">+</span>
                        Add opportunity
                    </button>

                </div>





                <!-- SEARCH -->

                <div class="search-section">

                    <div class="search-box">

                        <span class="search-icon">⌕</span>

                        <input
                            type="text"
                            id="opportunitySearch"
                            placeholder="Search roles or companies..."
                            aria-label="Search roles or companies"
                            >

                    </div>

                </div>


                <!-- OPPORTUNITY TABLE -->

                <div class="table-container">


                    <!-- TABLE HEADER -->

                    <div class="table-header">

                        <div class="column-opportunity">
                            OPPORTUNITY
                        </div>

                        <div class="column-package">
                            PACKAGE
                        </div>

                        <div class="column-eligibility">
                            ELIGIBILITY
                        </div>

                        <div class="column-deadline">
                            DEADLINE
                        </div>

                        <div class="column-applicants">
                            APPLICANTS
                        </div>

                        <div class="column-actions">
                            ACTIONS
                        </div>

                    </div>


                    <!-- DATABASE OPPORTUNITY ROWS -->

                    <c:forEach var="op" items="${requestScope.opportunities}">

                        <div class="table-row"
                             data-opportunity-id="${op.opportunityId}">

                            <div class="column-opportunity">

                                <h3>
                                    <c:out value="${op.jobTitle}"/>
                                </h3>

                                <p>
                                    <c:out value="${op.companyName}"/>
                                    <c:if test="${not empty op.location}">
                                        · <c:out value="${op.location}"/>
                                    </c:if>
                                </p>

                            </div>


                            <div class="column-package">
                                ₹<c:out value="${op.packageAmount}"/>
                                <span> LPA</span>
                            </div>


                            <div class="column-eligibility">
                                <c:out value="${op.eligibilityCgpa}"/> CGPA
                            </div>


                            <div class="column-deadline">
                                <c:choose>
                                    <c:when test="${not empty op.deadline}">
                                        <c:out value="${op.deadline}"/>
                                    </c:when>
                                    <c:otherwise>
                                        —
                                    </c:otherwise>
                                </c:choose>
                            </div>


                            <div class="column-applicants">
                                —
                            </div>


                            <div class="column-actions">

                                <button type="button"
                                        class="edit-button"
                                        title="Edit"
                                        aria-label="Edit opportunity">
                                    ✎
                                </button>

                                <button type="button"
                                        class="delete-button"
                                        title="Delete"
                                        aria-label="Delete opportunity">
                                    🗑️
                                </button>

                            </div>

                        </div>

                    </c:forEach>


                    <!-- EMPTY DATABASE MESSAGE -->

                    <c:if test="${empty requestScope.opportunities}">
                        <div class="table-row empty-opportunities">
                            <div class="column-opportunity">
                                <h3>No opportunities found</h3>
                                <p>Add an opportunity to display it here.</p>
                            </div>
                        </div>
                    </c:if>


                </div>

            </section>

        </main>


        <!-- ADD / EDIT OPPORTUNITY FORM -->

        <div id="opportunityModal"
             class="opportunity-modal"
             style="display:none;">

            <div class="opportunity-modal-content">

                <h2 id="modalTitle">Add opportunity</h2>

                <form id="opportunityForm"
                      action="${pageContext.request.contextPath}/admin-opportunities"
                      method="post">

                    <input type="hidden" name="action" id="formAction" value="add">

                    <input type="hidden"
                           name="opportunityId"
                           id="opportunityId"
                           value="">

                    <label for="companyId">Company</label>

                    <select name="companyId" id="companyId" required>
                        <option value="">Select company</option>

                        <c:forEach var="company" items="${requestScope.companies}">
                            <option value="${company.companyId}">
                                <c:out value="${company.companyName}"/>
                            </option>
                        </c:forEach>

                    </select>


                    <label for="jobTitle">Job title</label>

                    <input type="text"
                           name="jobTitle"
                           id="jobTitle"
                           maxlength="150"
                           required>


                    <label for="jobType">Job type</label>

                    <input type="text"
                           name="jobType"
                           id="jobType"
                           placeholder="Full-time / Internship">


                    <label for="location">Location</label>

                    <input type="text"
                           name="location"
                           id="location">


                    <label for="packageAmount">Package amount</label>

                    <input type="number"
                           name="packageAmount"
                           id="packageAmount"
                           min="0"
                           step="0.01"
                           required>


                    <label for="eligibilityCgpa">Eligibility CGPA</label>

                    <input type="number"
                           name="eligibilityCgpa"
                           id="eligibilityCgpa"
                           min="0"
                           max="10"
                           step="0.01"
                           required>


                    <label for="requiredSkills">Required skills</label>

                    <input type="text"
                           name="requiredSkills"
                           id="requiredSkills"
                           placeholder="Java, SQL, HTML">


                    <label for="description">Description</label>

                    <textarea name="description"
                              id="description"
                              rows="4"></textarea>


                    <label for="deadline">Application deadline</label>

                    <input type="date"
                           name="deadline"
                           id="deadline">


                    <div class="modal-actions">

                        <button type="submit">
                            Save opportunity
                        </button>

                        <button type="button"
                                class="cancel"
                                id="cancelModal">
                            Cancel
                        </button>

                    </div>

                </form>

            </div>

        </div>


        <!-- DELETE FORM -->

        <form id="deleteForm"
              action="${pageContext.request.contextPath}/admin-opportunities"
              method="post"
              style="display:none;">

            <input type="hidden" name="action" value="delete">

            <input type="hidden"
                   name="opportunityId"
                   id="deleteOpportunityId">

        </form>


        <script>
            document.addEventListener("DOMContentLoaded", function () {

                const searchInput = document.getElementById("opportunitySearch");
                const addButton = document.querySelector(".add-button");
                const tableContainer = document.querySelector(".table-container");
                const modal = document.getElementById("opportunityModal");
                const opportunityForm = document.getElementById("opportunityForm");
                const deleteForm = document.getElementById("deleteForm");

                const modalTitle = document.getElementById("modalTitle");
                const formAction = document.getElementById("formAction");
                const opportunityIdInput = document.getElementById("opportunityId");

                const companyIdInput = document.getElementById("companyId");
                const jobTitleInput = document.getElementById("jobTitle");
                const jobTypeInput = document.getElementById("jobType");
                const locationInput = document.getElementById("location");
                const packageAmountInput = document.getElementById("packageAmount");
                const eligibilityCgpaInput = document.getElementById("eligibilityCgpa");
                const requiredSkillsInput = document.getElementById("requiredSkills");
                const descriptionInput = document.getElementById("description");
                const deadlineInput = document.getElementById("deadline");

                const cancelButton = document.getElementById("cancelModal");


                // SEARCH OPPORTUNITIES

                searchInput.addEventListener("input", function () {

                    const searchValue = searchInput.value.toLowerCase().trim();

                    const rows = tableContainer.querySelectorAll(".table-row[data-opportunity-id]");

                    rows.forEach(function (row) {

                        const opportunityText =
                                row.querySelector(".column-opportunity").textContent.toLowerCase();

                        row.style.display =
                                opportunityText.includes(searchValue) ? "" : "none";

                    });

                });


                // OPEN ADD FORM

                addButton.addEventListener("click", function () {

                    opportunityForm.reset();

                    formAction.value = "add";
                    opportunityIdInput.value = "";

                    modalTitle.textContent = "Add opportunity";

                    modal.style.display = "flex";

                });


                // OPEN EDIT FORM

                tableContainer.addEventListener("click", function (event) {

                    const button = event.target.closest("button");

                    if (!button) {
                        return;
                    }

                    const row = button.closest(".table-row[data-opportunity-id]");

                    if (!row) {
                        return;
                    }

                    const id = row.dataset.opportunityId;


                    if (button.classList.contains("edit-button")) {

                        const opportunity = row.querySelector(".column-opportunity");
                        const title = opportunity.querySelector("h3").textContent.trim();
                        const companyText = opportunity.querySelector("p").textContent.trim();

                        const packageText =
                                row.querySelector(".column-package").textContent.trim();

                        const eligibilityText =
                                row.querySelector(".column-eligibility").textContent.trim();

                        const deadlineText =
                                row.querySelector(".column-deadline").textContent.trim();


                        // The current company name is used to select the matching dropdown entry.
                        let matchedCompanyId = "";

                        Array.from(companyIdInput.options).forEach(function (option) {

                            if (option.textContent.trim() === companyText.split(" · ")[0]) {
                                matchedCompanyId = option.value;
                            }

                        });


                        formAction.value = "update";
                        opportunityIdInput.value = id;

                        modalTitle.textContent = "Edit opportunity";

                        jobTitleInput.value = title;
                        companyIdInput.value = matchedCompanyId;

                        // Existing table columns do not expose every database field.
                        // Clear fields that cannot be reliably reconstructed from the row.
                        jobTypeInput.value = "";
                        locationInput.value = "";

                        packageAmountInput.value =
                                parseFloat(packageText.replace(/[^\d.]/g, "")) || 0;

                        eligibilityCgpaInput.value =
                                parseFloat(eligibilityText.replace(/[^\d.]/g, "")) || 0;

                        requiredSkillsInput.value = "";
                        descriptionInput.value = "";

                        // Keep the displayed deadline if it is in ISO yyyy-MM-dd format.
                        deadlineInput.value =
                                /^\d{4}-\d{2}-\d{2}$/.test(deadlineText) ? deadlineText : "";

                        modal.style.display = "flex";

                    }


                    // DELETE OPPORTUNITY

                    if (button.classList.contains("delete-button")) {

                        const confirmed = confirm(
                                "Are you sure you want to delete this opportunity?"
                                );

                        if (confirmed) {

                            document.getElementById("deleteOpportunityId").value = id;

                            deleteForm.submit();

                        }

                    }

                });


                // CLOSE FORM

                cancelButton.addEventListener("click", function () {

                    modal.style.display = "none";

                });


                // CLOSE WHEN CLICKING OUTSIDE THE FORM

                modal.addEventListener("click", function (event) {

                    if (event.target === modal) {
                        modal.style.display = "none";
                    }

                });

            });
        </script>


        <style>
            .opportunity-modal {
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

            .opportunity-modal-content {
                background: #fff;
                width: 100%;
                max-width: 540px;
                max-height: 90vh;
                overflow-y: auto;
                padding: 25px;
                border-radius: 12px;
                box-sizing: border-box;
            }

            .opportunity-modal-content h2 {
                margin-top: 0;
                margin-bottom: 20px;
            }

            .opportunity-modal-content label {
                display: block;
                margin-top: 12px;
                margin-bottom: 5px;
                font-weight: 600;
            }

            .opportunity-modal-content input,
            .opportunity-modal-content select,
            .opportunity-modal-content textarea {
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
                border-right: 2px solid goldenrod ;
                border-bottom: 2px solid goldenrod ;
                background: #01605c;
                color: white;
            }
            .modal-actions button:hover{
                border: 2px solid goldenrod ;
            }
            

            

            .opportunity-error {
                margin: 15px 0;
                padding: 12px;
                color: #842029;
                background: #f8d7da;
                border-radius: 5px;
            }
        </style>

    </body>
</html>