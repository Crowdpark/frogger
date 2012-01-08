package net.antonstepanov.frogger.view {
	import net.antonstepanov.utils.MathUtils;
	import assets.Assets;

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
		private var maxDistance:uint=150;
		private var unitQty:uint=4;
		
		private var unitTypes:Array;
		
		private var nextUnitDistance:uint;
		
		private var trafficContainer : Sprite ;
		//private var traffic : DisplayObject = new Assets.game_carMedium_mc();
		
		private var trafficArr:Array=[];
		
		public function TrafficLine(_speed:Number,unitTypes:Array=null) {
			
			speed=_speed;
			
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
				trafficUnit= new TrafficUnit(TrafficUnit.CAR_LONG,speed);
				trafficContainer.addChild(trafficUnit);
				
				
				trafficUnit.x=nextPos;
				nextPos=trafficUnit.x+trafficUnit.width+MathUtils.randomIntegerRange(minDistance, maxDistance);
				trafficArr.push(trafficUnit);
			}
			
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
			var trafficUnit:DisplayObject= new TrafficUnit(TrafficUnit.CAR_LONG,speed);
			trafficContainer.addChild(trafficUnit);
			
			//trafficUnit.x=-trafficUnit.width;
			trafficUnit.x=lineLength;
			
			trafficArr.push(trafficUnit);
			
			nextUnitDistance=MathUtils.randomIntegerRange(minDistance, maxDistance)+trafficUnit.width;
			//nextUnitDistance=trafficUnit.x;
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
			trace('noTraffic: ' + (noTraffic),nextUnitDistance);
			if (nextUnitDistance<noTraffic) {
				addUnit();	
			}
		}

		
	}
}
