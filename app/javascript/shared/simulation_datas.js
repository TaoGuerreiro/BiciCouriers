import  { initSweetalert } from '../plugins/init_sweetalert.js';
import { total } from '../shared/simulation.js';

let sum = 1
const datas = (price) => {
  sum = total();
  initSweetalert('#sweet-alert-demo',
    {
    title: `C'est parti !`,
    text: `Cette course pour ${price * sum / 100} € soit ${sum} ticket* !`,
    icon: "info",
    buttons: [ "Se faire rappeler", `Commander pour ${sum * price / 100}€`]

  }, (value) => {
      console.log(sum);
      });

}


export  { datas }
