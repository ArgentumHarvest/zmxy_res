package export.challengeboss
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ThreeBossHelp extends Sprite
   {
       
      
      public var btn_close:SimpleButton;
      
      public function ThreeBossHelp()
      {
         super();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         btn_close.addEventListener("click",xClick);
      }
      
      private function removed(e:Event) : void
      {
         btn_close.removeEventListener("click",xClick);
      }
      
      private function xClick(e:MouseEvent) : void
      {
         this.delloc();
      }
      
      private function delloc() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
