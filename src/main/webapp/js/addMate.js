checkShareMate();

$("#addMateModalBtn").click(function () {
    //저요 모달 버튼을 누르면

    if ($("#addMateBtn").hasClass("basic")) {
        //참여하기 전에 참여하기를 누름
        $("#addMateModalBtn").empty();
        $("#addMateModalBtn").append(`
            <i class="icon user"></i>
            참여 신청
        `);

        const ottId = $("#ottId").val();
        const boardId = $("#boardId").val();
        const memberId = $("#memberId").val();
        const data = {ottId, boardId, memberId};

        //참여를 신청하는 과정
        $.ajax("/shareMate/addMate", {
            method: "put",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function () {
                checkShareMate();
            }
        })

    } else {
        //참여하기 후에 참여취소를 누름
        $("#addMateModalBtn").empty();
        $("#addMateModalBtn").append(`
            <i class="icon user"></i>
            참여 취소
        `);

        //참여를 취소하는 과정
    }

    //모달이 뜨고 참여하기버튼을 누르면 저요 버튼이 변함
    $("#addMateBtn").toggleClass("basic");
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