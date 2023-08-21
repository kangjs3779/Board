//
// const ottId = $("#ottId").val();
// const boardId = $("#boardId").val();
// const memberId = $("#memberId").val();
// const data = {ottId, boardId, memberId};
//
// console.log(data)

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
            }
        })
    } else {
        //참여 취소를 하는 과가
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
            }
        })
    }

});

$("#cancleMateModalBtn").click(function () {
    //참여하기 후에 참여취소를 누름
    const boardId = $("#boardId").val();
    const memberId = $("#memberId").val();
    const data = {boardId, memberId};
    console.log(data)

    //참여를 취소하는 과정
    $.ajax("/shareMate/cancleMate", {
        method: "delete",
        contentType: "application/json",
        data: data,
        success: function () {
            checkShareMate();

            //참여 신청버튼으로 변함
            $("#cancleMateModalBtn").empty();
            $("#cancleMateModalBtn").append(`
                    <i class="icon user"></i>
                    참여 신청
                `);
        }
    })

    //모달이 뜨고 참여취소버튼을 누르면 저요 버튼이 변함
    $("#canclemateBtn").removeClass("basic");
})

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