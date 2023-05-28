//

async function shipOrder(e) {
    //
    let shipBtnId = e.target.id;
    let lineNo = shipBtnId.substring(shipBtnId.lastIndexOf('_') + 1);
    let orderNo = document.getElementById(`order_td_${lineNo}_1`).innerText;

    const fetchResponse = await fetch("/staff_only/update_order_status",
                                    {method: "POST",
                                    headers: {
                                        "Content-Type": "application/json"
                                        },
                                    body: JSON.stringify({
                                        "order_id": Number(orderNo),
                                        "order_status": "shipped",
                                        "ship_datetime": Date.now() / 1000
                                        })
                                    });
    const fetchResult = await fetchResponse.json();
    let statusArea = document.getElementById(`td_update_status_${lineNo}`);
    if (fetchResult['update-status'] == 'ok') {
        e.target.setAttribute("disabled", "");
        statusArea.innerHTML += `<p style="color:green;">
                                    order #${orderNo} status marked as shipped<br></p>`;
    } else {
        statusArea.innerHTML += `<p style="color:red;">
                                    order #${orderNo} status: error occured<br>
                                    ${fetchResult['error-message']}<br></p>`;
    }

}

var orderDetailsBtnList = document.querySelectorAll('.order-ship-btn');
orderDetailsBtnList.forEach((element) => {
    element.addEventListener('click', shipOrder);
})