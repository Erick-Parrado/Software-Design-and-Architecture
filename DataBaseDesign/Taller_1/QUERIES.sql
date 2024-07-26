-- CONSULTA 1
SELECT 
    h.hous_id, 
    h.hous_name, 
    t.tuto_id, 
    t.tuto_name, 
    t.tuto_phone
FROM 
    Houses h
JOIN 
    Tutors t ON h.hous_id = t.hous_id
WHERE 
    t.tuto_isDirector = TRUE;

-- CONSULTA 2
SELECT 
    h.hous_id, 
    h.hous_name, 
    t.tuto_id, 
    t.tuto_name, 
    t.tuto_phone
FROM 
    Houses h
JOIN 
    Tutors t ON h.hous_id = t.hous_id;
    
-- CONSULTA 3
SELECT 
    h.hous_id, 
    h.hous_name, 
    COUNT(t.tuto_id) AS Num_Tutors
FROM 
    Houses h
LEFT JOIN 
    Tutors t ON h.hous_id = t.hous_id
GROUP BY 
    h.hous_id, 
    h.hous_name;
    
-- CONSULTA 4
SELECT 
    h.hous_id, 
    h.hous_name, 
    COUNT(t.tuto_id) AS num_directors
FROM 
    Houses h
LEFT JOIN 
    Tutors t ON h.hous_id = t.hous_id AND t.tuto_isDirector = TRUE
GROUP BY 
    h.hous_id, 
    h.hous_name;

-- CONSULTA 5
SELECT 
    h.hous_id, 
    h.hous_name, 
    COUNT(t.kid_id) AS Num_Kids
FROM 
    Houses h
LEFT JOIN 
    Kids t ON h.hous_id = t.hous_id
GROUP BY 
    h.hous_id, 
    h.hous_name;

-- CONSULTA 6
SELECT 
    h.hous_id, 
    h.hous_name, 
    COUNT(t.tuto_id) AS Num_Tutors
FROM 
    Houses h
LEFT JOIN 
    Tutors t ON h.hous_id = t.hous_id
GROUP BY 
    h.hous_id, 
    h.hous_name
ORDER BY 
    num_tutors DESC;

-- QUERY 7
SELECT h.hous_id, h.hous_name,COUNT(k.kid_id) AS kids_count
FROM houses AS h
JOIN kids AS k ON h.hous_id = k.hous_id
GROUP BY k.hous_id
ORDER BY kids_count DESC;

-- QUERY 8
SELECT * 
FROM (
    SELECT hoac.hoac_id,hoac.acti_id, AVG(kiha_evaluation) as avg_evaluation 
    FROM hous_acti AS hoac 
    JOIN kids_hoac AS kiha 
    ON kiha.hoac_id = hoac.hoac_id  
    GROUP BY hoac.acti_id) 
AS ae INNER JOIN activities AS a 
ON ae.acti_id = a.acti_id 
ORDER BY ae.avg_evaluation DESC;

-- QUERY 9
SELECT h.hous_id,h.hous_name,ae_b_hous 
FROM (
    SELECT kiha.hoac_id,hoac.hous_id,AVG(kiha_evaluation) AS ae_b_hous
    FROM kids_hoac AS kiha 
    INNER JOIN hous_acti AS hoac 
    ON hoac.hoac_id = kiha.hoac_id
    GROUP BY hoac.hous_id) AS ae 
LEFT JOIN houses AS h
ON ae.hous_id = h.hous_id
WHERE ae_b_hous >= 3;

-- QUERY 10
SELECT * FROM (
    SELECT k.kid_name,AVG(kiha.kiha_evaluation) AS ae_b_kid
    FROM kids_hoac AS kiha
    INNER JOIN kids AS k
    ON kiha.kid_id = k.kid_id
    GROUP BY k.kid_id) AS ae
WHERE ae.ae_b_kid < 3;

-- QUERY 11
SELECT h.hous_id, COUNT(*) AS room_count
FROM houses AS h
INNER JOIN rooms AS r
ON h.hous_id = r.hous_id
GROUP BY h.hous_id;

-- QUERY 12
SELECT r.regi_id,r.regi_name,COUNT(*) AS houses_count 
FROM regions AS r 
INNER JOIN houses AS h 
ON r.regi_id = h.regi_id 
GROUP BY r.regi_id 
ORDER BY houses_count DESC;

