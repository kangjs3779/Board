//참여 승인 버튼을 누르면
$(".approveBtn").click(function () {
    console.log("click")
    let test = $(this).text();

    if (test == "참여 승인") {
        const id = $(this).attr("mate-id");
        const approve = 2;
        const data = {id, approve};

        $.ajax("/shareMate/approveMate", {
            method: "patch",
            contentType: "application/json",
            data: JSON.stringify(data)
        })

        $(this).text("승인 완료");
    }

})