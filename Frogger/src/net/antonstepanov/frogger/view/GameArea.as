package net.antonstepanov.frogger.view {
	import net.antonstepanov.frogger.events.FroggerEvent;
	import net.antonstepanov.frogger.model.ModelLocator;

	import flash.display.Sprite;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class GameArea extends Sprite {
		
//		private var frog:Frog;
		private var model:ModelLocator=ModelLocator.getInstance();
		
		private var linesContainer:Sprite;
		
		public function GameArea() {
			
			
			model.frog=new Frog();
			initLines();
			
			addChild(model.frog);
			addListeners();
		}

		private function initLines() : void {
			linesContainer=new Sprite();
			addChild(linesContainer)	;
			
			addLine(HLine.GRASS);
			addLine(HLine.WATER);
			addLine(HLine.WATER);
			addLine(HLine.WATER);
			addLine(HLine.WATER);
			addLine(HLine.GRASS);
			addLine(HLine.GRASS);
			addLine(HLine.ROAD);
			addLine(HLine.ROAD);
			addLine(HLine.ROAD);
			addLine(HLine.ROAD);
			addLine(HLine.GRASS);
			//addLine(HLine.GRASS);
			
			
			//init frog position and direction
			model.posX=model.frog.x=linesContainer.width/2;
			model.posY=model.frog.y=linesContainer.height-32;
			model.frog.direction="up";
		}
		
		private function addLine(lineType:String):void {
			var line:HLine=new HLine(lineType);
			line.y=linesContainer.height;
			linesContainer.addChild(line);
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
			model.frog.setPosition(model.posX, model.posY);
		}
		
		//
		//EVENT HANDLERS
		//
		
		private function positionChangeHandler(event : FroggerEvent) : void {
			updateFrogPosition();
		}
		
	}
}
