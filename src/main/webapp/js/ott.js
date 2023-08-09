$(".ottType").each(function() {
    var ottName = $(this).attr("ott");

    switch (ottName) {
        case "netflix" :
            $(this).addClass("red");
            break;
        case "tiving" :
            $(this).addClass("orange");
            break;
        case "disney" :
            $(this).addClass("olive");
            break;
        case "wavve" :
            $(this).addClass("blue");
            break;
        case "watcha" :
            $(this).addClass("pink");
            break;
        case "apple" :
            $(this).addClass("black");
            break;
        case "laftel" :
            $(this).addClass("purple");
            break;
        case "prime" :
            $(this).addClass("teal");
            break;
    }
});

$(".ottType").click(function () {
    let ott = $(this).attr("ott");
    console.log(ott)
})