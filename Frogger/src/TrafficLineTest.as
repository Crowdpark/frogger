package {
	import net.antonstepanov.frogger.vo.TrafficLineVO;
	import net.antonstepanov.frogger.view.TrafficLine2;
	import flash.display.Sprite;

		[ SWF ( backgroundColor = "#1D1D1D", width = "768", height = "768", frameRate = "30" ) ]
	/**
	 * @author 'Anton Stepanov'
	 */
	public class TrafficLineTest extends Sprite {
		
		
		private var tline:TrafficLine2;
		
		
		
		public function TrafficLineTest() {
			
			var tvo:TrafficLineVO=new TrafficLineVO();
			tvo.lineLength=768;
			tvo.speed=3;
			tvo.unitQty=4;
			
			
			
			tline=new TrafficLine2();
			tline.vo=tvo;
			addChild(tline);
			
			
			tline.start();
			
		}
	}
}
