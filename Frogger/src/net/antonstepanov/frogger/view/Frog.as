package net.antonstepanov.frogger.view {
	import com.greensock.TweenMax;
	import flash.events.Event;
	import assets.Assets;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class Frog extends Sprite {
		
		private var container:Sprite;
		private var mcFrog:MovieClip;
		
		private var _state:String="idle";
		private var _direction:String;
		
		public var isMoving:Boolean=false;
		
		public function Frog() {
			
			//create frog container for rotation and positioning
			container=new Sprite();
			addChild(container);
			
			mcFrog=new Assets.game_frog_mc();
			mcFrog.stop();
			mcFrog.x=-mcFrog.width/2;
			mcFrog.y=-mcFrog.height/2;
			container.addChild(mcFrog);
			
		}
		
		//
		//SETTERS AND GETTERS
		//
		
		public function get state() : String {return _state;}
		
		/**
		 * sets frog state and handles frog idle/not idle animation 
		 * 
		 */
		public function set state(value : String) : void {
			_state = value;
			if (_state=="idle"){
				startIdleLoop();
			} else {
				stopIdleLoop();
			}
		}
		
		public function get direction() : String {return _direction;}
		
		/**
		 * sets frog direction 
		 * 
		 * @param value:String enum(up/down/left/right);
		 */
		public function set direction(value : String) : void {
			_direction = value;
			changeDirection();
		}
		
		
		
		/**
		 * Sets frog position from outside and plays jump animation
		 * 
		 */
		public function setPosition(_x:int,_y:int):void {
			TweenMax.killTweensOf(this);
			if (this.y>_y) {
				direction="up";
			}else if (this.y<_y) {
				direction="down";
			}else if (this.x>_x) {
				direction="left";
			}else if (this.x<_x) {
				direction="right";
			} else{
				//return;
			}
			
			isMoving=true;
			playLabel("jump");
			TweenMax.to(this, 0.2, {x:_x,y:_y,onComplete:function():void {isMoving=false;}});
		}
		
		//TODO add drown/disapear animation
		/**
		 * run over by a car death animation 
		 */
		public function runOver():void {
			playLabel("dead");
		}
		
		/**
		 * reset frog if animating 
		 */
		public function reset():void {
			isMoving=false;
			TweenMax.killTweensOf(this);		
		}
		
		
		//
		//PRIVATE FUNCTIONS
		//
		
		/**
		 *starts idle frog animation, called on state swich 
		 * 
		 */
		private function startIdleLoop() : void {
			mcFrog.gotoAndPlay("idle");
			mcFrog.addEventListener(Event.ENTER_FRAME, idleLoopHandler);
		}
		/**
		 * stops idle animation loop
		 */
		private function stopIdleLoop() : void {
			mcFrog.removeEventListener(Event.ENTER_FRAME, idleLoopHandler);
		}

		/**
		 * rotate frog after direction change
		 * 
		 */
		private function changeDirection() : void {
			switch (direction) {
				case "left":
					container.rotation=-90;	
					break;
				case "right":
					container.rotation=90;	
					break;
				case "up":
					container.rotation=0;	
					break;
				case "down":
					container.rotation=180;	
					break;
			}
		}
		
		/**
		 * plays frog mc animation label
		 * 
		 */
		private function playLabel(label:String):void {
			if (state==label) return;
			state=label;
			mcFrog.gotoAndPlay(label);
			addEventListener(Event.ENTER_FRAME,playLabelHandler);
		}
		
		/**
		 * switches frog state to idle when label playback complete
		 * 
		 */
		private function playLabelHandler(event : Event) : void {
			if (mcFrog.currentLabel != state) {
				mcFrog.stop();
				state = "idle";
				removeEventListener(Event.ENTER_FRAME, playLabelHandler);
			}
		}
		
		
		
		//
		//EVENT HANDLERS
		//
		
		/**
		 * loops idle frog animation 
		 */
		private function idleLoopHandler(event : Event) : void {
			if (mcFrog.currentLabel != "idle") {
				mcFrog.gotoAndPlay("idle");
			}
		}
	

		
		
		
	}
}
