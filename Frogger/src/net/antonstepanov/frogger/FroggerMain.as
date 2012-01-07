package net.antonstepanov.frogger {
	import net.antonstepanov.frogger.nonvisual.KeyboardManager;
	import flash.display.Sprite;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class FroggerMain extends Sprite {
		
		var keyManager:KeyboardManager;
		
		public function FroggerMain() {
			init();	
			
		}

		private function init() : void {
			
			keyManager=new KeyboardManager();
			addChild(keyManager);
		}
	}
}
