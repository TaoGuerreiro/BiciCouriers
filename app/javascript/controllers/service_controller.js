import { Controller } from "stimulus"
import HorizontalScroll from '@oberon-amsterdam/horizontal';

export default class extends Controller {
  static targets = [ 'container', 'line', 'egg' ]


    connect() {
        console.log('Connexion du controller de service')
        const horizontal = new HorizontalScroll(
            {
            container: this.containerTarget,
            scrollAmountStep: 100,
            scrollAmount: 100,
            }
          );
          horizontal.on('scroll', (e) => {
            const oeufDiv = this.eggTarget
            const lineDiv = this.lineTarget
            // console.log(e);
            const lineSize = Math.min(((e * 1.6)), 2800);
            const EggLeft = Math.min(((e / 1)), 2800);
            if (e < 2450) {
            lineDiv.style.width = lineSize + 'px';
            oeufDiv.style.left = EggLeft + 'px';
            }
          });

    }     
}


