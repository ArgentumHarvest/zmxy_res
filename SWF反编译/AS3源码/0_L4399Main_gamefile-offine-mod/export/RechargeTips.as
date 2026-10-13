package export
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class RechargeTips extends Sprite
   {
       
      
      public var btn_ok:SimpleButton;
      
      public var btn_change:SimpleButton;
      
      public var txtfield:TextField;
      
      public function RechargeTips()
      {
         super();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         btn_ok.addEventListener("click",getBalance);
         btn_change.addEventListener("click",getBalance);
      }
      
      private function removed(e:Event) : void
      {
         btn_ok.removeEventListener("click",getBalance);
         btn_change.removeEventListener("click",getBalance);
      }
      
      private function getBalance(e:MouseEvent) : void
      {
         if(GMain.serviceHold)
         {
            GMain.serviceHold.getBalance();
         }
         this.closeSelf();
      }
      
      private function xClick(e:MouseEvent) : void
      {
         this.closeSelf();
      }
      
      private function closeSelf() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
