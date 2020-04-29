

const favoriteFill = () => {
  document.addEventListener("turbolinks:load", (event) => {

    const pickup = document.getElementById('favorite-pickup');
    if (pickup === null) {
      return
    }
    const drop = document.getElementById('favorite-drop');
    const pickupInput = document.getElementById('course_pickups_attributes_0_address');
    const dropInput = document.getElementById('course_drops_attributes_0_address');

    pickup.addEventListener('change',(event) => {
      const addressPu = event.srcElement.value;
      pickupInput.value = addressPu

    });

    drop.addEventListener('change',(event) => {
      const addressDr = event.srcElement.value;
      dropInput.value = addressDr

    });
  });



}

export { favoriteFill }

