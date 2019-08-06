"use strict";

const MAX_ITEM_QUANTITY = 100;

let toggleDescription = () => {
    document.getElementById("short_description").classList.toggle("hidden");
    document.getElementById("full_description").classList.toggle("hidden");
}

let incrementQuantity = () => {
  let input = document.getElementById("quantity_input");

  if (input.value < MAX_ITEM_QUANTITY) { input.value++; }
}

let decrementQuantity = () => {
  let input = document.getElementById("quantity_input");
  
  if (input.value > 1) { input.value--; }
}

document.addEventListener("click", (event) => {
  let descriptionTriggers = [document.getElementById("full_description_show"), document.getElementById("full_description_hide")];
  
  if (descriptionTriggers.includes(event.target)) { toggleDescription(); }
});
