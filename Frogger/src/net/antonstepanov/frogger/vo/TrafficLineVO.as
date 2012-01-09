package net.antonstepanov.frogger.vo {
	import net.antonstepanov.frogger.view.IFroggerLine;
	import net.antonstepanov.frogger.view.TrafficLine;
	/**
	 * @author 'Anton Stepanov'
	 */
	public class TrafficLineVO {
		
		
		public static var ROAD : String = "road";
		public static var GRASS : String = "grass";
		public static var WATER : String = "water";
		
		public var speed:Number;
		public var lineLength:int=768;
		public var minDistance:uint=100;
		public var maxDistance:uint=150;
		public var unitQty:uint=3;
		//public var density:Number=.3;
		
		
		public var bgType:String;
		public var trafficUnitArray:Array;
	//	public var traficLineInstanse:TrafficLine;
		public var line:IFroggerLine;
		
		//for quick reference
		public function get isTop() : Boolean {
			return (bgType==ROAD);
		}
		
	}
}
