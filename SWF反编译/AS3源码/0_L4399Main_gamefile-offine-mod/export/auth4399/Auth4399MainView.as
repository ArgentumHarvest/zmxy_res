package export.auth4399
{
   import config.Config;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.Auth4399Manager;
   
   public class Auth4399MainView extends Sprite
   {
       
      
      private var gc:Config;
      
      public var xbtn:SimpleButton;
      
      public var txBtn:SimpleButton;
      
      public var getBtn:SimpleButton;
      
      public var txmc:MovieClip;
      
      public var getmc:MovieClip;
      
      public function Auth4399MainView()
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
         getBtn.addEventListener("click",hdBtnHandler);
         this.initView();
      }
      
      private function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         txBtn.removeEventListener("click",txBtnHandler);
         getBtn.removeEventListener("click",hdBtnHandler);
      }
      
      private function initView() : void
      {
         this.txBtn.visible = false;
         this.getBtn.visible = true;
         this.txmc.visible = false;
         this.getmc.visible = true;
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
      
      private function hdBtnHandler(e:MouseEvent) : void
      {
         if(!gc.dataObject.hasGetAuth4399Present)
         {
            Auth4399Manager.getInstance().getPresent();
            gc.dataObject.hasGetAuth4399Present = true;
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
            this.xClick(null);
         }
         else
         {
            gc.ts.setTxt("该存档已经领取过礼包");
            gc.stage.addChild(gc.ts);
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
