import { fetchWithToken } from "../utils/fetch_with_token";


const init_urgences = (urgence_0_hour_input, urgence_0_day_input, urgence_1_hour_input, urgence_1_day_input, urgence_2_hour_input, urgence_2_day_input, urgence_buttons=[]) => {

      return fetchWithToken("/course/init_urgences", {
        method: "GET",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        }
      })
      .then(response => response.json())
      .then((data) => {
        
        // urgence_0_hour_input.innerText = data.urgence_0_end_hour
        // urgence_0_day_input.innerText = data.urgence_0_day
        // urgence_1_hour_input.innerText = data.urgence_1_end_hour
        // urgence_1_day_input.innerText = data.urgence_1_day
        // urgence_2_hour_input.innerText = data.urgence_2_end_hour
        // urgence_2_day_input.innerText = data.urgence_2_day

        // urgence_buttons[0].dataset.start_hour = data.urgence_0_start_hour
        // urgence_buttons[2].dataset.start_hour = data.urgence_1_start_hour
        // urgence_buttons[1].dataset.start_hour = data.urgence_2_start_hour
        // urgence_buttons[0].dataset.end_hour = data.urgence_0_end_hour
        // urgence_buttons[2].dataset.end_hour = data.urgence_1_end_hour
        // urgence_buttons[1].dataset.end_hour = data.urgence_2_end_hour

        // urgence_buttons[0].dataset.start_day = data.urgence_0_start_date
        // urgence_buttons[2].dataset.start_day = data.urgence_1_start_date
        // urgence_buttons[1].dataset.start_day = data.urgence_2_start_date
        // urgence_buttons[0].dataset.end_day = data.urgence_0_end_date
        // urgence_buttons[2].dataset.end_day = data.urgence_1_end_date
        // urgence_buttons[1].dataset.end_day = data.urgence_2_end_date
      });
    };

export { init_urgences }
