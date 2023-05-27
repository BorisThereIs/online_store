//

async function getOrderDetails(e) {
    //
    let orderDetailsBtnId = e.target.id;
    let lineNo = orderDetailsBtnId.substring(orderDetailsBtnId.lastIndexOf('_') + 1);
    let orderNo = document.getElementById(`order_td_${lineNo}_1`).innerText;
    const fetchResponse = await fetch("/staff_only/order_details",
                                    {method: "POST",
                                    headers: {
                                        "Content-Type": "application/json"
                                        },
                                    body: JSON.stringify({
                                        "order_id": Number(orderNo)
                                        })
                                    });
    const fetchResult = await fetchResponse.json();
    let orderDetailsArea = document.getElementById(`td_order_details_${lineNo}`);
    if (fetchResult['update-status'] == 'ok') {
        let orderDetails = JSON.parse(fetchResult['order_details']);
        let column_names = fetchResult['column_names'];

        let orderDetailsSpoiler = document.createElement('details');
        orderDetailsSpoiler.setAttribute('open', '');
        orderDetailsSpoiler.setAttribute('style', 'color: green;');
        let orderDetailsSpoilerSummary = document.createElement('summary');
        orderDetailsSpoilerSummary.innerText = 'Details';
        orderDetailsSpoiler.appendChild(orderDetailsSpoilerSummary);

        let detailsTable = document.createElement('table');
        let tableHeaderTr = document.createElement('tr');

        for (let col of column_names) {
            let tableHeaderTh = document.createElement('th');
            tableHeaderTh.innerText = col;
            tableHeaderTr.appendChild(tableHeaderTh);
        }
        detailsTable.appendChild(tableHeaderTr);

        for (item of orderDetails) {
            let tableTr = document.createElement('tr');
            for (itemDetail of item) {
                let tableTd = document.createElement('td');
                tableTd.innerText = itemDetail;
                tableTr.appendChild(tableTd);
            }
            detailsTable.appendChild(tableTr);
        }

        orderDetailsSpoiler.appendChild(detailsTable)
        orderDetailsArea.appendChild(orderDetailsSpoiler);

    } else {
        orderDetailsArea.innerHTML += `<p style="color:red;">
                                    order #${orderNo} status: error occured<br>
                                    ${fetchResult['error-message']}<br></p>`;
    }

}

var orderDetailsBtnList = document.querySelectorAll('.get-order-details-btn');
orderDetailsBtnList.forEach((element) => {
    element.addEventListener('click', getOrderDetails);
})