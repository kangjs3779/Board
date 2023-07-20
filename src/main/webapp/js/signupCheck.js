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