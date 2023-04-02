<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="/css/loglayout.css"/>
<script>
    function createDiv(id) {
        return '<div class="logToolTip" id="data' + id + '"></div>';
    }

    function getAddr(latitude, longitude, txTime, index) {
        let val;
        let geocoder = new kakao.maps.services.Geocoder();
        let coord = new kakao.maps.LatLng(latitude, longitude);
        let callback = function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                val = result[0].address.address_name;
                let address = '<div>위치정보: ' + val + '<br/> 일시: ' + txTime + '</div>';
                document.getElementById("data" + index).innerHTML = address;
            }
        }
        geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
    };

    <c:forEach var="history" items="${history}" varStatus="status">
        document.write(createDiv(${status.index}));
        getAddr(${history.h_lat}, ${history.h_long}, '<fmt:formatDate value="${history.tx_time}" pattern="yyyy-MM-dd HH:mm:ss"/>', ${status.index});
    </c:forEach>
</script>