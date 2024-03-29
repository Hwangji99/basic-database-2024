-- 집계 함수와 GROUP BY 검색
-- 고객이 주문한 도서의 총 판매액
SELECT sum(saleprice) 		-- saleprice를 합친 금액
  FROM Orders;

SELECT sum(saleprice) AS [총 매출]		-- 띄어쓰기를 넣고 싶으면 []나 ''에 넣으면 된다
  FROM Orders;

-- 김연아 고객이 주문한 도서의 총 판매액
SELECT *
  FROM Customer;
-- 김연아는 custid가 2번

SELECT sum(saleprice) AS [김연아 고객 총 판매액]
  FROM Orders
 WHERE custid = 2;

-- COUNT()는 *을 사용할 수 있음
-- 나머지 집계함수는 열(컬럼) 하나만 지정해서 사용할 것
SELECT COUNT(saleprice) AS [주문개수]
	 , SUM(saleprice) AS [총 판매액]
	 , AVG(saleprice) AS [판매액 평균]
	 , MIN(saleprice) AS [주문도서 최소금액]
	 , MAX(saleprice) AS [주문도서 최대금액]
  FROM Orders;

-- 출판사 중복 제거 개수
SELECT COUNT(DISTINCT publisher)
  FROM Book;

-- GROUP BY : 필요조건으로 그룹핑을 해서 결과(통계)를 내기위함
-- GROUP BY는 집계 함수가 없으면 사용불가
/*
SELECT *
  FROM Orders
 GROUP BY custid;
*/


SELECT SUM(saleprice) AS [판매액]
  FROM Orders
 GROUP BY custid;

-- GROUP BY로 쓰여진 컬럼 빼고는 SELECT에 절대(!) 사용불가
-- 단, saleprice는 집계함수 안에 들어있으므로 예외
-- bookid를 빼면 실행 가능
/*
SELECT custid, bookid, SUM(saleprice) AS [판매액]
  FROM Orders
 GROUP BY custid;
*/

-- HAVING : WHERE절은 일반 필터링조건
-- HAVING은 통계, 집합 함수의 필터링조건
-- 가격이 8,000원 이상인 도서를 구매한 고객에 고객별 주문도서 총수량
-- 단, 2권 이상 구매한 경우만
SELECT custid, COUNT(*) AS [구매수]
  FROM Orders
 WHERE saleprice >= 8000
 GROUP BY custid
 HAVING COUNT(*) >= 2; -- 별명 [구매수] 사용할 수 없음
