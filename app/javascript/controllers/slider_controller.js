import { Controller } from "stimulus"
import { fetchWithToken } from "../utils/fetch_with_token";
import noUiSlider from 'nouislider';

export default class extends Controller {
    static targets = [ 'sliderPickup', 'sliderDrop', 'text', 'ticket', 'hourPickupStart', 'hourPickupEnd', 'hourDropStart', 'hourDropEnd', 'dateStart', 'dateEnd', 'urgence', 'urgenceDayText', 'urgenceHourText' ]
    
    
      getCityInfo = () => {
        return fetchWithToken("/cities/current", {
            method: "GET",
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json"
            }
        })
          .then(response => response.json())
          .then((data) => {
            return [data["start_hour"], data["end_hour"]]
          });
      }

  connect() {

    console.log("Connexion du Slider controller")

    Number.prototype.toHHMMSS = function () {
        const date = new Date(this * 3600 /* sec per hr */
                             * 1000 /* msec per sec */);
    return ('0' + date.getUTCHours()  ).slice(-2) + ':' +
           ('0' + date.getUTCMinutes()).slice(-2);
    };

    const now = round(hm);

    function round(value, step) {
      step || (step = 0.25);
      const inv = 1.0 / step;
      return Math.ceil(value * inv) / inv;
    }
    const today = new Date();
    const h = today.getHours();
    const m = today.getMinutes();
    const hm = timeToDecimal(h + ":" + m);

    function timeToDecimal(t) {
      const arr = t.split(':');
      const dec = parseInt((arr[1]/6)*10, 10);

      return parseFloat(parseInt(arr[0], 10) + '.' + (dec<10?'0':'') + dec);
    }

    const range = this.getCityInfo()
    console.log(range)

    noUiSlider.create(this.sliderPickupTarget, {
        format: {
                to: function (value) {
                    return value.toHHMMSS();
                },
                from: function (value) {
                    return value;
                }
            },
          start: [8, 10],
          behaviour: 'drag-tap',
          connect: true,
        //   margin: urgenceRange,
          // padding: [now-8, 0],
          // padding: [now, 0],
          step: 0.25,
          tooltips: [true, true],
          range: {
              'min': 8,
              'max': 19
          }
      });
    
    //   noUiSlider.create(this.sliderDropTarget, {
    //     format: {
    //             to: function (value) {
    //                 return value.toHHMMSS();
    //             },
    //             from: function (value) {
    //                 return value;
    //             }
    //         },
    //       start: [8, 19],
    //       behaviour: 'drag-tap',
    //       connect: true,
    //     //   margin: urgenceRange,
    //       // padding: [now-8, 0],
    //       // padding: [now, 0],
    //       step: 0.25,
    //       tooltips: [true, true],
    //       range: {
    //         'min': range[0],
    //         'max': range[1]
    //       }
    //   });
  }
}
