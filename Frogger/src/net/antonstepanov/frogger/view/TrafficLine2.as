package net.antonstepanov.frogger.view {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import net.antonstepanov.frogger.vo.TrafficLineVO;
	import flash.display.Sprite;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class TrafficLine2 extends Sprite {
		
		//settings
		private var _vo:TrafficLineVO;
		
		private var trafficContainer:Sprite;
		private var maxTraficDensity:int; //in pixels
		private var _length:int;
		
		public function TrafficLine2() { 
			trafficContainer=new Sprite();
			addChild(trafficContainer);
			
		}
		
		
		public function get vo() : TrafficLineVO {
			return _vo;
		}

		public function set vo(value : TrafficLineVO) : void {
			_vo = value;
			init();
		}
		
		
		
		public function start():void {
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		
		
		public function stop():void {
			
		}
		
		//
		//PRIVATE FUNCTIONS
		//
		
		private function init():void {
			maxTraficDensity= vo.density*vo.lineLength;
			trace('maxTraficDensity: ' + (maxTraficDensity));
			
			var position:int;
			 
			while (maxTraficDensity > calcTraficDensity()) {
				var trafficUnit:TrafficUnit= new TrafficUnit(TrafficUnit.CAR_LONG,vo.speed);
				//trafficUnit.x=100;
				trafficUnit.setPath(0, vo.lineLength, vo.speed);
				trafficContainer.addChild(trafficUnit);
				
			}
//			var trafficUnit:TrafficUnit= new TrafficUnit(TrafficUnit.CAR_LONG,vo.speed);
//			//trafficUnit.x=100;
//			trafficUnit.setPath(0, vo.lineLength, vo.speed);
//			trafficContainer.addChild(trafficUnit);
			
		}
		
		private function calcTraficDensity():int {
			
			var result:int=0;
			var unit:DisplayObject;
			for (var i:int=0;i<trafficContainer.numChildren;i++) {
				unit=trafficContainer.getChildAt(i);
				result+=unit.width;
			}
			
			trace('result: ' + (result));
			return result;
		}
		
		private function enterFrameHandler(event : Event) : void {
			calcTraficDensity();
		}
		
	}
}
