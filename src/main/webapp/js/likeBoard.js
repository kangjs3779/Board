//좋아요 수 조회
likeCount();

//하트아이콘을 클릭하면
$(".heart").click(function () {
    //클래스가 사라졌다 생겼다함
    $(this).toggleClass("outline");

    //게시글의 아이디를 가져옴
    let boardId = $("#boardIdInfo").text();
    let data = {boardId};

    if (!$(this).hasClass("outline")) {
        //빈하트였다가 찬하트로 변함
        //하트 등록 과정
        $.ajax("/board/addLike", {
            method: "Put",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function () {
                console.log("success")
                likeCount();
            }
        })
    } else {
        //찬하트였다가 빈하트로 변함
        //하트 취소 과정
        $.ajax("/board/deleteLike", {
            method: "Delete",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function () {
                console.log("delete success")
                likeCount();
            }
        })
    }
});

//좋아요 수 조회
function likeCount() {
    //게시글의 아이디를 가져옴
    let boardId = $("#boardIdInfo").text();

    $.ajax("/board/likeCount?boardId=" + boardId, {
        success: function (like) {
            if(like.likeCount != null) {
                let likeCount = like.likeCount
                $("#likeCount").text(likeCount);
            } else {
                $("#likeCount").text("0");
            }
        }
    })
}