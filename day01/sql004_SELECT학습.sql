-- 모든 도서의 이름과 가격을 검색하시오
-- Ctrl + Shift + U --> 대문자, Ctrl + Shift + L --> 소문자
SELECT bookname, price
  FROM Book;

-- 모든 도서의 가격과 이름을 검색하시오
SELECT price, bookname
  FROM Book;

-- 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오
SELECT *	-- 실무에서는 이거 잘 안씀
  FROM Book;

-- 실무는 이래 씀, 실무에서는 속성, 컬럼명을 다 적는게 일반적
SELECT bookid, bookname, publisher, price	
  FROM Book;

-- 도서에서 출판사를 검색하시오(중복제거)
SELECT DISTINCT publisher	-- 중복제거는 제거할 수 있는(중복이 존재하는) 컬럼에서만 사용
  FROM Book;

-- 조건검색(조건 연산자 사용)
-- 가격이 2만원 미만인 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE price < 20000;

-- 가격이 1만원 이상 2만원 이하인 도서를 검색하시오.
-- BETWEEN은 미만, 초과는 검색 못함
SELECT *
  FROM Book
 WHERE price > 10000 AND price <= 20000;

 SELECT *
  FROM Book
 WHERE price BETWEEN 10000 AND 20000;

-- 출판사가 굿스포츠와 대한미디어의 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE publisher IN ('굿스포츠', '대한미디어');

 -- 출판사가 굿스포츠와 대한미디어가 아닌 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE publisher NOT IN ('굿스포츠', '대한미디어');

-- 축구의 역사를 출판한 출판사를 검색하시오
SELECT bookname, publisher
  FROM Book
 WHERE bookname = '축구의 역사';

-- 도서 이름에 축구로 시작하는 출판사를 검색하시오
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '축구%'; -- 축구라는 글자로 시작

SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '%축구'; -- 축구라는 글자로 끝남

SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '%축구%'; -- 축구라는 글자가 들어간 모든 책(가장 많이 씀)

-- 두글자에 구로 끝나는 단어로 시작되는 출판사를 검색하시오
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '_구%'; -- _(무슨 글자든 한글자가 들어간) 구라는 글자로 시작하는 (축구, 야구, 농구)