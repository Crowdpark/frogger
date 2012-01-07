package net.antonstepanov.frogger.view {
	import net.antonstepanov.frogger.events.FroggerEvent;
	import net.antonstepanov.frogger.model.ModelLocator;

	import flash.display.Sprite;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class GameArea extends Sprite {
		
		private var frog:Frog;
		private var model:ModelLocator=ModelLocator.getInstance();
		
		
		public function GameArea() {
			
			frog=new Frog();
			addChild(frog);
			
			addListeners();
		}
		
		//
		//PRIVATE FUNCTIONS
		//
		
		private function addListeners():void {
			model.addEventListener(FroggerEvent.POSSITION_CHANGE, positionChangeHandler);
		}
		
		
		private function updateFrogPosition():void {
			//frog.x=model.posX;
			//frog.y=model.posY;
			frog.setPosition(model.posX, model.posY);
		}
		
		//
		//EVENT HANDLERS
		//
		
		private function positionChangeHandler(event : FroggerEvent) : void {
			updateFrogPosition();
		}
		
	}
}
