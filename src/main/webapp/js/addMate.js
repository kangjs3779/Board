checkShareMate();

$("#addMateModalBtn").click(function () {
    //저요 모달 버튼을 누르면
    const ottId = $("#ottId").val();
    const boardId = $("#boardId").val();
    const memberId = $("#memberId").val();
    const data = {ottId, boardId, memberId};

    if ($("#addMateBtn").hasClass("basic")) {
        //참여하기 전에 참여하기를 누름
        //참여를 신청하는 과정
        $.ajax("/shareMate/addMate", {
            method: "put",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function () {
                //참여중인 메이트 확인
                checkShareMate();

                //참여 취소버튼으로 변함
                $("#addMateModalBtn").empty();
                $("#addMateModalBtn").append(`
                    <i class="icon user"></i>
                    참여 취소
                `);

                //참여신청 버튼을 누르면 저요버튼이 진해짐
                $("#addMateBtn").removeClass("basic");
                //사람아이콘 진해짐
                $("#userIcon").removeClass("outline");
            }
        })
    } else {
        //참여 취소를 하는 과정
        $.ajax("/shareMate/cancleMate", {
            method: "delete",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function () {
                //참여중인 메이트 확인
                checkShareMate();

                //참여 신청버튼으로 변함
                $("#addMateModalBtn").empty();
                $("#addMateModalBtn").append(`
                    <i class="icon user"></i>
                    참여 신청
                `);

                //참여취소 버튼을 누르면 저요버튼이 연해짐
                $("#addMateBtn").addClass("basic");
                //사람아이콘 연해짐
                $("#userIcon").addClass("outline");
            }
        })
    }

});

//참여중인 메이트 확인
function checkShareMate() {
    const boardId = $("#boardId").val();

    $.ajax("/shareMate/checkShareMate?boardId=" + boardId, {
        method: "get",
        success: function (data) {
            if (data.countMate != null) {
                let countMate = data.countMate;
                $(".countShare").text(countMate);
            } else {
                $(".countShare").text("0");
            }
        }
    })
}

//참여 승인 버튼을 누르면
$(".approveBtn").click(function () {
    let test = $(this).text();

    if (test == "참여 승인") {
        const id = $(this).attr("mate-id");
        const approve = 2;
        const data = {id, approve};

        $.ajax("/shareMate/approveMate", {
            method: "patch",
            contentType: "application/json",
            data: JSON.stringify(data)
        })

        $(this).text("승인 완료");
    }

})