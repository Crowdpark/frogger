package net.antonstepanov.frogger.controller {
	import net.antonstepanov.frogger.model.ModelLocator;
	/**
	 * @author 'Anton Stepanov'
	 */
	public class FrogActionsController {
		
		private var model:ModelLocator=ModelLocator.getInstance();
		
		private var step:int=50;
		
		
		public function moveUp():void {
			model.posY=model.posY-step;
		}
		
		public function moveDown():void {
			model.posY=model.posY+step;
		}
		
		public function moveLeft():void {
			model.posX=model.posX-step;
		}
		
		public function moveRight():void {
			model.posX=model.posX+step;
		}
		
	}
}
