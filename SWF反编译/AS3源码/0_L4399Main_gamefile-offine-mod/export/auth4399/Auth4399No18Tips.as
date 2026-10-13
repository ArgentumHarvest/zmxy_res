package export.auth4399
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class Auth4399No18Tips extends Sprite
   {
       
      
      private var gc:Config;
      
      public var xbtn:SimpleButton;
      
      public var okBtn:SimpleButton;
      
      public var qxBtn:SimpleButton;
      
      public function Auth4399No18Tips()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         xbtn.addEventListener("click",xClick);
         okBtn.addEventListener("click",okHandler);
         qxBtn.addEventListener("click",qxHandler);
      }
      
      private function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         okBtn.removeEventListener("click",okHandler);
         qxBtn.removeEventListener("click",qxHandler);
      }
      
      private function okHandler(e:MouseEvent) : void
      {
         var authMain:Auth4399MainView = new Auth4399MainView();
         gc.stage.addChild(authMain);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function qxHandler(e:MouseEvent) : void
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
