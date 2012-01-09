package net.antonstepanov.frogger.view {
	import flash.display.DisplayObject;
	/**
	 * @author Anton
	 */
	public interface IFroggerLine {
		
		function hitTestLine(target : DisplayObject) : Boolean;
		
	}
}
