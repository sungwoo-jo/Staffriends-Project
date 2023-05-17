<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../layout/header.jsp"%>

<c:if test="${signIn == null}"><c:redirect url="http://http://staffriends.duckdns.org/user/needLogin"/></c:if>
<head>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bcc049c8490042d9545bd799ec87eff7&libraries=services"></script>
    <link rel="stylesheet" type="text/css" href="/css/guardlayout.css"/>
</head>
<title>보호자페이지</title>
<h2 style="text-align: center; margin-top: 30px; margin-bottom: 70px; font-family: KakaoBold;">보호자페이지</h2>
<div>
<div class="full">
    <div class="screen_top"> <!-- 상단 카카오맵 표시 -->
        <div id="map" style="width: 100%; height: 100%;"/>
    </div>

<script>
    printGuardMap();

    function printGuardMap() { // 보호자 페이지 카카오맵 출력
        let container = document.getElementById('map'); // 지도 정보를 가져오기

        let options = {
            center: new kakao.maps.LatLng(${history[0].latitude}, ${history[0].longitude}), // 가장 최신 데이터의 마커를 지도의 중앙에 표시
            level: 7
        };
        let map = new kakao.maps.Map(container, options);

        // 마커 이미지 지정
        let imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png",
            imageSize = new kakao.maps.Size(24,35),
            imageOption = {offset: new kakao.maps.Point(14,69)};
        let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

        // 마커 정보 배열 선언 & 초기화
        let markerPosition = new Array();
        let marker = new Array();
        let iwContent = new Array();
        let iwPosition = new Array();
        let infoWindow = new Array();

        let history = [];

        <c:forEach var="history" items="${history}" varStatus="status"> <%-- 가져온 경로 정보를 카카오맵에 표시 --%>
            history.push("${history}");

            markerPosition = new kakao.maps.LatLng(${history.latitude}, ${history.longitude}); // 마커가 표시될 위치 지정

            marker = new kakao.maps.Marker({ position: markerPosition, image : markerImage }); // 마커를 생성

            marker.setMap(map); // 마커가 지도 위에 표시되도록 설정

            // JSTL 태그로 tx_time을 원하는 포맷대로 출력(yyyy-MM-dd HH:mm:ss)
            iwContent ='<div style="padding: 4px; font-size:0.6rem;">'+'<b style="color: blue">'+'${history.serial_num}'+'</b>'+':&nbsp' +'<fmt:formatDate value="${history.tx_time}" pattern="yyyy-MM-dd HH:mm:ss"/>'+'</div>';
            iwPosition = new kakao.maps.LatLng(${history.latitude}, ${history.longitude});
            infoWindow = new kakao.maps.InfoWindow({ position : iwPosition, content : iwContent });

            infoWindow.open(map, marker); // 인포 윈도우 오픈
        </c:forEach>
    }
</script>
<div class="screen_bottom">
    <div class="screen_bottom_1"> <!-- 좌하단 이동 로그 표시 -->
        <%@include file="log.jsp"%>

    </div>
    <div class="screen_bottom_2"> <!-- 우하단 실시간 이미지 표시(랜덤 이미지로 대체) -->
        <img id="random-image" alt="Random Image" style="cursor:pointer; width: 100%; height: 100%;" onclick="window.open('/img/road_sample_img.jpg');" onerror="this.src='/image/road_sample_img.jpg'">
        <script>
            const imgElement = document.querySelector('#random-image');

            setInterval(() => {
                getRandomImage();
            }, 1000);
            getRandomImage();
        </script>
    </div>
</div>
</div>
</div>
<%@ include file="../layout/footer.jsp"%>