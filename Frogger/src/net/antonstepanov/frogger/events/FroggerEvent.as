package net.antonstepanov.frogger.events {
	import flash.events.Event;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class FroggerEvent extends Event {
		
		
		public static var POSSITION_CHANGE:String="frog_position_change_x";
		public static var LINE_CHANGE:String="frog_line_change";
		public static var DEATH:String="frog_death";
		
		
		public static var GAME_STATE_LIVES:String="game_state_lives";
		public static var GAME_STATE_LEVEL:String="game_state_level";
		public static var GAME_STATE_SCORE:String="game_state_score";
		
		public static var SCREEN_CHANGED:String="screen_changed";
		
		public static var GAME_OVER:String="game_over";
		
		public function FroggerEvent(type : String) {
			
			super(type);
		}
	}
}
