package net.antonstepanov.frogger.controller {
	import net.antonstepanov.frogger.model.ModelLocator;
	/**
	 * @author 'Anton Stepanov'
	 */
	public class FrogActionsController {
		
		private var model:ModelLocator=ModelLocator.getInstance();
		
		private var step:int=64;
		
		
		public function moveUp():void {
			model.posY=model.posY-step;
			model.currentLineIndex--;
		}
		
		public function moveDown():void {
			model.posY=model.posY+step;
			model.currentLineIndex++;
		}
		
		public function moveLeft():void {
			model.moveHor(model.posX-step);
		}
		
		public function moveRight():void {
			model.moveHor(model.posX+step);
		}
		
		public function moveBy(value:Number):void {
			model.posX=model.posX+value;
		}
		
	}
}
