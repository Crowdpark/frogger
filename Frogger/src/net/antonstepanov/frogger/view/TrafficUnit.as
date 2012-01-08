package net.antonstepanov.frogger.view {
	import com.greensock.TweenMax;
	import flash.events.Event;
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
		
		
		private var graphicContainer:Sprite;
		private var type:String;
		
		private var direction:int=1;
		
		private var distance:int;
		private var endX:int;
		private var speed:int;
		
		public function TrafficUnit(_type:String,_direction:int) {
			type=_type;
			direction=_direction;
			init();
			drawBG();
		}

		private function drawBG() : void {
			this.graphics.beginFill(0xFF0000,.5);
			this.graphics.drawRect(0, 0, this.width, this.height);
			this.graphics.endFill();
		}
		
		//
		//PUBLIC FUNCTIONS
		//
		public function setPath(_start:int,_distance:int,_speed:Number):void {
			this.x=_start;
			distance=_distance;
			endX=_start+_distance;
			speed=_speed;//px/frame
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function dispose():void {
			
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
					
				default:
					break;
			}
			
			if (direction>0) {
				unit.scaleX=-1;
				unit.x=unit.width
			}
			return unit;
		}
		
		//
		//EVENT HANDLERS
		//
		private function enterFrameHandler(event : Event) : void {
			if (this.x != endX) {
				this.x += speed;
			} else {
				dispose();
			}
		}
	}
}
