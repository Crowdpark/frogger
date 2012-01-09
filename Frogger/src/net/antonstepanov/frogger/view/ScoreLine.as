package net.antonstepanov.frogger.view {
	import flash.display.DisplayObject;
	import assets.Assets;

	import net.antonstepanov.frogger.model.ModelLocator;

	import flash.display.Sprite;
	/**
	 * @author 'Anton Stepanov'
	 */
	public class ScoreLine extends Sprite implements IFroggerLine {
		
		private var model:ModelLocator=ModelLocator.getInstance();
		private var totalScoreFlowers:int=5;
		private var flowersContainer:Sprite;
		
		
		public function ScoreLine():void {
			init();
		}
		
		
		
		public function hitTestLine(target : DisplayObject) : Boolean {
			var flower : DisplayObject;
			
			for (var i : int = 0;i < flowersContainer.numChildren;i++) {
				flower = flowersContainer.getChildAt(i);
				if (flower.hitTestObject(target)) {
					flower.visible=false;
					return true;
				}
			}
			return false;
		}
		
		private function init():void {
			flowersContainer=new Sprite();
			addChild(flowersContainer);
			
			var flower:Sprite;
			var flowerDistance:int=model.gameSize.x/(totalScoreFlowers+1);
			
			for (var i:int=0; i<totalScoreFlowers; i++ ) {
				flower=new Assets.game_flower_mc();
				flowersContainer.addChild(flower);
				flower.x=flowerDistance*(i+1)-flower.width/2;
			}
			
		}

		
		
	}
}
