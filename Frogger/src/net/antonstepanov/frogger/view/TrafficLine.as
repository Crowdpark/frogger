package net.antonstepanov.frogger.view {
	import net.antonstepanov.frogger.vo.TrafficLineVO;
	import net.antonstepanov.utils.MathUtils;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class TrafficLine extends Sprite implements IFroggerLine {
		
		private var trafficContainer : Sprite ;
		private var trafficArr:Array=[];
		private var nextUnitDistance:uint;
		
		private var _vo:TrafficLineVO;
		
		public function TrafficLine(trafficData:TrafficLineVO) {
			
			trafficContainer = new Sprite();
			addChild(trafficContainer);
			
			configListeners() ;
			vo=trafficData;
		}
		
		//
		//SETTERS  AND GETTERS
		//
		
		public function get vo() : TrafficLineVO {
			return _vo;
		}

		public function set vo(value : TrafficLineVO) : void {
			_vo = value;
			setupTraffic();
		}
		
		
		//
		//PUBLIC FUNCTIONS
		//
		/**
		 * Interface function -> returns hit test of line traffic units
		 * 
		 */
		public function hitTestLine(target : DisplayObject) : Boolean {
			var trafficUnit : DisplayObject;
			
			for (var i : int = 0;i < trafficArr.length;i++) {
				trafficUnit = trafficArr[i];
				if (trafficUnit.hitTestObject(target)) {
					return true;
				}
			}
			return false;
		}
		
		
		//
		//PRIVATE FUNCTIONS
		//
		private function setupTraffic():void {
			while (trafficContainer.numChildren>0) {trafficContainer.removeChildAt(0);}
			
			var trafficUnit:DisplayObject;
			var nextPos:int=0;
			
			for (var i:int=0;i<vo.unitQty;i++) {
				trafficUnit= getUnit();
				trafficContainer.addChild(trafficUnit);
				
				trafficUnit.x=nextPos;
				nextPos=trafficUnit.x+trafficUnit.width+MathUtils.randomIntegerRange(vo.minDistance, vo.maxDistance);
				trafficArr.push(trafficUnit);
			}
			nextUnitDistance=MathUtils.randomIntegerRange(vo.minDistance, vo.maxDistance)+trafficUnit.width;
		}
		
		
		private function checkTraffic(unit : DisplayObject, index : int) : void {
			if (vo.speed > 0) {
				if (unit.x- unit.width > vo.lineLength) {
					trafficContainer.removeChild(unit);
					trafficArr.splice(index, 1);
				}
			} else {
				if ((unit.x + unit.width) < 0) {
					trafficContainer.removeChild(unit);
					trafficArr.splice(index, 1);
				}
			}
		}

		private function addUnit() : void {
			var trafficUnit:DisplayObject= getUnit();
			trafficContainer.addChild(trafficUnit);
			
			if (vo.speed>0){
				trafficUnit.x=-trafficUnit.width;
			}else {
				trafficUnit.x=vo.lineLength;
			}
			
			trafficArr.push(trafficUnit);
			
			nextUnitDistance=MathUtils.randomIntegerRange(vo.minDistance, vo.maxDistance)+trafficUnit.width;
			//nextUnitDistance=trafficUnit.x;
		}
		
		private function getUnit():DisplayObject {
			
			var index:int=MathUtils.randomIntegerRange(0, vo.trafficUnitArray.length);
			return new TrafficUnit(vo.trafficUnitArray[index],vo.speed);;
		}
		
		
		private function configListeners() : void {
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		private function enterFrameHandler(event : Event) : void {
			//trace('event: ' + (event));
			var trafficUnit : DisplayObject;
			var noTraffic:int=vo.lineLength;//no traffic distance
			
			for (var i:int=0;i<trafficArr.length;i++) {
				trafficUnit=trafficArr[i]; 
				trafficUnit.x+=vo.speed;
				
				if (vo.speed>0){
					if (noTraffic > trafficUnit.x) {
						noTraffic=trafficUnit.x;
					}
				} else {
					if (noTraffic > vo.lineLength-trafficUnit.x) {
						noTraffic=vo.lineLength-trafficUnit.x;
						
					}
				}
				checkTraffic(trafficUnit,i);
			}
			//trace('noTraffic: ' + (noTraffic),nextUnitDistance);
			if (nextUnitDistance<noTraffic) {
				addUnit();	
			}
		}

		

		

		
	}
}
