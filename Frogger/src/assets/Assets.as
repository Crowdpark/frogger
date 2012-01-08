package assets {
	/**
	 * @author Anton
	 */
	public class Assets {
		
		[Embed(source="frogger.swf", symbol="game_frog")]
		public static var game_frog_mc:Class;
		
		[Embed(source="frogger.swf", symbol="game_turtle")]
		public static var game_turtle_mc:Class;
		
		
		//bg
		[Embed(source="frogger.swf", symbol="game_road")]
		public static var game_road_mc:Class;
		
		[Embed(source="frogger.swf", symbol="game_grass")]
		public static var game_grass_mc:Class;
		
		[Embed(source="frogger.swf", symbol="game_water")]
		public static var game_water_mc:Class;
		
		
		
		//traffic
		[Embed(source="frogger.swf", symbol="game_carMedium")]
		public static var game_carMedium_mc:Class;
		
		[Embed(source="frogger.swf", symbol="game_carSmall_blue")]
		public static var game_carSmall_blue_mc:Class;
		
		[Embed(source="frogger.swf", symbol="game_carSmall_yellow")]
		public static var game_carSmall_yellow_mc:Class;
		
		[Embed(source="frogger.swf", symbol="game_carLong")]
		public static var game_carLong_mc:Class;
		
	}
}
