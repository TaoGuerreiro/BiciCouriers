import  { init_urgences } from '../toggle/init_urgences.js';
import  { display } from '../toggle/toggle_display.js';


const toggle = () => {
  document.addEventListener("turbolinks:load", (event) => {

  const puAddress = document.getElementById('course_pickups_attributes_0_address');
  const drAddress = document.getElementById('course_drops_attributes_0_address');
  const addressInputs = [puAddress, drAddress]

  const puStart = document.getElementById('course_pickups_attributes_0_start_hour');
  const puEnd = document.getElementById('course_pickups_attributes_0_end_hour');
  const drStart = document.getElementById('course_drops_attributes_0_start_hour');
  const drEnd = document.getElementById('course_drops_attributes_0_end_hour');

  const urButtons = document.querySelectorAll('.urgence');
  const voButtons = document.querySelectorAll('.volume');

  const sousTotals = document.querySelectorAll('.sous-total');
  const toDisplay = document.getElementById('total-course');

  const diDisplay = document.getElementById('kilometers');
  const urDisplay = document.querySelector('.right-urgence');
  const tiDisplay = document.querySelector('.right-distance');
  const heDisplay = document.querySelector('.heure');
  const voDisplay = document.querySelector('.right-volume');


  const urgence_0_hour = document.querySelector('.urgence-0-hour');
  const urgence_1_hour = document.querySelector('.urgence-1-hour');
  const urgence_2_hour = document.querySelector('.urgence-2-hour');
  const urgence_0_day = document.querySelector('.urgence-0-day');
  const urgence_1_day = document.querySelector('.urgence-1-day');
  const urgence_2_day = document.querySelector('.urgence-2-day');



 init_urgences(urgence_0_hour, urgence_0_day, urgence_1_hour, urgence_1_day, urgence_2_hour, urgence_2_day, urButtons);
 display();

  });
}

export { toggle }
