package {
	import net.antonstepanov.frogger.FroggerMain;

	import flash.display.Sprite;
		
	
	[ SWF ( backgroundColor = "#1D1D1D", width = "768", height = "768", frameRate = "30" ) ]
	/**
	 * @author 'Anton Stepanov'
	 */
	[Frame(factoryClass="Preloader")]
	public class FroggerApp extends Sprite {
		
		private var mainApp : FroggerMain;

		public function FroggerApp() {
			
			mainApp = new FroggerMain();
			addChild(mainApp);
			
		}
	}
}
