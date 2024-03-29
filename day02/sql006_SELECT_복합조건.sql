-- 조회 복합조건
-- 도서 중 축구에 관하고, 가격이 2만원 이상인 책을 조회
SELECT bookid
	 , bookname
	 , publisher
	 , price
  FROM Book
 WHERE bookname LIKE '%축구%'
   AND price >= 20000;


-- 출판사가 굿스포츠 혹은 대한미디어인 도서 검색
SELECT *
  FROM Book
 WHERE publisher = '굿스포츠'
	OR publisher = '대한미디어';

-- 정렬
-- 기본적으로 ASC(ascending : 오름차순) 생략가능하지만 되도록 적어줘라
-- DESC(descending : 내림차순) 생략불가
SELECT *
  FROM Book
 ORDER BY bookname;

-- 도서를 가격순으로 검색하고, 가격이 같으면 이름 역순으로 검색
 SELECT *
   FROM Book
  ORDER BY price ASC, bookname DESC;

SELECT *
  FROM Book
 ORDER BY price ASC, publisher ASC;

-- 도서 가격은 내림차순, 책 출판사는 오름차순으로 검색
SELECT *
  FROM Book
 ORDER BY price DESC, publisher ASC;

-- 최근에 등록된 책부터 오래된 책순으로 검색
SELECT *
  FROM Book
 ORDER BY bookid DESC;