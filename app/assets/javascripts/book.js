"use strict";

const DESCRIPTION = {
    full_trigger: 'full_description_show',
    short_trigger: 'full_description_hide',
    short: 'short_description',
    full: 'full_description'
};

const QUANTITY_INPUT = 'quantity_input';

let getElement = name => document.getElementById(name);

let toggleDescription = () => {
    getElement(DESCRIPTION.short).classList.toggle("hidden");
    getElement(DESCRIPTION.full).classList.toggle("hidden");
}

let incrementQuantity = () => getElement(QUANTITY_INPUT).value++;

let decrementQuantity = () => {
  let input = getElement(QUANTITY_INPUT);
  
  if (input.value > 1) input.value--;
}

getElement('book_info').addEventListener("click", (event) => {
  if (event.target == getElement(DESCRIPTION.full_trigger) || event.target == getElement(DESCRIPTION.short_trigger)) toggleDescription();
});