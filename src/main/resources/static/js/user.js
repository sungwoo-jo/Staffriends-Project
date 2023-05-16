let validUsername;
let validPassword;
let validSamePassword;
let validEmail;
let validNickname;
let validName;

function findMyIdProc() { // 아이디 찾기
    let name = document.getElementById('name').value.trim();
    let email = document.getElementById('email').value.trim();

    // 빈 값일 시 해당 칸을 focus
    if (name === "") {
        alert("아이디를 입력해주세요.");
        document.getElementById('name').focus();
        return false;
    }
    if (email === "") {
        alert("이메일을 입력해주세요.");
        document.getElementById('email').focus();
        return false;
    }

    let data = {
        name:name,
        email:email
    };

    let xhr = new XMLHttpRequest();
    xhr.open("POST", "/user/findMyIdProc");
    xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
    xhr.onload = function() {
        if (xhr.status === 200 || xhr.status === 201) {
            let resp = xhr.responseText;
            let result = JSON.parse(resp);
            if (resp.status === 500) {
                alert("에러가 발생했습니다.");
            } else {
                if(result.username === '0') { // 존재하는 회원이 없을 때
                    alert('올바른 정보를 입력했는지 다시 확인해주세요.');
                } else { // 조회 결과로 회원 ID 반환
                    alert('회원님의 아이디는 ' + result.username + '입니다.');
                }
            }
        } else {
            console.log(xhr.responseText);
            alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
        }
    };
    xhr.onerror = function() {
        console.log(xhr.responseText);
        alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
    };
    xhr.send(JSON.stringify(data));
}

function findMyPasswordProc() { // 비밀번호 찾기
    let username = document.getElementById('username').value.trim();
    let name = document.getElementById('name').value.trim();
    let email = document.getElementById('email').value.trim();

    // 빈 값일 시 해당 칸을 focus
    if (username === "") {
        alert("아이디를 입력해주세요.");
        document.getElementById('username').focus();
        return false;
    }
    if (name === "") {
        alert("이름을 입력해주세요.");
        document.getElementById('name').focus();
        return false;
    }
    if (email === "") {
        alert("이메일을 입력해주세요.");
        document.getElementById('email').focus();
        return false;
    }

    let data = {
        username:username,
        name:name,
        email:email
    };

    let xhr = new XMLHttpRequest();
    xhr.open("POST", "/user/resetPassword");
    xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
    xhr.onload = function() {
        if (xhr.status === 200 || xhr.status === 201) {
            let resp = xhr.responseText;
            let result = JSON.parse(resp);
            if (resp.status === 500) {
                alert("에러가 발생했습니다.");
            } else {
                if(result.password === '0') { // 존재하는 회원이 없을 때
                    alert('올바른 정보를 입력했는지 다시 확인해주세요.');
                } else { // 재설정된 비밀번호를 반환
                    alert('회원님의 비밀번호는 ' + result.password + ' 입니다.');
                }
            }
        } else {
            console.log(xhr.responseText);
            alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
        }
    };
    xhr.onerror = function() {
        console.log(xhr.responseText);
        alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
    };
    xhr.send(JSON.stringify(data));
}

function join() { // 회원가입
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const nickname = document.getElementById('nickname').value;
    const email = document.getElementById('email').value;
    const name = document.getElementById('name').value;
    const serialNum = document.getElementById('serialNum').value;

    // 유효성 검사 완료 후 실행할 로직
    let data = {
        username:username,
        password:password,
        nickname:nickname,
        email:email,
        name:name,
        serialNum:serialNum
    };

    let xhr = new XMLHttpRequest();
    xhr.open("POST", "/user/join/insert");
    xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
    xhr.onload = function() {
        if (xhr.status === 200 || xhr.status === 201) {
            let resp = xhr.responseText;
            if (resp.status === 500) {
                alert("에러가 발생했습니다.");
            } else {
                alert("회원가입이 완료되었습니다.");
                location.href = "/";
            }
        } else {
            console.log(xhr.responseText);
            alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
        }
    };
    xhr.onerror = function() {
        alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
    };
    xhr.send(JSON.stringify(data));
}

