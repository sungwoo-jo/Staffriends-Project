<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../layout/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${signIn == null}"><c:redirect url="http://localhost:8080/user/needLogin"/></c:if>
<head>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bcc049c8490042d9545bd799ec87eff7&libraries=services"></script>
    <link rel="stylesheet" type="text/css" href="/css/guardlayout.css"/>
</head>
<title>보호자페이지</title>
<h2 style="text-align: center">보호자페이지</h2><br/>
<div>
<div class="full">
    <div class="screen_top">
        <div id="map" style="width: 100%; height: 100%;"/>
    </div>

<script>
    var container = document.getElementById('map');
    var options = {
        center: new kakao.maps.LatLng(${history[0].h_lat}, ${history[0].h_long}), // 가장 최신 데이터의 마커를 지도의 중앙에 표시
        level: 7
    };
    var map = new kakao.maps.Map(container, options);
    // Marker image
    var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png",
        imageSize = new kakao.maps.Size(24,35),
        imageOption = {offset: new kakao.maps.Point(14,69)};
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
    let markerPosition = new Array();
    let marker = new Array();
    let iwContent = new Array();
    let iwPosition = new Array();
    let infowindow = new Array();

    let history = [];

    <c:forEach var="history" items="${history}" varStatus="status">
        history.push("${history}");
        // 마커가 표시될 위치입니다.
        markerPosition = new kakao.maps.LatLng(${history.h_lat}, ${history.h_long});
        // 마커를 생성합니다.
        marker = new kakao.maps.Marker({ position: markerPosition, image : markerImage });
        // 마커가 지도 위에 표시되도록 설정합니다.
        marker.setMap(map);
        iwContent ='<div style="padding: 4px; font-size:5px;">'+'${history.serial_num}'+':&nbsp' +'${history.tx_time}'+'</div>';
        iwPosition = new kakao.maps.LatLng(${history.h_lat}, ${history.h_long});
        infowindow = new kakao.maps.InfoWindow({ position : iwPosition, content : iwContent });
        // 인포 윈도우 오픈
        infowindow.open(map, marker);
    </c:forEach>

</script>
<div class="screen_bottom">
    <div class="screen_bottom_1">
        <%@include file="log.jsp"%>

    </div>
    <div class="screen_bottom_2">
        <img id="random-image" alt="Random Image" style="cursor:pointer; width: 100%; height: 100%;" onclick="window.open('image/road_image/image1.jpg');" onerror="this.src='/image/default.jpg'">
        <script>const imgElement = document.querySelector('#random-image');

        async function getRandomImage() {
            const response = await fetch('https://source.unsplash.com/random');
            const blob = await response.blob();
            const imgUrl = URL.createObjectURL(blob);
            imgElement.src = imgUrl;
        }

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