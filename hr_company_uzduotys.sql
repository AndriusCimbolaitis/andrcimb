use hrcompany;

-- 1. Pasirinkite visus darbuotojus: parašykite SQL užklausą, kuri gautų visus darbuotojų įrašus iš Employees lentelės.

select*
from employees;


-- 2. Pasirinkite tam tikrus stulpelius: parodykite visus vardus ir pavardes iš Employees lentelės.


select 
FirstName,
LastName
from employees;

-- 3. Filtruokite pagal skyrius: gaukite darbuotojų sąrašą, kurie dirba HR skyriuje (department lentelė).

select 
e.FirstName,
d.DepartmentName = 'HR'
from employees as e
	join departments as d
    on e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'HR';


    SELECT 
concat(firstname,lastname) AS dirba_HR
FROM departments AS d
INNER JOIN employees as e
    ON d.departmentid = e.departmentid
WHERE departmentname = 'HR';

SELECT 
e.FirstName,
e.LastName,
d.DepartmentName
FROM employees AS e
LEFT JOIN  departments AS d
	ON e.DepartmentID = d.DepartmentID
    WHERE DepartmentName= "HR";

-- 4. Surikiuokite darbuotojus: gaukite darbuotojų sąrašą, surikiuotą pagal jų įdarbinimo datą didėjimo tvarka.


select 
FirstName,
LastName,
HireDate 
from employees
order by HireDate asc;


-- 5. Suskaičiuokite darbuotojus: raskite kiek iš viso įmonėje dirba darbuotojų.

select 
count(EmployeeID) as 'Įmonėje dirba darbuotojų'
from employees;

-- 6. Sujunkite darbuotojus su skyriais: išveskite bendrą darbuotojų sąrašą, šalia kiekvieno darbuotojo nurodant skyrių kuriame dirba.

select 
e.FirstName,
e.LastName,
d.DepartmentName
from employees as e
join departments as d
	on e.DepartmentID = d.DepartmentID;
    
    
-- 7. Apskaičiuokite vidutinį atlyginimą: suraskite koks yra vidutinis atlyginimas įmonėje tarp visų darbuotojų.

select 
concat(round(avg(SalaryAmount), 0), '€') as 'Vidutinis darbuotojo atlyginimas'
from salaries;


SELECT AVG(SalaryAmount) AS Vidutinis_atlyginimas
FROM employees AS e
JOIN salaries AS s
	ON e.employeeid = s.employeeid
WHERE s.SalaryEndDate = '2023-12-31';

-- 8. Išfiltruokite ir suskaičiuokite: raskite kiek darbuotojų dirba IT skyriuje.

   
    SELECT 
count(d.DepartmentID) AS 'Dirba IT skyriuje'
FROM departments AS d
INNER JOIN employees as e
    ON d.departmentid = e.departmentid
WHERE departmentname = 'IT';
    

-- 9. Išrinkite unikalias reikšmes: gaukite unikalių siūlomų darbo pozicijų sąrašą iš jobpositions lentelės.

select 
distinct(PositionTitle)
from jobpositions;


-- 10. Išrinkite pagal datos rėžį: gaukite darbuotojus, kurie buvo nusamdyti tarp 2020-02- 01 ir 2020-11-01.


SELECT * 
FROM employees
WHERE HireDate BETWEEN '2020-02-01' AND '2020-11-01';





-- 11. Darbuotojų amžius: gaukite kiekvieno darbuotojo amžių pagal tai kada jie yra gimę.

select 
LastName,
DateOfBirth,
TIMESTAMPDIFF( year, DateOfBirth, now() ) AS amzius 
from employees;

-- 12. Darbuotojų el. pašto adresų sąrašas: gaukite visų darbuotojų el. pašto adresų sąrašą abėcėline tvarka.

select 
email 
from employees
order by email asc ;

-- 13. Darbuotojų skaičius pagal skyrių: suraskite kiek kiekviename skyriuje dirba darbuotojų.

SELECT DepartmentName, COUNT(*) AS darbuotoju_skaicius
FROM departments
GROUP BY DepartmentName;

-- 14. Darbštus darbuotojas: išrinkite visus darbuotojus, kurie turi daugiau nei 3 įgūdžius (skills).

select 
ee.FirstName as 'Vardas',
ee.LastName as 'Pavardė',
count(e.SkillID) as 'Įgūdžių kiekis'
from employeeskills as e
	left join employees as ee
	on e.EmployeeID = ee.EmployeeID
group by ee.FirstName, ee.LastName;

