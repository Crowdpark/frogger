package net.antonstepanov.frogger.view.screens {
	import net.antonstepanov.frogger.events.FroggerEvent;
	import assets.Assets;

	import net.antonstepanov.frogger.model.ModelLocator;

	import flash.display.Sprite;

	/**
	 * @author Anton
	 */
	public class ScreenManager extends Sprite {
		
		private var model:ModelLocator=ModelLocator.getInstance();
		
		private var _screen:String;
		private var bg:Sprite;
		private var currentScreenContainer:Sprite;
		
		
		
		public function ScreenManager() {
			init();
			
		}
		
		//
		//SETTERS AND GETTERS
		//
		public function get screen() : String {
			return _screen;
		}

		public function set screen(value : String) : void {
			if (_screen!=value){
				_screen = value;
				changeScreen();
			}
		}
		
		
		//
		//PRIVATE FUNCTIONS
		//
		private function init():void {
			
			bg=new Assets.main_bg_mc();
			addChild(bg);
			currentScreenContainer=new Sprite();
			addChild(currentScreenContainer);
		}
		
		
		private function changeScreen():void {
			//while (currentScreenContainer.numChildren>0) {currentScreenContainer.removeChildAt(0);}
			
			switch (screen) {
				case GameStateList.TITLE:
					currentScreenContainer.addChild(new StartScreen());
					break;
				case GameStateList.GAME:
					var game: GameScreen=new GameScreen();
					game.settingsVO=model.settings;
					currentScreenContainer.addChild(game);
					break;
				default:
					trace(this,"UNHANDLED SCREEN STATE:",screen);
					break;
			}
			
			model.dispatchEvent(new FroggerEvent(FroggerEvent.SCREEN_CHANGED));
			
		}
		
		
		
	}
}
