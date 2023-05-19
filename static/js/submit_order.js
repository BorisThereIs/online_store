
var items_dict = {};

function addItem() {
    items_dict[document.getElementById("input_sku").value] = document.getElementById("input_qty").value;
    var newContent = ""
    for(var key in items_dict) {
        newContent += key + ", " + items_dict[key] + "<br>";
    }
    var elementToChange = document.getElementById("p_chosen_items_area")
    elementToChange.innerHTML = newContent;
    document.getElementById("input_sku").value = "";
    document.getElementById("input_qty").value = "";
    document.getElementById("input_hidden").value = JSON.stringify(items_dict);
}

