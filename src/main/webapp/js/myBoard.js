function checkBtn() {
    //체크된 checkBtn을 확인
    var checkedCount = $(".checkBtn:checked").length;

    //총 checkBtn을 확인
    var totalCount = $(".checkBtn").length;

    //총 개수보다 체크된 개수가 작으면 true
    var anyUnchecked = checkedCount < totalCount;

    //하나라도 체크가 안되어 있으면 체크해제
    $("#fullCheckBtn").prop("checked", !anyUnchecked);

    //체크된 것이 하나도 없으면 삭제버튼 비활성화
    $("#deleteBtn").prop("disabled", checkedCount === 0);
}

$(".checkBtn").on("change", checkBtn);

//전체 체크버튼 누르면 전체제크됨
$("#fullCheckBtn").on("change", function () {
    if ($(this).prop("checked")) {
        $(".checkBtn").prop("checked", true);
    } else {
        $(".checkBtn").prop("checked", false);
    }
    checkBtn();
});

//삭제하기 버튼을 클릭하면
$("#deleteBtn").click(function () {
    var data = [];

    // 체크된 모든 체크박스를 순회하여 boardId 값을 배열에 추가
    $(".checkBtn:checked").each(function () {
        var boardId = $(this).attr("boardId");
        data.push(boardId)
    });

    console.log(data)

    $.ajax("/member/myBoardDelete", {
        method: "delete",
        contentType: "application/json",
        data: JSON.stringify(data),
        success: function () {
            console.log("success")
        }
    })

});



