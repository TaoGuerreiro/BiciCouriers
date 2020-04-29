

const favoriteFill = () => {

  const pickup = document.querySelector('.favorite-pickup');
  const drop = document.querySelector('.favorite-drop');
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



}

export { favoriteFill }

