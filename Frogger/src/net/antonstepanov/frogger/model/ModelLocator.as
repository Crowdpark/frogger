package net.antonstepanov.frogger.model {
	import net.antonstepanov.frogger.controller.FrogActionsController;
	import net.antonstepanov.frogger.events.FroggerEvent;
	import net.antonstepanov.frogger.view.Frog;

	import flash.events.EventDispatcher;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class ModelLocator extends EventDispatcher {
	
		// Single Instance of ModelLocator
		private static var instance : ModelLocator;

		public function ModelLocator(enforcer : SingletonEnforcer) {
			if (instance != null) {
				// throw error
			}
			instance = this;
		}
		
		
		  // Returns the Single Instance
        public static function getInstance():ModelLocator
        {
            if (instance == null)
            {
                instance = new ModelLocator(new SingletonEnforcer);
            }
            return instance;
        }
		
		//
		//PRIVATE VARIABLES
		//
		private var _frogAction : FrogActionsController;
		
		
		
		private var _posX:int;
		private var _posY:int;
		
	
		//
		//PUBLIC VARIABLES
		//
		public var frog:Frog;//frog reference
		
		
		
		//
		//SETTERS AND GETTERS
		//
		
	//CONTROLLERS
		public function get frogAction() : FrogActionsController {
			if (!_frogAction) _frogAction=new FrogActionsController();
			return _frogAction;
		}
		
		
	//FROG SETTINGS	
		public function get posX() : int {
			return _posX;
		}

		public function set posX(posX : int) : void {
			_posX = posX;
			dispatchEvent(new FroggerEvent(FroggerEvent.POSSITION_CHANGE));
		}

		public function get posY() : int {
			return _posY;
		}

		public function set posY(posY : int) : void {
			_posY = posY;
			dispatchEvent(new FroggerEvent(FroggerEvent.POSSITION_CHANGE));
		}
		
	}
}

class SingletonEnforcer{}