-- 15. Vidutinė papildomos naudos kaina: apskaičiuokite vidutines papildomų naudų išmokų (benefits lentelė) išlaidas darbuotojams.

select
round(avg(cost), 1) as 'Vidutinė papildomų naudų išmokų kaina'
from 
benefits;

-- 16. Jaunausias ir vyriausias darbuotojai: suraskite jaunausią ir vyriausią darbuotoją įmonėje.



SELECT 
FirstName,
LastName,
DateOfBirth,
CASE
WHEN (SELECT MIN(DateOfBirth) FROM employees) = DateOfBirth THEN 'seniausias'
WHEN (SELECT MAX(DateOfBirth) FROM employees) = DateOfBirth THEN 'jauniausias'
END AS metai
FROM employees
GROUP BY FirstName,
LastName,
DateOfBirth
HAVING  metai LIKE ('seniausias') OR metai LIKE ('jauniausias');



-- 17. Skyrius su daugiausiai darbuotojų: suraskite kuriame skyriuje dirba daugiausiai darbuotojų.

    
    SELECT  DepartmentName, COUNT(*) AS darbuotoju_skaicius
FROM departments
GROUP BY Departmentid
ORDER BY darbuotoju_skaicius desc
LIMIT 1;

-- 18. Tekstinė paieška: suraskite visus darbuotojus su žodžiu “excellent” jų darbo atsiliepime (performancereviews lentelė).

select 
e.EmployeeID,
p.ReviewerID
from employees as e -- NEBAIGTA
 join performancereviews as p
 ON e.EmployeeID = p.ReviewerID
 where p.ReviewerID = '%excellent%';


SELECT 
    CONCAT(FirstName, ' ', LastName) AS 'Vardas ir Pavardė',
    ReviewText
FROM
    employees AS e
        JOIN
    performancereviews AS p ON e.EmployeeID = p.EmployeeID
WHERE
    ReviewText LIKE '%excellent%';

SELECT * 
FROM performancereviews
WHERE ReviewText LIKE '%excellent%';

-- 19. Darbuotojų telefono numeriai: išveskite visų darbuotojų ID su jų telefono numeriais.

select
EmployeeID,
Phone
from employees;

-- 20. Darbuotojų samdymo mėnesis: suraskite kurį mėnesį buvo nusamdyta daugiausiai darbuotojų.


SELECT MONTH(HireDate) AS Month, COUNT(*) AS TotalHires
FROM employees
GROUP BY Month
ORDER BY TotalHires DESC
LIMIT 1;

-- 21. Darbuotojų įgūdžiai: išveskite visus darbuotojus, kurie turi įgūdį “Communication”.

select *
from skills
WHERE SkillName like 'Communication';



-- 22. Sub-užklausos: suraskite kuris darbuotojas įmonėje uždirba daugiausiai ir išveskite visą jo informaciją.

select FirstName, LastName, SalaryAmount 
from salaries as s
join employees as em
on s.EmployeeID = em.EmployeeID
where round(SalaryAmount = (select MAX(SalaryAmount) from salaries), 0);

SELECT * 
FROM salaries AS s
JOIN employees AS e
	ON s.EmployeeID = e.EmployeeID
WHERE s.SalaryAmount = (SELECT MAX(SalaryAmount) FROM salaries) AND s.SalaryEndDate > curdate();


-- 23. Grupavimas ir agregacija: apskaičiuokite visas įmonės išmokų (benefits lentelė) išlaidas.

select 
round(sum(cost), 1)
from benefits;

-- 24. Įrašų atnaujinimas: atnaujinkite telefono numerį darbuotojo, kurio id yra 1.

select EmployeeID
UPDATE Phone
SET employeeID
WHERE ; 
from employees;

-- 25. Atostogų užklausos: išveskite sąrašą atostogų prašymų (leaverequests), kurie laukia patvirtinimo.

select *
from leaverequests 
where Status = 'Pending';

-- 26. Darbo atsiliepimas: išveskite darbuotojus, kurie darbo atsiliepime yra gavę 5 balus.

select 
e.FirstName,
e.LastName,
p.Rating 
from employees as e
	join performancereviews as p
    on e.EmployeeID = p.EmployeeID
where p.Rating = 5;

-- 27. Papildomų naudų registracijos: išveskite visus darbuotojus, kurie yra užsiregistravę į “Health Insurance” papildomą naudą (benefits lentelė).

select
ee.FirstName,
ee.LastName, 
b.BenefitName = 'Health Insurance'
from employees as ee
	join employeebenefits as e 
    on ee.EmployeeID = e.EmployeeID  
    join benefits as b 
    on b.BenefitID = e.EmployeeID
