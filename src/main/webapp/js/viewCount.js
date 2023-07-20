$(".titleLink").click(function () {
    let boardId = $(this).attr("boardId");
    let data = {id : boardId};

    $.ajax("/board/view", {
        method: "patch",
        contentType: "application/json",
        data: JSON.stringify(data)
    })
});