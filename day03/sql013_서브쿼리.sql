-- 책 가격이 가장 비싼 책
-- bookname이 GROUP BY에 없어서 에러가 남
/*
SELECT MAX(price), bookname
  FROM Book;
*/

-- 35000원인거 찾기
SELECT *
  FROM Book
 WHERE price = 35000;

-- 서브쿼리 WHERE, FROM, SELECT
-- 서브쿼리를 쓰면 한번에 실행가능
SELECT bookname
  FROM Book
 WHERE price = (SELECT MAX(price)
                  FROM Book);

-- 도서를 구매한 적이 있는 고객리스트
-- 서브쿼리
SELECT [name] AS [고객이름]
  FROM Customer
 WHERE custid IN (SELECT DISTINCT custid    -- NOT IN하면 박세리가 출력
                   FROM Orders);

-- 조인도 동일한 결과를 냄
SELECT DISTINCT c.[name] AS [고객이름]
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid

-- 구매한 적이 없는 고객 외부조인
SELECT DISTINCT c.[name] AS [고객이름]
  FROM Customer AS c LEFT OUTER JOIN Orders AS o
    ON c.custid = o.custid
 WHERE o.orderid IS NULL;

-- 서브쿼리 FROM 절
SELECT b.bookid
     , b.bookname
     , b.price
     , b.publisher
     , o.orderdate
     , o.orderid
  FROM Book AS b, Orders AS o
 WHERE b.bookid = o.bookid;

-- SELECT로 만들 실행결과(가상의 테이블)를 마치 DB에 있는 테이블처럼 사용할 수 있다
SELECT t.*
  FROM (
        SELECT b.bookid
            , b.bookname
            , b.price
            , b.publisher
            , o.orderdate
            , o.orderid
          FROM Book AS b, Orders AS o
         WHERE b.bookid = o.bookid) AS t

-- 서브쿼리 SELECT절
-- 무조건 1건에 1컬럼만 연결
-- 조인으로 가능(조인보다 성능에 취약)
SELECT o.orderid
     , o.custid
     , (SELECT [name] FROM Customer WHERE custid = o.custid) AS [고객명]
     , o.bookid
     , (SELECT bookname FROM Book WHERE bookid = o.bookid) AS [도서명]
     , o.saleprice
     , o.orderdate
  FROM Orders AS o

-- 대한미디어에서 출판한 도서를 구매한 고객의 이름을 조회(서브쿼리 2번)
SELECT [name] AS [고객명]
  FROM Customer
 WHERE custid IN (SELECT custid
                    FROM Orders
                   WHERE bookid IN (SELECT bookid
                                      FROM Book
                                     WHERE publisher = '대한미디어'));

-- 계산결과를 서브쿼리로 사용
-- 각각의 출판사의 도서 평균 가격을 넘은 책들만 조회
SELECT b1.*
  FROM Book b1
 WHERE b1.price > (SELECT AVG(b2.price)
                     FROM Book b2
                    WHERE b2.publisher = b1.publisher);

-- 각 출판사별 평균가격
SELECT AVG(b2.price), b2.publisher
  FROM Book b2
 GROUP BY b2.publisher