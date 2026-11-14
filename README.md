# Pathway – Student Placement Portal

**Discover. Apply. Achieve.**

## About the Project

Pathway is a web-based Student Placement Portal developed to simplify and organize the campus placement process. It provides a platform where students can explore job opportunities, apply for positions, track application statuses, and manage their profiles.

The portal also provides an admin workspace to manage students, companies, placement opportunities, and applications through a centralized dashboard.

## Features

### Student Module
- Student registration and login.
- Student dashboard with dynamic placement statistics.
- Browse available placement opportunities.
- View opportunities with company and package details.
- Apply for job opportunities.
- Track application status.
- Manage student profile.

### Admin Module
- Admin login and authentication.
- Admin dashboard with placement statistics.
- Manage student records.
- Add, update, and delete company information.
- Manage placement opportunities.
- View student applications.
- Update application statuses.

### Home Page
- Dynamic placement statistics.
- Display recruiting companies.
- Placement information and highlights.
- Student and coordinator login navigation.

## Technologies Used

### Frontend
- HTML5
- CSS3
- JavaScript
- JSP (JavaServer Pages)

### Backend
- Java
- Jakarta Servlets
- JDBC
- DAO (Data Access Object) Pattern

### Database
- MySQL
- MySQL Workbench

### Development Tools
- NetBeans IDE
- Apache Tomcat
- Maven
- Git and GitHub

## Database Design

The project uses a MySQL database named `pathway`.

Main database tables:
- `students`
- `companies`
- `opportunities`
- `applications`

JDBC is used to connect the Java application with the MySQL database.

## Project Structure

- `1_Home Page` – Main landing page.
- `2_Client_Side` – Student interface and dashboard.
- `3_Admin_Side` – Admin interface and dashboard.
- `controller` – Servlet classes.
- `dao` – Database operations.
- `model` – Java model classes.
- `util` – Database connection utility.

## Application Workflow

1. Students register and log in.
2. Students explore available placement opportunities.
3. Students apply for suitable opportunities.
4. Admin manages companies, opportunities, and applications.
5. Students track their application progress through their dashboard.

## Installation and Setup

1. Clone or download this repository.
2. Open the project in NetBeans IDE.
3. Create a MySQL database named `pathway`.
4. Import or execute the project's database SQL script.
5. Configure your MySQL username and password in `DBConnection.java`.
6. Build the project using Maven.
7. Run the application on Apache Tomcat.
8. Open the application in your browser.

## Project Objective

The main objective of Pathway is to create a centralized placement management system that connects students and placement coordinators, making the campus recruitment process more organized, accessible, and efficient.

## Project Type

**Academic Project – Advanced Java / Web Technology**

## Developed By

**Pathway Project Team**# Pathway_
