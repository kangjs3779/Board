
let boardId = $("#boardIdInfo").text();
console.log(boardId)
commentList();

//댓글 리스트 조회
function commentList() {

    $.ajax("/boardComment/list?boardId=" + boardId, {
        method: "get",
        success: function (comments) {
            //댓글 개수
            $("#commentCount").text(comments.length);

            //댓글 리스트
            $("#commentListBox").empty();
            for (comment of comments) {
                const insertedDate = new Date(comment.inserted); // 작성날짜
                const date = insertedDate.toISOString().split('T')[0]; //작성날짜

                $("#commentListBox").append(`
                <hr>
                <div class="mb-2 row">
                    <label for="commentInput${comment.id}" class="col-sm-2 col-form-label">${comment.nickname}</label>
                    <div class="col-sm-10">
                        <input type="text" readonly class="form-control-plaintext" id="commentInput${comment.id}" value="${comment.body}">
                        <div class="d-grid gap-2 d-md-flex">
                            <span style="font-size: 12px; color: gray;">${date}</span>
                            <button style="font-size: 12px; color: gray; padding: 0px;"  class="btn me-md-1" >답글쓰기</button>
                            <button style="font-size: 12px; color: gray; padding: 0px;"  class="btn me-md-1 ${comment.editable == true ? '' : 'd-none'}" >수정</button>
                            <button style="font-size: 12px; color: gray; padding: 0px;"  class="btn ${comment.editable == true ? '' : 'd-none'}"  >삭제</button>
                        </div>
                    </div>
                </div>
                `)

            }
        }
    })
}


//등록 버튼을 누르면
$("#addCommentBtn").click(function () {
    let nickname = $("#nicknameInfo").text();
    let body = $("#commentInput").val();
    let boardId = $("#boardIdInfo").text();
    let memberId = $("#usernameInput").val();
    let data = {nickname, body, boardId, memberId};
    console.log(data)

    $.ajax("/boardComment/add", {
        method: "post",
        contentType: "application/json",
        data: JSON.stringify(data),
        success: function () {
            commentList();
            $("#commentInput").val('');
        }
    });

})