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
		
		
		private var bgLines:Array=[];
		private var linesHeight:int=64;
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
			
			var waterTraffic:Array= [TrafficUnit.TREE_LONG,TrafficUnit.TREE_MEDIUM,TrafficUnit.TREE_SMALL,TrafficUnit.WATER_CROC,TrafficUnit.WATER_TURTLE];
			addLine(HLine.GRASS);
			
			addLine(HLine.WATER,new TrafficLine(-2,waterTraffic));
			addLine(HLine.WATER,new TrafficLine(2,waterTraffic));
			addLine(HLine.WATER,new TrafficLine(-3,waterTraffic));
			addLine(HLine.WATER,new TrafficLine(1,waterTraffic));
			
			addLine(HLine.GRASS);
			addLine(HLine.GRASS);
			//addLine(HLine.ROAD,new TrafficLine(-5));
			//addLine(HLine.ROAD,new TrafficLine(-7));
		//	addLine(HLine.ROAD,new TrafficLine(5));
		
			var roadTrafic:Array= [TrafficUnit.CAR_LONG,TrafficUnit.CAR_MEDIUM,TrafficUnit.CAR_SMALL_BLUE,TrafficUnit.CAR_SMALL_YELLOW];
			addLine(HLine.ROAD,new TrafficLine(-2,roadTrafic));
			addLine(HLine.ROAD,new TrafficLine(-3,roadTrafic));
			addLine(HLine.ROAD,new TrafficLine(3,roadTrafic));
			addLine(HLine.ROAD,new TrafficLine(2,roadTrafic));
			
			addLine(HLine.GRASS);
			//addLine(HLine.GRASS);
			
			
			//init frog position and direction
			model.posX=model.frog.x=linesContainer.width/2;
			model.posY=model.frog.y=linesContainer.height-32;
			model.frog.direction="up";
		}
		
		private function addLine(lineType:String,_trafficLine:TrafficLine=null):void {
			
			var line:HLine=new HLine(lineType);
			line.y=linesHeight *bgLines.length;
			if (_trafficLine) line.trafficLine=_trafficLine;
			linesContainer.addChild(line);
			
			bgLines.push(line);
			
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
