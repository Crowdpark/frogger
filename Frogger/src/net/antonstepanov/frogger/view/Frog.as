package net.antonstepanov.frogger.view {
	import assets.Assets;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class Frog extends Sprite {
		
		private var mcFrog:MovieClip;
		
		
		
		public function Frog() {
			mcFrog=new Assets.game_frog_mc();
			addChild(mcFrog);
		}
		
		
	}
}
