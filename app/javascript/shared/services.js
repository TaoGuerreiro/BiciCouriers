const movement = () => {
  window.onscroll =  (e) => {
    const oeufDiv = document.querySelector('.oeuf-1');
    const lineDiv = document.querySelector('.plein');
    let h_pos = pageXOffset;

    const lineSize = lineDiv.style.width = 200 + (h_pos * 1.6) + 'px';
    const EggLeft = oeufDiv.style.left = 600 + (h_pos / 6) + 'px';
  }
};


export { movement };