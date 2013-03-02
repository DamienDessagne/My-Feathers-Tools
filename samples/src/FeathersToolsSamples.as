package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	
	/**
	 * Demonstrates the basic use of the Tools.
	 */
	[SWF(frameRate="60")]
	public class FeathersToolsSamples extends Sprite {
		
		/** A reference to the Starling instance. */
		public static var myStarling:Starling;
		
		
		// CONSTRUCTOR :
		public function FeathersToolsSamples() {
			super();
			addEventListener(Event.ENTER_FRAME, init);
		}
		
		/**
		 * Waits for a stage before initializing Starling.
		 */
		private function init(ev:Event):void {
			if(stage == null) return;
			
			removeEventListener(Event.ENTER_FRAME, init);
			
			// These settings are recommended to avoid problems with touch handling
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// Start Starling :
			Starling.handleLostContext = false;
			Starling.multitouchEnabled = false;
			
			var myStarling:Starling = new Starling(Samples, stage, new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
			trace("Starting Starling ...");
			myStarling.start();
			myStarling.showStatsAt(HAlign.RIGHT, VAlign.BOTTOM);
		}
	}
}