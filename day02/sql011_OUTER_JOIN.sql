-- OUTER JOIN(외부 조인)
-- LEFT OUTER JOIN vs RIGHT OUTER JOIN

SELECT *
  FROM Table A
  LEFT OUTER JOIN Table B
	ON A.key = B.key;

-- 이 둘은 같은 의미의 쿼리
SELECT *
  FROM Table B
  LEFT OUTER JOIN Table A
	ON A.key = B.key;
