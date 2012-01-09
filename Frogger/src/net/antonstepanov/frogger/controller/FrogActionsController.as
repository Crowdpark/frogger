package net.antonstepanov.frogger.controller {
	import net.antonstepanov.frogger.model.ModelLocator;
	/**
	 * @author 'Anton Stepanov'
	 */
	public class FrogActionsController {
		
		private var model:ModelLocator=ModelLocator.getInstance();
		
		private var step:int=64;
		
		
		public function moveUp():void {
			trace("moveUp");
			if (model.currentLineIndex==0) return;
			
			model.posY=model.posY-step;
			model.currentLineIndex--;
			
		}
		
		public function moveDown():void {
			trace("moveDown");
			if (model.currentLineIndex==(model.totalLines-1)) return;
			model.posY=model.posY+step;
			model.currentLineIndex++;
		}
		
		public function moveLeft():void {
			trace("moveLeft");
			model.moveHor(model.posX-step);
		}
		
		public function moveRight():void {
			trace("moveRight");
			model.moveHor(model.posX+step);
		}
		
		public function moveBy(value:Number):void {
			model.posX=model.posX+value;
		}
		
	}
}
