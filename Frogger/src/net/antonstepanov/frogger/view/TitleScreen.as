package net.antonstepanov.frogger.view {
	import assets.Assets;
	import flash.display.Sprite;

	/**
	 * @author Anton
	 */
	public class TitleScreen extends Sprite {
		
		private var titleBG:Sprite;
		
		public function TitleScreen() {
			titleBG=new Assets.title_bg_mc();
			addChild(titleBG);
			
		}
	}
}
