<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="/css/loglayout.css"/>
<script>
    function createDiv(id) {
        return '<div class="logToolTip" id="data' + id + '"></div>';
    }

    function getAddr(latitude, longitude, txTime, index) { // 주소 변환 메서드
        let val;
        let geocoder = new kakao.maps.services.Geocoder(); // 주소-좌표 변환 객체 생성
        let coords = new kakao.maps.LatLng(latitude, longitude); // 위도 및 경도 전달
        let callback = function(result, status) {
            if (status === kakao.maps.services.Status.OK) { // 주소 변환 성공 시
                val = result[0].address.address_name; // 변환한 주소를 대입(도로명 주소 : OO시 OO구 OO동 000-00)
                let address = '<div>위치정보: ' + val + '<br/> 일시: ' + txTime + '</div>';
                document.getElementById("data" + index).innerHTML = address; // 생성한 로그(div태그)내부에 내용을 삽입
            }
        }
        geocoder.coord2Address(coords.getLng(), coords.getLat(), callback); // 좌표 주소 변환하기
    };

    <c:forEach var="history" items="${history}" varStatus="status">
        document.write(createDiv(${status.index})); // 좌하단에 표시되는 로그(div태그)들을 하나씩 생성
        getAddr(${history.h_lat}, ${history.h_long}, '<fmt:formatDate value="${history.tx_time}" pattern="yyyy-MM-dd HH:mm:ss"/>', ${status.index}); // 위치 및 일시 정보를 구하는 메서드
    </c:forEach>
</script>