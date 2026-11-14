
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Pathway - Find Opportunities</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/2_Client_Side/student_Opportunities.css">
    </head>

    <body>

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/2_Client_Side/image/pathway logo.png" width="150px" height="75px" alt="logo">
            </div>

            <p class="menu-title">STUDENT WORKSPACE</p>

            <nav>
                <a href="${pageContext.request.contextPath}/student-dashboard">📋 Overview</a>
                <a href="${pageContext.request.contextPath}/opportunities" class="active">🔎 Find opportunities</a>
                <a href="${pageContext.request.contextPath}/student-applications">📝 My applications</a>
                <a href="${pageContext.request.contextPath}/student-profile">👤 My profile</a>
            </nav>

            <a href="${pageContext.request.contextPath}/logout" class="signout">[→ Sign out</a>
        </aside>


        <!-- MAIN CONTENT -->
        <main class="main-content">

            <!-- HEADER -->
            <header class="topbar">

                <div>
                    <p>Opportunity board</p>
                    <h1>Find your next opportunity</h1>
                </div>

                <span class="user" id="f_user">AR</span>

            </header>


            <!-- DASHBOARD -->
            <section class="dashboard">

                <!-- INTRODUCTION -->
                <div class="intro">

                    <p>
                        Roles with enough context to make a considered decision.
                        Start with what<br>
                        feels like a stretch in the right direction.
                    </p>

                    <div class="role-count">
                        <span id="openRoleCount">${opportunities.size()}</span> open roles
                    </div>

                </div>


                <!-- SEARCH AND LOCATION FILTER -->
                <div class="search-section">

                    <div class="search-box">

                        <input
                            type="text"
                            id="searchInput"
                            placeholder="Search roles, skills, companies..."
                        >

                    </div>

                    <select id="locationFilter">
                        <option value="all">All locations</option>
                        <option value="Ahmedabad">Ahmedabad</option>
                        <option value="Pune">Pune</option>
                        <option value="Bengaluru">Bengaluru</option>
                        <option value="Mumbai">Mumbai</option>
                    </select>

                </div>


                <!-- JOB CARDS -->
                <div class="job-cards" id="jobCards">

                    <c:forEach var="job" items="${opportunities}">

                        <div class="job-card"
                             data-opportunity-id="${job.opportunityId}"
                             data-minimum-cgpa="${job.eligibilityCgpa}"
                             data-location="${job.location}"
                             data-deadline="${job.deadline}">

                            <div class="card-top">

                                <div class="job-icon purple">
                                    <c:choose>
                                        <c:when test="${not empty job.companyName}">
                                            <c:out value="${job.companyName.substring(0,1)}"/>
                                        </c:when>
                                        <c:otherwise>C</c:otherwise>
                                    </c:choose>
                                </div>

                                <span class="status">Open</span>

                            </div>

                            <div class="job-details">

                                <h3><c:out value="${job.jobTitle}"/></h3>

                                <p class="company">
                                    <c:out value="${job.companyName}"/>
                                </p>

                                <div class="skills">
                                    <c:out value="${job.requiredSkills}"/>
                                </div>

                            </div>

                            <div class="job-footer">

                                <div>
                                    <h4><c:out value="${job.packageAmount}"/> LPA</h4>

                                    <p><c:out value="${job.location}"/></p>
                                </div>

                                <!-- APPLY FORM -->
                                <form action="${pageContext.request.contextPath}/apply-opportunity"
                                      method="post">

                                    <input type="hidden"
                                           name="opportunityId"
                                           value="${job.opportunityId}">

                                    <button type="submit"> →</button>

                                </form>

                            </div>

                        </div>

                    </c:forEach>

                </div>

                <p id="noResults" hidden>
                    No opportunities found. Try another search.
                </p>

            </section>

        </main>



        <!-- OPPORTUNITY DETAILS POPUP -->
        <div class="modal-overlay"
             id="jobModal"
             aria-hidden="true">

            <div class="job-modal"
                 role="dialog"
                 aria-modal="true"
                 aria-labelledby="modalTitle">

                <!-- POPUP HEADER -->
                <div class="modal-header">

                    <h2 id="modalTitle">Java Developer</h2>

                    <button type="button"
                            class="close-modal"
                            id="closeModal"
                            aria-label="Close popup">
                        &times;
                    </button>

                </div>


                <!-- COMPANY DETAILS -->
                <div class="modal-company">

                    <div class="modal-company-icon" id="modalIcon">
                        T
                    </div>

                    <div>
                        <h3 id="modalCompany">
                            Tata Consultancy Services
                        </h3>

                        <p id="modalLocation">
                            Ahmedabad · hybrid
                        </p>
                    </div>

                </div>


                <!-- PACKAGE AND MINIMUM CGPA -->
                <div class="modal-stats">

                    <div class="stat-box">

                        <h2 id="modalPackage">6.0 LPA</h2>

                        <p>Package</p>

                    </div>

                    <div class="stat-box highlight">

                        <h2 id="modalCgpa">7</h2>

                        <p>Minimum CGPA</p>

                    </div>

                </div>


                <!-- REQUIRED SKILLS -->
                <div class="modal-skills">

                    <h4>What you will bring</h4>

                    <div class="modal-skill-list" id="modalSkills">
                        <span>Java</span>
                        <span>SQL</span>
                        <span>Spring Boot</span>
                    </div>

                </div>


                <!-- APPLICATION DEADLINE -->
                <div class="modal-deadline">

                    <h4>
                        &nbsp; Applications close
                        <span id="modalDeadline">30 Aug</span>
                    </h4>

                    <p>
                        <span id="modalApplicants">3</span>
                        people have already raised their hand.
                    </p>

                </div>


                <!-- APPLY BUTTON -->
                <button type="button"
                        class="apply-button"
                        id="applyButton">

                    Apply for this role &nbsp;

                </button>

            </div>

        </div>



        <!-- JAVASCRIPT -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {

                // ----------------------------------
                // DISPLAY SAVED STUDENT INITIALS
                // ----------------------------------

                const studentName = localStorage.getItem("studentName");
                const userInitials = document.getElementById("f_user");

                if (studentName && studentName.trim()) {

                    const initials = studentName.trim()
                            .split(/\s+/)
                            .map(word => word.charAt(0))
                            .join("")
                            .substring(0, 2)
                            .toUpperCase();

                    userInitials.textContent = initials;
                }


                // ----------------------------------
                // POPUP ELEMENTS
                // ----------------------------------

                const modal = document.getElementById("jobModal");
                const closeButton = document.getElementById("closeModal");
                const applyButton = document.getElementById("applyButton");

                let selectedJob = "";
                let selectedApplicationForm = null;
                let previousFocus = null;


                // ----------------------------------
                // OPEN POPUP WHEN A JOB IS CLICKED
                // ----------------------------------

                document.querySelectorAll(".job-card").forEach(function (card) {

                    card.style.cursor = "pointer";

                    card.addEventListener("click", function (event) {

                        // Do not open popup when Apply form is clicked.
                        if (event.target.closest("form, button, a")) {
                            return;
                        }

                        previousFocus = document.activeElement;

                        const title = card.querySelector(".job-details h3");
                        const company = card.querySelector(".company");
                        const salary = card.querySelector(".job-footer h4");
                        const location = card.querySelector(".job-footer p");
                        const icon = card.querySelector(".job-icon");
                        const skills = card.querySelector(".skills").textContent.trim();

                        // Get the actual application form for this opportunity.
                        selectedApplicationForm = card.querySelector("form");

                        selectedJob = title.textContent.trim();

                        // Fill popup details
                        document.getElementById("modalTitle").textContent =
                                selectedJob;

                        document.getElementById("modalCompany").textContent =
                                company.textContent.trim();

                        document.getElementById("modalPackage").textContent =
                                salary.textContent.trim();

                        document.getElementById("modalLocation").textContent =
                                location.textContent.trim();

                        document.getElementById("modalIcon").textContent =
                                icon.textContent.trim();

                        document.getElementById("modalCgpa").textContent =
                                card.dataset.minimumCgpa || "7";

                        document.getElementById("modalDeadline").textContent =
                                card.dataset.deadline || "Not specified";

                        document.getElementById("modalApplicants").textContent =
                                card.dataset.applicants || "0";

                        // Add the selected job's skills
                        const skillsContainer =
                                document.getElementById("modalSkills");

                        skillsContainer.replaceChildren();

                        const skillArray = skills.split(",");

                        skillArray.forEach(function (skill) {

                            const span = document.createElement("span");

                            span.textContent = skill.trim();

                            skillsContainer.appendChild(span);
                        });

                        // Show popup
                        modal.classList.add("show");
                        modal.setAttribute("aria-hidden", "false");

                        document.body.style.overflow = "hidden";

                        closeButton.focus();

                    });

                });


                // ----------------------------------
                // CLOSE POPUP
                // ----------------------------------

                function closeModal() {

                    modal.classList.remove("show");
                    modal.setAttribute("aria-hidden", "true");

                    document.body.style.overflow = "";

                    selectedApplicationForm = null;

                    if (previousFocus) {
                        previousFocus.focus();
                    }
                }


                closeButton.addEventListener("click", closeModal);


                // Close when clicking outside the popup
                modal.addEventListener("click", function (event) {

                    if (event.target === modal) {
                        closeModal();
                    }

                });


                // Close with Escape key
                document.addEventListener("keydown", function (event) {

                    if (
                            event.key === "Escape" &&
                            modal.classList.contains("show")
                    ) {
                        closeModal();
                    }

                });


                // ----------------------------------
                // APPLY BUTTON - SAVE IN DATABASE
                // ----------------------------------

                applyButton.addEventListener("click", function () {

                    if (!selectedApplicationForm) {

                        alert("Please select an opportunity first.");

                        return;
                    }

                    const opportunityId =
                            selectedApplicationForm.querySelector(
                                    'input[name="opportunityId"]'
                            );

                    if (!opportunityId || !opportunityId.value) {

                        alert("Opportunity ID not found.");

                        return;
                    }

                    // Submit the selected opportunity's POST form.
                    // This sends opportunityId to ApplyOpportunityServlet.
                    selectedApplicationForm.requestSubmit();

                });


                // ----------------------------------
                // SEARCH AND LOCATION FILTER
                // ----------------------------------

                const searchInput = document.getElementById("searchInput");
                const locationFilter = document.getElementById("locationFilter");
                const jobCards = document.querySelectorAll(".job-card");
                const openRoleCount = document.getElementById("openRoleCount");
                const noResults = document.getElementById("noResults");

                function filterJobs() {

                    const searchText = searchInput.value.toLowerCase().trim();
                    const selectedLocation = locationFilter.value;

                    let visibleCount = 0;

                    jobCards.forEach(function (card) {

                        const cardText = card.textContent.toLowerCase();

                        const cardLocation =
                                card.querySelector(".job-footer p").textContent;

                        const matchesSearch = cardText.includes(searchText);

                        const matchesLocation =
                                selectedLocation === "all" ||
                                cardLocation.includes(selectedLocation);

                        const showCard = matchesSearch && matchesLocation;

                        card.style.display = showCard ? "" : "none";

                        if (showCard) {
                            visibleCount++;
                        }

                    });

                    openRoleCount.textContent = visibleCount;

                    noResults.hidden = visibleCount !== 0;

                    // Close popup if its job is filtered out
                    if (modal.classList.contains("show")) {

                        const selectedCard = Array.from(jobCards).find(function (card) {
                            return card.querySelector(".job-details h3")
                                    .textContent.trim() === selectedJob;
                        });

                        if (selectedCard && selectedCard.style.display === "none") {
                            closeModal();
                        }
                    }
                }

                searchInput.addEventListener("input", filterJobs);

                locationFilter.addEventListener("change", filterJobs);

            });
        </script>

    </body>
</html>
