require("turbolinks").start()
import "bootstrap";
import 'nouislider/distribute/nouislider.css';
import "controllers"
import "../plugins/flatpickr"
import  { initSweetalert } from '../plugins/init_sweetalert.js';



import  { movement } from '../shared/services.js';
import  { cardsFly } from '../shared/avantages.js';
import  { userLogo } from '../shared/navbar.js';
import  { initMap } from '../shared/init_map.js';
import  { initAutocomplete } from '../shared/init_autocomplete.js';
import  { urgenceToggle } from '../shared/urgence.js';
import  { bikeToggle } from '../shared/volume.js';
import  { initShowMap } from '../shared/init_show.js';
import  { slider } from '../shared/slider.js';
import  { animations } from '../shared/animations.js';
import  { counterCircle } from '../shared/loading_bar.js';
import  { selectCarnet } from '../shared/select_carnet.js';
import  { progressSidebar } from '../shared/progress_sidebar.js';
import  { progressCarnet } from '../shared/progress_carnet.js';
import  { favoriteFill } from '../shared/favorite_fill.js';
import  { simulation } from '../shared/simulation.js';
// import  { calculSurMesure } from '../shared/sur_mesure.js';

const price = 7
const distance = 2
const tickets = 1
initSweetalert('#sweet-alert-demo', {
  title: `C'est parti !`,
  text: `Cette course pour ${price}.00 € soit ${tickets} ticket* !`,
  icon: "info",

  buttons: [ "Se faire rappeler", `Commander pour ${price}€`]
}, (value) => {
  console.log(value);
});



movement();
cardsFly();
userLogo();
initMap();
initAutocomplete();
urgenceToggle();
bikeToggle();
initShowMap();
slider();
animations();
counterCircle();
selectCarnet();
favoriteFill();
// simulation();

progressSidebar();
progressCarnet();
// calculSurMesure();
