require("turbolinks").start()
import "bootstrap";
import 'nouislider/distribute/nouislider.css';
import "controllers"
import "../plugins/flatpickr"





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
import  { distance } from '../shared/get_distance.js';
import  { datas } from '../shared/simulation_datas.js';
import  { toggle } from '../toggle/toggle.js';

toggle();

movement();
cardsFly();
userLogo();
//initMap();
initAutocomplete();
// urgenceToggle();
// bikeToggle();
initShowMap();
// slider();
animations();
counterCircle();
selectCarnet();
favoriteFill();
// simulation();
datas();
// progressSidebar();
// progressCarnet();
distance();


