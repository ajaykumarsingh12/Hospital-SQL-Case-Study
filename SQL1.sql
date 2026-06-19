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
select  extract(month from AdmissionDate) AS Month,count(*) from Hospital group by Month order by  Month;

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
select * from Hospital;

-- 23. Top 3 hospitals by patients
select  HospitalName,sum(Patientscount)as total_Patients from Hospital group by HospitalName order by total_Patients desc limit 3 ; 

-- 24. Running total of medical expenses
select *,sum(MedicalExpenses) over(order by  AdmissionDate) from Hospital;

-- 25. Previous expense (LAG)
select AdmissionDate,MedicalExpenses,lag(MedicalExpenses) over(order by AdmissionDate),MedicalExpenses-lag(MedicalExpenses) over(order by AdmissionDate)profit_lose from Hospital ;

-- 25. Next expense (LEAD)
select AdmissionDate,MedicalExpenses,lead(MedicalExpenses) over(order by AdmissionDate) from Hospital ;
select department,ntile(5) over (order by MedicalExpenses) from Hospital;
-- 26.Highest expense within each department
select * from Hospital;
select Department,sum(MedicalExpenses)as Departmentwise from Hospital group by Department order by Departmentwise desc ;


-- 27. Find hospitals with above-average expenses
select avg(MedicalExpenses) from Hospital ;
select HospitalName,avg(MedicalExpenses) from Hospital group by HospitalName having avg(MedicalExpenses)>(select avg(MedicalExpenses) from Hospital)

select sum(MedicalExpenses)*0.20 from Hospital
-- 28.Department contributing more than 20% of total expenses
select department,sum(MedicalExpenses) from Hospital group by Department having sum(MedicalExpenses)>(select sum(MedicalExpenses)*0.20 from Hospital);

--29. Median Of The Salary
select percentile_cont(0.90) within group (order by MedicalExpenses desc ) from Hospital;


-- CONT → Interpolates and may return a value not present in the table.
-- DISC → Returns an actual value from the dataset.

-- 30.Median With Department Wise
select Department,percentile_cont(0.50) within group (order by MedicalExpenses desc ) from Hospital group by Department;

--31. Top 2 hospitals from each city by patient count.
select Location,HospitalName,count(*),sum(PatientsCount)as total,rank() over(partition by location order by sum(PatientsCount) desc) from Hospital group by Location,HospitalName order by Location ;

--32.location wise Ranking to MedicalExpenses
select *,rank() over(partition by location order by MedicalExpenses desc) from Hospital;


--33.Calculate cumulative patients by admission date.
select Department,AdmissionDate,sum(Patientscount) over(order by AdmissionDate) from Hospital;

--34. Find percentage contribution of each department to total expenses.
select Department,count(*),sum(MedicalExpenses),(sum(MedicalExpenses)*100)/(select sum(MedicalExpenses) from Hospital)as departmentwisepercentage from Hospital group by department order by departmentwisepercentage desc; 

-- 35. Find moving average of expenses over the last 3 days.
select AdmissionDate,MedicalExpenses,avg(MedicalExpenses) over(order by AdmissionDate rows between 2 preceding and current row) from Hospital;

-- 36. Which department has the largest average stay
select Department,avg(DischargeDate-AdmissionDate)as avgstaydept from Hospital group by Department order by avgstaydept desc limit 1;

-- 37. Divide hospitals into quartiles using NTILE(4).
select *,ntile(4) over(order by MedicalExpenses) from Hospital;

-- 38. Find the first and last admission date for each hospital.
select HospitalName,min(AdmissionDate)as min_Date ,max(AdmissionDate)as max_Date from Hospital group by HospitalName;

-- 39. Calculate year medical expense.
select extract(Year from AdmissionDate)as Year,sum(MedicalExpenses) from Hospital group by Year;