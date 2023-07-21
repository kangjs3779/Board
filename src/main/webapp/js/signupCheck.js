let checkUsername = false;
let checkPw = false;
let checkEmail = false;
let checkVerification = false;
let checkNickname = false;
let checkIdNum = false;
let checkAddress = false;

function enableSubmitBtn() {
    //입력창이 모두 확인되지 않으면 가입 버튼은 비활성화, 모두 확인되면 활성화
    if(checkUsername && checkPw && checkEmail && checkNickname && checkIdNum && checkAddress && checkVerification) {
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
    console.log("click")
    //startTimer();

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

//타이머 메소드
function startTimer() {
    var duration = 180; // 3분(180초) 설정
    var timer = duration;
    $("#timer").show();

    var intervalId = setInterval(function () {
        var minutes = parseInt(timer / 60, 10);
        var seconds = parseInt(timer % 60, 10);

        // 0 분 이상 9 분 이하의 경우 숫자 앞에 0을 추가하여 2자리로 표시
        var displayMinutes = minutes < 10 ? "0" + minutes : minutes;
        // 0 초 이상 9 초 이하의 경우 숫자 앞에 0을 추가하여 2자리로 표시
        var displaySeconds = seconds < 10 ? "0" + seconds : seconds;

        $("#minutes").text(displayMinutes);
        $("#seconds").text(displaySeconds);

        if (--timer < 0) {
            // 타이머 종료 시
            clearInterval(intervalId);
            $("#timer").hide();
        }
    }, 1000);
}