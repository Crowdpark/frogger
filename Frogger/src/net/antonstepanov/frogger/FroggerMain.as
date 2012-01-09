package net.antonstepanov.frogger {
	import net.antonstepanov.frogger.vo.GameSettingsVO;
	import net.antonstepanov.frogger.model.ModelLocator;
	import net.antonstepanov.frogger.nonvisual.DeathValidator;
	import net.antonstepanov.frogger.nonvisual.KeyboardManager;
	import net.antonstepanov.frogger.view.GameArea;
	import net.antonstepanov.frogger.view.TrafficLine;
	import net.antonstepanov.frogger.view.TrafficUnit;
	import net.antonstepanov.frogger.view.screens.GameStateList;
	import net.antonstepanov.frogger.view.screens.ScreenManager;
	import net.antonstepanov.frogger.vo.TrafficLineVO;

	import flash.display.Sprite;

	/**
	 * @author 'Anton Stepanov'
	 */
	public class FroggerMain extends Sprite {
		
		private var keyManager:KeyboardManager;
		private var deathValidator:DeathValidator;
		private var game:GameArea;
		
		private var model:ModelLocator=ModelLocator.getInstance();
		
		public function FroggerMain() {
			init();	
			
		}

		private function init() : void {
			
			
			
			// visual
			model.screenManager=new ScreenManager();
			addChild(model.screenManager);
			
			model.screenManager.screen=GameStateList.TITLE;
			
			createSettings();
			//game visual
//			game=new GameArea();
//			addChild(game);

			//non visual
			keyManager=new KeyboardManager();
			addChild(keyManager);
			
			deathValidator=new DeathValidator();
			addChild(deathValidator);
			
		}
		
		private function createSettings():void {
			model.settings=new GameSettingsVO();
			
			//model.settings.linesArray.push(getLineData);
//			var firstLine:TrafficLineVO=getLineData(TrafficLineVO.GRASS);
//			firstLine.line=scoreLine;
//			addLine(firstLine);
			model.settings.linesArray.push(getLineData(TrafficLineVO.GRASS));
			model.settings.linesArray.push(getLineData(TrafficLineVO.WATER,-2));
			model.settings.linesArray.push(getLineData(TrafficLineVO.WATER,2));
			model.settings.linesArray.push(getLineData(TrafficLineVO.WATER,-3));
			model.settings.linesArray.push(getLineData(TrafficLineVO.WATER,1));
			
			
			model.settings.linesArray.push(getLineData(TrafficLineVO.GRASS));
			model.settings.linesArray.push(getLineData(TrafficLineVO.GRASS));
			
			model.settings.linesArray.push(getLineData(TrafficLineVO.ROAD,-2));
			model.settings.linesArray.push(getLineData(TrafficLineVO.ROAD,-3));
			model.settings.linesArray.push(getLineData(TrafficLineVO.ROAD,3));
			model.settings.linesArray.push(getLineData(TrafficLineVO.ROAD,2));
			
			model.settings.linesArray.push(getLineData(TrafficLineVO.GRASS));
		}
		
		private function getLineData(type:String,speed:Number=0):TrafficLineVO {
			var result:TrafficLineVO=new TrafficLineVO();
			result.bgType=type;
			result.speed=speed;
			//move to settings
			if (result.bgType==TrafficLineVO.GRASS) {
				
			} else if (result.bgType==TrafficLineVO.WATER) {
				
				 result.trafficUnitArray= [	 TrafficUnit.TREE_LONG,
														 TrafficUnit.TREE_MEDIUM,
														 TrafficUnit.TREE_SMALL,
														 TrafficUnit.WATER_CROC,
														 TrafficUnit.WATER_TURTLE];
				//result.traficLineInstanse=new TrafficLine(result.speed, result.trafficUnitArray);			
				result.line=new TrafficLine(result);			
			} else if (result.bgType==TrafficLineVO.ROAD) {
				
				 result.trafficUnitArray= [TrafficUnit.CAR_LONG,
													TrafficUnit.CAR_MEDIUM,
													TrafficUnit.CAR_SMALL_BLUE,
													TrafficUnit.CAR_SMALL_YELLOW];
				//result.traficLineInstanse=new TrafficLine(result.speed, result.trafficUnitArray);
				result.line=new TrafficLine(result);	
			}
			
				
			
			
			return result;
		}
		
	}
}
