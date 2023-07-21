let checkUsername = false;
let checkPw = false;
let checkEmail = false;
let checkNickname = false;
let checkIdNum = false;
let checkAddress = false;

function enableSubmitBtn() {
    //입력창이 모두 확인되지 않으면 가입 버튼은 비활성화, 모두 확인되면 활성화
    if(checkUsername && checkPw && checkEmail && checkNickname && checkIdNum && checkAddress) {
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
            }
        }
    })
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
    }

    enableSubmitBtn();
})

//이메일 입력창에 키업이 발생하면 인증 번호 전송 버튼 활성화
$("#emailInput").keyup(function () {
    checkEmail = false;
    $("#verificationCodeInput").addClass("d-none");
    $("#checkEmailBtn").removeAttr("disabled");
    $("#emailInput").removeClass("is-invalid");
    $("#emailInput").removeClass("is-valid");

    enableSubmitBtn();
})

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
                $(".emailCheckComment").text("사용 가능한 이메일 입니다.");
            } else {
                $("#emailInput").removeClass("is-valid");
                $("#emailInput").addClass("is-invalid");
                $(".emailCheckComment").text("이미 사용된 이메일 입니다.");
            }
        }
    })
})

