
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Pathway – Discover. Apply. Achieve.</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/1_Home_Page/style.css"
          type="text/css">
</head>

<body>

    <!-- HEADER -->
    <header>

        <div class="logo">
            <img src="${pageContext.request.contextPath}/1_Home_Page/image/pathway%20logo.png"
                 width="150px"
                 height="75px"
                 alt="pathway logo">
        </div>

        <nav class="nav-top">
            <a href="#Why_pathway">Why pathway</a>
            <a href="#For_recruiters">For recruiters</a>
            <a href="#Our_approach">Our approach</a>
        </nav>

        <div class="signin_header">
            <a href="${pageContext.request.contextPath}/1_Home_Page/signin.jsp">
                Sign in ↗
            </a>
        </div>
    </header>


    <main>

        <!-- HOME SCREEN -->
        <div class="home">

            <div class="home_left">

                <h1>
                    Your next <br>
                    <i style="color: rgb(15, 233, 160);">chapter</i>
                    starts here.
                </h1>

                <p style="color:gray;">
                    Pathway brings your campus opportunities, applications,
                    and momentum into one clear place — so finding meaningful
                    work feels possible, not overwhelming.
                </p>

                <div class="home_signin">

                    <div class="signin_home">
                        <a href="${pageContext.request.contextPath}/1_Home_Page/signin.jsp">
                            Start your journey →
                        </a>
                    </div>

                    <div class="start">
                        <a href="#Why_pathway">See how it works ▽</a>
                    </div>

                </div>


                <!-- DYNAMIC PLACEMENT STATISTICS -->
                <h3 class="h1">PLACEMENT STATISTICS</h3>

                <div class="home_leftPlacementStatic">

                    <div class="Static_box">
                        <h4>Student</h4>

                        <h3>
                            <c:out value="${statistics.totalStudents}"/>+
                        </h3>

                        <p>Active candidates</p>
                    </div>


                    <div class="Static_box">
                        <h4>Open jobs</h4>

                        <h3>
                            <c:out value="${statistics.openJobs}"/>+
                        </h3>

                        <p>roles available</p>
                    </div>


                    <div class="Static_box">
                        <h4>Companies</h4>

                        <h3>
                            <c:out value="${statistics.recruitingCompanies}"/>+
                        </h3>

                        <p>recruiting partners</p>
                    </div>

                </div>

            </div>


            <div class="home_right">

                <img src="${pageContext.request.contextPath}/1_Home_Page/image/home_image.png"
                     width="400px"
                     height="300px"
                     alt="Opportunity feed">

            </div>

        </div>


        <!-- WHY PATHWAY SECTION -->
        <section id="Why_pathway">

            <div class="whypathway">

                <div class="whypathway_header">

                    <i>
                        <br>One workspace. More signal.
                    </i>

                    <h2>
                        Less hunting. <br>
                        More moving forward.
                    </h2>

                </div>


                <div class="whypathway_body">

                    <div class="whypathway_card">
                        <b style="margin-top: 10px;">01</b>
                        <br>
                        <b>Find your fit</b>
                        <br>
                        See roles that match your branch, skills,
                        and ambitions — not a wall of noise.
                    </div>


                    <div class="whypathway_card">
                        <b style="margin-top: 10px;">02</b>
                        <br>
                        <b>Keep your signal</b>
                        <br>
                        Your applications, deadlines, and next steps
                        stay visible from one calm dashboard.
                    </div>


                    <div class="whypathway_card">
                        <b style="margin-top: 10px;">03</b>
                        <br>
                        <b>Meet the moment</b>
                        <br>
                        Arrive prepared for every drive with clear
                        details and a profile that represents you.
                    </div>

                </div>

            </div>

        </section>


        <!-- COMPANIES HIRING SECTION -->
        <section id="For_recruiters">

            <div class="For_recruiters">

                <div class="For_recruiters_header">

                    <div class="For_recruiters_left">

                        <p>Already looking for the next spark</p>

                        <h3>Companies hiring from here</h3>

                    </div>


                    <div class="For_recruiters_right">

                        <p>
                            <c:out value="${sessionLabel}"/> session
                        </p>

                    </div>

                </div>


                <!-- DYNAMIC COMPANY CARDS -->
                <div class="For_recruiters_body">

                    <c:choose>

                        <c:when test="${not empty hiringCompanies}">

                            <c:forEach var="company"
                                       items="${hiringCompanies}">

                                <div class="card">

                                    <div class="card1">
                                        <c:out value="${company.initial}"/>
                                    </div>

                                    <b>
                                        <c:out value="${company.companyName}"/>
                                    </b>

                                    <c:choose>

                                        <c:when test="${not empty company.location}">
                                            <c:out value="${company.location}"/>
                                        </c:when>

                                        <c:otherwise>
                                            Recruiting partner
                                        </c:otherwise>

                                    </c:choose>

                                </div>

                            </c:forEach>

                        </c:when>


                        <c:otherwise>

                            <div class="card">
                                No companies are currently hiring.
                            </div>

                        </c:otherwise>

                    </c:choose>

                </div>

            </div>

        </section>


        <!-- OUR APPROACH SECTION -->
        <section id="Our_approach">

            <div class="Our_approach">

                <div class="Our_approach_left">

                    <p>The point of the portal</p>

                    <h2>
                        A little more context. <br>
                        A lot more confidence.
                    </h2>

                    <b>
                        Behind every application is a person making
                        a brave, practical decision about what comes next.
                        Pathway gives students a fair shot and gives
                        coordinators the clarity to make every introduction
                        count.
                    </b>

                </div>


                <!-- DYNAMIC PLACEMENT RATE AND ACTIVE PARTNERS -->
                <div class="Our_approach_right">

                    <div class="Our_approach2_card box">

                        <h1>
                            <c:out value="${statistics.placementRate}"/>%
                        </h1>

                        <p>placement rate</p>

                    </div>


                    <div class="Our_approach2_card box1">

                        <h1>
                            <c:out value="${activePartners}"/>
                        </h1>

                        <p>active partners</p>

                    </div>

                </div>

            </div>

        </section>

    </main>


    <!-- FOOTER -->
    <footer>

        <div class="footer">

            <img src="${pageContext.request.contextPath}/1_Home_Page/image/pathway%20logo.png"
                 width="75px"
                 alt="pathway logo">

        </div>

        <div class="footer">

            <p>For the work you are ready to do.</p>

        </div>

    </footer>

</body>
</html>
