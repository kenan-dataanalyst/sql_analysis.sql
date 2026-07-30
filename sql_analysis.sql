SELECT *
  FROM employee;

SELECT "job_role",
       round(avg("annual_salary_usd"),2) avg_salary
  FROM EMPLOYEE 
 GROUP BY "job_role" 
 ORDER BY avg_salary DESC;


--INSIGHT: DevOps və ML Engineer mövqeləri ən yüksək orta maaşa malikdir, 
--Product Manager isə siyahının sonundadır.

SELECT "education_level",
       round(avg("performance_score"),2) AS avg_performance
  FROM employee
 GROUP BY "education_level" 
 ORDER BY avg_performance DESC;

-- INSIGHT: Təhsil səviyyəsi performansla zəif bağlıdır — PhD sahiblərinin
-- orta performansı (3.6) Bachelor/Master-dan (3.51) və High School-dan (3.4) 
-- cəmi bir az yüksəkdir. Bu, "yüksək təhsil = yüksək performans" fərziyyəsini
-- tam təsdiqləmir.

SELECT "remote_work",
       count(*) AS employee_count,
       round(count(*)*100/(SELECT count(*) FROM employee),1) AS percentage
  FROM employee
 GROUP BY "remote_work";

-- INSIGHT: İşçilərin faktiki olaraq yarısına yaxını (48.8%) uzaqdan işləyir,
-- qalan 51.2% isə ofisdən — kifayət qədər balanslı bölgüdür, aydın üstünlük yoxdur.

SELECT 
  CASE 
    WHEN "years_experience" < 2 THEN '0-2 il'
    WHEN "years_experience" BETWEEN 2 AND 5 THEN '2-5 il'
    WHEN "years_experience" BETWEEN 6 AND 10 THEN '6-10 il'
    ELSE '10+ il'
  END AS experience_group,
  ROUND(AVG("annual_salary_usd"), 2) AS avg_salary,
  COUNT(*) AS employee_count,
  round(count(*)*100/(SELECT count(*) FROM employee),1) AS percentage
FROM EMPLOYEE
GROUP BY 
  CASE 
    WHEN "years_experience" < 2 THEN '0-2 il'
    WHEN "years_experience" BETWEEN 2 AND 5 THEN '2-5 il'
    WHEN "years_experience" BETWEEN 6 AND 10 THEN '6-10 il'
    ELSE '10+ il'
  END
ORDER BY avg_salary DESC;

-- INSIGHT: Təcrübə ilə maaş arasında aydın əlaqə var — 10+ il təcrübəsi 
-- olanlar ($155,169) 0-2 illik işçilərdən ($86,505) təxminən 80% çox qazanır.
-- İşçilərin böyük əksəriyyəti (68.8%) artıq 10+ il təcrübəyə malikdir.

SELECT "city_tier",
       round(avg("annual_salary_usd"),0) AS avg_salary,
       count(*) AS count
  FROM employee
 GROUP BY "city_tier" 
 ORDER BY "city_tier";

-- INSIGHT: Şəhər səviyyəsi (city_tier) ilə maaş arasında aydın əlaqə var —
-- Tier 1 şəhərlərdə orta maaş ($148,736) Tier 3-dən ($128,446) təxminən
-- 14% yüksəkdir. Bu, böyük/inkişaf etmiş şəhərlərdə maaşların daha yüksək 
-- olduğunu göstərir. 

SELECT "employee_id",
       "job_role",
       "num_skills",
       "performance_score"
  FROM employee
 ORDER BY "num_skills" DESC
 FETCH FIRST 5 ROWS ONLY;

-- INSIGHT: Ən çox bacarıqlı işçilərin (12 skill) sayı performans balı ilə
-- birbaşa bağlı görünmür — QA Engineer (4.6) yüksək performansdadır, amma 
-- Product Manager (2.5) və ML Engineer (2.5) eyni bacarıq sayına baxmayaraq 
-- aşağı performans göstərir. Deməli, sadəcə bacarıq sayı yox, onların 
-- keyfiyyəti/tətbiqi daha önəmlidir.

SELECT "job_role",
       count(*) AS high_performers
  FROM EMPLOYEE 
 WHERE "performance_score" > 4
 GROUP BY "job_role" 
 ORDER BY high_performers DESC;

-- INSIGHT: DevOps yüksək performanslı işçilərin sayına görə (69 nəfər) 
-- açıq liderdir və eyni zamanda ən yüksək orta maaşa da malikdir (sorğu 2) — 
-- bu, DevOps sahəsində həm çox güclü kadrların olduğunu, həm də bunun 
-- maaşla mükafatlandırıldığını göstərir.

SELECT 
  CASE 
    WHEN "age" < 30 THEN '30-dan az'
    WHEN "age" BETWEEN 30 AND 40 THEN '30-40'
    WHEN "age" BETWEEN 41 AND 50 THEN '41-50'
    ELSE '50-dən çox'
  END AS age_group,
  ROUND(AVG("annual_salary_usd"), 2) AS avg_salary,
  ROUND(AVG("performance_score"), 2) AS avg_performance
FROM EMPLOYEE
GROUP BY 
  CASE 
    WHEN "age" < 30 THEN '30-dan az'
    WHEN "age" BETWEEN 30 AND 40 THEN '30-40'
    WHEN "age" BETWEEN 41 AND 50 THEN '41-50'
    ELSE '50-dən çox'
  END;

-- INSIGHT: Maaş yaşla birlikdə demək olar ki, davamlı artır — 30-dan az 
-- yaş qrupu $94,484 alırsa, 50-dən çox yaş qrupu $179,144 alır (təxminən 
-- 90% çox). Amma performans balı bütün yaş qruplarında demək olar ki, 
-- eynidir (3.46-3.55 arası) — yəni yaşla maaş artır, lakin bu, performansın 
-- yüksəlməsi ilə izah olunmur, daha çox təcrübə/say-a görə ola bilər.

SELECT 
  COUNT(*) AS total_employees,
  ROUND(AVG("annual_salary_usd"), 2) AS avg_salary,
  ROUND(AVG("performance_score"), 2) AS avg_performance,
  ROUND(AVG("years_experience"), 1) AS avg_experience
FROM EMPLOYEE;

-- INSIGHT: Şirkətdə 1000 işçi var, orta maaş $137,295, orta performans 
-- balı 3.51/5, orta təcrübə isə 18.6 il — bu, kifayət qədər təcrübəli 
-- işçi bazasına işarə edir.