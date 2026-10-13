package export.huodong.kunlun
{
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.PayManager;
   import my.FinancialInfo;
   import my.MainGame;
   
   public class KunlunMountains extends Sprite
   {
       
      
      public var swkls:SimpleButton;
      
      public var btn_close:SimpleButton;
      
      public var btncost:SimpleButton;
      
      private var gc:Config;
      
      private var renewalse:RenewalseThisSZ;
      
      public function KunlunMountains()
      {
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         swkls.addEventListener("click",swClick);
         btn_close.addEventListener("click",xClick);
         btncost.addEventListener("click",costClick);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
      }
      
      private function removed(e:Event) : void
      {
         swkls.removeEventListener("click",swClick);
         btn_close.removeEventListener("click",xClick);
         btncost.removeEventListener("click",costClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
      }
      
      private function swClick(e:MouseEvent) : void
      {
         this.intoswKunLunMountains();
      }
      
      private function intoswKunLunMountains() : void
      {
         if(gc.dataObject.onedaytime == 0)
         {
            gc.curStageAndCurLevel.curStage = 13;
            gc.curStageAndCurLevel.curLevel = 1;
            if(MainGame.getInstance())
            {
               MainGame.getInstance().destroyGame();
            }
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("您今天已经挑战过");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function tzClick(e:MouseEvent) : void
      {
      }
      
      private function costClick(e:MouseEvent) : void
      {
         this.addRenewalseMask("您确定要花费200点券重新挑战一次?");
      }
      
      public function addRenewalseMask(inst:String) : void
      {
         renewalse["txt"].text = inst;
         this.addChild(renewalse);
         renewalse["okbtn"].addEventListener("click",renewalseOk);
         renewalse["nobtn"].addEventListener("click",renewalseChange);
      }
      
      private function renewalseOk(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         var enough:Boolean = true;
         if(gc.gameVip.dataObject.lastMoney < 200)
         {
            gc.ts.setTxt("账户余额不足");
            gc.stage.addChild(gc.ts);
            enough = false;
         }
         gc.pay.money = 200;
         if(enough)
         {
            if(GMain.serviceHold)
            {
               PayManager.getInstance().pay(14,"道具14",gc.pay.money,1);
               gc.lastPaymentString = "KunlunMountains";
               gc.addActionMask("renewalse");
            }
         }
         if(renewalse && this.contains(renewalse))
         {
            this.removeChild(renewalse);
         }
      }
      
      private function renewalseChange(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && this.contains(renewalse))
         {
            this.removeChild(renewalse);
         }
      }
      
      private function paymentSuccess(e:CommonEvent) : void
      {
         if(gc.lastPaymentString != "KunlunMountains")
         {
            return;
         }
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         gc.gameVip.dataObject.lastMoney = e.data[0];
         gc.lastPaymentString = "";
         gc.dataObject.onedaytime = 0;
         btncost.removeEventListener("click",costClick);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
         this.intoswKunLunMountains();
         FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
            "id":10690,
            "ename":"custom"
         },1,1],[{
            "id":10690,
            "ename":"custom"
         },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
      }
      
      private function paymentFail(e:CommonEvent) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
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
