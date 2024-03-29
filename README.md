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
                1. 속성은 단일값을 가짐
                2. 속성은 서로 다른 이름으로 구성 (책이름이라는 속성이 두번있으면 안됨)
                3. 속성의 값은 정의된 도메인값만 가짐(대학교 학년에 5학년이 있으면 안됨)
                4. 속성의 순서는 상관없음
                5. 릴레이션 내의 중폭된 튜플은 허용하지 안함(같은 책 정보를 두번 넣을 수 없음)
                6. 튜플의 순서는 상관없음(1,3,5,2,6,7,8...)
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
            - SUM(총합), AVG(평균), COUNT(개수), MIN(최소값), MAX(최대값)

## 3일차


## 4일차


## 5일차


## 6일차


## 7일차


## 8일차