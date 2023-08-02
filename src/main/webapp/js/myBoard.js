//테이블 헤드에 있는 체크박스를 누르면 전체 선택 하기 또는 전체 선택 해제 하기
$("#fullCheckBtn").on("change", function () {
    if ($(this).prop("checked")) {
        $(".checkBtn").prop("checked", true);
        $("#deleteBtn").prop("disabled", false);
    } else {
        $(".checkBtn").prop("checked", false);
        $("#deleteBtn").prop("disabled", true);
    }
});

//


