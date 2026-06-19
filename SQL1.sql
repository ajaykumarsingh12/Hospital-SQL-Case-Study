create table Hospital(
				HospitalName  varchar(50),
				Location  varchar(20),
				Department varchar(30),
				DoctorsCount int,
				PatientsCount int,
				AdmissionDate date,
				DischargeDate date,
				MedicalExpenses numeric(10,2)

)
drop table Hospital;
copy Hospital(HospitalName,Location,Department,DoctorsCount,PatientsCount,AdmissionDate,DischargeDate,MedicalExpenses)
from  'D:\Data_Analyst\SQLASSIGNMENT\Hospital_Data.CSV'
csv header;
select * from Hospital;

-- 1. Total Number of Patients 
select sum(patientsCount)as Total_Patient_Count from Hospital;

-- 2. Average Number of Doctors per Hospital
select avg(doctorscount)as AvgDoctor_per_Hospital from Hospital;

-- 3. Top 3 Departments with the Highest Number of Patients 
select Department,count(*),sum(Patientscount)as Total_Patient from Hospital group by Department order by Total_Patient desc limit 3;

-- 4. Hospital with the Maximum Medical Expenses 

select HospitalName,MedicalExpenses from Hospital order by MedicalExpenses desc;

-- 5. Daily Average Medical Expenses 
select avg(MedicalExpenses)as Avg_Medicak_Expenses from Hospital;

-- 6. Longest Hospital Stay
select *,(dischargedate-admissiondate)as Total_Stay from Hospital   order by Total_Stay desc;

-- 7. Total Patients Treated Per City 
select location as City ,count(*),sum(Patientscount)as patientcountSumPerCity from Hospital group by location;

--8. Average Length of Stay Per Department 
select Department,avg(dischargedate-admissiondate) as Total_Avg_Stay_Departmenwise from Hospital group by Department order by Total_Avg_Stay_Departmenwise desc;


--9. Identify the Department with the Lowest Number of Patients 

select Department,sum(PatientsCount)as PatientCount from Hospital group by Department order by PatientCount;
-- 10. Monthly Medical Expenses Report 
select count(*),extract(months from admissiondate) months,sum(MedicalExpenses) from Hospital group by months order by months;

select * from Hospital;

-- 11.Which hospital treated the maximum number of patients
select HospitalName,sum(PatientsCount)as Total_Patient  from Hospital group by HospitalName order by Total_Patient desc ;

-- 12. Which city has the highest medical expenses
select Location,sum(MedicalExpenses)as City_wise_MedicalExpenses from Hospital group by Location order by City_wise_MedicalExpenses desc limit 2;

-- 13. Average patients per doctor in each department
select department,sum(PatientsCount)/sum(doctorscount)as patientavgdoctor from Hospital group by Department ;

-- 14. Find hospitals having more than average patients
select  HospitalName,avg(PatientsCount) from Hospital group by HospitalName having avg(PatientsCount)>(select avg(PatientsCount) from Hospital)

-- 15. Department with maximum average expenses
select department,avg(MedicalExpenses)as maximum from Hospital group by department order by maximum desc;

-- 16. Number of admissions per month
select  extract(month from AdmissionDate) AS Month,count(*) from Hospital GROUP BY Month ORDER BY Month;

--17. Average hospital stay by city
select Location as City ,avg(dischargedate-admissiondate),count (*) from Hospital group by Location;

--18. Hospitals where stay duration exceeds 10 days
select HospitalName ,(dischargedate-admissiondate) from Hospital where (dischargedate-admissiondate)>10;

-- 19. Department contributing highest medical expenses
select Department,sum(MedicalExpenses)as total from Hospital group by Department order by total desc;

-- 20. Count hospitals in each city
select Location,count(Distinct HospitalName) from Hospital group by Location
-- 21. Rank hospitals by expenses
select HospitalName,MedicalExpenses, rank() over(order by MedicalExpenses desc)as HospitalRankBasedOnMedicalExpenses from Hospital;

-- 23. Top 3 hospitals by patients
select  HospitalName,sum(Patientscount)as total_Patients from Hospital group by HospitalName order by total_Patients desc limit 3 ; 

-- 24. Running total of medical expenses
select *,sum(MedicalExpenses) over(order by  AdmissionDate) from Hospital;
-- 25. Previous expense (LAG)
select AdmissionDate,MedicalExpenses,lag(MedicalExpenses) over(order by AdmissionDate),MedicalExpenses-lag(MedicalExpenses) over(order by AdmissionDate)profit_lose from Hospital ;
select AdmissionDate,MedicalExpenses,lead(MedicalExpenses) over(order by AdmissionDate),MedicalExpenses-lead(MedicalExpenses) over(order by AdmissionDate)profit_lose from Hospital ;
