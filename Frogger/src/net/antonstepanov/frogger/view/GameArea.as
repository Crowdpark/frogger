package net.antonstepanov.frogger.view {
	import assets.Assets;
	import flash.events.Event;
	import net.antonstepanov.frogger.events.FroggerEvent;
	import net.antonstepanov.frogger.model.ModelLocator;
	import net.antonstepanov.frogger.vo.TrafficLineVO;

	import flash.display.Sprite;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class GameArea extends Sprite {
		
//		private var frog:Frog;
		private var model:ModelLocator=ModelLocator.getInstance();
		
		
//		private var bgLines:Array=[];
		private var linesHeight:int=64;
		private var totalScoreFlowers:int=5;
		private var bgLinesContainer:Sprite;
		private var bottomTrafficContainer:Sprite;
		private var topTrafficContainer:Sprite;
		
		
		private var scoreLine:Sprite;
		
		private var hudContainer:Sprite;
		private var hud:Sprite;
		
		public function GameArea() {
			bgLinesContainer=new Sprite();
			bottomTrafficContainer=new Sprite();
			topTrafficContainer=new Sprite();
			hudContainer=new Sprite();
			
			scoreLine=new Sprite();
			
			model.frog=new Frog();
			initLines();
			initHud();
			
			
			addChild(bgLinesContainer)	;
			addChild(scoreLine);
			addChild(bottomTrafficContainer);
			addChild(model.frog);
			addChild(topTrafficContainer);
			addChild(hudContainer);
			addListeners();
		}
		
		//
		//PRIVATE FUNCTIONS
		//
		private function initHud() : void {
			hud=new Assets.game_hud_mc();
			hudContainer.addChild(hud);
			hudContainer.x=(model.gameSize.x-hudContainer.width);
			hudContainer.y=(model.gameSize.y-hudContainer.height);
			
		}

		private function initLines() : void {
			
			addLine(getLineData(TrafficLineVO.GRASS));
			
			addLine(getLineData(TrafficLineVO.WATER,-2));
			addLine(getLineData(TrafficLineVO.WATER,2));
			addLine(getLineData(TrafficLineVO.WATER,-3));
			addLine(getLineData(TrafficLineVO.WATER,1));
			
			addLine(getLineData(TrafficLineVO.GRASS));
			addLine(getLineData(TrafficLineVO.GRASS));
			
			addLine(getLineData(TrafficLineVO.ROAD,-2));
			addLine(getLineData(TrafficLineVO.ROAD,-3));
			addLine(getLineData(TrafficLineVO.ROAD,3));
			addLine(getLineData(TrafficLineVO.ROAD,2));
			
			addLine(getLineData(TrafficLineVO.GRASS));
			model.currentLineIndex=model.totalLines-1;
			//model.totalLines=model.length;
			
			
			// init score flowers
			var flower:Sprite;
			var flowerDistance:int=model.gameSize.x/(totalScoreFlowers+1);
			for (var i:int=0; i<totalScoreFlowers; i++ ) {
				flower=new Assets.game_flower_mc();
				scoreLine.addChild(flower);
				
				flower.x=flowerDistance*(i+1)-flower.width/2;
			}
			
			//init frog position and direction
			model.posX=model.frog.x=bgLinesContainer.width/2;
			model.posY=model.frog.y=bgLinesContainer.height-linesHeight/2;
			model.frog.direction="up";
			
		}
		
		private function addLine(lineData:TrafficLineVO):int {
			var lineY:int=linesHeight *model.totalLines;
			
			var line:BackgroundLine=new BackgroundLine(lineData);
			line.y=lineY;
			bgLinesContainer.addChild(line);
			if (lineData.traficLineInstanse) {
				if (lineData.isTop) {
					topTrafficContainer.addChild(lineData.traficLineInstanse);
				} else {
					bottomTrafficContainer.addChild(lineData.traficLineInstanse);
				}
				lineData.traficLineInstanse.y = lineY;
			}
			
			return model.lineDataArray.push(lineData);
			
		}
		
		private function getLineData(type:String,speed:Number=0):TrafficLineVO {
			var result:TrafficLineVO=new TrafficLineVO();
			result.bgType=type;
			result.speed=speed;
			//move to settings
			if (result.bgType==TrafficLineVO.GRASS) {
				
			} else if (result.bgType==TrafficLineVO.WATER) {
				
				 result.trafficUnitArray= [	 TrafficUnit.TREE_LONG,
														 TrafficUnit.TREE_MEDIUM,
														 TrafficUnit.TREE_SMALL,
														 TrafficUnit.WATER_CROC,
														 TrafficUnit.WATER_TURTLE];
				result.traficLineInstanse=new TrafficLine(result.speed, result.trafficUnitArray);			
			} else if (result.bgType==TrafficLineVO.ROAD) {
				
				 result.trafficUnitArray= [TrafficUnit.CAR_LONG,
													TrafficUnit.CAR_MEDIUM,
													TrafficUnit.CAR_SMALL_BLUE,
													TrafficUnit.CAR_SMALL_YELLOW];
				result.traficLineInstanse=new TrafficLine(result.speed, result.trafficUnitArray);									
			}
			
			
			
			
			return result;
		}
		
	
		
		//
		//PRIVATE FUNCTIONS
		//
		
		private function addListeners():void {
			model.addEventListener(FroggerEvent.LINE_CHANGE, lineChangeHandler);
			model.addEventListener(FroggerEvent.POSSITION_CHANGE, positionChangeHandler);
			model.addEventListener(FroggerEvent.DEATH, deathHandler);
			model.addEventListener(FroggerEvent.GAME_STATE_LEVEL, levelHandler);
			model.addEventListener(FroggerEvent.GAME_STATE_LIVES, livesHandler);
			model.addEventListener(FroggerEvent.GAME_STATE_SCORE, scoreHandler);
		}

		private function scoreHandler(event : FroggerEvent) : void {
			hud["txt_score"].text=model.score;
		}

		private function livesHandler(event : FroggerEvent) : void {
			hud["txt_lives"].text=model.lives;
		}

		private function levelHandler(event : FroggerEvent) : void {
			hud["txt_level"].text=model.score;
		}

		

		private function updateFrogPosition():void {
			model.frog.setPosition(model.posX, model.posY);
		}
		
		private function startLineFollow():void {
			this.addEventListener(Event.ENTER_FRAME, followLineHandler);
		}
		
		private function stopLineFollow():void {
			this.removeEventListener(Event.ENTER_FRAME, followLineHandler);
		}
		
		//
		//EVENT HANDLERS
		//
		
		private function lineChangeHandler(event : FroggerEvent) : void {
			if (model.getCurrentLineVO().bgType==TrafficLineVO.WATER) {
				startLineFollow();
			}else {
				stopLineFollow();
			}
		}
		private function followLineHandler(event : Event) : void {
			model.frogAction.moveBy(model.getCurrentLineVO().speed);
			model.frog.x+=model.getCurrentLineVO().speed;
			//model.frog.setPosition(model.posX+model.getCurrentLineVO().speed, model.posY);
			
		}
		private function deathHandler(event : FroggerEvent) : void {
			model.frog.runOver();
		}
		
		private function positionChangeHandler(event : FroggerEvent) : void {
			updateFrogPosition();
		}
		
	}
}
