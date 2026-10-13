package export.auth4399
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import manager.Auth4399Manager;
   
   public class Auth4399OrderView extends Sprite
   {
       
      
      private var gc:Config;
      
      public var xbtn:SimpleButton;
      
      public var okBtn:SimpleButton;
      
      public var qxBtn:SimpleButton;
      
      public var nameTxt:TextField;
      
      public var authTxt:TextField;
      
      public var nameTxt1:TextField;
      
      public var authTxt1:TextField;
      
      public function Auth4399OrderView()
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
         if(gc.suggestAuth.demoName)
         {
            this.setExampleVisible(true,gc.suggestAuth.demoName,gc.suggestAuth.demoCardId);
         }
         else
         {
            this.setExampleVisible(false,"","");
         }
         if(gc.lastSubmitName != "")
         {
            this.nameTxt.text = gc.lastSubmitName;
            this.authTxt.text = gc.lastSubmitCId;
         }
      }
      
      private function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         okBtn.removeEventListener("click",okHandler);
         qxBtn.removeEventListener("click",qxHandler);
      }
      
      public function setExampleVisible(_bool:Boolean, _cname:String, _code:String) : void
      {
         this.nameTxt1.visible = _bool;
         this.authTxt1.visible = _bool;
         trace("--------_cname-----------",_cname);
         this.nameTxt1.text = "如：" + _cname;
         this.authTxt1.text = "如：" + _code;
      }
      
      private function okHandler(e:MouseEvent) : void
      {
         var reg:RegExp = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
         if(reg.test(authTxt.text) === false)
         {
            gc.ts.setTxt("无效的身份证号码，请重新填写");
            gc.stage.addChild(gc.ts);
            return;
         }
         this.commitAuth();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function commitAuth() : void
      {
         var data:Object = {};
         data.uid = gc.logInfo.uid;
         data.realname = nameTxt.text;
         data.idcard = authTxt.text;
         gc.lastSubmitName = nameTxt.text;
         gc.lastSubmitCId = authTxt.text;
         Auth4399Manager.getInstance().sumbitData(data);
      }
      
      private function qxHandler(e:MouseEvent) : void
      {
         var authMain:* = null;
         var view:* = null;
         if(gc.auth4399 && gc.auth4399.status == 100)
         {
            authMain = new Auth4399MainView();
            gc.stage.addChild(authMain);
         }
         else if(gc.canelTimes == 0)
         {
            gc.canelTimes++;
            view = new Auth4399AutoTips();
            gc.stage.addChild(view);
         }
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
