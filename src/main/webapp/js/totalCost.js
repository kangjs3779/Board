//요금 구하기
$(".form-check-input.total").change(function () {
    var ottId = $(this).attr("ottId");

    var check = $(this).prop("checked");

    var costAsText = $("#ottCost" + ottId).text();
    var costWithoutCommas = costAsText.replace(/,/g, ''); // 쉼표 제거
    var costAsNumber = parseFloat(costWithoutCommas); // 숫자로 변환 (부동 소수점)

    var totalCost = parseFloat($("#totalCostInput").val()); // 현재 총 요금 가져오기

    if (check) {
        totalCost += costAsNumber;
    } else {
        totalCost -= costAsNumber;
    }

    $("#totalCostInput").val(totalCost); // 변경된 총 요금 업데이트
});

