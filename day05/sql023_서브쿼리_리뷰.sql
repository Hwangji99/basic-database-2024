-- 서브쿼리 리뷰
-- All, ANY(SOME) -> ANY(SOME)을 쓰는 조건은 아래의 데이터는 사용하기 어려움
-- ALL은 모두, SOME(ANY)는 어떠한(최소한 하나라도)이라는 의미를 가짐

-- 3번 고객이 주문한 도서의 최고금액보다 더 비싼 도서를 구입한 다른 주문의 주문번호, 금액을 표시하라
-- 3번 고객이 누군지 확인(장미란)
SELECT *
  FROM Customer;

-- 장미란이 주문한 내역(13000원)
SELECT MAX(saleprice) AS '최고금액'
  FROM Orders
 WHERE custid = 3;

-- 13000원 보다 비싼 도서를 구입한 주문번호, 금액
-- 서브쿼리 앞에 ALL이나 ANY를 붙여도 결과 변동X 
SELECT o1.orderid
     , o1.saleprice
  FROM Orders AS o1
 WHERE o1.saleprice > (SELECT MAX(saleprice) AS '최고금액'
                         FROM Orders
                        WHERE custid = 3);

-- EXISTS, NOT EXISTS -> 열을 명시 안함
-- 데이터의 존재 유무를 확인하는 연산자

-- 대한민국 거주 고객에게 판매한 도서의 총 판매액
-- 전체 판매액 118000, 대한민국 고객 판매액 46000
SELECT SUM(saleprice) AS '대한민국 고객 총 판매액'
  FROM Orders AS o
 WHERE EXISTS(SELECT *
                FROM Customer AS c
               WHERE c.address LIKE '%대한민국%'
                 AND c.custid = o.custid);

-- 조인도 가능(아닌 것 찾을 땐 NOT LIKE하면 됨)
SELECT SUM(o.saleprice)
  FROM Orders AS o, Customer AS c
 WHERE o.custid = c.custid
   AND c.address LIKE '%대한민국%';

-- SELECT절 서브쿼리, JOIN으로 변경가능(JOIN이 더 낫다)
-- 이미 쿼리가 너무 복잡해서 더이상 테이블을 추가하기 힘들면 많이 사용(JOIN)
-- 51. 고객별 판매액을 보여라 GROUP BY가 들어가면 SELECT절에 반드시 집계함수가 들어가야 함★★★
SELECT SUM(o.saleprice) AS '고객별 판매액'
     , o.custid -- GROUP BY에서 custid를 사용했으니 SELECT에서도 custid만 사용 가능
     , (SELECT [name] FROM Customer WHERE custid = o.custid) AS '고객명'
  FROM Orders AS o
 GROUP BY o.custid;

-- 조인으로 가능, 바로 다음 장 나옴

--UPDATE에서도 사용가능
-- 사전준비
ALTER TABLE Orders ADD bookname VARCHAR(40);

-- 업데이트, 한꺼번에 필요한 필드값을 한테이블에서 다른 테이블로 복사할 때 아주 유용함
UPDATE Orders
   SET bookname = (SELECT bookname
                     FROM Book AS b
                    WHERE b.bookid = Orders.bookid);

-- FROM절 서브쿼리(인라인 뷰[가상테이블])
-- 52. 고객별 판매액으로 고객명과 판매금액을 보여라(서브쿼리 --> JOIN)
-- 고객별 판매액 집계 쿼리가 FROM절에 들어가면 모든 속성(컬럼)에 이름이 지정되어야 함
SELECT b.Total
     , c.[name]
  FROM (SELECT SUM(o.saleprice) AS 'Total'    -- 집계함수에 이름을 지어주지 않으면 에러뜸
             , o.custid 
          FROM Orders AS o
         GROUP BY o.custid) AS b, Customer AS c
 WHERE b.custid = c.custid;

-- 고객번호가 2이하인 고객별 판매액을 보이시오. 고객이름, 판매액 표시 
-- GROUP BY에 들어갈 속성(컬럼)은 최소화. 중복 등의 문제가 있으면 결과가 다 틀어짐(주의!!)
SELECT SUM(o.saleprice) AS '고객별 판매액'
     , (SELECT name FROM Customer WHERE custid = c.custid) AS '고객명'
 FROM(SELECT custid
           , [name]
        FROM Customer
       WHERE custid <= 2) AS c, Orders AS o
 WHERE c.custid = o.custid
 GROUP BY c.custid;