package controls.dialogs {
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	
	/**
	 * A simple Loading picto. You can use the static <code>instance</code> instead of 
	 * explicitely creating your own every time.
	 */
	public class LoadingDialog extends Sprite implements IAnimatable {
		
		/** Rotation speed. */
		private static const RAD_PER_SECOND:Number = Math.PI;
		
		
		// ASSETS :
		[Embed("/../assets/images/loading.png")]
		public static const LoadingSpriteClass:Class;
		
		// Static instance :
		private static var _instance:LoadingDialog;
		/** Use this instance if you don't want to instantiate your own for a Popup for example. */
		public static function get instance():LoadingDialog {
			if(!_instance) _instance = new LoadingDialog();
			return _instance;
		}
		
		
		/** The LoadingSprite instance. */
		private var content:Image;
		
		
		// CONSTRUCTOR :
		public function LoadingDialog() {
			super();
			
			content = Image.fromBitmap(new LoadingSpriteClass()); 
			
			content.x = content.pivotX = content.width / 2;
			content.y = content.pivotY = content.height / 2;
			
			addChild(content);
			
			addEventListener(Event.ADDED_TO_STAGE, start);
			addEventListener(Event.REMOVED_FROM_STAGE, stop);
		}
		
		/** Starts the loading image rotation. */
		private function start(ev:Event):void {
			Starling.juggler.add(this);
			content.rotation = 0;
		}
		
		/** Stops the loading image rotation. */
		private function stop(ev:Event):void {
			Starling.juggler.remove(this);
		}
		
		
		/** Rotates. */
		public function advanceTime(elapsedTime:Number):void {
			content.rotation += elapsedTime * RAD_PER_SECOND;
		}
	}
}