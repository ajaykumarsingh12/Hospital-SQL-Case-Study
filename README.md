paste this:

# 🏥 Hospital SQL Data Analysis Project

## 📌 Project Overview
This project analyzes hospital data using PostgreSQL. It contains SQL queries to answer business-related questions about patients, doctors, departments, expenses, and hospital stays.

## 📂 Files Included

- `Hospital_Data.xlsx` - Dataset
- `SQL1.sql` - SQL Queries and Solutions
- `SQLHOSPITALAnsAndQuery.pdf` - Questions and Answers Documentation

## 🛠 Tools Used

- PostgreSQL
- SQL
- Microsoft Excel

## 📊 SQL Concepts Used

- SELECT
- Aggregate Functions (SUM, AVG, COUNT)
- GROUP BY
- ORDER BY
- LIMIT
- Date Functions
- EXTRACT()
- Arithmetic Operations on Dates

## 📈 Business Questions Solved

### 1. Total Number of Patients
```sql
SELECT SUM(PatientsCount) AS Total_Patient_Count
FROM Hospital;
```

### 2. Average Number of Doctors per Hospital
```sql
SELECT AVG(DoctorsCount) AS AvgDoctor_per_Hospital
FROM Hospital;
```

### 3. Top 3 Departments with the Highest Number of Patients
```sql
SELECT Department,
       SUM(PatientsCount) AS Total_Patient
FROM Hospital
GROUP BY Department
ORDER BY Total_Patient DESC
LIMIT 3;
```

### 4. Hospital with Maximum Medical Expenses
```sql
SELECT HospitalName, MedicalExpenses
FROM Hospital
ORDER BY MedicalExpenses DESC;
```

### 5. Average Medical Expenses
```sql
SELECT AVG(MedicalExpenses) AS Avg_Medical_Expenses
FROM Hospital;
```

### 6. Longest Hospital Stay
```sql
SELECT *,
       (DischargeDate - AdmissionDate) AS Total_Stay
FROM Hospital
ORDER BY Total_Stay DESC;
```

### 7. Total Patients Treated Per City
```sql
SELECT Location AS City,
       SUM(PatientsCount) AS PatientCountSumPerCity
FROM Hospital
GROUP BY Location;
```

### 8. Average Length of Stay Per Department
```sql
SELECT Department,
       AVG(DischargeDate - AdmissionDate) AS Avg_Stay
FROM Hospital
GROUP BY Department
ORDER BY Avg_Stay DESC;
```

### 9. Department with the Lowest Number of Patients
```sql
SELECT Department,
       SUM(PatientsCount) AS PatientCount
FROM Hospital
GROUP BY Department
ORDER BY PatientCount;
```

### 10. Monthly Medical Expenses Report
```sql
SELECT EXTRACT(MONTH FROM AdmissionDate) AS Month,
       SUM(MedicalExpenses) AS Total_Expenses
FROM Hospital
GROUP BY Month
ORDER BY Month;
```

## 🚀 Key Insights

- Calculated total patients across hospitals.
- Identified top-performing departments.
- Analyzed average doctor availability.
- Determined departments with the lowest patient count.
- Measured hospital stay durations.
- Created monthly medical expense reports.

## 👨‍💻 Author

**Ajay Singh**

- LinkedIn: https://linkedin.com/in/ajay-singh-03169034a
