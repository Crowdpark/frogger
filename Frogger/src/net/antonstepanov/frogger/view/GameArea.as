package net.antonstepanov.frogger.view {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
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
		
		private var bgLinesContainer:Sprite;
		private var bottomTrafficContainer:Sprite;
		private var topTrafficContainer:Sprite;
		private var hudContainer:Sprite;
		
		private var hud:Sprite;
		
		private var deathTimer:Timer;
		
		
		public function GameArea() {
			bgLinesContainer=new Sprite();
			bottomTrafficContainer=new Sprite();
			topTrafficContainer=new Sprite();
			hudContainer=new Sprite();
			
//			scoreLine=new ScoreLine();
			
			model.frog=new Frog();
			initLines();
			initHud();
			
			
			addChild(bgLinesContainer)	;
//			addChild(scoreLine);
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
			
			model.score=0;
			model.lives=3;
			model.level=1;
			
		}

		private function initLines() : void {
//			
//			var firstLine:TrafficLineVO=getLineData(TrafficLineVO.GRASS);
//			//firstLine.line=scoreLine;
//			addLine(firstLine);
//			
//			addLine(getLineData(TrafficLineVO.ROAD,-2));
//			addLine(getLineData(TrafficLineVO.ROAD,-3));
//			addLine(getLineData(TrafficLineVO.ROAD,3));
//			addLine(getLineData(TrafficLineVO.ROAD,2));
//			
//			addLine(getLineData(TrafficLineVO.GRASS));
//			addLine(getLineData(TrafficLineVO.GRASS));
//			
//			
//			addLine(getLineData(TrafficLineVO.WATER,-2));
//			addLine(getLineData(TrafficLineVO.WATER,2));
//			addLine(getLineData(TrafficLineVO.WATER,-3));
//			addLine(getLineData(TrafficLineVO.WATER,1));
//			addLine(getLineData(TrafficLineVO.GRASS));
//			model.currentLineIndex=model.totalLines-1;
//			//model.totalLines=model.length;
//			
//			model.resetFrog();
			//init frog position and direction
//			model.posX=model.frog.x=bgLinesContainer.width/2;
//			model.posY=model.frog.y=bgLinesContainer.height-linesHeight/2;
//			model.frog.direction="up";
			
		}
		
		private function addLine(lineData:TrafficLineVO):int {
//			var lineY:int=linesHeight *model.totalLines;
//			
//			var line:BackgroundLine=new BackgroundLine(lineData);
//			line.y=lineY;
//			bgLinesContainer.addChild(line);
//			if (lineData.line) {
//				if (lineData.isTop) {
//					topTrafficContainer.addChild(lineData.traficLineInstanse);
//				} else {
//					bottomTrafficContainer.addChild(lineData.traficLineInstanse);
//				}
//				lineData.line.y = lineY;
//			}
			
			return model.lineDataArray.push(lineData);
			
		}
		
//		private function getLineData(type:String,speed:Number=0):TrafficLineVO {
//			var result:TrafficLineVO=new TrafficLineVO();
//			result.bgType=type;
//			result.speed=speed;
//			//move to settings
//			if (result.bgType==TrafficLineVO.GRASS) {
//				
//			} else if (result.bgType==TrafficLineVO.WATER) {
//				
//				 result.trafficUnitArray= [	 TrafficUnit.TREE_LONG,
//														 TrafficUnit.TREE_MEDIUM,
//														 TrafficUnit.TREE_SMALL,
//														 TrafficUnit.WATER_CROC,
//														 TrafficUnit.WATER_TURTLE];
//				result.traficLineInstanse=new TrafficLine(result.speed, result.trafficUnitArray);			
//			} else if (result.bgType==TrafficLineVO.ROAD) {
//				
//				 result.trafficUnitArray= [TrafficUnit.CAR_LONG,
//													TrafficUnit.CAR_MEDIUM,
//													TrafficUnit.CAR_SMALL_BLUE,
//													TrafficUnit.CAR_SMALL_YELLOW];
//				result.traficLineInstanse=new TrafficLine(result.speed, result.trafficUnitArray);									
//			}
//			
//			
//			
//			
//			return result;
//		}
		
	
		
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
			
			//model.addEventListener(FroggerEvent.GAME_OVER, gameOverHandler);
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
		
		private function reset():void {
			//model.isDead=false;
			model.resetFrog();
			model.isDead=false;
			//init frog position and direction
			
		}
		

		private function updateFrogPosition():void {
			//trace("updateFrogPosition",model.posX, model.posY);
			model.frog.setPosition(model.posX, model.posY);
		}
		
		private function startLineFollow():void {
			this.addEventListener(Event.ENTER_FRAME, followLineHandler);
		}
		
		private function stopLineFollow():void {
			this.removeEventListener(Event.ENTER_FRAME, followLineHandler);
		}
		
		private function startDeathTimer():void {
			if (deathTimer) return;
				deathTimer=new Timer(1000,1);
				deathTimer.addEventListener(TimerEvent.TIMER_COMPLETE, deathTimerCompleteHandler);
				deathTimer.start();
			
		}
		
		private function disposeDeathTimer():void {
			deathTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, deathTimerCompleteHandler);
			deathTimer=null;
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
			
			if (model.getCurrentLineVO().line is ScoreLine) {
				model.scoreController.checkScore();
			}
			
		}
		
		private function followLineHandler(event : Event) : void {
			model.frogAction.moveBy(model.getCurrentLineVO().speed);
			model.frog.x+=model.getCurrentLineVO().speed;
			//model.frog.setPosition(model.posX+model.getCurrentLineVO().speed, model.posY);
			
		}
		
		private function deathHandler(event : FroggerEvent) : void {
			
			model.frog.runOver();
			startDeathTimer();
			
		}

		private function deathTimerCompleteHandler(event : TimerEvent) : void {
			disposeDeathTimer();
			reset();
		}
		
		private function positionChangeHandler(event : FroggerEvent) : void {
			updateFrogPosition();
		}
		
	}
}
