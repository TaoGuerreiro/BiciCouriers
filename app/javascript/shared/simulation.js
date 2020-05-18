
const simulation = () => {
  document.addEventListener("turbolinks:load", (event) => {
    const volumes = document.querySelectorAll('.volume');
    const urgences = document.querySelectorAll('.urgence');
    const urgenceInput = document.getElementById('simulation_s_urgence');
    const volumeInput = document.getElementById('simulation_s_volume');

    const removeActive = (array) => {
        array.forEach((urgence) => {
          urgence.classList.remove('active');
        });
      }

    urgences.forEach( (urgence) => {
      urgence.addEventListener('click', (event) => {
        removeActive(urgences);
        urgence.classList.add('active');
        console.log(urgence);
        const ticket = urgence.dataset.tickets;
        console.log(ticket);
        urgenceInput.value = ticket
      });
    });

    volumes.forEach( (volume) => {
      volume.addEventListener('click', (event) => {
        removeActive(volumes);
        volume.classList.add('active');
        console.log(volume);
        const ticket = volume.dataset.tickets;
        console.log(ticket);
        volumeInput.value = ticket
      });
    });

  });
}

export { simulation }

