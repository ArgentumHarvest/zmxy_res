package export.huodong.kabu
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.system.System;
   import flash.text.TextField;
   
   public class KaBuActivites extends Sprite
   {
       
      
      public var copybtn:SimpleButton;
      
      public var intoKaBubtn:SimpleButton;
      
      public var idtxt:TextField;
      
      public var backbtn:SimpleButton;
      
      private var gc:Config;
      
      private var urlLoader:URLLoader;
      
      public function KaBuActivites()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         copybtn.addEventListener("click",copyClick);
         intoKaBubtn.addEventListener("click",kabuClick);
         backbtn.addEventListener("click",back);
         this.checkEligible();
      }
      
      private function removed(e:Event) : void
      {
         copybtn.removeEventListener("click",copyClick);
         intoKaBubtn.removeEventListener("click",kabuClick);
         backbtn.removeEventListener("click",back);
      }
      
      private function checkEligible() : void
      {
         var cPet:* = null;
         if(gc.cardId != "")
         {
            gc.ts.setTxt("改账号已经获取过卡号");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(gc.player1.roleid > 0)
         {
            if(gc.player1.findBiggestPetLevel() >= 36)
            {
               this.doRequest();
               return;
            }
         }
         if(gc.player2.roleid > 0)
         {
            if(gc.player2.findBiggestPetLevel() >= 36)
            {
               this.doRequest();
               return;
            }
         }
         this.copybtn.visible = false;
         this.idtxt.text = "宠物等级要求达到36级才能完成该活动";
      }
      
      private function doRequest() : void
      {
         urlLoader = new URLLoader();
         urlLoader.dataFormat = "text";
         urlLoader.addEventListener("complete",completeHandler);
         var urlVariables:URLVariables = new URLVariables();
         urlVariables.uid = gc.logInfo.uid;
         var urlReuest:URLRequest = new URLRequest("https://php.wanwan4399.com/api/card_for_kabu.php");
         urlReuest.method = "POST";
         urlReuest.data = urlVariables;
         urlLoader.load(urlReuest);
      }
      
      private function completeHandler(e:Event) : void
      {
         urlLoader.removeEventListener("complete",completeHandler);
         var exictmask:Sprite = this.stage.getChildByName("execuitionActiongetKaBuActId") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         var jObj:* = JSON.parse(urlLoader.data);
         this.copybtn.visible = true;
         this.idtxt.text = String(jObj["CardId"]);
      }
      
      private function copyClick(e:MouseEvent) : void
      {
         System.setClipboard(idtxt.text);
         gc.ts.setTxt("复制成功");
         gc.stage.addChild(gc.ts);
      }
      
      private function kabuClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://www.4399.com/flash/48399.htm"),"_blank");
      }
      
      private function back(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
