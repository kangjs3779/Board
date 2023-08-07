
//아이디 찾기 탭에서 아이디 찾기 버튼을 클릭하면
$("#findIdBtn").click(function () {
    //이메일 입력창 입력값을 가져오기
    var emailInput = $("#emailInput").val();
    //이름입력창 입력값 가져오기
    var nameInput = $("#nameInput").val();

    //이메일 입력창이 비어있거나 @가 없거나 이름 입력창이 비어있으면
    if (emailInput === '' || !emailInput.includes('@') || nameInput === '') {
        if (emailInput === '' || !emailInput.includes('@')) {
            //이메일 입력창이 비어있거나 @가 없으면
            $("#emailInput").val("");
            $("#emailBox").addClass("error");
            $("#emailInput").attr("placeholder", "이메일을 입력해주세요.");
        }

        if (nameInput === '') {
            //이름 입력창이 비어있으면
            $("#nameInput").val("");
            $("#nameBox").addClass("error");
            $("#nameInput").attr("placeholder", "이름을 입력해주세요.");
        }
    } else {
        $.ajax("/member/findEmailAndName?email=" + emailInput + "&" + "name=" + nameInput, {
            success: function (data) {
                if (data.check) {
                    var username = data.member.username;
                    $("#findIdBox").empty();
                    $("#findIdBox").append(`
                        <form class="ui form">
                            <div class="field" id="emailBox">
                                <label>ID</label>
                                <input required type="text" value="${username}">
                                <div class="ui pointing blue basic label">
                                    찾으시는 아이디 입니다.
                                </div>
                            </div>
                        </form>
                    `);
                }
            },
            error: function () {
                $("#findIdBtn").after(`
                    <div class="ui left pointing red basic label">
                        잘못된 아이디 또는 이름이 입력되었습니다.
                    </div>
                `);
            }
        })
    }
})

//아이디 찾기 탭에서 이메일 입력창에 키업이 발생하면 초기화
$("#emailInput").keyup(function () {
    $("#emailBox").removeClass("error");
    $("#emailInput").attr("placeholder", "회원 가입 시 입력했던 이메일을 입력해주세요.");
})

//아이디 찾기 탭에서 이름 입력창에 키업이 발생하면 초기화
$("#nameInput").keyup(function () {
    $("#nameBox").removeClass("error");
    $("#nameInput").attr("placeholder", "회원 가입 시 입력했던 이름을 입력해주세요.");
})

//비밀번호 찾기 탭에서 이메일 전송 버튼을 눌렀을 떄
$("#findPwBtn").click(function () {
    //아이디 입력값 가져오기
    var idInput = $("#PwIdInput").val();
    //이메일 입력값 가져오기
    var emailInput = $("#PwEmailInput").val();

    //이메일 입력창이 비어있거나 @가 없거나 아이디 입력창이 비어있으면
    if (emailInput === '' || !emailInput.includes('@') || idInput === '') {
        if (emailInput === '' || !emailInput.includes('@')) {
            //이메일 입력창이 비어있거나 @가 없으면
            $("#PwEmailInput").val("");
            $("#pwEmailBox").addClass("error");
            $("#PwEmailInput").attr("placeholder", "이메일을 입력해주세요.");
        }

        if (idInput === '') {
            //이름 입력창이 비어있으면
            $("#PwIdInput").val("");
            $("#PwIdBox").addClass("error");
            $("#PwIdInput").attr("placeholder", "이름을 입력해주세요.");
        }
    } else {
        //가입된 아이디와 이메일인지 확인
        $.ajax("/member/findIdAndEmail?email=" + emailInput + "&" + "id=" + idInput, {
            success: function (data) {
                if (data.check) {
                    var username = data.member.username;
                    $("#findPwBox").empty();
                    $("#findPwBox").append(`
                        <form action="/member/modify" method="post" class="ui form">
                            <input name="username" type="hidden" value="${username}">
                            <div class="field" id="pwBox">
                                <label>새로운 비밀번호</label>
                                <input name="password" type="password" class="pwInput" id="pw">
                            </div>
                            <div class="field" id="checkPwBox">
                                <label>비밀번호 확인</label>
                                <input type="password" class="pwInput" id="checkPw">
                                <div class="valid-feedback pwCheck">
                                    비밀번호가 일치합니다.
                                </div>
                                <div class="invalid-feedback pwCheck">
                                    비밀번호가 일치하지 않습니다.
                                </div>
                            </div>
                            <button type="submit" class="ui button d-none" id="pwBtn">수정</button>
                        </form>
                    `)
                }
            }
        });
    }
})

//비번 찾기 탭에서 이메일 입력창에 키업이 발생하면 초기화
$("#PwEmailInput").keyup(function () {
    $("#pwEmailBox").removeClass("error");
    $("#PwEmailInput").attr("placeholder", "회원 가입 시 입력했던 이메일을 입력해주세요.");
})

//비번 찾기 탭에서 아이디 입력창에 키업이 발생하면 초기화
$("#PwIdInput").keyup(function () {
    $("#PwIdBox").removeClass("error");
    $("#PwIdInput").attr("placeholder", "회원 가입 시 입력했던 이름을 입력해주세요.");
})

$(document).on("keyup", ".pwInput", function () {
    var pw = $("#pw").val();
    var checkPw = $("#checkPw").val();
    if (pw == checkPw) {
        $("#checkPw").removeClass("is-invalid");
        $("#checkPw").addClass("is-valid");
        $("#pwBtn").removeClass("d-none");
    } else {
        $("#checkPw").removeClass("is-valid");
        $("#checkPw").addClass("is-invalid");
        $("#pwBtn").addClass("d-none");
    }
})

