package export.auth4399
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class Auth4399AutoTips extends Sprite
   {
       
      
      private var gc:Config;
      
      public var xbtn:SimpleButton;
      
      public var txBtn:SimpleButton;
      
      public function Auth4399AutoTips()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         xbtn.addEventListener("click",xClick);
         txBtn.addEventListener("click",txBtnHandler);
      }
      
      private function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         txBtn.removeEventListener("click",txBtnHandler);
      }
      
      private function txBtnHandler(e:MouseEvent) : void
      {
         var view:Auth4399OrderView = new Auth4399OrderView();
         view.name = "Auth4399OrderView";
         gc.stage.addChild(view);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
