<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<link rel="stylesheet" type="text/css" href="/css/loglayout.css"/>
<script>
    function createDiv(id) {
        return '<div class="logtooltip" id="data' + id + '"></div>';
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

    for (let i = 0; i < <%= latitude %>.length; i++) {
        document.write(createDiv(i));
        getAddr(<%= latitude %>[i], <%= longitude %>[i], <%= txTime %>[i], i);
    }
</script>