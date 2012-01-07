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
		
		public function Frog() {
		
			mcFrog=new Assets.game_frog_mc();
			
			mcFrog.stop();
			
			container=new Sprite();
			addChild(container);
			mcFrog.x=-mcFrog.width/2;
			mcFrog.y=-mcFrog.height/2;
			container.addChild(mcFrog);
			
			addListeners();
		}
		
		//
		//SETTERS AND GETTERS
		//
		
		public function get state() : String {
			return _state;
		}

		public function set state(value : String) : void {
			_state = value;
			if (_state=="idle"){
				startIdleLoop();
			} else {
				stopIdleLoop();
			}
		}
		
		public function get direction() : String {
			return _direction;
		}

		public function set direction(value : String) : void {
			_direction = value;
			changeDirection();
		}
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
		
		public function setPosition(_x:int,_y:int):void {
			TweenMax.killTweensOf(this);
			if (this.x>_x) {
				jumpAnimation("left");
			}else if (this.x<_x) {
				jumpAnimation("right");
			} else {
				//return;
			}
			
			
			if (this.y>_y) {
				jumpAnimation("up");
			}else if (this.y<_y) {
				jumpAnimation("down");
			}else {
				//return;
			}
			TweenMax.to(this, 0.2, {x:_x,y:_y});
		}
		
		//
		//PRIVATE FUNCTIONS
		//
		private function startIdleLoop() : void {
			mcFrog.gotoAndPlay("idle");
			mcFrog.addEventListener(Event.ENTER_FRAME, idleLoopHandler);
		}
		
		private function stopIdleLoop() : void {
			mcFrog.removeEventListener(Event.ENTER_FRAME, idleLoopHandler);
		}

		
		
		
		
		
		private function addListeners():void {
			//mcFrog.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function jumpAnimation(_direction:String):void {
			direction=_direction;
			playLabel("jump");
			
			
		}
		
		
		private function playLabel(label:String):void {
			state=label;
			mcFrog.gotoAndPlay(label);
			addEventListener(Event.ENTER_FRAME, function(e : Event) : void {
						if (mcFrog.currentLabel != label) {
							mcFrog.stop();
							state="idle";
							removeEventListener(Event.ENTER_FRAME, arguments.callee);
						}
			});
		}
		
		
		
		//
		//EVENT HANDLERS
		//
		private function idleLoopHandler(event : Event) : void {
			if (mcFrog.currentLabel != "idle") {
				mcFrog.gotoAndPlay("idle");
			}
		}
	

		
		
		
	}
}