function idCheck() { // 아이디 체크
    let username = document.getElementById('username').value;
    let usernameCheck = /^[a-zA-Z0-9_-]{7,20}$/; // 아이디의 정규표현식
    if (username.trim() === '') { // 입력값이 없는 경우
        document.getElementById("notInputId").style.display = "block"; // 아이디를 입력하라는 메시지를 block으로 표시해 화면에 띄워지게 함
        document.getElementById("invalidId").style.display = "none";
        document.getElementById("duplicateId").style.display = "none";
        document.getElementById("validId").style.display = "none";
        document.getElementById("username").style.backgroundColor="#FFCECE";
        validUsername = false;
    } else if (usernameCheck.test(username) === false || username.length > 20) { // 양식에 맞지 않고 길이 초과 시
        document.getElementById("notInputId").style.display = "none";
        document.getElementById("invalidId").style.display = "block"; // 양식에 맞지 않는다는 메시지를 block으로 표시해 화면에 띄워지게 함
        document.getElementById("duplicateId").style.display = "none";
        document.getElementById("validId").style.display = "none";
        document.getElementById("username").style.backgroundColor="#FFCECE";
        validUsername = false;
    } else { // 중복값 검사
        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/user/join/idCheck");
        xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
        xhr.onload = function() {
            if (xhr.status === 200 || xhr.status === 201) {
                let resp = xhr.responseText;
                if (resp.status === 500) {
                    alert("에러가 발생했습니다.");
                } else {
                    let result = JSON.parse(resp);
                    if(result.count > 0) {
                        document.getElementById("notInputId").style.display = "none";
                        document.getElementById("invalidId").style.display = "none";
                        document.getElementById("duplicateId").style.display = "block"; // 중복된 아이디라는 메시지를 block으로 표시해 화면에 띄워지게 함
                        document.getElementById("validId").style.display = "none";
                        document.getElementById("username").style.backgroundColor="#FFCECE";
                        validUsername = false;
                    } else {
                        document.getElementById("notInputId").style.display = "none";
                        document.getElementById("invalidId").style.display = "none";
                        document.getElementById("duplicateId").style.display = "none";
                        document.getElementById("validId").style.display = "block"; // 사용 가능하다는 메시지를 block으로 표시해 화면에 띄워지게 함
                        document.getElementById("username").style.backgroundColor="#B0F6AC";
                        validUsername = true;
                    }
                }
            } else {
                console.log(xhr.responseText);
                alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
            }
        };
        xhr.onerror = function() {
            alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
        };
        xhr.send(username);
    }
}

function pwCheck() { // 비밀번호 체크
    let password = document.getElementById('password').value;
    let passwordCheck = /(?=.*\d)(?=.*[a-zA-ZS]).{8,}/; // 비밀번호의 정규표현식
    if (password.trim() === '') { // 입력값이 없는 경우
        document.getElementById("notInputPw").style.display = "block"; // 비밀번호를 입력하라는 메시지를 block으로 표시해 화면에 띄워지게 함
        document.getElementById("invalidPw").style.display = "none";
        document.getElementById("password").style.backgroundColor="#FFCECE";
        validPassword = false;
    } else if (passwordCheck.test(password) === false || password.length > 128) { // 양식에 맞지 않고 길이 초과 시
        document.getElementById("notInputPw").style.display = "none";
        document.getElementById("invalidPw").style.display = "block"; // 양식에 맞지 않는다는 메시지를 block으로 표시해 화면에 띄워지게 함
        document.getElementById("password").style.backgroundColor="#FFCECE";
        validPassword = false;
    } else { // 사용 가능한 비밀번호
        document.getElementById("notInputPw").style.display = "none";
        document.getElementById("invalidPw").style.display = "none";
        document.getElementById("password").style.backgroundColor="#FFFFFF"; // 사용 가능한 경우 다른효과 없이 흰색 배경으로 마무리
        validPassword = true;
    }
}

