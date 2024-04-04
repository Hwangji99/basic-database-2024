# basic-database-2024
IoT 개발자 과정 SQL Server 학습 리포지토리

## 1일차(2024-03-28)
- MS SQL Server 설치 : https://www.microsoft.com/ko-kr/sql-server/sql-server-downloads (최신버전)
    - DBMS 엔진 (개발자 버전(미디어 다운로드, iso))
        - iso 다운로드 후 설치 추천
        - 다운로드 파일 우클릭 후 탑재
        - setup.exe 클릭
        - SQL Server에 대한 Azure 확장 비활성화 후 진행

        ![기능선택](https://github.com/Hwangji99/basic-database-2024/blob/main/images/images/db001.png)

        - 인스턴스 기능
            - 데이터베이스 엔진 서비스, SQL Server 복제, 검색을 위한 전체 텍스트 및 의미 체계 추출 선택
            - Integration Services 선택
        - 서버 구성은 손대지 말고 데이터 정렬(CI은 대소문자 구분X, AS는 악센트 구분)
        - 데이터베이스 엔진 구성부터 중요
            - Windows 인증모드로 하면 외부로부터 접근불가
            - 혼합모드(sa)에 대한 암호를 지정(무조건 sa임) / mssql_p@ss (8장 이상 / 대소문자 구분 / 특수문자 1자 이상 포함)
            - 데이터 디렉터리에서 데이터 루트 디렉토리는 주소 변경 -> C에 Datas라는 파일을 만들어 주소 입력(나머지는 손대지 마라)
    - [개발툴 설치](https://learn.microsoft.com/ko-kr/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16) 
        - SSMS(Sql Server Management Studio) DB에 접근, 여러개발 작업을 할 수 있는 툴
        - 한국어를 설치해야함(SSMS-Setup-KOR)
        - 다운 완료 후 그냥 설치하면됨

- 데이터베이스 개념
    - 데이터를 보관, 관리, 서비스하는 시스템
    - Data, Information, Knowledge 개념
    - DBMS > Database > Data(Model)

- DB언어
    - SQL(Structured Query Language) : 구조화된 질의 언어    
    - DDL(Data Definition Language) - 데이터베이스, 테이블, 인덱스 생성 CREATE, ALTER, DROP
    - DML(Data Manipulation Language) - 검색(SELECT), 삽입(INSURT), 수정(UPDATE), 삭제(DELETE) 등 기능(가장 중요!)★★★★★
    - DCL(Data Control Language) - 보안, 권한 부여(GRANT) / 제거(REVOKE) 기능
    - TCL(Transaction Control Language) - 트랜잭션 제어하는 기능 COMMIT, ROLLBACK (원래는 DCL의 일부, 기능이 특이해서 TCL로 분리)

- SQL 기본 학습
    - SSMS 실행

    ![SSMS로그인](https://github.com/Hwangji99/basic-database-2024/blob/main/images/images/db002.png)

    - 특이사항 : SSMS 쿼리창에서 소스코드 작성시 빨간색 오류 밑줄이 가끔 표현(전부 오류는 아님)

    - SQL에서는 equal연산자에 == 사용X, 모조건 =
	- SQL에서는 문자열에 "" 사용X, 무조건 ''
	- SQL에서는 대소문자 구분X, 하지만 키워드(파란글)는 대문자로 사용할 것
	- SQL에서는 ;이 필수가 아님. 하지만 중요한 사항에서는 사용할 것
    - 도구 -> 옵션 -> 파일확장명 -> sql쿼리 인코딩 사용
    - 컨트롤+n하면 utf-8로 바로 설정가능

- DML 학습
    - SQL 명령어 키워드 : SELECT, INSURT, UPDATE, DELETE
    - IT개발 표현 언어 : Request, Create, Update, Delete(CRUD로 부름)
    - 예시 - CRU개발 뜻은 INSERT, UPDATE, SELECT를 할 수 있는 기능을 개발하라는 의미
    - SELECT
        - SELECT 구문이 여러 개일 때 원하는 쿼리만 드래그해서 실행시키면 원하는 값만 나옴
        - SELECT, FROM은 필수고 밑에 []들은 옵션
        ```sql
        SELECT [ALL | DISTINCT] 속성이름(들)
          FROM 테이블이름(들)
         [WHERE 검색조건(들)]
         [GROUP BY 속성이름(들)]
         [HAVING 검색조건(들)]
         [ORDER BY 속성이름(들) [ASC | DESC]]
        ```
    - SELECT문 학습
     - 기본, 조건검색 학습 중

## 2일차(2024-03-29)
- Database 학습
    - DB 개발 시 사용할 수 있는 툴
        - SSMS(기본)
        - Visual Studio - 아무런 설치 없이 개발 가능
        - Visual Studio Code - SQL Server(mssql) 플러그인 설치하고 개발
    - ServerName(HostName) - [본인 컴퓨터 이름 | 본인 네트워크 주소 | 127.0.0.1(LoopBack IP) | localhost(LoopBack URL)] 중에서 선호하는거 아무거나
    - 관계 데이터 모델
        - 릴레이션 : 행과 열로 구성된 테이블
            - 행(튜플), 열(속성), 스키마, 인스턴스 용어
            - 릴레이션 특징
                - 속성은 단일값을 가짐
                - 속성은 서로 다른 이름으로 구성 (책이름이라는 속성이 두번있으면 안됨)
                - 속성의 값은 정의된 도메인값만 가짐(대학교 학년에 5학년이 있으면 안됨)
                - 속성의 순서는 상관없음
                - 릴레이션 내의 중폭된 튜플은 허용하지 안함(같은 책 정보를 두번 넣을 수 없음)
                - 튜플의 순서는 상관없음(1,3,5,2,6,7,8...)
        - 테이블(실제 DB에서 부를 때)
            - 행(레코드), 열(컬럼, 필드), 내포(스키마, 필드명), 외연(데이터)
        - 차수(degree) - 속성의 개수
        - 카디널리티(cardinality) - 튜플의 수
        - 관게 데이터 모델 구성요소
            - 릴레이션(Relation)
            - 제약조건(Contraints)
            - 관계대수(Relational algebra)
- DML 학습
    - SELECT문
        - 복합조건
        - 집계 함수와 GROUP BY 검색
            - 집계 함수 -> SUM(총합), AVG(평균), COUNT(개수), MIN(최소값), MAX(최대값)
            - 집계 함수 외 일반 컬럼은 GROUP BY절에 속한 컬럼만 SELECT문에 사용가능
            - GROUP BY절
            ```sql
            SELECT SUM(saleprice) AS [판매액]
              FROM Orders
             GROUP BY custid;
            ```

            - HAVING은 집계함수의 필터로 GROUP BY 뒤에 작성 WHERE절과 필터링이 다름
            - HAVING절
            ```sql
            SELECT custid, COUNT(*) AS [구매수]
              FROM Orders
             WHERE saleprice >= 8000
             GROUP BY custid
             HAVING COUNT(*) >= 2; -- 별명 [구매수] 사용할 수 없음
            ```
        - 2개 이상의 테이블 질의(Query)
            - 관계형 DB에서 가장 중요한 기법 중 하나(JOIN)
              (https://sql-joins.leopard.in.ua/)
            ```sql
            SELECT *
              FROM Customer, Orders
             WHERE Customer.custid = Orders.custid
             ORDER BY Customer.custid ASC;
            ```
            - 각 테이블의 별명으로 줄여서 쓰는게 일반적
            - 내부조인(INNER JOIN)(교집합)
            ```sql
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
            ```
            - 외부조인(LEFT | RIGHT JOIN) : 어느 테이블이 기준인지에 따라서 결과가 상이함

        ![외부조인](https://github.com/Hwangji99/basic-database-2024/blob/main/images/images/db006.png)

## 3일차(2024-04-01)
- Database 학습
    - 관계 데이터 모델
        - 키
            - 특정 튜플을 식별할 때 사용하는 속성 혹은 속성의 집합
            - 키는 릴레이션 간의 관계를 맺는 데도 사용
            - 릴레이션은 중복된 튜플을 허용X, 때문에 각각 속성들은 값이 달라야함. 즉, 키가 되는 속성은 반드시 값이 달라서 튜플들을 서로 구별할 수 있어여 함

             - 기본키 ★★★★★ (Primary Key, [Unique & NOT NULL])
                - 여러 후보키 중 하나를 선정하여 대표로 삼는 키 (고객번호)
                - 후보키가 하나뿐이라면 그 후보키를 기본키로 사용하면 되고 여러 개라면 릴레이션의 특성을 반영하여 하나를 선택하면 됨
                - 기본키 선정 시 고려사항
                    - 릴레이션 내 튜플을 식별할 수 있는 고유한 값을 가져야 함
                    - NULL값 허용X
                    - 키 값의 변동이 일어나지 않아야 함
                    - 최대한 적은 수의 속성을 가진 것이어야 함
                    - 향후 키를 사용하는 데 있어서 문제 발생 소지가 없어야 함
                    - 릴레이션 스카를 표현할 때 기본키는 밑줄을 그어 표시함
            - 슈퍼키 
                - 튜플을 유일하게 식별할 수 있는 하나의 속성 혹은 속성의 집합 (Ex. 고객번호 | 고객번호/이름 | 고객번호/주소, | 고객번호/이름/전화번호..., 이름만 있으면 안됨(동명이인이 있을 수 있어서)) 
                - 튜플을 유일하게 식별할 수 있는 값이면 모두 슈퍼키가 될 수 있음
            - 후보키 
                - 튜플을 유일하게 식별할 수 있는 속성의 최소 집합 (Ex. 고객번호 | 주민번호)
                - 후보키 중에서 2개 이상의 속성으로 이루어진 조합을 복합키라 함
            - 대리키
                - 기본키가 보안을 요하거나, 여러 개의 속성으로 구성되어 복잡하거나, 마땅한 기본키가 없을 때 일련번호 같은 가상의 속성을 만들어 기본키로 삼는 경우 -> 대리키 혹은 인조키
                - 대리키는 DBMS나 관련 소프트웨어에서 임의로 생성하는 값으로 사용자가 직관적으로 그 값의 의미를 알 수 없음
            - 대체키
                - 기본키로 선정되지 않은 후보키
            - 외래키 ★★★ (Foriegn Key)
                - 기본키를 참조하여 사용하는 것
                - 고려사항
                    - 다른 릴레이션과의 관계
                    - 다른 릴레이션의 기본키를 호칭
                    - 서로 같은 값을 사용
                    - 기본키가 변경되면 외래키도 변경되어야 함
                    - NULL이거나 중복값일 수도 있음(NOT NULL인 경우도 있음)
                    - 자기 자신의 기본키를 외래키로 사용할 수 있음 <-> 외래키가 기본키의 속성 중 하나가 될 수도 있음
           
        
        - 무결성 제약조건
            - 데이터 무결성
                - 데이터베이스에 저장된 데이터의 일관성과 정확성을 지키는 것을 말함
            - 도메인 무결성
                - 도메인 제약이라고도 하며, 릴레이션 내의 튜플들이 각 속성의 도메인에 지정된 값만을 가져야 한다는 조건
                - SQL문에서 데이터 형식(type), 널(NULL / NOT NULL), 기본 값(default), 체크(check) 등을 사용하여 지정할 수 있음
            - 개체 무결성
                - 기본키 제약이라고도 함
                - 기본키는 NULL값을 가져서는 안되며 릴레이션 내에 오직 하나의 값만 존재해야 한다는 조건(값이 중복되어도 안되고, 빠져도 안됨)
                - 삽입 : 기본키 값이 같으면 삽입이 금지됨
                - 수정 : 기본키 값이 같거나 NULL로도 수정이 금지됨
                - 삭제 : 특별한 확인이 필요하지 않으며 즉시 수행함
            - 참조 무결성
                - 외래키 제약이라고도 하며, 릴레이션 간의 참조 관계를 선언하는 제약조건
                - 자식 릴레이션의 외래키는 부모 릴레이션의 기본키와 도메인이 동일해야 하며, 자식 릴레이션의 값이 변경될 때 부모 릴레이션의 제약을 받음
                - 옵션
                    - RESTRICTED : 자식 릴레이션에서 참조하고 있으면 부모 릴레이션의 삭제 작업을 거부함 (사용중이면 삭제 못한다는 의미)
                    - CASCADE : 자식 릴레이션의 관련 튜플을 같이 삭제함
                    - DEFAULT : 자식 릴레이션의 관련 튜플을 미리 설정해 둔 값으로 변경함
                    - NULL : 자식 릴레이션의 관련 튜플을 NULL값으로 설정함(NULL값을 허가한 경우)
            - 유일성 제약조건
                - 일반 속성의 값이 중복되면 안되는 제약조건 (NULL값은 허용)

- DML 학습
    - SELECT문
        - 외부조인(OUTER JOIN)
            - LEFT | RIGHT | FULL(FULL은 거의 사용안함) 
                - 왼쪽 테이블을 기준으로 조건에 일치하지 않는 왼쪽테이블 데이터로 모두 표시(LEFT OUTER JOIN)
                - 오른쪽 테이블 기준으로 조건에 일치하지 않는 오른쪽 테이블 데이터 모두 표시(RIGHT OUTER JOIN)
            
        - 서브쿼리 (부속질의, 많은 연습 필요!!)
            - 쿼리 내에 다시 쿼리를 작성하는 것
            - 서브쿼리를 쓸 수 있는 위치
                - SELECT절 -> 한 컬럼에 하나의 값만 사용가능
                - FROM절 -> 가상의 테이블로 사용
                - WHERE절 -> 여러 조건에 많이 사용
                ```sql
                SELECT bookname
                  FROM Book
                 WHERE price = (SELECT MAX(price)
                                  FROM Book);
                ```
            - 상관 부속질의
                - 상위 부속질의의 튜플을 이용하여 하위 부속질의를 계산함
                - 상위 부속질의와 하위 부속질의가 독립적이지 않고 서로 관련을 맺고 있음

            - 집합연산 : JOIN도 집합이지만, 속성별로 가로로 병합하기 때문에 집합이라 부르지 않음. 집합은 데이터를 세로로 합치는 것을 뜻함
                - 차집합(EXCEPT, 거의 사용안함) : 하나의 테이블에서 교집합 값을 뺀 나머지
                - 합집합(UNION, 진짜 많이 사용) : UNION(중복제거), UNION ALL(중복허용)
                - 교집합(INTERSECT, 거의 사용안함) : 두 테이블에 모두 존재하는 값
                - EXISTS : 데이터 자체의 존재여부 

- DDL 학습 (SSMS에서 마우스로 조작이 편리)
    - CREATE : 개체(데이터베이스, 뷰, 테이블, 사용자 등)를 생성하는 구문
        ```sql
        -- 테이블 생성에 한정
        CREATE TABLE 테이블명
        ({ 속성이름 데이터타입
            [NOT NULL]
            [UNIQUE]
            [DEFAULT 기본값]
            [CHECK 체크조건]
        }
            [PRIMARY KEY 속성이름(들)]
            {[FORIEGN KEY 속성이름 REFERENCES 테이블이름(속성이름)]
                [ON UPDATE [NO ACTION | CASCADE | SET NULL | SET DEFAULT]]
            }
        )
        ```
    - ALTER : 개체를 변경(수정)하는 구문
        ```sql
        ALTER TABLE 테이블명
            [ADD 속성이름 데이터 타입]
            [DROP COLMN 속성이름]
            [ALTER COLUMN 속성이름 데이터 타입]
            [ALTER COLUMN 속성이름 [NULL | NOT NULL]]
            [ADD PRIMARY KEY(속성이름)]
            [[ADD | DROP] 제약조건이름];
        ```
    - DROP : 개체를 삭제하는 구문
        ```sql
        DROP TABLE 테이블명;
        ```

        - 외래키로 사용되는 기본키가 있으면 외래키를 사용하는 테이블을 삭제 후, 기본키의 테이블을 삭제해야 함!!

## 4일차(2024-04-02)
- 관계 데이터 모델
    - 관계대수(Relation Algebra) : 릴레이션에서 원하는 결과를 얻기 위한 수학의 대수와 같은 연산을 이용하여 기술하는 언어
        - 관계대수식
            - 릴레이션 간 연산을 통해 결과 릴레이션을 찾는 절차를 기술한 언어
            - 대상이 되는 릴레이션과 연산자로 구성되며, 결과는 릴레이션으로 반환됨. 반환된 릴레이션은 릴레이션의 모든 특징을 따름
            - 단항 연산자 : 연산자<조건> 릴레이션
            - 이항 연산자 : 릴레이션1 연산자<조건> 릴레이션2
        - 셀렉션, 프로젝션, 집합, 조인, 카티션 프로덕트, etc...

- DML 학습(SELECT 외)
    - INSERT
        - 테이블에 새로운 튜플을 삽입하는 명령어

        ```sql
        INSERT INTO 테이블이름[(속성리스트)]
            VALUES (값리스트);
        ```
    - UPDATE
        - 특정 속성값을 수정하는 명령어

        ```sql
        -- 트랜잭션을 걸어서 복구를 대비
        UPDATE 테이블이름
            SET 속성이름1 = 값[, 속성이름2 = 값, ...]
         WHERE <검색조건>   -- 실무에서는 빼면 큰일남
        ```
    - DELETE
        - 테이블에 있는 기존 튜플을 삭제함

        ```sql
        -- 트랜잭션을 걸어서 복구를 대비
        DELETE FROM 테이블이름
         WHERE 검색조건;    -- 실무에서는 빼면 큰일남
        ```

- SQL 고급
    - 내장함수
        - 수학함수, 문자열함수, 날짜/시간함수, 변환함수, 커서 함수(!), 보안함수, 시스템함수
        - 내장 함수의 결과 NULL(!)
            - 아직 지정되지 않은 값
            - NULL 값은 '0', "(빈문자), ''(공백) 등과 다른 특별한 값
            - NULL 값은 비교 연산자로 비교가 불가능함
            - NULL 값의 연산을 수행하면 결과 역시 NULL 값으로 반환됨
            - 집계 함수를 사용할 때 주의할 점
                - 'NULL + 숫자' 연산의 결과는 NULL
                - 집계 함수 계산 시 NULL이 포함된 행은 집계에서 빠짐
                - 해당되는 행이 하나도 없을 경우 SUM, AVG 함수의 결과는 NULL이 되며, COUNT 함수의 결과는 0
    - 서브쿼리 리뷰
        - SELECT -> 단일행, 단일열을 반환 (스칼라 서브쿼리)
        - FROM -> 다수행, 다수열 반환 (인라인 뷰)
        - WHERE -> 다수행, 다수열 반환 (중첩 서브쿼리)
            - 비교연산, 집합연산, 한정연산, 존재연산 가능
    

## 5일차(2024-04-03)
- SQL 고급
    - 서브쿼리 리뷰
    - 뷰 : 하나 이상의 테이블을 합하여 만든 가상의 테이블
        - 장점
            - 편리성(및 재사용성) : 자주 사용되는 복잡한 질의를 뷰로 미리 정의해 놓을 수 있음 -> 복잡한 질의를 간단히 작성, 미리 정의된 뷰를 일반 테이블처럼 사용할 수 있기 때문에 편리함
            - 보안성 : 각 사용자별로 필요한 데이터만 선별하여 보여줄 수 있음. 중요한 질의의 경우 질의 내용을 암호화할 수 있음 -> 개인정보(주민번호)나 급요, 건강 같은 민감한 정보를 제외한 테이블을 만들어 사용
            - 논리적 독립성 제공 : 개념 스키마의 데이터베이스 구조가 변하여도 외부 스키마에 영향을 주지 않도록하는 논리적 데이터 독립성 제공

        - 특징
            - 원본 데이터 값에 따라 같이 변함
            - 독립적인 인덱스 생성이 어려움
            - 삽입, 삭제, 갱신 연산에 많은 제약이 따름

        ```sql
        -- 생성
        CREATE VIEW 뷰이름 [(열이름 [, ...])]
        AS <SELECT 쿼리문>;

        --수정
        ALTER VIEW 뷰이름 [(열이름 [, ...])]
        AS <SELECT 쿼리문>;

        -- 삭제
        DROP VIEW 뷰이름;
        ```

    - 인덱스
        - 특징
            - 테이블에서 한 개 이상의 속성을 이용하여 생성함
            - 빠른 검색과 함께 효율적인 레코드 접근이 가능함
            - 순서대로 정렬된 속성과 데이터의 위치만 보유하므로 테이블보다 작은 공간을 차지함
            - 저장된 값들은 테이블의 부분집합이 됨
            - 일반적으로 B-tree 형태의 구조를 가짐
            - 데이터의 수정, 삭제 등의 변경이 발생하면 인덱스의 재구성이 필요함
        - 클러스터 인덱스 : 발생하면 인덱스의 재구성이 필요, PRIMARY KEY는 클러스터링
        - 비클러스터 인덱스 : PK외에는 비클러스터링

        ```sql
        -- 생성
        CREATE [UNIQUE] [CLUSTERD | NONCLUSTERED] INDEX 인덱스이름
        ON 테이블명 (속성이름 [ASC | DESC] [,...n]);

        -- 수정
        ALTER INDEX {인덱스 이름 | ALL}
        ON 테이블명 { REBUILD | DISABLE | REORGANIZE};

        -- 삭제
        DROP INDEX 인덱스이름 ON 테이블명;
        ```

        - SSMS에서 실행계획을 가지고 쿼리 실행 성능을 체크할 수 있음

- 파이썬 SQL Server 연동 프로그래밍 
    - Madang DB 관리 프로그램
    - PyQT GUI 생성
    - SQL Server 데이터 핸들링
        - pymssql 라이브러리 설치

        ```shell
        > pip install pymssql
        ```

    - DB 연결 설정 - Oracle, MySQL 등은 설정이 없음. 구성관리자에서 TCP/IP로 접근을 허용하지 않으면 접속 안됨
        1. 시작메뉴 > 모든 앱 > MicroSoft SQL Server 20xx > **SQL Server 20xx 구성관리자** 실행
        2. SQL Server 네트워크 구성 > **MSSQL SERVER에 대한 프로토콜** 클릭
        3. TCP/IP 프로토콜 상태가 사용안함(최초) > **TCP/IP**를 더블클릭
        4. **프로토콜 사용 > 예** 로 변경
        5. IP주소 탭 > IP주소가 본인 IP인 것 > **사용 > 예** 로 변경
        6. 127.0.0.1로 된 주소 > **사용 > 예** 로 변경
        7. 적용 후 SQL Server 서비스 > SQL Server (MSSQLSERVER) 더블클릭 후, **다시 시작** 버튼 클릭, 재시작 필요

        ![구성관리자](https://github.com/Hwangji99/basic-database-2024/blob/main/images/images/db007.png)

## 6일차(2024-04-04)
- 파이썬 SQL Server 연동 프로그래밍
    - Madang DB 관리 프로그램
        - PyQt5 + pymssql

    - 문제점   
        - 한글 깨짐문제 해결 방법
            - DB 테이블의 varchar(ASCII) -> nvarchar(UTF-8) 변경
            - Python에서 pymssql로 접속할 때, Charset을 'UTF8'로 설정
            - INSERT 쿼리에 한글 입력되는 컬럼은 N''을 붙여줌(유니코드로 입력하라는 뜻)

    - 실행화면은 픽픽을 사용하여 MP4나 GIF로 만들 수 있음(저화질로 설정)
    - 동영상을 깃허브 리드미에서 드래그해서 옮길 수 있음
    - 실행화면


	https://github.com/Hwangji99/basic-database-2024/assets/158007430/8769ac28-47e3-4394-8f91-98912cc05afe


	
## 7일차(2024-04-05)
- SQL 고급
    - 트랜잭션
    - 
- 데이터베이스 모델링


## 8일차
