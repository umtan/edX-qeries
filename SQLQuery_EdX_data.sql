select * from dbo.Edx_data$
--altering "Launch Date" column (Date Time) to (Date)
ALTER TABLE dbo.Edx_data$
ADD Launch_date  DATE;
UPDATE dbo.Edx_data$
SET Launch_date = CAST([Launch Date] AS DATE);
select [Launch Date], Launch_date from dbo.Edx_data$
ALTER TABLE dbo.Edx_data$
DROP COLUMN [Launch Date];
select * from dbo.Edx_data$
--How many Distinct Courses (Course Title or Course Number column) run by EdX ?
SELECT COUNT(DISTINCT dbo.Edx_data$.[Course Title]) AS distinct_Courses
FROM dbo.Edx_data$;
--Number of distinct courses Run by EdX is 201
---Number of Distinct courses breakup by Institutions
SELECT COUNT(DISTINCT dbo.Edx_data$.[Course Title]) AS distinct_Courses_MITx
FROM dbo.Edx_data$ where dbo.Edx_data$.Institution ='MITx' ;
---- Courses Run by Institution MITx is 92
SELECT COUNT(DISTINCT dbo.Edx_data$.[Course Title]) AS distinct_Courses_HarvardX
FROM dbo.Edx_data$ where dbo.Edx_data$.Institution ='HarvardX'
---Courses Run by Institution MITx is 109
Select SUM(dbo.Edx_data$.[Total Course Hours (Thousands)]) as Total_Course_hours  
from dbo.Edx_data$;
---Total_Course_hours is 27544.73 thousands hours
--How many total Participants at EdX from 2012-2016?
Select SUM(dbo.Edx_data$.[Participants (Course Content Accessed)]) as Total_Participent  
from dbo.Edx_data$;
---Total_Participant is 4449857
--How many Certified  at EdX from 2012-2016?
Select SUM(dbo.Edx_data$.Certified) as Total_Certified  
from dbo.Edx_data$;
----Total_Certified at EdX is 244705
--Queries on year wise : a) Participients in 2012 in MITx and HarvardX and 
                      ---b) Participients in 2016 in MITx and HarvardX 
Select SUM(dbo.Edx_data$.[Participants (Course Content Accessed)]) as Participent_MITx_2012  
from dbo.Edx_data$ where Institution ='MITx' and YEAR(Launch_date)= 2012;
---Total_Participent_MITx in 2012 = 115477
Select SUM(dbo.Edx_data$.[Participants (Course Content Accessed)]) as Participent_MITx_2016  
from dbo.Edx_data$ where Institution ='MITx' and YEAR(Launch_date)= 2016;
----Total_Participent_MITx in 2016 = 377402
------% of increment of total participents at MITx 
select ((377402 - 115477)/115477) *100 as  Increment_MITx_percent
---------200 % of increment of total participents at MITx 
---Same logic can be added for Institution = 'HarvardX'
---calculation of number of total certified of MITx on the basis of  Course Subject
Select SUM(dbo.Edx_data$.Certified) as Certified_MITx_2016, dbo.Edx_data$.[Course Subject] 
from dbo.Edx_data$ where Institution ='MITx'
group by  dbo.Edx_data$.[Course Subject];
----Like the above process we can calculate for HarvardX also.
----calculating the overall gender ratio of Edx 

select dbo.Edx_data$.[Course Subject],
    round(sum(dbo.Edx_data$.Male_Total) / sum(dbo.Edx_data$.Female_Total)*100,0) as gender_ratio
from dbo.Edx_data$ group by dbo.Edx_data$.[Course Subject];


 
