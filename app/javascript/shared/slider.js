import noUiSlider from 'nouislider';
import 'nouislider/distribute/nouislider.css';
import  { urgenceRange } from '../shared/urgence.js';

const slider = () => {
  const sliderPickup = document.getElementById('slider-pickup');
  if (sliderPickup === null) {
    return
  }
  const sliderDrop = document.getElementById('slider-drop');
  const sliders = document.querySelectorAll('.slider-container');

  const sliderValuePickup = document.getElementById('slider-pickup-value');
  const sliderValueDrop = document.getElementById('slider-drop-value');
  const originsPickup = sliderPickup.getElementsByClassName('noUi-origin');
  const originsDrop = sliderDrop.getElementsByClassName('noUi-origin');
  const urgence1 = document.querySelector('.urgence-1');
  const urgence2 = document.querySelector('.urgence-2');
  const urgence3 = document.querySelector('.urgence-3');
  const urgence4 = document.querySelector('.urgence-4');
  const urgences = document.querySelectorAll('.urgence');
  const Qminutes = document.getElementById('45min');
  const Qheures = document.getElementById('4heures');


  Number.prototype.toHHMMSS = function () {
    const date = new Date(this * 3600 /* sec per hr */
                             * 1000 /* msec per sec */);
    return ('0' + date.getUTCHours()  ).slice(-2) + ':' +
           ('0' + date.getUTCMinutes()).slice(-2);
  };

  const timeToDecimal = (t) => {
      const arr = t.split(':');
      const dec = parseInt((arr[1]/6)*10, 10);

      return parseFloat(parseInt(arr[0], 10) + '.' + (dec<10?'0':'') + dec);
  }
  function round(value, step) {
      step || (step = 0.25);
      const inv = 1.0 / step;
      return Math.ceil(value * inv) / inv;
  }
  const today = new Date();
  const h = today.getHours();
  const m = today.getMinutes();
  const s = today.getSeconds();
  const hm = timeToDecimal(h + ":" + m);

  // VARIABLES
  const now = round(hm);
  const start = 8
  const end = 22

  Qminutes.innerText = (hm + 0.75).toHHMMSS();
  Qheures.innerText = (hm + 4).toHHMMSS();



  function toggle(element) {

      // If the checkbox is checked, disabled the slider.
      // Otherwise, re-enable it.
      if (this.checked) {
          element.setAttribute('margin', urgenceRange);
      } else {
          element.removeAttribute('margin', urgenceRange);
      }
  }

  noUiSlider.create(sliderPickup, {
    format: {
            to: function (value) {
                return value.toHHMMSS();
            },
            from: function (value) {
                return value;
            }
        },
      start: [now, now + 2],
      connect: true,
      margin: urgenceRange,
      padding: [now-8, 0],
      step: 0.25,
      tooltips: [true, true],
      range: {
          'min': start,
          'max': end
      }
  });

  noUiSlider.create(sliderDrop, {
    format: {
            to: function (value) {
                return value.toHHMMSS();
            },
            from: function (value) {
                return value;
            }
        },
      start: [now, now + 2],
      connect: true,
      margin: urgenceRange,
      padding: [now-8, 0],
      step: 0.25,
      tooltips: [true, true],
      range: {
          'min': start,
          'max': end
      }
  });

  sliderPickup.noUiSlider.on('update', (values, handle) => {
      sliderValuePickup.innerHTML = values[handle];
  });

  urgences.forEach((urgence) => {
    urgence.addEventListener('click', function () {
      console.log(urgenceRange)
      sliderPickup.noUiSlider.updateOptions({
          margin: urgenceRange,
      });
      sliderDrop.noUiSlider.updateOptions({
          margin: urgenceRange,
      });
      sliderPickup.noUiSlider.reset()
      sliderDrop.noUiSlider.reset()
    });
  })

 urgence4.addEventListener('click', () => {
  sliders.forEach((slider) => {
    slider.classList.toggle('hidden-trans');
  });
 });

}

export { slider }
