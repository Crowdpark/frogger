package net.antonstepanov.frogger.controller {
	import net.antonstepanov.frogger.model.ModelLocator;
	/**
	 * @author 'Anton Stepanov'
	 */
	public class FrogActionsController {
		
		private var model:ModelLocator=ModelLocator.getInstance();
		
		
		public function moveUp():void {
			trace("up");
			
		}
		
	}
}
