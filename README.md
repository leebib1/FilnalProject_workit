# workit(2023)
구디 아카데미 파이널 프로젝트 : IT 학원 그룹웨어
* 참여인원 : 4명
* 프로젝트 기간 : 7/24~8/21
* 프로젝트 주제 : IT 학원 그룹웨어
* 프로젝트 개요 : IT 학원에서 사용할 수 있는 강의 등록, 상담실 예약 기능이 합쳐진 그룹웨어 사이트를 구현하고자 함
## 담당 역할
✅ 클릭 시 해당 기능 패키지로 이동합니다.
### 👩‍💻이은지
#### Git 관리: Github을 통한 형상관리
#### DB 설계 담당 : 관계형 데이터베이스 설계 및 구축, 관리
* 로그인, 마이페이지
  * [member](https://github.com/leebib1/FilnalProject_workit/tree/master/GDJ64-workit-final/src/main/java/com/workit/member)
  * [security](https://github.com/leebib1/FilnalProject_workit/tree/master/GDJ64-workit-final/src/main/java/com/workit/config)
* 인사 관리
  * [employee](https://github.com/leebib1/FilnalProject_workit/tree/master/GDJ64-workit-final/src/main/java/com/workit/employee)
### 👩‍💻조윤진
#### 팀장
#### Git 관리 : repository 생성 및 Github를 통한 형상관리
* 게시판
  * [board](https://github.com/leebib1/FilnalProject_workit/tree/master/GDJ64-workit-final/src/main/java/com/workit/board)
* 강의 등록 및 회의실 예약
  * [lecture(강의)](https://github.com/leebib1/FilnalProject_workit/tree/master/GDJ64-workit-final/src/main/java/com/workit/lecture)
  * [meet(회의실)](https://github.com/leebib1/FilnalProject_workit/tree/master/GDJ64-workit-final/src/main/java/com/workit/meet)
* 근태 관리
  * [work](https://github.com/leebib1/FilnalProject_workit/tree/master/GDJ64-workit-final/src/main/java/com/workit/work)
### 👨‍💻최주영
#### 물리 DB 설계 담당 : ERD를 통한 물리 DB 설계 및 관리
* 메인 페이지
  * [member](https://github.com/leebib1/FilnalProject_workit/tree/master/GDJ64-workit-final/src/main/java/com/workit/member)
* 전자 결
  * [approve](https://github.com/leebib1/FilnalProject_workit/tree/master/GDJ64-workit-final/src/main/java/com/workit/approve)
### 👩‍💻최하리
#### UI 담당 : UI 설계 및 구현, UI 총괄
* 채팅
  * [chat](https://github.com/leebib1/FilnalProject_workit/tree/master/GDJ64-workit-final/src/main/java/com/workit/chat)
  * [chatroom](https://github.com/leebib1/FilnalProject_workit/tree/master/GDJ64-workit-final/src/main/java/com/workit/chatroom)
## 개발 환경
![개발도구](https://github.com/leebib1/FilnalProject_workit/assets/128957257/f4d801f2-25a5-48c0-b345-236450fcf2e4)

## 프로젝트 진행 방식
### 회의
프로젝트 진행 시작 전 주제 구상, UI 설계, 논리 DB 설계를 위해 2주간 화,목요일 회의를 진행.
노션을 이용해 회의 기록, 기능정의서, 공유 템플릿, 일정 등을 기록.
![노션메인](https://github.com/leebib1/FilnalProject_workit/assets/128957257/a9569060-ba68-47e3-9eb2-fd3d42403120)
노션 보드를 이용해서 프로젝트 일정을 확인 및 공유.
![노션일정](https://github.com/leebib1/FilnalProject_workit/assets/128957257/c4358985-079a-4d5a-bed1-3da45db0b53d)

### Git
1. <b>윤진</b>님이 팀 Repository 생성 후 각자 개인 브랜치 생성하여 작업.
2. 개인 브랜치에서 작업 후 <b>윤진</b>님에게 PR -> <b>윤진</b>님이 PR 승인 후 dev 브랜치에 병합되는 형식으로 진행
3. 프로젝트 후반 Git 운영 방식 변경.
4. PR 승인 작업 없이 dev 브랜치에 자유롭게 개인 브랜치 작업 내용을 merge 하는 방식. ->작업하는 시간이 서로 일정하지 않고 PR 승인 시 코드를 상세하게 보지 않고 넘긴다는 문제점 해결
