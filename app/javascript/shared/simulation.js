



// const simulation = () => {
//   document.addEventListener("turbolinks:load", (event) => {
//     const volumes = document.querySelectorAll('.volume');
//     const urgences = document.querySelectorAll('.urgence');

//     const currentdate = new Date();

//     const datetime = currentdate.getHours() + ":"  + currentdate.getMinutes()

//     const puStart = document.getElementById('course_pickups_attributes_0_start_hour');
//     const puEnd = document.getElementById('course_pickups_attributes_0_end_hour');
//     const drStart = document.getElementById('course_drops_attributes_0_start_hour');
//     const drEnd = document.getElementById('course_drops_attributes_0_end_hour');

//     // const timeToDecimal = (t) => {
//     //     const arr = t.split(':');

//     //     return (arr[0]<10?'0':'') + arr[0] + ':' + ((arr[1]<10 && arr[1]>0)?'0':'') + arr[1];
//     // }

//     const removeActive = (array) => {
//       array.forEach((urgence) => {
//         urgence.classList.remove('active');
//       });
//     }

//     urgences.forEach( (urgence) => {
//       urgence.addEventListener('click', (event) => {
//         removeActive(urgences);
//         urgence.classList.add('active');
//       });
//     });

//     volumes.forEach( (volume) => {
//       volume.addEventListener('click', (event) => {
//         removeActive(volumes);
//         volume.classList.add('active');
//         const ticket = volume.dataset.tickets;
//       });
//     });

//   });
// };
//     // const typeOfUrgence = urgence.dataset.tickets
//     // puStart.value = timeToDecimal(datetime)
//     // drStart.value = timeToDecimal(datetime)

//     // const expr = typeOfUrgence;
//     // switch (expr) {
//     //   case '0' :
//     //     puEnd.value = timeToDecimal('19:00')
//     //     drEnd.value = timeToDecimal('19:00')
//     //     break;
//     //   case '1':
//     //     puEnd.value = timeToDecimal((currentdate.getHours() + 4)  + ":"  + currentdate.getMinutes())
//     //     drEnd.value = timeToDecimal((currentdate.getHours() + 4)  + ":"  + currentdate.getMinutes())
//     //   break;
//     //   case '2':
//     //     puEnd.value = timeToDecimal((currentdate.getHours() + 1)  + ":"  + currentdate.getMinutes())
//     //     drEnd.value = timeToDecimal((currentdate.getHours() + 1)  + ":"  + currentdate.getMinutes())
//     //     break;
//     //   default:
//     //     puEnd.value = timeToDecimal('19:00')
//     //     drEnd.value = timeToDecimal('19:00')
//     // }



// export { simulation }

