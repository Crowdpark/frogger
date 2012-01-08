package net.antonstepanov.frogger.view {
	import net.antonstepanov.utils.MathUtils;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class TrafficLine extends Sprite {
		
		//settings
		private var speed:Number;
		private var lineLength:int=768;
		private var minDistance:uint=100;
		private var maxDistance:uint=300;
		private var unitQty:uint=4;
		
		private var unitTypes:Array=[TrafficUnit.CAR_LONG,TrafficUnit.CAR_MEDIUM,TrafficUnit.CAR_SMALL_BLUE,TrafficUnit.CAR_SMALL_YELLOW];
		
		private var nextUnitDistance:uint;
		
		private var trafficContainer : Sprite ;
		//private var traffic : DisplayObject = new Assets.game_carMedium_mc();
		
		private var trafficArr:Array=[];
		
		public function TrafficLine(_speed:Number,_unitTypes:Array=null) {
			
			speed=_speed;
			if (_unitTypes) unitTypes=_unitTypes;
			trafficContainer = new Sprite();
			addChild(trafficContainer);
			
			init();
			
			configListeners() ;
		}
		
		
		private function init():void {
			var trafficUnit:DisplayObject;
			var nextPos:int=0;
			
			for (var i:int=0;i<unitQty;i++) {
				//trafficUnit= new Assets.game_carMedium_mc();
				trafficUnit= getUnit();
				trafficContainer.addChild(trafficUnit);
				
				
				trafficUnit.x=nextPos;
				nextPos=trafficUnit.x+trafficUnit.width+MathUtils.randomIntegerRange(minDistance, maxDistance);
				trafficArr.push(trafficUnit);
			}
			nextUnitDistance=MathUtils.randomIntegerRange(minDistance, maxDistance)+trafficUnit.width;
		}
		
		
		private function checkTraffic(unit : DisplayObject, index : int) : void {
			if (speed > 0) {
				if (unit.x- unit.width > lineLength) {
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
			
			if (speed>0){
				trafficUnit.x=-trafficUnit.width;
			}else {
				trafficUnit.x=lineLength;
			}
			
			trafficArr.push(trafficUnit);
			
			nextUnitDistance=MathUtils.randomIntegerRange(minDistance, maxDistance)+trafficUnit.width;
			//nextUnitDistance=trafficUnit.x;
		}

		
		private function getUnit():DisplayObject {
			var index:int=MathUtils.randomIntegerRange(0, unitTypes.length);
			return new TrafficUnit(unitTypes[index],speed);;
		}
		
		
		private function configListeners() : void {
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		private function enterFrameHandler(event : Event) : void {
			var trafficUnit:DisplayObject;
			var noTraffic:int=lineLength;//no traffic distance
			
			for (var i:int=0;i<trafficArr.length;i++) {
				trafficUnit=trafficArr[i]; 
				trafficUnit.x+=speed;
				
				if (speed>0){
					if (noTraffic > trafficUnit.x) {
						noTraffic=trafficUnit.x;
					}
				} else {
					if (noTraffic > lineLength-trafficUnit.x) {
						noTraffic=lineLength-trafficUnit.x;
						
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
