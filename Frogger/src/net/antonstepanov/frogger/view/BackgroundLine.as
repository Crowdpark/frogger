package net.antonstepanov.frogger.view {
	import net.antonstepanov.frogger.vo.TrafficLineVO;
	import assets.Assets;

	import flash.display.Sprite;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class BackgroundLine extends Sprite {
		
		private var bg : Sprite ;
		
		private var trafficData:TrafficLineVO;
		
		public function BackgroundLine(_trafficData :TrafficLineVO) {
			trafficData=_trafficData;
			setBG();
		}

		
		
		//
		//SETTERS AND GETTERS
		//
//		public function get trafficLine() : TrafficLine {
//			return _trafficLine;
//		}
//
//		public function set trafficLine(value : TrafficLine) : void {
//			_trafficLine = value;
//			addChild(_trafficLine);
//		}
		
		override public function get height():Number {
			return bg.height;
		}
		
		//
		//PRIVATE FUNCTIONS
		//
		
		private function setBG() : void {
			switch(trafficData.bgType) {
				case TrafficLineVO.ROAD:
					bg = new Assets.game_road_mc();
					break;
				case TrafficLineVO.GRASS:
					bg = new Assets.game_grass_mc();
					break;
				case TrafficLineVO.WATER:
					bg = new Assets.game_water_mc();
					break;
			}

			addChild(bg);
		}
	}
}