function samePwCheck() { // 비밀번호 확인 체크
    let password = document.getElementById('password').value;
    let passwordCheck = /(?=.*\d)(?=.*[a-zA-ZS]).{8,}/; // 비밀번호의 정규표현식
    let samePassword = document.getElementById('samePassword').value;
    if (samePassword.trim() === '') { // 입력값이 없는 경우
        document.getElementById("notInputSamePw").style.display = "block"; // 비밀번호를 한번 더 입력하라는 메시지를 block으로 표시해 화면에 띄워지게 함
        document.getElementById("invalidSamePw").style.display = "none";
        document.getElementById("notSamePw").style.display = "none";
        document.getElementById("validSamePw").style.display = "none";
        document.getElementById("samePassword").style.backgroundColor="#FFCECE";
        validSamePassword = false;
    } else if (passwordCheck.test(samePassword) === false || password.length > 128) { // 양식에 맞지 않고 길이 초과 시
        document.getElementById("notInputSamePw").style.display = "none";
        document.getElementById("invalidSamePw").style.display = "block"; // 양식에 맞지 않는다는 메시지를 block으로 표시해 화면에 띄워지게 함
        document.getElementById("notSamePw").style.display = "none";
        document.getElementById("validSamePw").style.display = "none";
        document.getElementById("samePassword").style.backgroundColor="#FFCECE";
        validSamePassword = false;
    } else if (password !== samePassword) { // 일치하지 않는 경우
        document.getElementById("notInputSamePw").style.display = "none";
        document.getElementById("invalidSamePw").style.display = "none";
        document.getElementById("notSamePw").style.display = "block"; // 비밀번호가 같지 않다는 메시지를 block으로 표시해 화면에 띄워지게 함
        document.getElementById("validSamePw").style.display = "none";
        document.getElementById("samePassword").style.backgroundColor="#FFCECE";
        validSamePassword = false;
    } else { // 사용 가능한 비밀번호
        document.getElementById("notInputSamePw").style.display = "none";
        document.getElementById("invalidSamePw").style.display = "none";
        document.getElementById("notSamePw").style.display = "none";
        document.getElementById("validSamePw").style.display = "block"; // 비밀번호가 일치한다는 메시지를 block으로 표시해 화면에 띄워지게 함
        document.getElementById("samePassword").style.backgroundColor="#B0F6AC";
        validSamePassword = true;
    }
}

function nicknameCheck() { // 닉네임 체크
    let nickname = document.getElementById('nickname').value;
    let nicknameCheck = /^[가-힇a-zA-Z0-9]{2,15}$/; // 닉네임의 정규표현식
    if (nickname.trim() === '') { // 입력값이 없는 경우
        document.getElementById("notInputNickname").style.display = "block"; // 비밀번호를 입력하라는 메시지를 block으로 표시해 화면에 띄워지게 함
        document.getElementById("invalidNickname").style.display = "none";
        document.getElementById("nickname").style.backgroundColor="#FFCECE";
        validNickname = false;
    } else if (nicknameCheck.test(nickname) === false || nickname.length > 15) { // 양식에 맞지 않고 길이 초과 시
        document.getElementById("notInputNickname").style.display = "none";
        document.getElementById("invalidNickname").style.display = "block"; // 양식에 맞지 않는다는 메시지를 block으로 표시해 화면에 띄워지게 함
        document.getElementById("nickname").style.backgroundColor="#FFCECE";
        validNickname = false;
    } else { // 사용 가능한 닉네임
        document.getElementById("notInputNickname").style.display = "none";
        document.getElementById("invalidNickname").style.display = "none";
        document.getElementById("nickname").style.backgroundColor="#B0F6AC";
        validNickname = true;
    }
}

function emailCheck() { // 이메일 체크
    let email = document.getElementById('email').value; // email 값을 담아줌
    let emailCheck = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/; // 이메일의 정규표현식
    if (email.trim() === '') { // 입력값이 없는 경우
        document.getElementById("notInputEmail").style.display = "block"; // 이메일을 입력하라는 메시지를 block으로 표시해 화면에 띄워지게 함
        document.getElementById("invalidEmail").style.display = "none";
        document.getElementById("email").style.backgroundColor="#FFCECE";
        validEmail = false;
    } else if (emailCheck.test(email) === false) { // 양식에 맞지 않을 시
        document.getElementById("notInputEmail").style.display = "none";
        document.getElementById("invalidEmail").style.display = "block"; // 양식에 맞지 않는다는 메시지를 block으로 표시해 화면에 띄워지게 함
        document.getElementById("email").style.backgroundColor="#FFCECE";
        validEmail = false;
    } else { // 사용 가능한 이메일
        document.getElementById("notInputEmail").style.display = "none";
        document.getElementById("invalidEmail").style.display = "none";
        document.getElementById("email").style.backgroundColor="#B0F6AC";
        validEmail = true;
    }
}

function nameCheck() { // 이름 체크
    let name = document.getElementById('name').value; // name 값을 담아줌
    let nameCheck =  /^[가-힣]{2,10}$/; // 이름의 정규표현식
    if (name.trim() === '') { // 입력값이 없는 경우
        document.getElementById("notInputName").style.display = "block"; // 이름을 입력하라는 메시지를 block으로 표시해 화면에 띄워지게 함
        document.getElementById("invalidName").style.display = "none";
        document.getElementById("name").style.backgroundColor="#FFCECE";
        validName = false;
    } else if (nameCheck.test(name) === false) { // 양식에 맞지 않을 시
        document.getElementById("notInputName").style.display = "none";
        document.getElementById("invalidName").style.display = "block"; // 양식에 맞지 않는다는 메시지를 block으로 표시해 화면에 띄워지게 함
        document.getElementById("name").style.backgroundColor="#FFCECE";
        validName = false;
    } else { // 사용 가능한 이름
        document.getElementById("notInputName").style.display = "none";
        document.getElementById("invalidName").style.display = "none";
        document.getElementById("name").style.backgroundColor="#B0F6AC";
        validName = true;
    }
}