where b.BenefitName = 'Health Insurance'; 


SELECT em.FirstName, em.LastName, BenefitName
FROM employees as em
JOIN employeebenefits as eb 
ON em.EmployeeID = eb.EmployeeID
JOIN benefits as bn 
	ON bn.BenefitID = eb.BenefitID
WHERE bn.BenefitName = 'Health Insurance';

-- 28. Atlyginimų pakėlimas: parodykite kaip atrodytų atlyginimai darbuotojų, dirbančių “Finance” skyriuje, jeigu jų atlyginimus pakeltume 10 %.

SELECT 
      CONCAT(firstname,' ', lastname) AS darbuotojai,
      DepartmentName,
      ROUND(Salaryamount + (salaryamount * 10) / 100) AS 'atlyginimas_pakeltas_10%'
FROM departments AS d
JOIN employees AS e
    ON d.departmentid = e.DepartmentID
JOIN salaries AS s
    ON e.EmployeeID = s.EmployeeID
WHERE DepartmentName = 'finance' and SalaryStartDate LIKE '2023-__-__';

-- 29. Efektyviausi darbuotojai: raskite 5 darbuotojus, kurie turi didžiausią darbo vertinimo (performance lentelė) reitingą.


select 
e.FirstName,
e.LastName,
max(Rating)
from employees as e
join performancereviews as p
on e.EmployeeID = p.EmployeeID
group by e.FirstName,
e.LastName
limit 5;

SELECT * 
FROM performancereviews
ORDER BY Rating DESC
LIMIT 5;

-- 30. Darbuotojo darbo stažas: suskaičiuokite vidutinį darbuotojo išdirbtą laiką įmonėje metais, išgrupuotą pagal skyrius.

select 
e.FirstName,
e.LastName,
DepartmentName,
avg(HireDate - now())
from employees as e
join departments as d
	on e.DepartmentID = d.DepartmentID
group by e.FirstName,
e.LastName,
DepartmentName;

-- 31. Atostogų užklausų istorija: gaukite visą atostogų užklausų istoriją (leaverequests lentelė) darbuotojo, kurio id yra 1.

 SELECT * 
 FROM leaverequests
 WHERE EmployeeID = 1;
 
-- 32. Atlyginimų diapozono analizė: nustatykite atlyginimo diapazoną (minimalų ir maksimalų) kiekvienai darbo pozicijai.

 SELECT 
 EmployeeID,
    MIN(SalaryAmount) AS minimalus_atlyginimas, 
    MAX(SalaryAmount) AS maksimalus_atlyginimas
FROM 
 salaries
GROUP BY 
   EmployeeID;

-- 33. Papildomų naudų registracijos laikotarpis: raskite vidutinį visų papildomų naudų išmokų (benefits lentelė) registracijos laikotarpį (mėnesiais).


-- 34. Darbo atsiliepimo istorija: gaukite visą istoriją apie darbo atsiliepimus (performancereviews lentelė), darbuotojo, kurio id yra 2.



-- 35. Papildomos naudos kaina vienam darbuotojui: apskaičiuokite bendras papildomų naudų išmokų išlaidas vienam darbuotojui (benefits lentelė).


SELECT BenefitID,
 SUM(Cost) AS papildomos_islaidos
FROM benefits
GROUP BY BenefitID
LIMIT 1; 

-- 36. Geriausi įgūdžiai pagal skyrių: išvardykite dažniausiai pasitaikančius įgūdžius kiekviename skyriuje.


SELECT SkillName, COUNT(*) AS pasikartojimai
FROM skills
GROUP BY SkillName
ORDER BY pasikartojimai asc;

-- 37. Atlyginimo augimas: apskaičiuokite procentinį atlyginimo padidėjimą kiekvienam darbuotojui, lyginant su praėjusiais metais.



-- 38. Darbuotojų išlaikymas: raskite darbuotojus, kurie įmonėje dirba daugiau nei 5 metai ir kuriems per tą laiką nebuvo pakeltas atlyginimas.


-- 39. Darbuotojų atlyginimų analizė: suraskite kiekvieno darbuotojo atlygį (atlyginimas
-- (salaries lentelė) + išmokos už papildomas naudas (benefits lentelė)) ir surikiuokite
-- darbuotojus pagal bendrą atlyginimą mažėjimo tvarka.



-- 40. Darbuotojų darbo atsiliepimų tendencijos: išveskite kiekvieno darbuotojo vardą ir
-- pavardę, nurodant ar jo darbo atsiliepimas (performancereviews lentelė) pagerėjo ar sumažėjo.