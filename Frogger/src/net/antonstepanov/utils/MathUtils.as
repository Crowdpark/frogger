package net.antonstepanov.utils {
	/**
	 * @author 'Anton Stepanov'
	 */
	public class MathUtils {
		
		static public function randomIntegerRange(min:Number, max:Number):int {
			var scale:Number = max - min;
			return  Math.random() *scale+min;
			
			
			
		}
		
	}
}
