import { sweetalert_display } from '../toggle/sweetalert.js';
import { init_urgences } from '../toggle/init_urgences.js';
import { getUrgence } from '../toggle/get_urgence.js';
import { getDistance, getDistTicket } from '../toggle/get_distance.js';
import { getVolume } from '../toggle/get_volume.js';
import { removeValidationError } from '../toggle/validations.js';
import { displayTotal } from '../toggle/animations.js';



const toggle = () => {
  document.addEventListener("turbolinks:load", (event) => {

    const validators = document.querySelectorAll('.validators');

    const puAddress = document.getElementById('course_pickups_attributes_0_address');
    const drAddress = document.getElementById('course_drops_attributes_0_address');
    const addressInputs = [puAddress, drAddress]

    const urInputs = document.querySelectorAll('.urgence');
    const voInputs = document.querySelectorAll('.volume');

    const sousTotals = document.querySelectorAll('.sous-total');
    const toDisplay = document.getElementById('total-course');
    const priceDisplay = document.getElementById('total-price');

    const diDisplay = document.getElementById('kilometers');
    const voTextDisplay = document.getElementById('vo-text-volume');
    const urDisplay = document.querySelector('.right-urgence');
    const tiDisplay = document.querySelector('.right-distance');
    const heDisplay = document.querySelector('.heure');
    const voDisplay = document.querySelector('.right-volume');
    const voInput = document.getElementById('bike');


    const urgence_0_hour = document.querySelector('.urgence-0-hour');
    const urgence_1_hour = document.querySelector('.urgence-1-hour');
    const urgence_2_hour = document.querySelector('.urgence-2-hour');
    const urgence_0_day = document.querySelector('.urgence-0-day');
    const urgence_1_day = document.querySelector('.urgence-1-day');
    const urgence_2_day = document.querySelector('.urgence-2-day');

    const puStart = document.getElementById('course_pickups_attributes_0_start_hour');
    const puEnd = document.getElementById('course_pickups_attributes_0_end_hour');
    const drStart = document.getElementById('course_drops_attributes_0_start_hour');
    const drEnd = document.getElementById('course_drops_attributes_0_end_hour');
    const stDay = document.getElementById('course_pickups_attributes_0_date');
    const ndDay = document.getElementById('course_drops_attributes_0_date');

    let getTotal = (sous_total_array_input) => {
      let total = 0
      sous_total_array_input.forEach((number) => {
        total = total + (parseInt(number.innerText, 10) || 0)
        toDisplay.innerHTML = total
        priceDisplay.innerHTML = total * 6
      });
    }

    init_urgences(urgence_0_hour, urgence_0_day, urgence_1_hour, urgence_1_day, urgence_2_hour, urgence_2_day, urInputs)
    setInterval(() => { init_urgences(urgence_0_hour, urgence_0_day, urgence_1_hour, urgence_1_day, urgence_2_hour, urgence_2_day, urInputs)}, 60000);
    sweetalert_display(addressInputs, urInputs, voInputs);
    removeValidationError(addressInputs, urInputs, voInputs);
    displayTotal(sousTotals);

    const removeActive = (array) => {
     array.forEach((button) => {
       button.classList.remove('active');
     });
    }

// DISTANCE_____________________________________________________________________

    addressInputs.forEach((input) => {
      input.addEventListener("change", (event) => {
        getDistance(puAddress.value, drAddress.value, diDisplay)
        .then((dist) => getDistTicket(dist, tiDisplay))
        .then(() => getTotal(sousTotals))
      });
    })

    addressInputs.forEach((input) => {
      input.addEventListener("input", (event) => {
        getDistance(puAddress.value, drAddress.value, diDisplay)
        .catch( (e) => console.log('Adresses pas assez précises'))
        .then((dist) => {
          getDistTicket(dist, tiDisplay)
        })
        .then(() => getTotal(sousTotals))
      });
    })


// URGENCE______________________________________________________________________

    urInputs.forEach((button) => {
      button.addEventListener("click", (event) => {
        removeActive(urInputs);
        event.target.classList.add('active');

        puStart.value = event.currentTarget.dataset.start_hour
        puEnd.value = event.currentTarget.dataset.end_hour
        drStart.value = event.currentTarget.dataset.start_hour
        drEnd.value = event.currentTarget.dataset.end_hour
        stDay.value = event.currentTarget.dataset.start_day
        ndDay.value = event.currentTarget.dataset.end_day
        getUrgence(puStart.value, puEnd.value, drStart.value, drEnd.value, stDay.value, ndDay.value, urDisplay, heDisplay )
        .then(() => getTotal(sousTotals));
      })
    });

// VOLUME_______________________________________________________________________

    voInputs.forEach( (volume) => {
      volume.addEventListener('click', (event) => {
        removeActive(voInputs);
        event.target.classList.add('active');
        voTextDisplay.innerText = event.currentTarget.dataset.text

        let number = parseInt(event.srcElement.dataset.tickets, 10)
        getVolume(number, voDisplay, voInput)
        .then(() => getTotal(sousTotals));
      });
    });


  });
}

export { toggle }
