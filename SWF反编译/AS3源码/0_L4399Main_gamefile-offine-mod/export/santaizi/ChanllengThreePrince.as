package export.santaizi
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import mvc.controllor.RandomControllor;
   import my.FinancialInfo;
   
   public class ChanllengThreePrince extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var mc1:MovieClip;
      
      public var mc2:MovieClip;
      
      public var mc3:MovieClip;
      
      public var txt:TextField;
      
      public var costbtn:SimpleButton;
      
      private var gc:Config;
      
      private var renewalse:RenewalseThisSZ;
      
      private var _anti:Antiwear;
      
      public function ChanllengThreePrince()
      {
         this._anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this._anti.needtopay = 100;
         this._anti.whichboss = 1;
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
         mc1.buttonMode = true;
         mc2.buttonMode = true;
         mc3.buttonMode = true;
         mc1.addEventListener("click",mcClick);
         mc2.addEventListener("click",mcClick);
         mc3.addEventListener("click",mcClick);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         costbtn.addEventListener("click",costClick);
         xbtn.addEventListener("click",xClick);
         this.setTxt();
      }
      
      private function removed(e:Event) : void
      {
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         xbtn.removeEventListener("click",xClick);
         mc1.removeEventListener("click",mcClick);
         mc2.removeEventListener("click",mcClick);
         costbtn.removeEventListener("click",costClick);
         mc3.removeEventListener("click",mcClick);
      }
      
      private function setTxt() : void
      {
         this.txt.text = gc.dataObject.challengeThreePrinceTimes + "";
      }
      
      private function costClick(e:MouseEvent) : void
      {
         this.addRenewalseMask("您确定要花费" + this._anti.needtopay + "点券，增加一次挑战次数吗?");
      }
      
      private function mcClick(e:MouseEvent) : void
      {
         var rd:Number = NaN;
         if(gc.dataObject.challengeThreePrinceTimes > 0)
         {
            gc.dataObject.challengeThreePrinceTimes--;
            rd = RandomControllor.getIns().getRandom();
            if(rd < 0.3333)
            {
               this._anti.whichboss = 1;
            }
            else if(rd >= 0.3333 && rd < 0.6666)
            {
               this._anti.whichboss = 2;
            }
            else
            {
               this._anti.whichboss = 3;
            }
            trace("this._anti.whichboss ->>" + this._anti.whichboss);
            e.target.gotoAndStop(this._anti.whichboss + 1);
            mc1.removeEventListener("click",mcClick);
            mc2.removeEventListener("click",mcClick);
            mc3.removeEventListener("click",mcClick);
            setTimeout(gotoFuBen,1000);
         }
         else
         {
            gc.ts.setTxt("挑战次数不够");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function gotoFuBen() : void
      {
         if(this._anti.whichboss == 1)
         {
            gc.curStageAndCurLevel.curStage = 44;
            gc.curStageAndCurLevel.curLevel = 1;
         }
         else if(this._anti.whichboss == 2)
         {
            gc.curStageAndCurLevel.curStage = 44;
            gc.curStageAndCurLevel.curLevel = 2;
         }
         else if(this._anti.whichboss == 3)
         {
            gc.curStageAndCurLevel.curStage = 44;
            gc.curStageAndCurLevel.curLevel = 3;
         }
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function addRenewalseMask(inst:String) : void
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
         gc.lastPaymentString = "ChanllengThreePrince";
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
         if(gc.lastPaymentString != "ChanllengThreePrince")
         {
            return;
         }
         gc.lastPaymentString = "";
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         gc.gameVip.dataObject.lastMoney = e.data[0];
         gc.dataObject.challengeThreePrinceTimes++;
         FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
            "id":10400,
            "ename":"custom"
         },1,1],[{
            "id":10400,
            "ename":"custom"
         },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         this.setTxt();
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
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
