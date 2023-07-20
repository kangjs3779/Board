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
                <div class="mb-2 row commentBox" comment-id="${comment.id}">
                    <label for="commentInput${comment.id}" class="col-sm-2 col-form-label"><strong>${comment.nickname}</strong></label>
                    <div class="col-sm-10" id="commentBox${comment.id}">
                        <input type="text" readonly class="form-control-plaintext" id="commentInput${comment.id}" value="${comment.body}">
                        <div class="d-grid gap-2 d-md-flex">
                            <span style="font-size: 12px; color: gray;">${date}</span>
                            <button style="font-size: 12px; color: gray; padding: 0px;"  class="btn me-md-1 childCommentBtn ${comment.repliable == true ? '' : 'd-none'}" comment-id="${comment.id}">답글쓰기</button>
                            <button style="font-size: 12px; color: gray; padding: 0px;" comment-id="${comment.id}" class="btn me-md-1 ${comment.editable == true ? '' : 'd-none'} commentmodify" >수정</button>
                            <button style="font-size: 12px; color: gray; padding: 0px;" comment-id="${comment.id}" class="btn ${comment.editable == true ? '' : 'd-none'} commentdelete"  >삭제</button>
                        </div>
                        <!--대댓폼-->
                        <span id="childCommentFormBox${comment.id}">
                        </span>
                        <!--대댓리스트-->
                        <span id="childCommentBox${comment.id}">
                        </span>
                    </div>
                </div>
                `)
            }

            //답글 리스트 조회
            childCommentList();

            // 답글 달기 버튼을 누르면 입력창이 토글되도록 함
            $(document).on("click", ".childCommentBtn", function () {
                let commentId = $(this).attr("comment-id");
                let nickname = $("#nicknameInfo").text();
                const childCommentFormBox = $("#childCommentFormBox" + commentId);

                // 입력창이 이미 열려있는지 확인
                const isFormVisible = childCommentFormBox.children("form").length > 0;

                // 입력창이 열려있으면 닫기
                if (isFormVisible) {
                    childCommentFormBox.empty();
                } else {
                    // 모든 대댓폼을 닫기 (하나의 대댓폼만 열도록 처리)
                    $(".childCommentForm").remove();

                    // 입력창이 닫혀있으면 열기
                    childCommentFormBox.append(`
                    <form class="childCommentForm">
                        <br>
                        <input type="hidden" value="${commentId}" id="commentIdInput">
                        <div class="form-floating">
                            <input class="form-control" id="childCommentInput">
                            <label for="childCommentInput" style="color: gray">${nickname}님 답글을 남겨주세요.</label>
                        </div>
                        <div class="d-flex justify-content-end">
                            <button type="button" class="btn" style="color: gray;" id="addChildCommentBtn">답글 등록</button>
                        </div>
                    </form>
                    `);
                }
            });

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

                if (confirm("댓글을 삭제하시겠습니까?") == true) {
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

//답글 리스트 조회 메소드 정의
function childCommentList() {
    $(".commentBox").each(function () {
        let commentId = $(this).attr("comment-id");
        $.ajax("/childComment/list?commentId=" + commentId, {
            method: "get",
            success: function (childComments) {
                $("#childCommentBox" + commentId).empty();
                for (childComment of childComments) {
                    const insertedDate = new Date(childComment.inserted); // 작성날짜
                    const date = insertedDate.toISOString().split('T')[0]; //작성날짜

                    $("#childCommentBox" + commentId).append(`
                            <hr>
                            <div class="mb-2 row childCommentBox" id="formBox${childComment.id}" childComment-id="${childComment.id}">
                                <label for="childCommentInput${childComment.id}" class="col-sm-2 col-form-label"><strong>${childComment.nickname}</strong></label>
                                <div class="col-sm-10" id="childCommentBox${childComment.id}">
                                    <input type="text" readonly class="form-control-plaintext" id="childCommentInput${childComment.id}" value="${childComment.body}">
                                    <div class="d-grid gap-2 d-md-flex">
                                        <span style="font-size: 12px; color: gray;">${date}</span>
                                        <button style="font-size: 12px; color: gray; padding: 0px;" childComment-id="${childComment.id}" class="${childComment.editable == true ? '' : 'd-none'} btn me-md-1 modifyChild" >수정</button>
                                        <button style="font-size: 12px; color: gray; padding: 0px;" childComment-id="${childComment.id}" class="${childComment.editable == true ? '' : 'd-none'}  btn deleteChild"  >삭제</button>
                                    </div>
                                </div>
                            </div>
                    `);
                }
            }
        })
    });
}

//답글 등록 버튼을 누르면
$(document).on("click", "#addChildCommentBtn", function () {
    let body = $("#childCommentInput").val();
    let commentId = $("#commentIdInput").val();
    let memberId = $("#usernameInput").val();
    let nickname = $("#nicknameInfo").text();
    let data = {body, commentId, memberId, nickname};

    $.ajax("/childComment/add", {
        method: "post",
        contentType: "application/json",
        data: JSON.stringify(data),
        success: function () {
            //답글 리스트 조회
            childCommentList();
            //답글창 초기화
            $("#childCommentInput").val('');
        }
    })
})

//답글 수정 버튼을 누르면
$(document).on("click", ".modifyChild", function () {
    let childCommentId = $(this).attr("childComment-id");
    //해당 답글의 정보를 불러옴
    $.ajax("/childComment/get?childCommentId=" + childCommentId, {
        method: "get",
        success: function (childComment) {
            $("#formBox" + childCommentId).empty();
            $("#formBox" + childCommentId).append(`
            <label for="childCommentInput${childComment.id}" class="col-sm-2 col-form-label"><strong>${childComment.nickname}</strong></label>
            <div class="col-sm-10" id="childCommentBox${childComment.id}">
                <input type="text" class="form-control" id="childCommentInput${childComment.id}" value="${childComment.body}">
                <div class="d-grid gap-2 d-md-flex">
                    <button style="font-size: 12px; color: gray; padding: 0px;" childComment-id="${childComment.id}" class="btn me-md-1" id="modifyChildBtn">수정</button>
                    <button style="font-size: 12px; color: gray; padding: 0px;" class="btn" id="cancleChildBtn"  >취소</button>
                </div>
            </div>
            `);

            //취소 버튼을 누르면 다시 돌아감
            $(document).on("click", "#cancleChildBtn", function () {
                childCommentList();
            })
        }
    })
})

//답글 수정 후 수정 버튼을 누르면
$(document).on("click", "#modifyChildBtn", function () {
    let id = $(this).attr("childComment-id");
    let body = $("#childCommentInput" + id).val();
    let data = {id, body}

    $.ajax("/childComment/modify", {
        method: "patch",
        contentType: "application/json",
        data: JSON.stringify(data),
        success: function () {
            childCommentList();
        }
    })
})


//답글 삭제 버튼을 누르면
$(document).on("click", ".deleteChild", function () {
    let id = $(this).attr("childComment-id");
    let data = {id}

    let ok = confirm("답글을 삭제하시겠습니까?");
    if(ok) {
        $.ajax("/childComment/delete", {
            method: "delete",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function () {
                childCommentList();
            }
        })
    }
})