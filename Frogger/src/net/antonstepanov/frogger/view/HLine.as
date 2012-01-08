package net.antonstepanov.frogger.view {
	import assets.Assets;

	import flash.display.Sprite;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class HLine extends Sprite {
		
		public static var ROAD : String = "road";
		public static var GRASS : String = "grass";
		public static var WATER : String = "water";
		
		private var bg : Sprite ;
		private var bgType : String;
		
		private var _trafficLine:TrafficLine;

		public function HLine(_bgType : String) {
			bgType = _bgType;
			setBG();
		}

		
		
		//
		//SETTERS AND GETTERS
		//
		public function get trafficLine() : TrafficLine {
			return _trafficLine;
		}

		public function set trafficLine(value : TrafficLine) : void {
			_trafficLine = value;
			addChild(_trafficLine);
		}
		
		//
		//PRIVATE FUNCTIONS
		//
		
		private function setBG() : void {
			switch(bgType) {
				case ROAD:
					bg = new Assets.game_road_mc();
					break;
				case GRASS:
					bg = new Assets.game_grass_mc();
					break;
				case WATER:
					bg = new Assets.game_water_mc();
					break;
			}

			addChild(bg);
		}
	}
}
