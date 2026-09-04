# Sunrise Dental Clinic Management System

## Overview

The Sunrise Dental Clinic Management System is a web-based Java application developed to automate the daily operations of Sunrise Dental Clinic. The system replaces manual paper-based processes with a computerized solution for managing patients, appointments, treatments, billing, reports, and user authentication.

This project was developed as part of the Advanced Programming coursework and follows Object-Oriented Programming principles, a three-tier architecture, design patterns, database integration, and web technologies.

---

## Features

### User Authentication

* Secure login system
* Role-based access control
* Authorized staff access only

### Patient Management

* Add new patients
* Update patient details
* Search patients
* Delete patient records

### Dentist Management

* Register dentists
* Manage specializations
* Update dentist information

### Treatment Management

* Add treatments
* Update treatment prices
* Manage treatment records

### Appointment Management

* Create appointments
* View appointment details
* Search appointments
* Prevent duplicate bookings

### Billing System

* Calculate treatment costs
* Generate patient bills
* Store billing records

### Reports

* Appointment Reports
* Revenue Reports
* Patient Reports

### Help Section

* User instructions
* System guidance for new staff

---

## Technologies Used

### Frontend

* JSP
* HTML5
* CSS3
* JavaScript

### Backend

* Java
* Jakarta Servlet

### Database

* MySQL

### Build Tool

* Maven

### Web Server

* Apache Tomcat 10

### Version Control

* Git
* GitHub

---

## System Architecture

The application follows a Three-Tier Architecture:

1. Presentation Layer (JSP Pages)
2. Business Logic Layer (Servlets and Services)
3. Data Access Layer (DAO Classes and MySQL Database)

---

## Design Patterns Implemented

### DAO Pattern

Used to separate database operations from business logic.

### Singleton Pattern

Used for database connection management.

### MVC Pattern

Used to separate presentation, control, and data components.

---

## Database

Database Name:

```sql
sunrise_dental_db
```

Main Tables:

* users
* patients
* dentists
* treatments
* appointments
* bills

---

## Installation Guide

### Prerequisites

* JDK 17 or later
* Apache Tomcat 10
* MySQL Server
* Maven

### Steps

1. Clone the repository.

```bash
git clone  https://github.com/azlafaasmi/CIS6003_AdvancedProgramming.git
```

2. Open the project in IntelliJ IDEA or Eclipse.

3. Configure MySQL database.

4. Update database credentials in:

```text
DBConnection.java
```

5. Build the project.

```bash
mvn clean package
```

6. Deploy the generated WAR file to Apache Tomcat.

7. Start Tomcat and open:

```text
http://localhost:8080/SunriseDentalClinic
```

---

## Testing

The project includes:

* Unit Testing
* Integration Testing
* User Interface Testing
* Validation Testing

JUnit was used to automate test execution.

---

## GitHub Repository

The project uses GitHub for:

* Version control
* Source code management
* Development history tracking
* Collaboration
* CI/CD workflow execution

---

## Future Enhancements

* Email notifications
* SMS appointment reminders
* Online patient portal
* Cloud deployment
* Mobile application integration

---

## Author

Azlafa Asmi

Advanced Programming Coursework

Sunrise Dental Clinic Management System

2026

---

## License

This project is developed for academic purposes only.
