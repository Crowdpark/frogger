package {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;

	/**
	 * @author Anton
	 */
	public class Preloader extends MovieClip {
		
		public function Preloader() {
			stop();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		private function init() : void {
			
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			nextFrame();
			
			var mainClass : Class = Class(getDefinitionByName("FroggerApp"));
			if (mainClass) {
				var mainApp : Object = new mainClass();
				addChild(mainApp as DisplayObject);
			}
		}
		
		public function enterFrameHandler(e : Event) : void {
			if (framesLoaded == totalFrames) {
				init();
			} else {
				var percent : Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
				trace("loading.. ",percent,"%");
			}
		}
		
	}
}
