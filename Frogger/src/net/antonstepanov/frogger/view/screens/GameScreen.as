package net.antonstepanov.frogger.view.screens {
	import flash.display.DisplayObject;
	import net.antonstepanov.frogger.view.TrafficLine;
	import assets.Assets;

	import net.antonstepanov.frogger.events.FroggerEvent;
	import net.antonstepanov.frogger.model.ModelLocator;
	import net.antonstepanov.frogger.view.BackgroundLine;
	import net.antonstepanov.frogger.view.Frog;
	import net.antonstepanov.frogger.view.ScoreLine;
	import net.antonstepanov.frogger.vo.GameSettingsVO;
	import net.antonstepanov.frogger.vo.TrafficLineVO;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Anton
	 */
	public class GameScreen extends Sprite {
		
		private var model:ModelLocator=ModelLocator.getInstance();
		
		private var _settingsVO:GameSettingsVO;
		
		private var bgLinesContainer:Sprite;
		private var bottomTrafficContainer:Sprite;
		private var topTrafficContainer:Sprite;
		private var hudContainer:Sprite;
		private var scoreLine:ScoreLine;
		private var hud:Sprite;
		
		private var deathTimer:Timer;
		
		public function GameScreen() {
			init();
			configListeners();
			initHud();
		}
		
		//
		//SETTERS AND GETTERS
		//
		public function get settingsVO() : GameSettingsVO {
			return _settingsVO;
		}

		public function set settingsVO(value : GameSettingsVO) : void {
			_settingsVO = value;
			setupLevel();
		}
		
		
		//
		//PRIVATE FUNCTIONS
		//
		private function init():void {
			bgLinesContainer=new Sprite();
			bottomTrafficContainer=new Sprite();
			topTrafficContainer=new Sprite();
			hudContainer=new Sprite();
			scoreLine=new ScoreLine();
			
			model.frog=new Frog();
			
			addChild(bgLinesContainer)	;
			addChild(scoreLine);
			addChild(bottomTrafficContainer);
			addChild(model.frog);
			addChild(topTrafficContainer);
			addChild(hudContainer);
		}
		
		private function configListeners() : void {
			model.addEventListener(FroggerEvent.LINE_CHANGE, lineChangeHandler);
			model.addEventListener(FroggerEvent.POSSITION_CHANGE, positionChangeHandler);
			model.addEventListener(FroggerEvent.DEATH, deathHandler);
			
			//hud events
			model.addEventListener(FroggerEvent.GAME_STATE_LEVEL, levelHandler);
			model.addEventListener(FroggerEvent.GAME_STATE_LIVES, livesHandler);
			model.addEventListener(FroggerEvent.GAME_STATE_SCORE, scoreHandler);
		}
		
		private function initHud() : void {
			hud=new Assets.game_hud_mc();
			hudContainer.addChild(hud);
			hudContainer.x=(model.gameSize.x-hudContainer.width);
			hudContainer.y=(model.gameSize.y-hudContainer.height);
			
			model.score=0;
			model.lives=3;
			model.level=1;
			
		}
		
		private function setupLevel():void {
			var line:TrafficLineVO;
			for (var i:int=0;i<settingsVO.linesArray.length;i++) {
				line=settingsVO.linesArray[i];
				addLine(line);
			}
			
			//set first line as score line
			settingsVO.linesArray[0].line=scoreLine;
			
			model.currentLineIndex=model.totalLines-1;
			model.resetFrog();
		}

		
		private function addLine(lineData:TrafficLineVO):int {
			var lineY:int=model.lineHeight *model.totalLines;
			
			var line:BackgroundLine=new BackgroundLine(lineData);
			line.y=lineY;
			bgLinesContainer.addChild(line);
			
			
			if (lineData.trafficUnitArray) {
				lineData.line=new TrafficLine(lineData);	
				var trafficDO:DisplayObject= lineData.line as DisplayObject;
				
				if (lineData.isTop) {
					topTrafficContainer.addChild(trafficDO);
				} else {
					bottomTrafficContainer.addChild(trafficDO);
				}
				
				
			}
			
			
			
			if (trafficDO) {
				trafficDO.y = lineY;
			}
			
			return model.lineDataArray.push(lineData);
			
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
		
		private function reset():void {
			model.resetFrog();
			model.isDead=false;
		}
		
		//
		//EVENT HANDLERS
		//
		private function positionChangeHandler(event : FroggerEvent) : void {
			updateFrogPosition();
		}
		
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
			
		}
		
		private function deathHandler(event : FroggerEvent) : void {
			model.frog.runOver();
			startDeathTimer();
		}
		
		private function deathTimerCompleteHandler(event : TimerEvent) : void {
			disposeDeathTimer();
			reset();
		}
	}
}
