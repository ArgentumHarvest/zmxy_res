package export.eightimmortals
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SutraEightImmortal extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public function SutraEightImmortal()
      {
         super();
         this.addEventListener("addedToStage",added);
      }
      
      private function added(e:Event) : void
      {
         this.removeEventListener("addedToStage",added);
         xbtn.addEventListener("click",xClick);
      }
      
      protected function xClick(event:MouseEvent) : void
      {
         xbtn.removeEventListener("click",xClick);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