function activateSignupBtn() { // 전체 폼 요소들 정규화 후 회원가입 버튼 활성화
    if (validUsername === true && validPassword === true && validSamePassword === true && validNickname === true && validEmail === true && validName === true) {
        document.getElementById("joinBtn").disabled = false;
        document.getElementById("joinBtn").backgroundColor = "#70ad47";
    } else {
        document.getElementById("joinBtn").disabled = true;
        document.getElementById("joinBtn").backgroundColor = "#70ad478f";
    }
}

function loginProc() { // 로그인 실행 로직
    let username = document.getElementById('username').value.trim();
    let password = document.getElementById('password').value.trim();

    if (username === "") {
        alert("아이디를 입력해주세요.");
        document.getElementById('username').focus();
        return false;
    }
    if (password === "") {
        alert("비밀번호를 입력해주세요.");
        document.getElementById('password').focus();
        return false;
    }

    let data = {
        username:username,
        password:password
    };

    let xhr = new XMLHttpRequest();
    xhr.open("POST", "/user/loginProc");
    xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
    xhr.onload = function() {
        if (xhr.status === 200 || xhr.status === 201) {
            let resp = xhr.responseText;
            let result = JSON.parse(resp);
            if (resp.status === 500) {
                alert("에러가 발생했습니다.");
            } else {
                if (result) { // 회원 정보를 반환받은 경우
                    alert("로그인이 완료되었습니다.");
                    location.href = "/";
                } else { // 반환받은 회원 정보가 없는 경우
                    alert("아이디 또는 비밀번호를 확인해주세요.");
                    document.getElementById('username').focus();
                }
            }
        } else {
            console.log(xhr.responseText);
            alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
        }
    };
    xhr.onerror = function() {
        console.log(xhr.responseText);
        alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
    };
    xhr.send(JSON.stringify(data));
}

function findMyIdPopUp() { // 아이디 찾기 팝업창 열기
    // 창 크기 지정(700 x 500)
    let width = 700;
    let height = 500;

    // pc 화면 기준 가운데 정렬
    let left = (window.screen.width / 2) - (width/2);
    let top = (window.screen.height / 4);

    // 팝업창 속성 지정
    let windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+'';

    // /user/findMyId로 연결
    const url = "/user/findMyId";

    //등록된 url 및 window 속성 기준으로 팝업창 열기
    window.open(url, "findMyIdPopUp", windowStatus);
}

function findMyPasswordPopUp() { // 비밀번호 찾기 팝업창 열기
    // 창 크기 지정(700 x 500)
    let width = 700;
    let height = 500;

    // pc 화면 기준 가운데 정렬
    let left = (window.screen.width / 2) - (width/2);
    let top = (window.screen.height / 4);

    // 팝업창 속성 지정
    let windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+'';

    // /user/findMyId로 연결
    const url = "/user/findMyPassword";

    //등록된 url 및 window 속성 기준으로 팝업창 열기
    window.open(url, "findMyPasswordPopUp", windowStatus);
}

function updateInfo() { // 회원 정보 수정
    if(validPassword === true && validSamePassword === true && validNickname === true && validEmail === true) {
        const password = document.getElementById('password').value;
        const nickname = document.getElementById('nickname').value;
        const email = document.getElementById('email').value;
        const serialNum = document.getElementById('serialNum').value;

        // 유효성 검사 완료 후 실행할 로직
        let data = {
            password:password,
            nickname:nickname,
            email:email,
            serialNum:serialNum
        };

        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/user/updateProc");
        xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
        xhr.onload = function() {
            if (xhr.status === 200 || xhr.status === 201) {
                let resp = xhr.responseText;
                if (resp.status === 500) {
                    alert("에러가 발생했습니다.");
                } else {
                    alert("정보수정이 완료되었습니다.");
                    location.href = "/";
                }
            } else {
                console.log(xhr.responseText);
                alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
            }
        };
        xhr.onerror = function() {
            alert("에러가 발생했습니다. \n에러 코드: " + xhr.status);
        };
        xhr.send(JSON.stringify(data));
    } else {
        alert('입력하신 정보를 다시 한 번 확인해주세요.');
    }
}