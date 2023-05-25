//

function changeItemQty(e) {
    //
    var qtyElementValue = e.target.value;
    if (qtyElementValue == "" || qtyElementValue == "0") {
        e.target.value = "1";
        qtyElementValue = "1";
    }
    var qtyElementId = e.target.id;
    var itemNo = qtyElementId.substring(qtyElementId.lastIndexOf("_") + 1);
    items_to_submit[Number(itemNo - 1)]["qty"] = Number(e.target.value);
    updateSessionStorage();
}

function updateSessionStorage() {
    if (items_to_submit.length != 0) {
        sessionStorage.setItem("items_to_order", JSON.stringify(items_to_submit));
    } else {
        sessionStorage.removeItem("items_to_order");
    }

}

function removeItem(e) {
    //
    var removeBtnId = e.target.id;
    var itemNo = removeBtnId.substring(removeBtnId.lastIndexOf("_") + 1);
    items_to_submit.splice(Number(itemNo - 1), 1);
    updateSessionStorage();
    renderCart();
}

function handlePageRefresh(e) {
    e.preventDefault();
    updateSessionStorage();
}

function renderCart() {
    //
    if (items_to_submit.length == 0) {
        document.getElementById("chosen-items-area").innerHTML = `<p>No items in cart</p>`;
        return;
    }

    var newContent = "";
    let colTitles = "";
    let tableHeader = "";
    let tableLines = "";
    
    let itemKeys = Object.keys(items_to_submit[0]);
    for (let i = 0; i < itemKeys.length; i++) {
        colTitles += `<th>${itemKeys[i]}</th>`;
    }
    
    tableHeader += `<tr>${colTitles}</tr>`;
    
    for (let item = 0; item < items_to_submit.length; item++) {
        let lineCells = "";
        for (let i = 0; i < itemKeys.length; i++) {
            let tdValue = items_to_submit[item][itemKeys[i]];
            if (itemKeys[i] == "qty") {
                lineCells += `<td id="td_qty_${item + 1}">
                                <input class="input-item-qty" id="input_qty_${item + 1}" type="number" value="${items_to_submit[item][itemKeys[i]]}" min="1">
                                </input>
                            </td>`
                continue;
            }
            lineCells += `<td id="td_${item + 1}_${i + 1}">${tdValue}</td>`;
        }
        let lineRemoveBtn = `<td>
                    <button class="btn-remove-item" id="btn_remove_item_${item + 1}">
                        Remove item
                    </button>
                </td>`;
        tableLines += `<tr id="tr_${item + 1}">${lineCells}${lineRemoveBtn}</tr>`
    }

    newContent += `<table>${tableHeader}${tableLines}</table>`
    document.getElementById("chosen-items-area").innerHTML = newContent;
    registerCartEventListeners();
}

function registerCartEventListeners() {
    //
    var qtyElementsList = document.querySelectorAll(".input-item-qty");
    var listOfRemoveButtons = document.querySelectorAll(".btn-remove-item");

    qtyElementsList.forEach((element) => {
        element.addEventListener("input", changeItemQty);
    }
    )

    listOfRemoveButtons.forEach((element) => {
    element.addEventListener("click", removeItem);
    })
}

function submitOrder(e) {
    //
    e.preventDefault();
    if (e.target.elements["customer"].value == ""
        || e.target.elements["destination_address"].value == ""
        || e.target.elements["email"].value == "") {
        alert(`all fields should be filled in`);
        return;
    }

    var formHiddenField = e.target.elements["hid_items_to_submit"];
    formHiddenField.value = sessionStorage.getItem("items_to_order");
    sessionStorage.removeItem("items_to_order");
    e.target.submit();
}

const items_to_submit = Array();
if (sessionStorage.getItem("items_to_order") != null) {
    items_to_submit.push(...JSON.parse(sessionStorage.getItem("items_to_order")));
}

renderCart();

var listOfLinks = document.querySelectorAll("a");
listOfLinks.forEach((element) => {
        element.addEventListener("click", updateSessionStorage);
    }
)

addEventListener("beforeunload", handlePageRefresh);

var submitForm = document.getElementById("submit_order_form");
submitForm.addEventListener("submit", submitOrder);