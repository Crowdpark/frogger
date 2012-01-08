package {
	import net.antonstepanov.frogger.FroggerMain;

	import flash.display.Sprite;
		
	
	[ SWF ( backgroundColor = "#1D1D1D", width = "768", height = "768", frameRate = "30" ) ]
	
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
