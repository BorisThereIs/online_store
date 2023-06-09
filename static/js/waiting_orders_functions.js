//

async function getOrderDetails(e) {
    //
    let approveBtnId = e.target.id;
    let lineNo = approveBtnId.substring(approveBtnId.lastIndexOf('_') + 1);
    let orderNo = document.getElementById(`order_td_${lineNo}_1`).innerText;
    // hidden tr
    const fetchResponse = await fetch("/staff_only/update_order_status",
                                    {method: "POST",
                                    headers: {
                                        "Content-Type": "application/json"
                                        },
                                    body: JSON.stringify({
                                        "order_id": Number(orderNo),
                                        "order_status": "approved"
                                        })
                                    });
    const fetchResult = await fetchResponse.json();
    let statusArea = document.getElementById('status_area_div');
    if (fetchResult['update-status'] == 'ok') {
        statusArea.innerHTML += `<p style="color:green;">
                                    order #${orderNo} status: approved<br></p>`;
    } else {
        statusArea.innerHTML += `<p style="color:red;">
                                    order #${orderNo} status: error occured<br>
                                    ${fetchResult['error-message']}<br></p>`;
    }

}

var orderDetailsBtnList = document.querySelectorAll('.order-approve-btn');
orderDetailsBtnList.forEach((element) => {
    element.addEventListener('click', getOrderDetails);
})