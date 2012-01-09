package net.antonstepanov.frogger.view {
	import assets.Assets;

	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class TrafficUnit extends Sprite {
		
		public static var CAR_SMALL_BLUE:String="game_carSmall_blue";
		public static var CAR_SMALL_YELLOW:String="game_carSmall_yellow";
		public static var CAR_MEDIUM:String="game_carMedium";
		public static var CAR_LONG:String="game_carLong";
		
		public static var WATER_TURTLE:String="game_turtle";
		public static var WATER_CROC:String="game_croc";
		
		public static var TREE_SMALL:String="game_treeSmall";
		public static var TREE_MEDIUM:String="game_treeMedium";
		public static var TREE_LONG:String="game_treeLong";
		
		private var graphicContainer:Sprite;
		private var type:String;
		
		private var direction:int=1;
		
		public function TrafficUnit(_type:String,_direction:int) {
			type=_type;
			direction=_direction;
			init();
			//drawBG();
		}

		
		//
		//PRIVATE FUNCTIONS
		//
		
		private function init() : void {
			graphicContainer=new Sprite();
			addChild(graphicContainer);
			graphicContainer.addChild(getUnit());
		}
		
		private function getUnit():DisplayObject {
			var unit:DisplayObject;
			
			switch(type) {
				
				case CAR_SMALL_BLUE:
					unit = new Assets.game_carMedium_mc();
					break;
					
				case CAR_SMALL_YELLOW:
					unit = new Assets.game_carSmall_blue_mc();
					break;
					
				case CAR_MEDIUM:
					unit = new Assets.game_carSmall_yellow_mc();
					break;
					
				case CAR_LONG:
					unit = new Assets.game_carLong_mc();
					break;
				
				case TREE_LONG:
					unit = new Assets.game_treeLong_mc();
					break;
					
				case TREE_MEDIUM:
					unit = new Assets.game_treeMedium_mc();
					break;
					
				case TREE_SMALL:
					unit = new Assets.game_treeSmall_mc();
					break;
				
				case WATER_CROC:
					unit = new Assets.game_turtle_mc();
					break;
				
				case WATER_TURTLE:
					unit = new Assets.game_croc_mc();
					break;
				
				default:
					break;
			}
			
			if (direction>0) {
				unit.scaleX=-1;
				unit.x=unit.width;
			}
			return unit;
		}
		
		//temp
		private function drawBG() : void {
			this.graphics.beginFill(0xFF0000,.5);
			this.graphics.drawRect(0, 0, this.width, this.height);
			this.graphics.endFill();
		}
		
	}
}
