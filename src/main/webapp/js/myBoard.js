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

//삭제하기 모달 버튼을 클릭하면
$("#deleteModalBtn").click(function () {
    // 체크된 모든 체크박스의 boardId를 얻음
    $(".checkBtn:checked").each(function () {
        var boardId = $(this).attr("boardId");
        var password = $("#passwordInput").val();
        var username = $("#usernameInput").val();
        var data = {password, username};

        $.ajax("/member/myBoardDelete/" + boardId, {
            method: "delete",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function () {
                console.log("성공")
                myBoardList();
            }
        })
    });
});

//내 게시글 전체 조회
function myBoardList() {
    $.ajax("/member/myBoardList", {
        method: "get",
        success: function (lists) {
            console.log(Array.isArray(lists.boards));
            $("#boardListBox").empty();
            for(const list of lists.boards) {
                let commentCountSpan = '';
                if (list.commentCount > 0) {
                    commentCountSpan = `<span style="color: gray;">[${list.commentCount}]</span>`;
                }
                $("#boardListBox").append(`
                <tr>
                    <th class="col text-center"><input type="checkbox" class="checkBtn" boardId="${list.id}"></th>
                    <td class="col-10 text-center" boardId="${list.id}">
                        <a style="color: black;" href="/board/detail?boardId=${list.id}">${list.title}</a>
                        ${commentCountSpan}
                        <a class="ui basic label ${list.roll == 1 ? 'yellow' : ''}">${list.roll == 1 ? '파티장' : '파티원'}</a>
                        <a class="ui empty circular label ottService" ottId="${list.ottId}"></a>
                    </td>
                    <td class="col text-center">${list.viewCount}</td>
                    <td class="col text-center">${list.writer}</td>
                </tr>
                `);
            }
        }
    })
}



