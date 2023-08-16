# 💻Overview
### 시각장애인 및 시각장애인의 보호자를 위한 위치 정보 공유 서비스

![프로토타입](https://github.com/sungwoo-jo/Staffriends-Project/assets/110444315/8d2c2cd2-83bc-428d-9d16-fdead7673db7)
![staffriends 데이터베이스 ERD](https://github.com/sungwoo-jo/Staffriends-Project/assets/110444315/8f48b19d-239d-497a-b319-76c76ff71e1f)
<br/><br/>

# 🧶프로젝트명  
### `Staffriends`
<br/><br/>

# 🎤프로젝트 소개
- #### AI와 IoT를 접목한 시각장애인용 AI 스마트 지팡이
- #### 시각장애인은 객체인식을 활용해 전방 사물 및 노면 도로에 대한 판단이 가능
- #### 보호자는 웹 페이지를 통해 위치 정보, 이동 경로, 실시간 전방 사진 등을 쉽게 확인이 가능
<br/><br/>

# 📄프로젝트 배경
#### 기존 시각장애인들이 보편적으로 사용하는 흰 지팡이라고 불리는 시각장애인 전용 지팡이는 전방 물체에 대한 정보, 지면 상황 등을 판단하는 것이 불가능합니다. 또한 흰 지팡이를 소지하고 다닌다고 하더라도 보호자는 시각장애인의 활동 반경을 예측할 수 없다는 문제가 있습니다. 이러한 흰 지팡이를 사용하지 않게 된다면 안내견을 동반해야 하는데, 실제로 2022년 영국에서는 안내견과 함께 호텔을 방문한 시각장애인을 반려견과 함께 입장했다는 이유로 내쫓아버린 황당한 일도 일어난 만큼 사회적으로 시각장애인을 위한 안전장치가 충분히 마련되어 있지 않은 것이 현실입니다. 시야를 확보하는 것이 어려운 시각장애인은 통화로 보호자에게 일일이 자신의 위치와 경로를 설명해주는 것 또한 불가능합니다. <br/>
#### 이러한 문제점들의 불편함을 개선시키기 위한 방법을 고민하다가 `AI와 IoT를 접목한 시각장애인을 위한 AI 스마트 지팡이`와 `웹 페이지를 통해 실시간으로 보호자와 공유가 가능한 서비스`를 제작하게 되었습니다.
<br/><br/>

# ⌨활용기술스택
|구분|이름|
|------|---|
|Language|Java 17, HTML/CSS, Javascript|
|Framework|Spring Boot 2.7, MyBatis 3.0, BootStrap4|
|Server|Apache Tomcat(IntelliJ Plugins), AWS EC2(Ubuntu 22.04), AWS RDS(MariaDB 10.6.10)|
|OS|Linux(Ubuntu)|
|Tools|IntelliJ, DBeaver, MySQL Workbench, XShell, Github, Postman|
|API&Library|KakaoMapsAPI, KakaoLoginAPI, CKEditor4, JSTL|
<br/><br/>


# 📆프로젝트 수행기간
### 2022. 04 ~ 2022. 09(약 6개월) - 모든 웹 사이트 코드를 PHP로 제작
### 2023. 04 ~ 2023. 07(약 4개월) - 혼자서 Java로 Migration 및 핵심 JS 코드 리팩토링
<br/><br/>

# 💡핵심기능
1. 시각장애인의 이동 경로와 일자 및 시간이 마커로 표시(Kakao Maps API)
2. 주소로 변환된 좌표 정보의 출력 및 실시간 사진 확인 가능
3. 카카오, 네이버 REST API OAuth2.0 로그인 구현
4. 게시판, 회원, 댓글 CRUD 구현
5. 페이지네이션, 다중게시판
