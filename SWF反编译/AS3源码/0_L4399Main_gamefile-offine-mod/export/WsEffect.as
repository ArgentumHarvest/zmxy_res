package export
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class WsEffect extends Sprite
   {
       
      
      public var Role1Mc:MovieClip;
      
      public var Role2Mc:MovieClip;
      
      public var Role3Mc:MovieClip;
      
      public var bg:MovieClip;
      
      public function WsEffect()
      {
         super();
         this.bg.addEventListener("enterFrame",__enterFrame);
      }
      
      function __enterFrame(evt:Event) : void
      {
         if(this.bg.currentFrame == this.bg.totalFrames)
         {
            this.bg.removeEventListener("enterFrame",__enterFrame);
            bg.stop();
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
         }
      }
   }
}
