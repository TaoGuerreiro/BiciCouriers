// import { sweetalert_display } from '../toggle/sweetalert.js';
// import { getVolume } from '../toggle/get_volume.js';
import  { initMap } from '../courses/init_map.js';


const newCourse = () => {
//   document.addEventListener("turbolinks:load", (event) => {

//     if (window.location.pathname != '/courses/new') {
//       return
//     }
    const puAddress = document.getElementById('course_pickups_attributes_0_address');
    const drAddress = document.getElementById('course_drops_attributes_0_address');
  

//     const voInputs = document.querySelectorAll('.volume');

//     const sousTotals = document.querySelectorAll('.sous-total');
//     const toDisplay = document.getElementById('total-course');
//     const priceDisplay = document.getElementById('total-price');

//     const voTextDisplay = document.getElementById('vo-text-volume');
//     const voDisplay = document.querySelector('.right-volume');
//     const voInput = document.getElementById('bike');


  
//     const getTotal = (sous_total_array_input) => {
//       let total = 0
//       sous_total_array_input.forEach((number) => {
//         total = total + (parseInt(number.innerText, 10) || 0)
//         toDisplay.innerHTML = total
//         priceDisplay.innerHTML = total * 6
//       });
//     }

    // initMap(puAddress, drAddress);

    // init_urgences(urgence_0_hour, urgence_0_day, urgence_1_hour, urgence_1_day, urgence_2_hour, urgence_2_day, urInputs)
    // sweetalert_display(addressInputs, urInputs, voInputs);
    // const removeActive = (array) => {
    // console.log(array)
    // array.forEach((button) => {
    // console.log(button.classList)
    // button.classList.remove('active');
    // button.nextElementSibling.classList.remove('font-active');
    //  });
    // }

// DISTANCE_____________________________________________________________________
    // dropdown.forEach((list) => {
    //   list.addEventListener('click', (event) => {
    //     getDistance(puAddress.value, drAddress.value, diDisplay)
    //       .then((dist) => {
    //         getDistTicket(dist, tiDisplay)
    //         .then((response) => {
    //             getTotal(sousTotals)
    //         });
    //       });
    //   });
    // });

    // addressInputs.forEach((input) => {
    //   input.addEventListener("change", (event) => {
    //     getDistance(puAddress.value, drAddress.value, diDisplay)
    //     .then((dist) => {
    //       getDistTicket(dist, tiDisplay)
    //     .then(() => getTotal(sousTotals))
    //     });
    //   });
    // })

    // drAddress.addEventListener('change', displayRoute(puAddress, drAddress));

    // addressInputs.forEach((input) => {
    //   input.addEventListener("input", (event) => {
    //     getDistance(puAddress.value, drAddress.value, diDisplay)
    //     .then((dist) => {
    //       getDistTicket(dist, tiDisplay)
    //     })
    //     .then(() => getTotal(sousTotals))
    //   });
    // })

// URGENCE______________________________________________________________________

    // urInputs.forEach((button) => {
    //   button.addEventListener("click", (event) => {
    //     removeActive(urInputs);
    //     event.target.parentNode.classList.add('active');
    //     // event.target.nextElementSibling.className ='font-active';

    //     puStart.value = event.currentTarget.dataset.start_hour
    //     puEnd.value = event.currentTarget.dataset.end_hour
    //     drStart.value = event.currentTarget.dataset.start_hour
    //     drEnd.value = event.currentTarget.dataset.end_hour
    //     stDay.value = event.currentTarget.dataset.start_day
    //     ndDay.value = event.currentTarget.dataset.end_day
    //     getUrgence(puStart.value, puEnd.value, drStart.value, drEnd.value, stDay.value, ndDay.value, urDisplay, heDisplay )
    //     .then(() => getTotal(sousTotals));
    //   })
    // });

// VOLUME_______________________________________________________________________

    // voInputs.forEach( (volume) => {
    //   volume.addEventListener('click', (event) => {
    //     // removeActive(voInputs);
    //     event.target.parentNode.classList.add('active');
    //     // console.log(event.target)
    //     // event.target.nextElementSibling.className ='font-active';
    //     console.log(event.currentTarget.lastElementChild.innerText)
    //     voTextDisplay.innerText = event.currentTarget.lastElementChild.innerText
          
    //     let number = parseInt(event.srcElement.nextElementSibling.dataset.tickets, 10)
    //     getVolume(number, voDisplay, voInput)
    //     .then(() => getTotal(sousTotals));
    //   });
    // });


  // });
}

export { newCourse }
