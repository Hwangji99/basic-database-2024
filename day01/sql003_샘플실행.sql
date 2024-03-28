-- 책중에서 '축구의 역사'라는 도서의 출판사와 가격을 알고 싶어
-- dbo(DataBase Owner)
-- DML(4가지) 중 SELECT(조회)
-- 모든 프로그램언어는 ==(2개씀, 같다라는 의미), 데이터베이스는 =(1개씀)
SELECT publisher, price
  FROM Book
 WHERE bookname = '축구의 역사'; 

 /*
	- SQL에서는 equal연산자에 == 사용X, 모조건 =
	- SQL에서는 문자열에 "" 사용X, 무조건 ''
	- SQL에서는 대소문자 구분X, 하지만 키워드(파란글)는 대문자로 사용할 것
	- SQL에서는 ;이 필수가 아님. 하지만 중요한 사항에서는 사용할 것
 */
 -- USE basic2024;
 -- 도구 -> 옵션 -> 파일확장명 -> sql쿼리 인코딩 사용
 -- 컨트롤+n하면 utf-8로 바로 설정가능
 -- F5하여 나온 결과는 가상의 결과

 -- 김연아 고객의 전화번호를 찾으시오.
 -- 1 step
 SELECT * /* SELECT *은 All이라고 호칭(모든 컴럼을 읽어옴) */
   FROM Customer;
   
-- 2 step(1 step에서 수정)
-- []이거는 컬럼이 아니라는 의미
-- SELECT 구문이 여러 개일 때 원하는 쿼리만 드래그해서 실행시키면 원하는 값만 나옴
SELECT *
  FROM Customer
 WHERE [name] = '김연아';

 -- 3 step(2 step에서 수정)
 SELECT phone
  FROM Customer
 WHERE [name] = '김연아';

 -- 단계별로 작성이 편함