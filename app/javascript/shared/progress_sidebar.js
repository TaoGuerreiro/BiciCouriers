

// const progressSidebar = () => {
//   document.addEventListener("turbolinks:load", () => {
//     const currentLeftTickets = document.querySelector('.myItem1');
//     if (currentLeftTickets === null) {
//       return
//     }
//     const tickets = parseInt(currentLeftTickets.dataset.value, 10);
//     const pool = parseInt(currentLeftTickets.dataset.pool, 10);
//     const sum = (tickets + pool)
//     let max = currentLeftTickets.dataset.max
//     let min = 0

//     if (sum < 0) {
//       min = pool
//       max = pool
//     } else {
//       max = currentLeftTickets.dataset.max
//     }

//     // console.log("tickets" + tickets);
//     // console.log("sum" + sum);
//     // console.log("pool" + pool);

//     let color = "#FFCC00"

//     if (sum < 0) {
//       color = '#f00'
//     } else {
//       color = "#FFCC00"
//     }
//     const bar = new ldBar(".myItem1", {
//      "stroke": color,
//      "stroke-width": 9,
//      "preset": "circle",
//      "value": sum,
//      "max": max,
//      "min": min
//     });

//     bar.set(sum)


//   });
// }

// export { progressSidebar }
