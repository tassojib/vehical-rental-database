# Vehicle Rental Database

## Overview

This project implements a simplified Vehicle Rental System that manages users, vehicles, and bookings.
The main purpose of this project is to assess your understanding of:

- Database table design and ERD relationships
- Primary and foreign keys
- Writing SQL queries using JOIN, EXISTS, WHERE, GROUP BY, and HAVING clauses

---

## Part 1: Database Design (ERD)

The system consists of three main tables:

1. **Users**

   - Stores user information including role (Admin or Customer), name, email, and phone number.
   - Each email is unique to prevent duplicate accounts.

2. **Vehicles**

   - Stores vehicle details including name, type (car/bike/truck), model, registration number, rental price and availability status.
   - Registration number is unique.

3. **Bookings**
   - Links users to vehicles.
   - Stores booking details such as start date, end date, booking status, and total cost.

### Relationships

- **One-to-Many (User → Bookings)**: Each user can have multiple bookings.
- **Many-to-One (Bookings → Vehicle)**: Each booking is associated with a single vehicle.
- **One-to-One (Logical)**: Each booking connects exactly one user and one vehicle.

Primary keys and foreign keys are included in the tables to maintain referential integrity. Status fields are used to indicate the current state of vehicles and bookings.

**ERD Link:** https://drawsql.app/teams/tas-6/diagrams/assignment

---

## Part 2: SQL Queries

Below are the POSTGRESQL queries based on the designed schema along with expected results.

### 1. Retrieve Booking Information (JOIN)

**Requirement:** Retrieve booking information along with customer name and vehicle name.

```postgresql
select
  b.id,
  u.name,
  v.vehicle_name,
  b.start_date,
  b.end_date,
  b.status
from
  bookings as b
  inner join users as u on b.user_id = u.id
  inner join vehicles as v on b.vehicle_id = v.id;
```
**Explanation**
   - INNER JOIN connects bookings, users, and vehicles on their IDs.
   - Retrieves booking details along with the corresponding customer and vehicle.

### 2. Find Vehicles Never Booked (NOT EXISTS)

**Requirement:** Find all vehicles that have never been booked.

```postgresql
SELECT *
FROM vehicles v
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.vehicle_id = v.id
);
```
**Explanation**
   - NOT EXISTS checks if no matching booking exists for each vehicle.

### 3. Retrieve Available Vehicles of a Specific Type (WHERE)

**Requirement:** Retrieve all available vehicles of type 'car'.

```postgresql
SELECT *
FROM vehicles
WHERE availability_status = 'available'
  AND type = 'car';
```
**Explanation**
   - Filters vehicles where availability_status is 'available' and type matches the desired type.

### 4. Total Number of Bookings per Vehicle (GROUP BY and HAVING)

**Requirement:** Find the total number of bookings for each vehicle and display only vehicles with more than 2 bookings.

```postgresql
select
  vehicle_name,
  count(b.id) as total_bookings
from
  vehicles v
  inner join bookings b on v.id = b.vehicle_id
group by
  vehicle_name
  having count(b.id)>2;
```
**Explanation**
   - INNER JOIN matches vehicles with their bookings.
   - GROUP BY groups results per vehicle.
   - COUNT(b.id) counts total bookings for each vehicle.
   - HAVING COUNT(b.id) > 2 filters vehicles with more than 2 bookings.

  
