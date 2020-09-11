



const simulation = () => {
  document.addEventListener("turbolinks:load", (event) => {
    // const submitDistance = document.getElementById('testv2');



    const volumes = document.querySelectorAll('.volume');

    const urgences = document.querySelectorAll('.urgence');

//     const urgenceInput = document.getElementById('simulation_s_urgence');
//     const volumeInput = document.getElementById('simulation_s_volume');
//     const distanceInput = document.getElementById('simulation_s_distance');

//     const mainUrgence = document.getElementById('urgence');
//     const mainVolume = document.getElementById('volume');
//     const mainDistance = document.getElementById('distance');

//     let urgenceTickets = 0
//     let volumeTickets = 0
//     let distanceTickets = 0
var currentdate = new Date();


var datetime = currentdate.getHours() + ":"  + currentdate.getMinutes()




    const puStart = document.getElementById('course_pickups_attributes_0_start_hour');
    const puEnd = document.getElementById('course_pickups_attributes_0_end_hour');
    const drStart = document.getElementById('course_drops_attributes_0_start_hour');
    const drEnd = document.getElementById('course_drops_attributes_0_end_hour');

    const timeToDecimal = (t) => {
        const arr = t.split(':');
        const dec = parseInt((arr[1]/6)*10, 10);

        return parseFloat(parseInt(arr[0], 10) + '.' + (dec<10?'0':'') + dec);
    }

    const removeActive = (array) => {
        array.forEach((urgence) => {
          urgence.classList.remove('active');
        });
      }

    urgences.forEach( (urgence) => {
      urgence.addEventListener('click', (event) => {
        removeActive(urgences);
        urgence.classList.add('active');
        const typeOfUrgence = urgence.dataset.tickets
        puStart.value = timeToDecimal(datetime)
        drStart.value = timeToDecimal(datetime)

        const expr = typeOfUrgence;
        switch (expr) {
          case '0' :
            puEnd.value = timeToDecimal('19:00')
            drEnd.value = timeToDecimal('19:00')
            break;
          case '1':
            puEnd.value = timeToDecimal((currentdate.getHours() + 4)  + ":"  + currentdate.getMinutes())
            drEnd.value = timeToDecimal((currentdate.getHours() + 4)  + ":"  + currentdate.getMinutes())
          break;
          case '2':
            puEnd.value = timeToDecimal((currentdate.getHours() + 1)  + ":"  + currentdate.getMinutes())
            drEnd.value = timeToDecimal((currentdate.getHours() + 1)  + ":"  + currentdate.getMinutes())
            break;
          default:
            puEnd.value = timeToDecimal('19:00')
            drEnd.value = timeToDecimal('19:00')
        }

        //Requete ajax pour connaitre le nb de tickets


      });
    });

    volumes.forEach( (volume) => {
      volume.addEventListener('click', (event) => {
        removeActive(volumes);
        volume.classList.add('active');
        // console.log(volume);
        const ticket = volume.dataset.tickets;
        // console.log(ticket);
        mainVolume.dataset.volume = parseInt(ticket, 10);
        volumeInput.value = parseInt(ticket, 10);
        datas(700);
      });
    });



      });
    };

    export { simulation }

//     const directionsService = new google.maps.DirectionsService();
//     const directionsDisplay = new google.maps.DirectionsRenderer();
//     const pickupInput = document.getElementById('simulation_s_pickup');
//     const dropInput = document.getElementById('simulation_s_drop');

//     const calculDistance = () => {
//       if (dropInput.value.length == 0 || pickupInput.value.length == 0 )
//       {
//         return
//       }
//       let distance = 0
//       const request = {
//         origin: pickupInput.value,
//         destination: dropInput.value,
//         travelMode: google.maps.DirectionsTravelMode.WALKING
//       };
//       directionsService.route(request, function(response, status) {
//        if (status == google.maps.DirectionsStatus.OK) {
//         distance = response.routes[0].legs[0].distance.value;
//         // console.log(distance)
//         directionsDisplay.setDirections(response);
//         mainDistance.dataset.distance = parseInt(Math.ceil(distance / 3500), 10);
//         volumeInput.input = parseInt(Math.ceil(distance / 3500), 10);
//         datas(700);
//         }
//       });
//     }


//     pickupInput.addEventListener('keyup', () => {
//       setTimeout(calculDistance, 400);
//     });
//     dropInput.addEventListener('keyup', () => {
//       setTimeout(calculDistance, 400);
//     });
//   });

// const total = () => {
//     const mainUrgence = document.getElementById('urgence');
//     const mainVolume = document.getElementById('volume');
//     const mainDistance = document.getElementById('distance');
//     const priceInput = document.getElementById('simulation_price_cents');
//     let urgenceTickets = parseInt(mainUrgence.dataset.urgence, 10);
//     let volumeTickets = parseInt(mainVolume.dataset.volume, 10);
//     let distanceTickets = parseInt(mainDistance.dataset.distance, 10);
//     let sum = parseInt((urgenceTickets + volumeTickets + distanceTickets), 10);
//     priceInput.value = sum * 700
//     return sum
