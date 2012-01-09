package net.antonstepanov.frogger.controller {
	import net.antonstepanov.frogger.model.ModelLocator;
	/**
	 * @author Anton
	 */
	public class ScoreController {
		
		private var model:ModelLocator=ModelLocator.getInstance();
		
		/**
		 * Check whether user scored. Called when frog is on the ScoreLine
		 * 
		 */
		public function checkScore():void {
			var scorred:Boolean =model.getCurrentLineVO().line.hitTestLine(model.frog);
			
			if (scorred){
				//got to score flower
				model.score+=100;
				//reset to start position
				model.resetFrog();
			}else {
				//missed score flower -> dead
				model.setDead();
			}
			
		}
		
		
	}
}
