require("turbolinks").start()
require("channels")
import '../stylesheets/application.scss';
// import 'nouislider/distribute/nouislider.css';
import "controllers"
import "../plugins/flatpickr"

import  { movement } from '../shared/services.js';
import  { userLogo } from '../shared/navbar.js';
import  { initAutocomplete } from '../shared/init_autocomplete.js';
import  { initShowMap } from '../shared/init_show.js';
// import  { slider } from '../shared/slider.js';
import  { animations } from '../shared/animations.js';
import  { counterCircle } from '../shared/loading_bar.js';
import  { selectCarnet } from '../shared/select_carnet.js';
import  { progressSidebar } from '../shared/progress_sidebar.js';
import  { progressCarnet } from '../shared/progress_carnet.js';
import  { favoriteFill } from '../shared/favorite_fill.js';

import  { newCourseGuest } from '../toggle/main.js';



newCourseGuest();


movement();
userLogo();
initAutocomplete();
// bikeToggle();
initShowMap();
// slider();
animations();
counterCircle();
selectCarnet();
favoriteFill();
progressSidebar();
progressCarnet();
