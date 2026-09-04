# Sunrise Dental Clinic Management System

## Overview

The Sunrise Dental Clinic Management System is a web-based Java application developed to automate patient registration, appointment scheduling, treatment management, billing, and reporting functions for Sunrise Dental Clinic. The system replaces manual paper-based processes with a secure, efficient, and centralized digital solution.

## Features

### User Authentication

* Secure login system
* Role-based access control
* Administrator and Receptionist access levels

### Patient Management

* Add, update, search, and delete patients
* Store patient contact and medical information

### Dentist Management

* Manage dentist records
* Store specialization details
* Update dentist information

### Treatment Management

* Add and update treatments
* Maintain treatment pricing information

### Appointment Management

* Schedule appointments
* Search appointments
* Prevent duplicate bookings

### Billing System

* Generate patient bills
* Calculate treatment costs
* Print receipts

### Reports

* Appointment Reports
* Revenue Reports
* Patient Reports

### Help Section

* System usage guidelines
* User assistance for clinic staff

---

## Technologies Used

* Java
* JSP
* Jakarta Servlet
* MySQL
* Maven
* Apache Tomcat 10
* Visual Studio Code
* Git & GitHub

---

## Design Patterns

### MVC Pattern

Separates the application into Model, View, and Controller components.

### DAO Pattern

Handles database operations independently from business logic.

### Singleton Pattern

Used for database connection management.

---

## System Architecture

The application follows a Three-Tier Architecture:

1. Presentation Layer (JSP)
2. Business Logic Layer (Servlets & Services)
3. Data Access Layer (DAO & MySQL)

---

## Installation Guide

### Prerequisites

* JDK 17+
* Apache Tomcat 10+
* MySQL Server
* Maven
* Visual Studio Code

### Clone Repository

```bash
git clone https://github.com/azlafaasmi/CIS6003_AdvancedProgramming.git
```

### Open Project

```bash
cd CIS6003_AdvancedProgramming
```

Open the folder using Visual Studio Code.

### Build Project

```bash
mvn clean package
```

### Database Setup

Create the database:

```sql
CREATE DATABASE sunrise_dental_db;
```

Import the SQL file provided in the project.

### Configure Database

Update database credentials in:

```text
src/main/java/util/DBConnection.java
```

### Deploy Application

Copy the generated WAR file from:

```text
target/
```

into Apache Tomcat's:

```text
webapps/
```

Start Tomcat and access:

```text
http://localhost:8080/SunriseDentalClinic
```

---

## Project Structure

