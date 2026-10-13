package export.queenmother
{
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import my.MainGame;
   
   public class QueenMotherInterface extends Sprite
   {
       
      
      public var freebtn:SimpleButton;
      
      public var btn_close:SimpleButton;
      
      public var xnkybtn:SimpleButton;
      
      private var gc:Config;
      
      private var renewalse:RenewalseThisSZ;
      
      public function QueenMotherInterface()
      {
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         this.removeEventListener("addedToStage",added);
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         freebtn.addEventListener("click",freeClick);
         btn_close.addEventListener("click",xClick);
         xnkybtn.addEventListener("click",xnClick);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         freebtn.removeEventListener("click",freeClick);
         btn_close.removeEventListener("click",xClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         xnkybtn.removeEventListener("click",xnClick);
      }
      
      private function xnClick(e:MouseEvent) : void
      {
         this.intoXnTzFb();
      }
      
      private function freeClick(e:MouseEvent) : void
      {
         this.intoQueenMother();
      }
      
      private function intoXnTzFb() : void
      {
         if(gc.dataObject.onedaytimeQueenMotherXntz == 0)
         {
            gc.curStageAndCurLevel.curStage = 54;
            gc.curStageAndCurLevel.curLevel = 1;
            gc.stage541Type = 1;
            gc.dataObject.onedaytimeQueenMotherXntz = 1;
            if(MainGame.getInstance())
            {
               MainGame.getInstance().destroyGame();
            }
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
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
      
      private function intoQueenMother() : void
      {
         if(gc.dataObject.onedaytimeQueenMother == 0)
         {
            gc.curStageAndCurLevel.curStage = 54;
            gc.curStageAndCurLevel.curLevel = 1;
            gc.stage541Type = 0;
            gc.dataObject.onedaytimeQueenMother = 1;
            if(MainGame.getInstance())
            {
               MainGame.getInstance().destroyGame();
            }
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
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
         gc.lastPaymentString = "QueenMotherInterface";
         gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[100000]));
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
         if(gc.lastPaymentString != "QueenMotherInterface")
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
         gc.dataObject.onedaytimeQueenMother = 0;
         this.intoQueenMother();
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
