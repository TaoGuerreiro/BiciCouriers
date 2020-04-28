import HorizontalScroll from '@oberon-amsterdam/horizontal';


const movement = () => {
  document.addEventListener("turbolinks:load", (event) => {
  if (document.querySelector('.long-container') === null) {
    return
  }
  // console.log(document);
  const horizontal = new HorizontalScroll(
    {
    container: document.querySelector('.long-container'),
    scrollAmountStep: 100,
    scrollAmount: 100,
    }
  );
    // console.log(horizontal);

  horizontal.on('scroll', (e) => {

    const oeufDiv = document.querySelector('.oeuf-1');
    const lineDiv = document.querySelector('.plein');
    // console.log(e);
    const lineSize = Math.min((200 + (e * 1.6)), 2800);
    const EggLeft = Math.min((450 + (e / 7.3)), 2800);
    if (e < 2450) {
    lineDiv.style.width = lineSize + 'px';
    oeufDiv.style.left = EggLeft + 'px';
    }
  });
  });
};

export { movement };
