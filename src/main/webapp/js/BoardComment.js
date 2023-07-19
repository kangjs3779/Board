//해당 게시글 id값 가져오기
let boardId = $("#boardIdInfo").text();

//댓글 리스트 조회
commentList();

//댓글 리스트 조회 메소드 정의
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
                <div class="mb-2 row" >
                    <label for="commentInput${comment.id}" class="col-sm-2 col-form-label">${comment.nickname}</label>
                    <div class="col-sm-10" id="commentBox${comment.id}">
                        <input type="text" readonly class="form-control-plaintext" id="commentInput${comment.id}" value="${comment.body}">
                        <div class="d-grid gap-2 d-md-flex">
                            <span style="font-size: 12px; color: gray;">${date}</span>
                            <button style="font-size: 12px; color: gray; padding: 0px;"  class="btn me-md-1" >답글쓰기</button>
                            <button style="font-size: 12px; color: gray; padding: 0px;" comment-id="${comment.id}" class="btn me-md-1 ${comment.editable == true ? '' : 'd-none'} commentmodify" >수정</button>
                            <button style="font-size: 12px; color: gray; padding: 0px;" comment-id="${comment.id}" class="btn ${comment.editable == true ? '' : 'd-none'} commentdelete"  >삭제</button>
                        </div>
                    </div>
                </div>
                `)
            }

            //수정 버튼을 누르면 수정 입력창이 뜨도록 함
            $(".commentmodify").click(function () {
                let commentId = $(this).attr("comment-id");

                $.ajax("/boardComment/get?commentId=" + commentId, {
                    method: "get",
                    success: function (comment) {
                        $("#commentBox" + comment.id).empty();
                        $("#commentBox" + comment.id).append(`
                            <div class="col-sm-10">
                                <input type="text" class="form-control mb-1" id="commentInput${comment.id}" value="${comment.body}">
                                <div class="d-grid gap-2 d-md-flex">
                                    <button style="font-size: 12px; color: gray; padding: 0px;" comment-id="${comment.id}" class="btn me-md-1" id="commentmodifyBtn" >수정</button>
                                    <button style="font-size: 12px; color: gray; padding: 0px;" class="btn me-md-1" id="cancleBtn" >취소</button>
                                </div>
                            </div>
                        `);

                        //취소버튼을 누르면
                        $("#cancleBtn").click(function () {
                            //댓글 리스트 조회
                            commentList();
                        });
                    }
                })
            });

            //삭제 버튼을 눌렀을 때
            $(".commentdelete").click(function () {
                let id = $(this).attr("comment-id");
                let data = {id}

                if(confirm("댓글을 삭제하시겠습니까?") == true) {
                    $.ajax("/boardComment/delete", {
                        method: "delete",
                        contentType: "application/json",
                        data: JSON.stringify(data),
                        success: function () {
                            commentList();
                        }
                    })
                }



            })
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

//수정 후 수정버튼을 눌렀을 때
$(document).on("click", "#commentmodifyBtn", function () {
    let id = $(this).attr("comment-id");
    let body = $("#commentInput" + id).val();
    let data = {id, body}

    $.ajax("/boardComment/modify", {
        method: "patch",
        contentType: "application/json",
        data: JSON.stringify(data),
        success: function () {
            commentList();
        }
    })
});
