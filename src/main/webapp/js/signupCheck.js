let checkUsername = false;
let checkPw = false;
let checkEmail = false;
let checkVerification = false;
let checkNickname = false;
let checkPhoneNum = false;
let checkAddress = false;

function enableSubmitBtn() {
    //입력창이 모두 확인되지 않으면 가입 버튼은 비활성화, 모두 확인되면 활성화
    if(checkUsername && checkPw && checkEmail && checkNickname && checkPhoneNum && checkAddress && checkVerification) {
        $("#joinBtn").removeAttr("disabled");
    } else {
        $("#joinBtn").attr("disabled", "");
    }
}

$("#usernameCheckBtn").click(function () {
    //아이디 중복확인 버튼을 누르면
    let username = $("#usernameInput").val();

    $.ajax("/member/checkUsername?username=" + username, {
        success: function (data) {
            console.log(data.available)
            if(data.available) {
                $("#usernameInput").addClass("is-valid");
                checkUsername = true;
            } else {
                $("#usernameInput").addClass("is-invalid");
                checkUsername = false;
            }
        },
        complete: enableSubmitBtn
    });
})

//아이디 입력창에 키업이 발생하면
$("#usernameInput").keyup(function () {
    checkUsername = false;
    $("#usernameInput").removeClass("is-valid");
    $("#usernameInput").removeClass("is-invalid");

    enableSubmitBtn();
})

//비밀번호 확인 입력창에 키업이 발생하면
$(".pw").keyup(function () {
    checkPw = false;
    let pw = $("#pwInput").val();
    let pwCheck = $("#pwCheckInput").val();

    if(pw == pwCheck) {
        $("#pwCheckInput").removeClass("is-invalid");
        $("#pwCheckInput").addClass("is-valid");
        checkPw = true;
    } else {
        $("#pwCheckInput").removeClass("is-valid");
        $("#pwCheckInput").addClass("is-invalid");
        checkPw = false;
    }

    enableSubmitBtn();
})

//이메일 입력창에 키업이 발생하면 버튼 초기화
$("#emailInput").keyup(function () {
    emailintialize();
})

//이메일 입력창 초기화 메소드
function emailintialize() {
    checkEmail = false;
    //인증번호 입력창 안보이게
    $("#verificationCodeInput").addClass("d-none");
    $("#checkEmailBtn").removeAttr("disabled");
    //이메일 사용에 대한 코멘트 지움
    $("#emailInput").removeClass("is-invalid");
    $("#emailInput").removeClass("is-valid");
    //버튼 초기화
    $("#checkEmailBtn").removeClass("d-none");
    $("#veriCodeSendBtn").addClass("d-none");

    enableSubmitBtn();
}

//이메일 중복 확인 버튼을 누르면 인증번호 입령창 활성화
$("#checkEmailBtn").click(function () {
    $("#verificationCodeInput").removeClass("d-none");

    //사용자가 입력한 이메일 정보 가져오기
    let email = $("#emailInput").val();

    $.ajax("/member/checkEmail?email=" + email, {
        success : function (data) {
            if(data.available) {
                $("#emailInput").removeClass("is-invalid");
                $("#emailInput").addClass("is-valid");
                $(".emailCheckComment").text("사용 가능한 이메일입니다.");
                checkEmail = true;
                //중복확인 버튼 없애고 인증 번호 발송 버튼 활성화
                $("#veriCodeSendBtn").removeClass("d-none");
                $("#checkEmailBtn").addClass("d-none");
            } else {
                $("#emailInput").removeClass("is-valid");
                $("#emailInput").addClass("is-invalid");
                $(".emailCheckComment").text("이미 사용된 이메일입니다.");
                checkEmail = false;
            }
        },
        complete: enableSubmitBtn
    })
})

//인증 번호 발송 버튼을 눌렀을 때
$("#veriCodeSendBtn").click(function () {

    //사용자가 입력한 이메일 정보 가져오기
    let email = $("#emailInput").val();

    $.ajax("/member/veriCode?email=" + email, {
        method: "get"
    })
})

//인증 번호를 입력하고 인증버튼을 눌렀을 때
$("#veriCodeBtn").click(function () {
    let code = $("#veriCodeInput").val().trim();

    $.ajax("/member/checkveriCode?code=" + code, {
        method: "get",
        success: function (data) {
            console.log("인증 성공")
            if(data.available) {
                console.log(data.available);
                $("#veriCodeInput").addClass("is-valid");
                $(".veriCodeCheckComment").text("인증번호가 일치합니다.");
                $("#veriCodeSendBtn").addClass("d-none")
                checkVerification = true;
            } else {
                $("#veriCodeInput").addClass("is-invalid");
                $(".veriCodeCheckComment").text("인증번호가 일치하지 않습니다.");
                checkVerification = false;
            }
        },
        complete: enableSubmitBtn
    })
})

//인증번호 입력창에 키업이 발생
$("#veriCodeInput").keyup(function () {
    checkVerification = false;
    $("#veriCodeInput").removeClass("is-valid");
    $("#veriCodeInput").removeClass("is-invalid");
    $("#veriCodeSendBtn").removeClass("d-none")

    enableSubmitBtn();
})

//주소
//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("sample4_extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }

            let address = $("#sample4_roadAddress").val();
            $("#addressInput").val(address);

            checkAddress = true;
            enableSubmitBtn();
        }
    }).open();
}

//
