-- 8b In which we look at a survey and deal with some more complex calculations.

-- 8b.1 Show the the percentage who STRONGLY AGREE.
SELECT A_STRONGLY_AGREE
  FROM nss
 WHERE question = 'Q01'
   AND institution = 'Edinburgh Napier University'
   AND subject = '(8) Computer Science';

-- 8b.2 Show the institution and subject where the score is at least 100 for
--      question 15.
SELECT institution, subject
  FROM nss
 WHERE question = 'Q15'
   AND score >= 100;

-- 8b.3 Show the institution and score where the score for
--      '(8) Computer Science' is less than 50 for question 'Q15'
SELECT institution, score
  FROM nss
 WHERE question = 'Q15'
   AND subject = '(8) Computer Science'
   AND score < 50;

-- 8b.4 Show the subject and total number of students who responded to
--      question 22 for each of the subjects '(8) Computer Science' and
--      '(H) Creative Arts and Design'.
SELECT subject, SUM(response)
  FROM nss
 WHERE question = 'Q22'
   AND (subject = '(8) Computer Science'
        OR subject = '(H) Creative Arts and Design')
GROUP BY subject;

-- 8b.5 Show the subject and total number of students who A_STRONGLY_AGREE to
--      question 22 for each of the subjects '(8) Computer Science' and
--      '(H) Creative Arts and Design'.
SELECT subject, SUM(response * A_STRONGLY_AGREE / 100)
  FROM nss
 WHERE question = 'Q22'
   AND (subject = '(8) Computer Science'
        OR subject = '(H) Creative Arts and Design')
GROUP BY subject;

-- 8b.6 Show the percentage of students who A_STRONGLY_AGREE to question 22 for
--      the subject '(8) Computer Science' show the same figure for the subject
--      '(H) Creative Arts and Design'. Use the ROUND function to show the
--      percentage without decimal places.
SELECT subject, ROUND(SUM(A_STRONGLY_AGREE * response) / SUM(response))
  FROM nss
 WHERE question = 'Q22'
   AND (subject = '(8) Computer Science'
        OR subject = '(H) Creative Arts and Design')
GROUP BY subject

-- 8b.7 Show the average scores for question 'Q22' for each institution that
--      include 'Manchester' in the name.
SELECT institution, ROUND(SUM(score * response) / SUM(response)) AS ave_score
  FROM nss
 WHERE question = 'Q22' AND (institution LIKE '%Manchester%')
GROUP BY institution;

--  8b.8 Show the institution, the total sample size and the number of computing
--       students for institutions in Manchester for 'Q01'.
SELECT institution,
       SUM(sample),
       SUM(CASE WHEN subject = '(8) Computer Science' THEN sample END) AS comp_students
  FROM nss
 WHERE question = 'Q22' AND (institution LIKE '%Manchester%')
GROUP BY institution;
