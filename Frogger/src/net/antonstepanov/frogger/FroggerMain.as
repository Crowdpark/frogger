package net.antonstepanov.frogger {
	import net.antonstepanov.frogger.view.GameArea;
	import net.antonstepanov.frogger.nonvisual.KeyboardManager;
	import flash.display.Sprite;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class FroggerMain extends Sprite {
		
		private var keyManager:KeyboardManager;
		private var game:GameArea;
		
		public function FroggerMain() {
			init();	
			
		}

		private function init() : void {
			
			//non visual
			keyManager=new KeyboardManager();
			addChild(keyManager);
			
			//game visual
			game=new GameArea();
			addChild(game);
			
			
		}
	}
}