```text
SunriseDentalClinic/
│
├── src/
│   ├── main/
│   │   ├── java/
│   │   │
│   │   ├── controller/
│   │   │   ├── LoginServlet.java
│   │   │   ├── LogoutServlet.java
│   │   │   ├── UserServlet.java
│   │   │   ├── PatientServlet.java
│   │   │   ├── DentistServlet.java
│   │   │   ├── TreatmentServlet.java
│   │   │   ├── AppointmentServlet.java
│   │   │   ├── BillingServlet.java
│   │   │   └── ReportServlet.java
│   │   │
│   │   ├── service/
│   │   │   ├── LoginService.java
│   │   │   ├── UserService.java
│   │   │   ├── PatientService.java
│   │   │   ├── DentistService.java
│   │   │   ├── TreatmentService.java
│   │   │   ├── AppointmentService.java
│   │   │   ├── BillingService.java
│   │   │   └── ReportService.java
│   │   │
│   │   ├── dao/
│   │   │   ├── UserDAO.java
│   │   │   ├── PatientDAO.java
│   │   │   ├── DentistDAO.java
│   │   │   ├── TreatmentDAO.java
│   │   │   ├── AppointmentDAO.java
│   │   │   └── BillDAO.java
│   │   │
│   │   ├── model/
│   │   │   ├── User.java
│   │   │   ├── Patient.java
│   │   │   ├── Dentist.java
│   │   │   ├── Treatment.java
│   │   │   ├── Appointment.java
│   │   │   └── Bill.java
│   │   │
│   │   ├── filter/
│   │   │   ├── AuthenticationFilter.java
│   │   │   └── AdminAuthorizationFilter.java
│   │   │
│   │   ├── util/
│   │   │   ├── DBConnection.java
│   │   │   ├── PasswordUtil.java
│   │   │   ├── PDFGenerator.java
│   │   │   ├── AppointmentNumberGenerator.java
│   │   │   └── ValidationUtil.java
│   │   │
│   │   └── webservice/
│   │       ├── AppointmentAPI.java
│   │       └── BillingAPI.java
│   │
│   │
│   ├── resources/
│   │   └── application.properties
│   │
│   │
│   └── webapp/
│       │
│       ├── assets/
│       │   ├── css/
│       │   │   └── style.css
│       │   │
│       │   ├── js/
│       │   │   └── script.js
│       │   │
│       │   └── images/
│       │
│       ├── views/
│       │
│       │   ├── auth/
│       │   │   └── login.jsp
│       │   │
│       │   ├── dashboard/
│       │   │   └── dashboard.jsp
│       │   │
│       │   ├── users/
│       │   │   ├── add-user.jsp
│       │   │   ├── edit-user.jsp
│       │   │   └── users.jsp
│       │   │
│       │   ├── patients/
│       │   │   ├── add-patient.jsp
│       │   │   ├── edit-patient.jsp
│       │   │   └── patients.jsp
│       │   │
│       │   ├── dentists/
│       │   │   ├── add-dentist.jsp
│       │   │   └── dentists.jsp
│       │   │
│       │   ├── treatments/
│       │   │   ├── add-treatment.jsp
│       │   │   └── treatments.jsp
│       │   │
│       │   ├── appointments/
│       │   │   ├── add-appointment.jsp
│       │   │   ├── search-appointment.jsp
│       │   │   ├── edit-appointment.jsp
│       │   │   └── appointments.jsp
│       │   │
│       │   ├── billing/
│       │   │   ├── generate-bill.jsp
│       │   │   ├── bill-details.jsp
│       │   │   └── receipt.jsp
│       │   │
│       │   ├── reports/
│       │   │   ├── appointment-report.jsp
│       │   │   └── revenue-report.jsp
│       │   │
│       │   └── help/
│       │       └── help.jsp
│       │
│       ├── index.jsp
│       │
│       └── WEB-INF/
│           └── web.xml
│
│
├── src/test/java/
│
│   ├── service/
│   │   ├── LoginServiceTest.java
│   │   ├── PatientServiceTest.java
│   │   ├── AppointmentServiceTest.java
│   │   └── BillingServiceTest.java
│   │
│   └── dao/
│       ├── PatientDAOTest.java
│       └── AppointmentDAOTest.java
│
│
├── database/
│   ├── schema.sql
│   ├── sample-data.sql
│   ├── procedures.sql
│   └── triggers.sql
│
│
├── docs/
│   ├── UseCaseDiagram.png
│   ├── ClassDiagram.png
│   ├── SequenceDiagram_Login.png
│   ├── SequenceDiagram_Appointment.png
│   └── SequenceDiagram_Billing.png
│
│
├── pom.xml
│
├── README.md
│
└── .gitignore
```

---

## Version Control

GitHub is used for:

* Source code management
* Version tracking
* Collaboration
* Continuous Integration
* Project backup and recovery

Repository:

https://github.com/azlafaasmi/CIS6003_AdvancedProgramming

---

## Future Enhancements

* Email Notifications
* SMS Appointment Reminders
* Online Patient Portal
* Cloud Deployment
* Mobile Application Support

---

## Author

Azlafa Asmi
CIS6003 – Advanced Programming
Sunrise Dental Clinic Management System
2026
