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

async function getRandomImage(i) { // 샘플 이미지 가져오기
            let response = "/img/road_sample_img/road_sample_img_" + i + ".jpg";
            imgElement.src = response;
}

function transUserInfo(serialNum) {
    let f = document.createElement('form'); // form element 생성

    let obj;
    obj = document.createElement('input'); // input element 생성
    obj.setAttribute('type', 'hidden'); // type을 hidden으로,
    obj.setAttribute('name', 'serialNum'); // name을 serialNum으로,
    obj.setAttribute('value', serialNum); // value를 serialNum으로 설정

    f.appendChild(obj); // form element의 자식 요소로 obj(input element)를 추가
    f.setAttribute('method', 'post'); // method를 post 방식으로,
    f.setAttribute('action', '/guard/guardIndex'); // action은 /guardIndex로 전송되도록
    document.body.appendChild(f); // body의 자식 요소로 form을 추가
    f.submit(); // form 전송
}