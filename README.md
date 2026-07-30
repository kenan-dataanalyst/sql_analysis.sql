# SQL ilə İşçi Datasının Analizi

Bu layihədə Oracle SQL istifadə edərək 1000 işçidən ibarət bir dataset üzərində 
analiz aparmışam. Məqsəd maaş, performans, təcrübə və digər amillər arasındakı 
əlaqələri araşdırmaqdır.

## İstifadə olunan alətlər
- Oracle Database
- DBeaver

## Dataset
1000 işçi, 10 sütun: employee_id, age, years_experience, education_level, 
job_role, city_tier, performance_score, num_skills, remote_work, annual_salary_usd

## Öne çıxan tapıntılar
- Təcrübə ilə maaş arasında güclü əlaqə var (10+ il təcrübəsi olan işçilər 
  0-2 illik işçilərdən təxminən 80% çox qazanır)
- DevOps mövqeyi həm ən yüksək orta maaşa, həm də ən çox yüksək performanslı 
  işçi sayına malikdir
- Təhsil səviyyəsinin performansa təsiri çox zəifdir — PhD sahibləri ilə 
  High School məzunları arasında performans balında demək olar ki, fərq yoxdur
  
## Faylda nə var?
'sql_analysis.sql' faylında 10 analitik sorğu var — hər sorğunun altında 
tapılan nəticə (insight) şərh olaraq yazılıb.
