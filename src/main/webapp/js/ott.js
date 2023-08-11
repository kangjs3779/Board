ottColor();

function color() {
    let colorMap = {}; // ottId와 해당 배경색을 저장할 맵

    $(".ottColor").each(function () {
        let ottColorId = $(this).attr("ottId");
        let backGroundColor = $(this).attr("ottColor");
        colorMap[ottColorId] = backGroundColor; // 맵에 저장
    });

    return colorMap;
}

function ottColor() {
    let colorMap = color();

    $(".ottService").each(function () {
        let ottId = $(this).attr("ottId");

        // colorMap에 해당 ottId의 배경색이 있는지 확인하고, 있다면 해당 배경색을 가져와서 적용합니다.
        if (colorMap.hasOwnProperty(ottId)) {
            let backgroundColor = colorMap[ottId];
            $(this).css("background", backgroundColor);
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
