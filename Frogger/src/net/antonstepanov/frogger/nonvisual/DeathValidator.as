package net.antonstepanov.frogger.nonvisual {
	import net.antonstepanov.frogger.view.screens.GameStateList;
	import flash.events.Event;
	import net.antonstepanov.frogger.events.FroggerEvent;
	import net.antonstepanov.frogger.model.ModelLocator;
	import net.antonstepanov.frogger.vo.TrafficLineVO;

	import flash.display.Sprite;
	/**
	 * @author 'Anton Stepanov'
	 */
	public class DeathValidator extends Sprite{
		
		private var model:ModelLocator=ModelLocator.getInstance();
		
		
		public function DeathValidator() {
			configListeners();
		}

		private function configListeners() : void {
			model.addEventListener(FroggerEvent.SCREEN_CHANGED, screenChangeHandler);
		}
		
		private function removeListeners():void {
			model.removeEventListener(FroggerEvent.SCREEN_CHANGED, screenChangeHandler);
		}
		
		//
		//EVENT HANDLERS
		//
		
		private function screenChangeHandler(event : FroggerEvent) : void {
			if (model.currentScreen==GameStateList.GAME) {
				model.addEventListener(FroggerEvent.LINE_CHANGE, lineChangeHandler);
				model.addEventListener(FroggerEvent.POSSITION_CHANGE, lineChangeHandler);
				this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			} else {
				model.removeEventListener(FroggerEvent.LINE_CHANGE, lineChangeHandler);
				model.removeEventListener(FroggerEvent.POSSITION_CHANGE, lineChangeHandler);
				this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}

		private function enterFrameHandler(event : Event) : void {
			
			if (model.isDead) return;
			var lineData : TrafficLineVO = model.getCurrentLineVO();
			
			switch( lineData.bgType) {
				
				case TrafficLineVO.ROAD:
					checkRoadTraffic();
					break;
					
				case TrafficLineVO.WATER:
					checkBoundaries();
					checkDrowning();
					break;
					
				case TrafficLineVO.GRASS:
				
					break;
			}
			//trace('lineData.bgType: ' + (lineData.bgType));
		}

		

		private function lineChangeHandler(event : FroggerEvent) : void {
			//trace('event: ', model.currentLineIndex);
			
			var lineData: TrafficLineVO = model.getCurrentLineVO();
			
//			if (checkBoundaries()) {
//				setDead();
//				return;
//			}
			switch( lineData.bgType) {
				
				case TrafficLineVO.ROAD:
					checkRoadTraffic();
					break;
					
				case TrafficLineVO.WATER:
					//checkRoadTraffic();
					//checkBoundaries();
					checkDrowning();
					break;
				
				case TrafficLineVO.GRASS:
				
					break;
			}
			
		}
		
		private function checkBoundaries():Boolean {
			if (model.posX<0  || (model.posX +model.frog.width)>model.gameSize.x
			|| model.posY<0  || (model.posY)>model.gameSize.y) {
//				trace(model.posX<0,model.posX);
//				trace((model.posX +model.frog.width)<0,model.posX);
//				trace(model.posX<0,model.posX);
//				trace(model.posX<0,model.posX);
//				trace ('checkBoundaries: DEAD');
				model.setDead();
				return true;
			} else {
				//trace ('checkBoundaries: ALIVE');
				return false;
			}
		}
		
		private function checkDrowning() : void {
			
			var lineData: TrafficLineVO = model.getCurrentLineVO();
			if (!lineData.line) return;
			
			if (!lineData.line.hitTestLine(model.frog)) {
				model.setDead();
			}
			
		}
		
		
		private function checkRoadTraffic():void {
			var lineData: TrafficLineVO = model.getCurrentLineVO();
			if (!lineData.line) return;
			
			if(lineData.line.hitTestLine(model.frog)) {
				model.setDead();
			}
		}
		
		
	}
}
