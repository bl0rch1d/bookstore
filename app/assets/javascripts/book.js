"use strict";

let toggleDescription = () => {
    document.getElementById('short_description').classList.toggle("hidden");
    document.getElementById('full_description').classList.toggle("hidden");
}

let incrementQuantity = () => {
  let input = document.getElementById('quantity_input');

  if (input.value < 10) input.value++;
}

let decrementQuantity = () => {
  let input = document.getElementById('quantity_input');
  
  if (input.value > 1) input.value--;
}

document.addEventListener("click", (event) => {
  let description_triggers = [document.getElementById('full_description_show'), document.getElementById('full_description_hide')]
  
  if (description_triggers.includes(event.target)) toggleDescription();
});