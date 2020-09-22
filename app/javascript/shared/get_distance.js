import { fetchWithToken } from "../utils/fetch_with_token";

const distance = () => {
  // document.addEventListener("turbolinks:load", (event) => {


    const puAddress = document.getElementById('course_pickups_attributes_0_address');
    const drAddress = document.getElementById('course_drops_attributes_0_address');
    const addressInputs = [puAddress, drAddress]

    const puStart = document.getElementById('course_pickups_attributes_0_start_hour');
    const puEnd = document.getElementById('course_pickups_attributes_0_end_hour');
    const drStart = document.getElementById('course_drops_attributes_0_start_hour');
    const drEnd = document.getElementById('course_drops_attributes_0_end_hour');
    const stDay = document.querySelector('.pickup-date-input');
    const ndDay = document.querySelector('.drop-date-input');

    const urButtons = document.querySelectorAll('.urgence');
    const voButtons = document.querySelectorAll('.volume');

    const sousTotals = document.querySelectorAll('.sous-total');
    const toDisplay = document.getElementById('total-course');

    const diDisplay = document.getElementById('kilometers');
    const urDisplay = document.querySelector('.right-urgence');
    const tiDisplay = document.querySelector('.right-distance');
    const heDisplay = document.querySelector('.heure');
    const voDisplay = document.querySelector('.right-volume');

//______________________TOTAL______________________
    let getTotal = (sous_total_array_input) => {
      let total = 0
      sous_total_array_input.forEach((number) => {
        total = total + parseInt(number.innerHTML, 10)
        // console.log(total)
        toDisplay.innerHTML = total

      });
    }
//______________________DISTANCE______________________

    let getDistance = (pickup, drop) => {

      let input = { addresses: { puAddressName:pickup, drAddressName:drop }}

      return fetchWithToken("/course/distance", {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: JSON.stringify(input)
      })
      .then(response => response.json())
      .then((dist) => {
        diDisplay.innerHTML = dist/1000
        // console.log(dist)
        return dist
        // getTotal()
      });
    };

//______________________TICKETS DISTANCE______________________
    let getDistTickets = (dist) => {
      let data = { distance: { distanceM:dist }}
      return fetchWithToken("/course/tickets", {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: JSON.stringify(data)
      })
      .then(response => response.json())
      .then((data) => {
        // console.log(data)
        tiDisplay.innerHTML = data
        getTotal(sousTotals)
        return data
      });

    };

    //______________________TICKETS URGENCE______________________

    let getUrgence = (pus, pue, drs, dre, pud, drd) => {

      let data = { urgence: { puStart:pus, puEnd:pue, drStart:drs, drEnd:dre, stDate:pud, ndDate:drd }}
      return fetchWithToken("/course/urgence", {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: JSON.stringify(data)
      })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
        // urDisplay.innerHTML = data
        // heDisplay.innerHTML = drEnd.value
        // getTotal(sousTotals)
        // return data
      });
    };



    // let feedUrgencesInput = (urgences_array) => {
    //   urgences_array.forEach((urgence) => {
    //     urgence.addEventListener('click', (event) => {


    //     });
    //   });
    // }

    //______________________TICKETS VOLUME______________________

    let getVolume = (size) => {

      let data = { volume: { size:size}}
      return fetchWithToken("/course/volume", {
        method: "POST",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: JSON.stringify(data)
      })
      .then(response => response.json())
      .then((data) => {
        // console.log(data)
        voDisplay.innerHTML = data
        getTotal(sousTotals)
        return data
      });

    };



//______________________EVENTS______________________
    voButtons.forEach((button) => {
      button.addEventListener("click", (event) => {
        let number = parseInt(event.srcElement.dataset.tickets, 10)
        getVolume(number);
      })
    });
    addressInputs.forEach((input) => {
      input.addEventListener("change", (event) => {
        getDistance(puAddress.value, drAddress.value)
        .then((dist) => getDistTickets(dist))
        .then(() => getTotal(sousTotals))
      });
    })
    addressInputs.forEach((input) => {
      input.addEventListener("input", (event) => {
        getDistance(puAddress.value, drAddress.value)
        .then((dist) => getDistTickets(dist))
        .then(() => getTotal(sousTotals))
      });
    })

    urButtons.forEach((button) => {
      button.addEventListener("click", (event) => {
        puStart.value = event.currentTarget.dataset.start_hour
        puEnd.value = event.currentTarget.dataset.end_hour
        drStart.value = event.currentTarget.dataset.start_hour
        drEnd.value = event.currentTarget.dataset.end_hour
        stDay.value = event.currentTarget.dataset.start_day
        ndDay.value = event.currentTarget.dataset.end_day
        const tick = getUrgence(puStart.value, puEnd.value, drStart.value, drEnd.value, stDay.value, ndDay.value );
        console.log(tick);
      })
    });



  // });
}

export { distance }
