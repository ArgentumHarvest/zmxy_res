package export
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class WsEffect extends MovieClip
   {
       
      
      public var Role1Mc:MovieClip;
      
      public var Role2Mc:MovieClip;
      
      public var bg:MovieClip;
      
      public function WsEffect()
      {
         super();
         this.bg.addEventListener(Event.ENTER_FRAME,this.__enterFrame);
      }
      
      function __enterFrame(param1:Event) : void
      {
         if(this.bg.currentFrame == this.bg.totalFrames)
         {
            this.bg.removeEventListener(Event.ENTER_FRAME,this.__enterFrame);
            this.bg.stop();
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
         }
      }
   }
}
