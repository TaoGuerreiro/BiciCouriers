import flatpickr from "flatpickr";
// import { Russian } from "flatpickr/dist/l10n/fr.js"
document.addEventListener("turbolinks:load", (event) => {
  flatpickr(".datepicker", {

    altInput: true,
    allowInput: true,
    defaultDate: new Date(),
    minDate: new Date(),
    weekNumbers: true,
    // dateFormat: "Y-m-d"
  });
});
