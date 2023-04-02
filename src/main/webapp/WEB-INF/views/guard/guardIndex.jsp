<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="../layout/header.jsp"%>
<head>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bcc049c8490042d9545bd799ec87eff7&libraries=services"></script>
    <link rel="stylesheet" type="text/css" href="/css/guardlayout.css"/>
</head>
<title>보호자페이지</title>
<h2 style="text-align: center">보호자페이지</h2><br/>
<%--<%@include file="getInfo.jsp"%>--%>
<div>
<div class="full">
    <div class="screen_top">
        <div id="map" style="width: 100%; height: 100%;"/>
    </div>
<h1>${history[0]}</h1>
<h1>${history[0].id}</h1>
<h1>${history[0].h_lat}</h1>
<h1>${history[0].h_long}</h1>
<h1>${historyVo[0].serialNum}</h1>
<h1>${history[0].tx_time}</h1>

<script>
    let latitude = ${history[0].h_lat};
    let longitude = ${history[0].h_long};
    var container = document.getElementById('map');
    var options = {
        center: new kakao.maps.LatLng( latitude, longitude),
        level: 7
    };

    var map = new kakao.maps.Map(container, options);

    //Marker image
    var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png",
        imageSize = new kakao.maps.Size(24,35),
        imageOption = {offset: new kakao.maps.Point(14,69)};

    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

<%--    let markerPosition = new Array();--%>
<%--    let marker = new Array();--%>
<%--    let iwContent = new Array();--%>
<%--    let iwPosition = new Array();--%>
<%--    let infowindow = new Array();--%>

<%--    for(let i = 0; i < 10; i++){--%>

<%--// 마커가 표시될 위치입니다--%>
<%--        markerPosition[i] = new kakao.maps.LatLng(<%= latitude %>[i], <%= longitude %>[i]);--%>

<%--// 마커를 생성합니다--%>
<%--        marker[i] = new kakao.maps.Marker({ position: markerPosition[i], image : markerImage });--%>

<%--// 마커가 지도 위에 표시되도록 설정합니다--%>
<%--        marker[i].setMap(map);--%>

<%--        iwContent[i] ='<div style="padding: 4px; font-size:5px;">'+<%= serialNum %>[i]+':&nbsp' +<%= txTime %>[i] +'</div>',--%>
<%--            iwPosition[i] = new kakao.maps.LatLng(<%= latitude %>[i], <%= longitude %>[i]);--%>
<%--        infowindow[i] = new kakao.maps.InfoWindow({ position : iwPosition[i], content : iwContent[i] });--%>

<%--// 인포 윈도우 오픈--%>
<%--        infowindow[i].open(map, marker[i]);--%>
<%--    };--%>
<%--</script>--%>
<%--<div class="screen_bottom">--%>
<%--    <div class="screen_bottom_1">--%>
<%--        <%@include file="log.jsp"%>--%>
<%--    </div>--%>
<%--    <div class="screen_bottom_2">--%>
<%--        <img id="random-image" alt="Random Image" style="cursor:pointer; width: 100%; height: 100%;" onclick="window.open('image/road_image/image1.jpg');" onerror="this.src='/image/default.jpg'">--%>
<%--        <script>const imgElement = document.querySelector('#random-image');--%>

<%--        async function getRandomImage() {--%>
<%--            const response = await fetch('https://source.unsplash.com/random');--%>
<%--            const blob = await response.blob();--%>
<%--            const imgUrl = URL.createObjectURL(blob);--%>
<%--            imgElement.src = imgUrl;--%>
<%--        }--%>

<%--        setInterval(() => {--%>
<%--            getRandomImage();--%>
<%--        }, 1000);--%>
<%--        getRandomImage();--%>
        </script>
    </div>
</div>
</div>
</div>
<%--<%--%>
<%--    } catch(SQLException ex) {--%>
<%--        out.println(ex.getMessage());--%>
<%--        ex.printStackTrace();--%>
<%--    } finally {--%>
<%--        // 6. 사용한 Statement 종료--%>
<%--        if (rs != null) try { rs.close(); } catch(SQLException ex) {}--%>
<%--        if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}--%>

<%--        // 7. 커넥션 종료--%>
<%--        if (conn != null) try { conn.close(); } catch(SQLException ex) {}--%>
<%--    }--%>
<%--%>--%>
<%@ include file="../layout/footer.jsp"%>