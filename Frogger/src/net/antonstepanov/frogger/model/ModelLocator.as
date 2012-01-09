package net.antonstepanov.frogger.model {
	import flash.geom.Point;
	import net.antonstepanov.frogger.controller.FrogActionsController;
	import net.antonstepanov.frogger.controller.FrogDeathController;
	import net.antonstepanov.frogger.events.FroggerEvent;
	import net.antonstepanov.frogger.view.Frog;
	import net.antonstepanov.frogger.vo.TrafficLineVO;

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
		private var _frogDeath : FrogDeathController;
		
		private var _currentLineIndex:int;
		
		private var _posX:int;
		private var _posY:int;
		
		private var _isDead:Boolean;
		
		private var _gameSize:Point=new Point(768,768);
		
		private var _score:int=0;
		private var _lives:int=3;
		private var _level:int=1;
		
		//
		//PUBLIC VARIABLES
		//
		public var frog:Frog;//frog reference
		
		public var lineDataArray:Array=[];
		
		
		
		//
		//SETTERS AND GETTERS
		//
		
		
		
		
	//CONTROLLERS
		public function get frogAction() : FrogActionsController {
			if (!_frogAction) _frogAction=new FrogActionsController();
			return _frogAction;
		}
		
		public function get frogDeath() : FrogDeathController {
			if (!_frogDeath) _frogDeath=new FrogDeathController();
			return _frogDeath;
		}	
		
	//GAME SETTINGS	
		public function get gameSize() : Point {
			return _gameSize;
		}

		public function set gameSize(value : Point) : void {
			_gameSize = value;
		}
	
		
	//FROG SETTINGS	
		public function get posX() : int {
			return _posX;
		}

		public function set posX(value : int) : void {
			_posX = value;
			
		}

		public function get posY() : int {
			return _posY;
		}

		public function set posY(value : int) : void {
			_posY = value;
			dispatchEvent(new FroggerEvent(FroggerEvent.POSSITION_CHANGE));
		}


		public function get currentLineIndex() : int {
			return _currentLineIndex;
		}

		public function set currentLineIndex(value : int) : void {
			_currentLineIndex = value;
			dispatchEvent(new FroggerEvent(FroggerEvent.LINE_CHANGE));
		}

		public function get totalLines() : int {
			return lineDataArray.length;
		}
		
		public function get isDead() : Boolean {
			return _isDead;
		}

		public function set isDead(value : Boolean) : void {
			if (_isDead && _isDead!=value) lives--;
			_isDead = value;
			if (_isDead) dispatchEvent(new FroggerEvent(FroggerEvent.DEATH));
			
		}
		
		//GAME STATE
		public function get score() : int {
			return _score;
		}

		public function set score(score : int) : void {
			_score = score;
			dispatchEvent(new FroggerEvent(FroggerEvent.GAME_STATE_SCORE));
		}
		
		public function get lives() : int {
			return _lives;
		}

		public function set lives(lives : int) : void {
			_lives = lives;
			dispatchEvent(new FroggerEvent(FroggerEvent.GAME_STATE_LIVES));
		}
		
		public function get level() : int {
			return _level;
		}

		public function set level(level : int) : void {
			_level = level;
			dispatchEvent(new FroggerEvent(FroggerEvent.GAME_STATE_LEVEL));
		}
		
		//
		//PUBLIC FUNCTIONS
		//
		
		public function moveHor(newX:int):void {
			posX=newX;
			dispatchEvent(new FroggerEvent(FroggerEvent.POSSITION_CHANGE));
		}
		
		public function getCurrentLineVO():TrafficLineVO {
			return lineDataArray[currentLineIndex] as TrafficLineVO;
		}

	


	

	

		
		
	}
}

class SingletonEnforcer{}