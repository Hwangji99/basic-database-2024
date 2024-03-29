-- 2개 이상의 테이블 SQL 쿼리 작성
-- Customer, Orders 테이블을 동시에 조회(조건없이)
/*
SELECT *
  FROM Customer;

SELECT *
  FROM Orders;		-- 동시에 부른게 아닌 2개를 부른 것
*/

SELECT *
  FROM Customer, Orders;	-- 50개 행이 출력, 그러나 이는 제대로 알아 볼 수 없는 의미없는 출력이다

-- Customer, Orders 테이블을 동시에 조회(둘의 custid가 일치하는 조건에서)
-- RDB(Relation Database)에서 가장 중요한 쿼리문 1번 -> Join, 조인 ★★★★★
-- Join이라고 함(관계형 데이터베이스에서 제일 중요함)
SELECT *
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid
 ORDER BY Customer.custid ASC;

-- 주문한 책의 고객이름과 책 판매액 조회
SELECT Customer.[name]
	 , Orders.saleprice
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid;

-- 고객별로 주문한 모든 도서의 총판매액을 구하고, 고객별로 정렬
SELECT Customer.[name]
	 , SUM(Orders.saleprice) AS [총 판매액]
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid	-- 두 테이블의 custid가 같다
 GROUP BY Customer.[name]
 ORDER BY Customer.[name];

-- 각 테이블의 별명으로 줄여서 사용가능(일반적)
-- JOIN, 내부조인, INNER JOIN
SELECT c.[address]
	 , c.custid
	 , o.custid
	 , c.[name]
	 , c.phone 
	 , o.bookid
	 , o.orderdate
	 , o.orderid
	 , o.saleprice
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid
 ORDER BY c.custid ASC;

-- 3개 테이블 조인 -> 표준 SQL이 아님(편의를 위해 축약)
SELECT *	-- 컬럼별로 나눠적기 생략(원래는 해야함)
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid
   AND o.bookid = b.bookid

-- 실제 표준 SQL Inner Join -> 표준 SQL은 더 복잡함
SELECT *
  FROM Customer AS c
 INNER JOIN Orders AS o
	ON c.custid = o.custid
 INNER JOIN Book AS b
	ON o.bookid = b.bookid;

-- 가격이 2만원 이상인 도서를 주문한 고객의 이름과 도서명 조회
SELECT c.[name]
	 , b.bookname
	 , o.saleprice
	 , b.price
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid
   AND o.bookid = b.bookid	-- 여기까진 JOIN을 위한 조건
   AND b.price >= 20000;	-- 그 외 필터링을 위한 조건

/* 조인안하면 이리 복잡함
SELECT *
  FROM Orders AS o
 WHERE o.bookid IN (3, 7)

SELECT *
  FROM Book AS b
 WHERE b.price >= 20000
   AND b.bookid IN (3, 7)

SELECT *
  FROM Customer AS c
 WHERE c.custid IN (1, 4)
 */