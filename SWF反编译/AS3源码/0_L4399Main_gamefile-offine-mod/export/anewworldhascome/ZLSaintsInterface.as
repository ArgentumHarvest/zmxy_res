package export.anewworldhascome
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import my.FinancialInfo;
   import user.User;
   
   public class ZLSaintsInterface extends Sprite
   {
       
      
      public var btn_close:SimpleButton;
      
      public var onebtn:SimpleButton;
      
      public var notimebtn:SimpleButton;
      
      public var onemorebtn:SimpleButton;
      
      private var gc:Config;
      
      private var renewalse:RenewalseThisSZ;
      
      private var _anti:Antiwear;
      
      public function ZLSaintsInterface()
      {
         this._anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this._anti.needtopay = 50;
         this._anti.one_thousand = 1000;
         this._anti.whichdoor = 1;
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
         btn_close.addEventListener("click",xClick);
         onebtn.addEventListener("click",oneClick);
         notimebtn.addEventListener("click",notimeClick);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         if(gc.dataObject.challengeSaints == true || gc.dataObject.challengeSaints == "true")
         {
            onemorebtn.visible = true;
            onemorebtn.addEventListener("click",onemoreClick);
         }
         else
         {
            onemorebtn.visible = false;
            onemorebtn.removeEventListener("click",onemoreClick);
         }
      }
      
      private function removed(e:Event) : void
      {
         btn_close.removeEventListener("click",xClick);
         onebtn.removeEventListener("click",oneClick);
         notimebtn.removeEventListener("click",notimeClick);
         onemorebtn.removeEventListener("click",onemoreClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function oneClick(e:MouseEvent) : void
      {
         if(gc.dataObject.challengeSaints == true || gc.dataObject.challengeSaints == "true")
         {
            gc.ts.setTxt("一天只能挑战一次Boss");
            gc.stage.addChild(gc.ts);
            return;
         }
         this._anti.whichdoor = 1;
         this.addRenewalseMask("您确定要花费1000灵魂挑战100秒限制的BOSS?");
      }
      
      private function lhConsume(_player:User) : void
      {
         if(_player.getLhValue() >= this._anti.one_thousand)
         {
            _player.setLhValue(_player.getLhValue() - this._anti.one_thousand);
            gc.dataObject.whichSaints = 1;
            this.intoChanllengeSaintsBoss();
         }
      }
      
      private function notimeClick(e:MouseEvent) : void
      {
         if(gc.dataObject.challengeSaints == true || gc.dataObject.challengeSaints == "true")
         {
            gc.ts.setTxt("一天只能挑战一次Boss");
            gc.stage.addChild(gc.ts);
            return;
         }
         this._anti.whichdoor = 2;
         this._anti.needtopay = 50;
         this.addRenewalseMask("您确定要花费50点券挑战无时间限制的BOSS?");
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
         if(this._anti.whichdoor == 2)
         {
            gc.lastPaymentString = "ZLSaintsInterface";
            gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[100000]));
         }
         else if(this._anti.whichdoor == 1)
         {
            if(gc.playNum == 1)
            {
               if(gc.player1.getLhValue() >= this._anti.one_thousand)
               {
                  this.lhConsume(gc.player1);
               }
               else
               {
                  gc.ts.setTxt("灵魂不够");
                  gc.stage.addChild(gc.ts);
               }
            }
            else if(gc.player1.getLhValue() >= this._anti.one_thousand)
            {
               this.lhConsume(gc.player1);
            }
            else if(gc.player2.getLhValue() >= this._anti.one_thousand)
            {
               this.lhConsume(gc.player2);
            }
            else
            {
               gc.ts.setTxt("需要至少一位玩家灵魂数大于1000");
               gc.stage.addChild(gc.ts);
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
         if(gc.lastPaymentString != "ZLSaintsInterface")
         {
            return;
         }
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         if(this._anti.needtopay == 50)
         {
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
               "id":10600,
               "ename":"custom"
            },1,1],[{
               "id":10600,
               "ename":"custom"
            },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         }
         else if(this._anti.needtopay == 150)
         {
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
               "id":10610,
               "ename":"custom"
            },1,1],[{
               "id":10610,
               "ename":"10610"
            },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         }
         gc.gameVip.dataObject.lastMoney = e.data[0];
         gc.dataObject.challengeSaints = false;
         gc.dataObject.whichSaints = 2;
         this.intoChanllengeSaintsBoss();
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
      
      private function intoChanllengeSaintsBoss() : void
      {
         gc.dataObject.challengeSaints = true;
         gc.curStageAndCurLevel.curStage = 40;
         gc.curStageAndCurLevel.curLevel = 1;
         gc.eventManger.dispatchEvent(new CommonEvent("ChanllengeBossInster"));
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function onemoreClick(e:MouseEvent) : void
      {
         this._anti.whichdoor = 2;
         this._anti.needtopay = 150;
         this.addRenewalseMask("您确定要花费150点券重新挑战无时间限制的BOSS?");
      }
   }
}
