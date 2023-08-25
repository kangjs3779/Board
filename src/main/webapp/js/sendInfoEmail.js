//정보 전송 버튼을 클릭하면
$(".sendInfoBtn").click(function () {
    //메이트 메일 정보 가져오기
    var mateMail = $(this).attr("mateEmail");
    console.log(mateMail)
    var ott = $(this).attr("ott");
    var boardId = $(this).attr("boardId");
    var id = $(this).attr("mateId");
    var data = {id}

    $.ajax("/member/sendInfoEmail?email=" + mateMail + "&ott=" + ott + "&boardId=" + boardId, {
        method: "get",
        success: function () {
            $.ajax("/member/completeEmail", {
                method: "patch",
                contentType: "application/json",
                data: JSON.stringify(data),
                success: function () {
                    console.log("success")
                }
            })
        }
    })

    $(this).text("전송 완료")


})