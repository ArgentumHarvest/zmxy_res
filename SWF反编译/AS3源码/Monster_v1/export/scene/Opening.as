package export.scene
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class Opening extends Sprite
   {
       
      
      public var btnSkip:SimpleButton;
      
      private var gc:Config;
      
      public var wzmc:MovieClip;
      
      public function Opening()
      {
         super();
         this.gc = Config.getInstance();
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      private function added(param1:*) : void
      {
         this.gc.opening = true;
         this.btnSkip.addEventListener(MouseEvent.CLICK,this.skipOpening);
      }
      
      private function removed(param1:*) : void
      {
         this.btnSkip.removeEventListener(MouseEvent.CLICK,this.skipOpening);
      }
      
      public function skipOpening(param1:MouseEvent) : void
      {
         this.wzmc.stop();
         this.gc.eventManger.dispatchEvent(new CommonEvent("ShowOpenAnimationOver"));
         this.removeMe();
      }
      
      private function removeMe() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
