package export
{
   import config.Config;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class OutAndStopGame extends Sprite
   {
       
      
      private var gc:Config;
      
      public function OutAndStopGame()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         stage.frameRate = 0;
         this.buttonMode = true;
      }
      
      private function removed(e:Event) : void
      {
      }
      
      public function hide() : void
      {
         stage.frameRate = gc.frameClips;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
