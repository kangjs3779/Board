ottColor();

function ottColor() {
    $(".ottType").each(function () {
        var ottName = $(this).attr("ott");

        switch (ottName) {
            case "netflix":
            case "넷플릭스":
                $(this).addClass("red");
                break;
            case "tiving":
            case "티빙":
                $(this).addClass("orange");
                break;
            case "disney":
            case "디즈니플러스":
                $(this).addClass("olive");
                break;
            case "wavve":
            case "웨이브":
                $(this).addClass("blue");
                break;
            case "watcha":
            case "왓챠":
                $(this).addClass("pink");
                break;
            case "apple":
            case "애플TV":
                $(this).addClass("black");
                break;
            case "laftel":
            case "라프텔":
                $(this).addClass("purple");
                break;
            case "prime":
            case "프라임비디오":
                $(this).addClass("teal");
                break;
        }
    });
}

$(".ottType").click(function () {
    //ott 버튼을 누르면 해당 ott만 검색
    let ott = $(this).attr("ott");

    $.ajax("/board/ottSearch?ott=" + ott, {
        success: function (lists) {

            $("#boardListBox").empty();

            for (const [index, list] of lists.entries()) {
                let commentCountSpan = '';
                if (list.commentCount > 0) {
                    commentCountSpan = `<span style="color: gray;">[${list.commentCount}]</span>`;
                }
                $("#boardListBox").append(`
                <tr>
                    <th class="col text-center">${index + 1}</th> <!-- 순차적인 숫자 추가 -->
                    <td class="col-10 text-center" boardId="${list.id}">
                        <a style="color: black;" href="/board/detail?boardId=${list.id}">${list.title}</a>
                        ${commentCountSpan}
                        <a class="ui basic label ${list.roll == 1 ? 'yellow' : ''}">${list.roll == 1 ? '파티장' : '파티원'}</a>
                        <a class="ui empty circular label ottType" ott="${list.ott}"></a>
                    </td>
                    <td class="col text-center">${list.viewCount}</td>
                    <td class="col text-center">${list.writer}</td>
                </tr>
                `);
            }

            ottColor();
        }
    })
})
