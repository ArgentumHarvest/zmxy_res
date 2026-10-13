package export
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class GameTips extends MovieClip
   {
       
      
      private var changeTipInterval:uint;
      
      public function GameTips()
      {
         super();
         this.addEventListener("addedToStage",__added,false,0,true);
         this.addEventListener("removedFromStage",__removed,false,0,true);
         this.stop();
      }
      
      protected function __removed(evt:Event) : void
      {
         clearInterval(this.changeTipInterval);
         evt.stopImmediatePropagation();
      }
      
      protected function __added(evt:Event) : void
      {
         this.changeTipInterval = setInterval(changeTips,8000);
         evt.stopImmediatePropagation();
      }
      
      public function changeTips() : void
      {
         if(this.currentFrame < this.totalFrames)
         {
            this.gotoAndStop(this.currentFrame + 1);
         }
         else
         {
            this.gotoAndStop(1);
         }
      }
   }
}
