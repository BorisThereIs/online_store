//

function addItem(e) {
    //
    let btnId = e.target.id;
    let lineNo = btnId.substring(btnId.indexOf("_") + 1);
    let item_sku = document.getElementById(`td_${lineNo}_1`);
    let item_name = document.getElementById(`td_${lineNo}_2`);
    let item_price = document.getElementById(`td_${lineNo}_4`);

    // console.log(`line: ${lineNo}`);

    items_to_order.push({
        "sku": item_sku.innerText,
        "name": item_name.innerText,
        "price": item_price.innerText
    });

    sessionStorage.setItem("items_to_order", JSON.stringify(items_to_order))
    showItemAtCart(items_to_order[items_to_order.length - 1]);

    if (items_to_order.length == 1) {
        orderBtn.style.display = "inline";
    }
    // console.log(`array length: ${items_to_order.length}`);
    // console.log(`storage:\n${sessionStorage.getItem("items_to_order")}`);

}

function showItemAtCart(item) {
    //
    let elementToChange = document.getElementById("cart");
    let newContent;
    document.getElementById("num_of_items_in_cart").innerText = items_to_order.length;
    newContent = `${item["sku"]},${item["name"]}<br>---<br>`;
    elementToChange.innerHTML += newContent;
}

function clearCart() {
    //
    items_to_order.length = 0;
    sessionStorage.removeItem("items_to_order");
    document.getElementById("cart").innerHTML = "";
    document.getElementById("num_of_items_in_cart").innerText = "0";
    orderBtn.style.display = "none";
}

var listOfButtons = document.querySelectorAll(".btn-add-to-cart");
var clearCartBtn = document.getElementById("btn-clr-cart");
var orderBtn = document.getElementById("btn-order");
const items_to_order = Array();
var storageValue = sessionStorage.getItem("items_to_order");
document.getElementById("num_of_items_in_cart").innerText = "0";

if (storageValue != null) {
    items_to_order.push(...JSON.parse(storageValue));
    for (let item of items_to_order) {
        showItemAtCart(item);
    }
    orderBtn.style.display = "inline";
}

listOfButtons.forEach((btn) => {
    //
    btn.addEventListener("click", addItem);
})

clearCartBtn.addEventListener("click", clearCart);