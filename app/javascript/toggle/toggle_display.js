const display = () => {

    const volumes = document.querySelectorAll('.volume');
    const urgences = document.querySelectorAll('.urgence');

    // const removeActive = (array) => {
    //   array.forEach((button) => {
    //     button.classList.remove('active');
    //   });
    // }

    // urgences.forEach( (urgence) => {
    //   urgence.addEventListener('click', (event) => {
    //     removeActive(urgences);
    //     urgence.classList.add('active');
    //   });
    // });

    volumes.forEach( (volume) => {
      volume.addEventListener('click', (event) => {
        removeActive(volumes);
        volume.classList.add('active');
      });
    });
};


export { display }

