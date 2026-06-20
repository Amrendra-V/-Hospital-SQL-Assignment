-- ============================================
-- HOSPITAL DATABASE - SQL ASSIGNMENT
-- Author: Amrendra Kumar
-- Course: 30 Days SQL Micro Course
-- Instructor: Satish Dhawale Sir
-- ============================================

-- DATABASE
CREATE DATABASE hospital_db;

-- TABLE
CREATE TABLE Hospital(
patient_id serial primary key,
Hospital_Name VARCHAR(100) NOT NULL,
Location VARCHAR(100) NOT NULL,
Department VARCHAR(100) NOT NULL,
Doctors_Count INT NOT NULL CHECK (Doctors_Count > 0),
Patients_Count INT NOT NULL CHECK (Patients_Count >= 0),
Admission_Date DATE NOT NULL,
Discharge_Date DATE NOT NULL CHECK (Discharge_Date >= Admission_Date),
Medical_Expenses NUMERIC(10,2) NOT NULL CHECK (Medical_Expenses >= 0),
Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- IMPORT DATA
SET datestyle = 'ISO, DMY';
COPY Hospital (Hospital_Name, Location, Department,
Doctors_Count, Patients_Count,
Admission_Date, Discharge_Date, Medical_Expenses)
FROM 'D:/Hospital_Data.csv'
DELIMITER ','
CSV HEADER;

-- Q1: Total Number of Patients
SELECT SUM(Patients_Count) AS Total_Patients
FROM Hospital;

-- Q2: Average Doctors per Hospital
SELECT Hospital_Name,
ROUND(AVG(Doctors_Count),2) AS Avg_Doctor
FROM Hospital
GROUP BY Hospital_Name;

-- Q3: Top 3 Departments by Patients
SELECT Department,
SUM(Patients_Count) AS Total_Patient
FROM Hospital
GROUP BY Department
ORDER BY Total_Patient DESC
LIMIT 3;

-- Q4: Hospital with Maximum Medical Expenses
SELECT Hospital_Name,
SUM(Medical_Expenses) AS Total_Expenses
FROM Hospital
GROUP BY Hospital_Name
ORDER BY Total_Expenses DESC
LIMIT 1;

-- Q5: Daily Average Medical Expenses
SELECT Hospital_Name,
ROUND(SUM(Medical_Expenses)/
SUM(Discharge_Date - Admission_Date + 1),2)
AS Avg_Expense_Per_Day
FROM Hospital
GROUP BY Hospital_Name;

-- Q6: Longest Hospital Stay
SELECT Hospital_Name, Department,
Admission_Date, Discharge_Date,
(Discharge_Date - Admission_Date + 1) AS Longest_Stay
FROM Hospital
ORDER BY Longest_Stay DESC
LIMIT 1;

-- Q7: Total Patients per City
SELECT Location,
SUM(Patients_Count) AS Total_Patient
FROM Hospital
GROUP BY Location
ORDER BY Total_Patient DESC;

-- Q8: Average Stay per Department
SELECT Department,
ROUND(AVG(Discharge_Date - Admission_Date + 1),2)
AS Avg_Stay_Days
FROM Hospital
GROUP BY Department;

-- Q9: Department with Lowest Patients
SELECT Department,
SUM(Patients_Count) AS Least_Patient
FROM Hospital
GROUP BY Department
ORDER BY Least_Patient ASC
LIMIT 1;

-- Q10: Monthly Medical Expenses
SELECT TO_CHAR(Admission_Date, 'YYYY-MM') AS Month,
ROUND(SUM(Medical_Expenses),2) AS Total_Medical_Expenses
FROM Hospital
GROUP BY TO_CHAR(Admission_Date, 'YYYY-MM')
ORDER BY Month;