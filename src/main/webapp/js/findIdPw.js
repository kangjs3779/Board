
//이메일 전송 버튼을 클릭하면
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

//이메일 입력창에 키업이 발생하면 초기화
$("#emailInput").keyup(function () {
    $("#emailBox").removeClass("error");
    $("#emailInput").attr("placeholder", "회원 가입 시 입력했던 이메일을 입력해주세요.");
})

//이름 입력창에 키업이 발생하면 초기화
$("#nameInput").keyup(function () {
    $("#nameBox").removeClass("error");
    $("#nameInput").attr("placeholder", "회원 가입 시 입력했던 이름을 입력해주세요.");
})
