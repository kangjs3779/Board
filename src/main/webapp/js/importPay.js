var currentDate = new Date();

var year = currentDate.getFullYear();
var month = (currentDate.getMonth() + 1).toString().padStart(2, '0'); // 0부터 시작하므로 1을 더하고, 2자리로 만듦
var day = currentDate.getDate().toString().padStart(2, '0'); // 1자리일 경우 2자리로 만듦
var hours = currentDate.getHours().toString().padStart(2, '0');
var minutes = currentDate.getMinutes().toString().padStart(2, '0');
var seconds = currentDate.getSeconds().toString().padStart(2, '0');

var current = year + month + day + hours + minutes + seconds;
var current_date = year + "-" + month + "-" + day;

function requestPay(payMethod, totalCount, ottServiceName, ott, shareMate) {

    var IMP = window.IMP;
    IMP.init("imp04437767");

    IMP.request_pay({
        pg: payMethod,
        pay_method: "card",
        merchant_uid: "test" + current,   // 주문번호
        name: ottServiceName + " 서비스 결제",
        amount: totalCount, // 숫자 타입
        buyer_email: $("#emailInput").val(),
        buyer_name: $("#nameInput").val(),
        buyer_tel: $("#phoneInput").val(),
        current_date: current_date,
        m_redirect_url: "/member/myPage"
    }, function (rsp) { // callback
        //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다.
        if(rsp.success) {
            alert("결제가 완료되었습니다.")

            var orderNumber = rsp.merchant_uid;
            var paidAmount = rsp.paid_amount;
            var status =  rsp.status;
            var memberId = $("#memberIdInput").val();
            var ottId = ott;
            var shareMateId = shareMate;
            var data = {orderNumber ,paidAmount, status, memberId, ottId, shareMateId};
            console.log("data 정보 확인 : " + ottId)

            $.ajax("/payment/addPay", {
                method: "put",
                contentType: "application/json",
                data: JSON.stringify(data),
                success: function () {
                    // 성공 후 리다이렉트
                    window.location.href = "/member/myPage";
                }
            })
        } else {
            alert("결제가 실패하였습니다.")
        }
    });
}

$(".payBtn").click(function () {
    //결제수단
    var payMethod = $(this).attr("payMethod");

    //총 금액
    var totalCount = parseInt($("#totalCostInput").val(), 10);

    // 선택된 체크박스의 value 값을 가져오기
    var ottServiceName = $(".total:checked").val();
    var ott = $(".total:checked").attr("ottId");
    var shareMate = $(".total:checked").attr("shareMateId");

    requestPay(payMethod, totalCount, ottServiceName, ott, shareMate);
})
