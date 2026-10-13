package export.rank
{
   import config.Config;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class RankErrorInterface extends Sprite
   {
       
      
      public var gomc:Sprite;
      
      private var gc:Config;
      
      public function RankErrorInterface()
      {
         super();
         gc = Config.getInstance();
         gomc.buttonMode = true;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         gomc.addEventListener("click",goClick);
         this.addEventListener("click",selfClick);
      }
      
      private function removed(e:Event) : void
      {
         gomc.removeEventListener("click",goClick);
         this.removeEventListener("click",selfClick);
      }
      
      private function goClick(e:MouseEvent) : void
      {
         gc.openUrl("https://my.4399.com/forums-mtag-tagid-80615.html");
      }
      
      private function selfClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
