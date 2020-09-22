

// const progressCarnet = () => {
//   document.addEventListener("turbolinks:load", () => {

// //In-Progress carnet
//     const carnetsIp = document.querySelectorAll('.carnet-progress-ip');
//     carnetsIp.forEach((carnet, index) => {
//       const tickets = parseInt(carnet.dataset.value, 10);
//       let max = parseInt(carnet.dataset.max, 10);
//       const sum = (tickets)
//       let min = 0
//       let color = "#FFCC00"

//       new ldBar(`.carnet-ip-${index}`, {
//         "stroke": color,
//         "stroke-width": 4,
//         "preset": "bar",
//         "value": tickets,
//         "max": max,
//         "min": min
//       });
//     });
// //Done carnet
//     const carnetsDo = document.querySelectorAll('.carnet-progress-do');
//     carnetsDo.forEach((carnet, index) => {
//       const tickets = parseInt(carnet.dataset.value, 10);
//       let max = parseInt(carnet.dataset.max, 10);
//       const sum = (tickets)
//       let min = 0
//       let color = "#FFCC00"

//       new ldBar(`.carnet-do-${index}`, {
//         "stroke": color,
//         "stroke-width": 4,
//         "preset": "bar",
//         "value": tickets,
//         "max": max,
//         "min": min
//       });
//     });



//   });
// }

// export { progressCarnet }
