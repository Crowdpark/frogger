package net.antonstepanov.frogger.events {
	import flash.events.Event;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class FroggerEvent extends Event {
		
		
		public static var POSSITION_CHANGE:String="frog_position_change";
		
		public function FroggerEvent(type : String) {
			
			super(type);
		}
	}
}
