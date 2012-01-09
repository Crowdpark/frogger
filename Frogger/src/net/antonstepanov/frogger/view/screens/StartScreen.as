package net.antonstepanov.frogger.view.screens {
	import flash.events.Event;
	import assets.Assets;

	import net.antonstepanov.frogger.model.ModelLocator;

	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author Anton
	 */
	public class StartScreen extends Sprite {
		
		private var model:ModelLocator=ModelLocator.getInstance();
		
		private var logo:Sprite;
		//logo position from .fla
		private var logoX:int=40;
		private var logoY:int=85;
		
		private var startBtn:MovieClip;
		private var startBtnX:int=452;
		private var startBtnY:int=545;
		
		private var scoresBtn:MovieClip;
		private var scoresBtnX:int=458;
		private var scoresBtnY:int=661;
		
		public function StartScreen() {
			
			init();
			configListeners();
		}
		
		
		//
		//PRIVATE FUNCTIONS
		//
		private function init():void {
			addChild(new Assets.title_bg_mc());
			
			logo = new Assets.title_logo_mc();
			logo.y=-logo.height;
			logo.x=logoX;
			addChild(logo);
			TweenMax.to(logo, .3, {y:logoY,ease:Strong.easeInOut});
			
			
			startBtn=new Assets.button_start_mc();
			startBtn.stop();
			startBtn.x=1000;
			startBtn.y=startBtnY;
			startBtn.buttonMode=true;
			
			addChild(startBtn);
			
			TweenMax.to(startBtn, .4, {x:startBtnX,ease:Strong.easeInOut});
						
			
			scoresBtn=new Assets.button_scores_mc();
			scoresBtn.stop();
			scoresBtn.x=1000;
			scoresBtn.y=scoresBtnY;
			scoresBtn.buttonMode=true;
			addChild(scoresBtn);
			TweenMax.to(scoresBtn, .5, {x:scoresBtnX,ease:Strong.easeInOut});
		}
		
		private function configListeners():void {
			
			startBtn.addEventListener(MouseEvent.CLICK, startClickHandler);
			scoresBtn.addEventListener(MouseEvent.CLICK, scoresClickHandler);
			startBtn.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
		}

		private function removeListeners():void {
			startBtn.removeEventListener(MouseEvent.CLICK, startClickHandler);
			startBtn.removeEventListener(MouseEvent.CLICK, scoresClickHandler);
			startBtn.removeEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
		}
		
		//
		//EVENT HANDLERS
		//
		private function startClickHandler(event : MouseEvent) : void {
			model.screenManager.screen=GameStateList.GAME;
		}
		
		private function scoresClickHandler(event : MouseEvent) : void {
			model.screenManager.screen=GameStateList.SCORES;
		}
		
		private function removedHandler(event : Event) : void {
			removeListeners();
		}
		
	}
}
