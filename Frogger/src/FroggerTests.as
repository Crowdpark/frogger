package {
	import net.antonstepanov.frogger.FroggerMain;

	import flash.display.Sprite;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class FroggerTests extends Sprite {
		
		var mainApp:FroggerMain;
		
		public function FroggerTests() {
			
			mainApp=new FroggerMain();
			addChild(mainApp);
		}
	}
}
