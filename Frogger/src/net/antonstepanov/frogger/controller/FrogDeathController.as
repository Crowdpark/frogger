package net.antonstepanov.frogger.controller {
	import net.antonstepanov.frogger.model.ModelLocator;
	/**
	 * @author 'Anton Stepanov'
	 */
	public class FrogDeathController {
		
		private var model:ModelLocator=ModelLocator.getInstance();
		
		
		private function validateDeath():void {
			
		}
		
		
		public function checkBoundaries(newX:int,newY:int):Boolean {
			if (model.posX<0  || (model.posX +model.frog.width)>model.gameSize.x
			|| model.posY<0  || (model.posY)>model.gameSize.y) {
				trace ('checkBoundaries: DEAD');
				return true;
			} else {
				trace ('checkBoundaries: ALIVE');
				return false;
			}
		}
		
	}
}
