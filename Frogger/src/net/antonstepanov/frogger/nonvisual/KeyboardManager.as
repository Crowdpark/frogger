package net.antonstepanov.frogger.nonvisual {
	import net.antonstepanov.frogger.model.ModelLocator;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.display.Sprite;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class KeyboardManager extends Sprite {
		
		private var model:ModelLocator=ModelLocator.getInstance();
		
		
		public function KeyboardManager() {
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
		}
		
		//
		//PRIVATE FUNCTIONS
		//
		private function addListeners():void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
		}
		
		private function removeListeners():void {
			
		}
		
		
		
		
		
		private function keyAction(keyPressed:uint):void {
			switch (keyPressed) {
				
				case 13:
					break;
				
				case 37://left arrow
					model.frogAction.moveLeft();
					break;
				
				case 38://up arrow
					model.frogAction.moveUp();
					break;
				
				case 39://right arrow
					model.frogAction.moveRight();
					break;
				
				case 40://down arrow
					model.frogAction.moveDown();
					break;
				
				default:
					trace(this,"Unhandled keycode:",keyPressed);
					break;
			}
			
		}
		
		
		//
		//EVENT HANDLERS
		//
		private function addedHandler(event : Event) : void {
			addListeners();
			
		}
		
		private function removedHandler(event : Event) : void {
			removeListeners();
		}
		
		
		private function keyDownHandler(event : KeyboardEvent) : void {
			keyAction(event.keyCode);
		}
	}
}
