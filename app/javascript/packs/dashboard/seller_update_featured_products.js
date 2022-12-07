var checked_product_ids = []
var unchecked_product_ids = []

window.update_featured_products = function () {
  let data = {
    checked_product_ids,
    unchecked_product_ids,
  }
  let JsonData = JSON.stringify(data)
  window.fetch('/api/toggle_featured_products', {
    method: "PUT",
    headers: {
      'Content-Type': 'application/json'
    },
    body: JsonData
  })

  alert("ok")
}

window.handleCheckbox = function (product_id) {
  const checkBox = document.getElementById(`product_featured_checkbox_${product_id}`);
  if (checkBox.checked == true){
      checked_product_ids.push(product_id)
      unchecked_product_ids = unchecked_product_ids.filter(id => id !== product_id)
  }
  else {
      unchecked_product_ids.push(product_id)
      checked_product_ids = checked_product_ids.filter(id => id !== product_id)
  }
}


