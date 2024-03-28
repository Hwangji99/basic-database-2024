# basic-database-2024
IoT 개발자 과정 SQL Server 학습 리포지토리

## 1일차
- MS SQL Server 설치 : https://www.microsoft.com/ko-kr/sql-server/sql-server-downloads (최신버전)
    - DBMS 엔진 (개발자 버전(미디어 다운로드, iso))
        - iso 다운로드 후 설치 추천
        - 다운로드 파일 우클릭 후 탑재
        - setup.exe 클릭
        - SQL Server에 대한 Azure 확장 비활성화 후 진행
        - 인스턴스 기능
            - 데이터베이스 엔진 서비스, SQL Server 복제, 검색을 위한 전체 텍스트 및 의미 체계 추출 선택
            - Integration Services 선택
        - 서버 구성은 손대지 말고 데이터 정렬(CI은 대소문자 구분X, AS는 악센트 구분)
        - 데이터베이스 엔진 구성부터 중요
            - Windows 인증모드로 하면 외부로부터 접근불가
            - 혼합모드(sa)에 대한 암호를 지정(무조건 sa임) / mssql_p@ss (8장 이상 / 대소문자 구분 / 특수문자 1자 이상 포함)
            - 데이터 디렉터리에서 데이터 루트 디렉토리는 주소 변경 -> C에 Datas라는 파일을 만들어 주소 입력(나머지는 손대지 마라)
    - 개발툴 설치
        - SSMS(Sql Server Management Studio) DB에 접근, 여러개발 작업을 할 수 있는 툴
        - 한국어를 설치해야함(SSMS-Setup-KOR)
        - 다운 완료 후 그냥 설치하면됨

- 데이터베이스 개념
    - 데이터를 보관, 관리, 서비스하는 시스템
    - Data, Information, Knowledge 개념
    - DBMS > Database > Data(Model)

- DB언어
    - SQL(Structured Query Language) : 구조화된 질의 언어    
    - DDL(Data Definition Language) - 데이터베이스, 테이블, 인덱스 생성
    - DML(Data Manipulation Language) - 검색, 삽입, 수정, 삭제 등 기능(!)
    - DCL(Data Control Language) - 권한, 트랜잭션 부여 / 제거 기능


## 2일차


## 3일차


## 4일차


## 5일차


## 6일차


## 7일차


## 8일차