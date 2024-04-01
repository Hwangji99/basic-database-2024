-- Customer를 기준으로 Orders 테이블과 외부조인하기
-- Ctrl + Shift + E가 실행
SELECT c.custid
     , c.[name]
     , c.[address]
     , c.phone
     , o.bookid
     , o.custid -- OUTER JOIN에서는 이 외래키는 필요X
     , o.saleprice
     , o.orderid
     , o.orderdate
  FROM Customer AS c RIGHT OUTER JOIN Orders AS o -- LEFT, RIGHT, FULL 등으로 변경하면서 실행
  -- FROM Customer AS c LEFT OUTER JOIN Orders AS o
  -- FROM Customer AS c INNER JOIN Orders AS o
    ON c.custid = o.custid;