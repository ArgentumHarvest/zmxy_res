package export.garden
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
   import flash.text.TextField;
   import manager.PayManager;
   import my.FinancialInfo;
   import my.SingleSavedBuff;
   
   public class LadnBlessInterface extends Sprite
   {
       
      
      public var ehptxt:TextField;
      
      public var levtxt:TextField;
      
      public var btn_close:SimpleButton;
      
      public var getbtn:SimpleButton;
      
      public var upbtn:SimpleButton;
      
      private var gc:Config;
      
      private var renewalse:RenewalseThisSZ;
      
      private var _anti:Antiwear;
      
      public function LadnBlessInterface()
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this._anti.needtopay = 50;
         this._anti.ehp = 0;
         this._anti.renewalseType = -1;
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         btn_close.addEventListener("click",xClick);
         getbtn.addEventListener("click",getClick);
         upbtn.addEventListener("click",upClick);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         this._anti.ehp = gc.achieveLandGodLevel();
         this.setTxt();
      }
      
      private function removed(e:Event) : void
      {
         btn_close.removeEventListener("click",xClick);
         getbtn.removeEventListener("click",getClick);
         upbtn.removeEventListener("click",upClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
      }
      
      private function setTxt() : void
      {
         this.levtxt.text = gc.achieveLandGodLevel() + "级";
         this.ehptxt.text = this._anti.ehp + "点";
      }
      
      private function getClick(e:MouseEvent) : void
      {
         gc.dataObject.landgodbless = true;
         gc.savedBuff.addBuff(SingleSavedBuff.BUFF_HP_CURE,this._anti.ehp,3600 * gc.frameClips);
         gc.ts.setTxt("领取成功");
         gc.stage.addChild(gc.ts);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function upClick(e:MouseEvent) : void
      {
         if(this._anti.ehp < 10)
         {
            this._anti.renewalseType = 0;
            this.addRenewalseMask("您确定花50点券增强回血效果吗");
         }
         else
         {
            gc.ts.setTxt("土地公祝福已经达到上限");
            gc.stage.addChild(gc.ts);
         }
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
         var enough:Boolean = false;
         if(this._anti.renewalseType == 0)
         {
            renewalse["okbtn"].removeEventListener("click",renewalseOk);
            renewalse["nobtn"].removeEventListener("click",renewalseChange);
            enough = true;
            if(gc.gameVip.dataObject.lastMoney < this._anti.needtopay)
            {
               gc.ts.setTxt("账户余额不足");
               gc.stage.addChild(gc.ts);
               enough = false;
            }
            gc.pay.money = this._anti.needtopay;
            if(enough)
            {
               if(GMain.serviceHold)
               {
                  PayManager.getInstance().pay(15,"道具15",gc.pay.money,1);
                  gc.lastPaymentString = "LadnBlessInterface";
                  gc.addActionMask("renewalse");
               }
            }
            if(renewalse && this.contains(renewalse))
            {
               this.removeChild(renewalse);
            }
         }
         else if(this._anti.renewalseType == 1)
         {
            this._anti.renewalseType = -1;
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
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
         this._anti.renewalseType = -1;
      }
      
      private function paymentSuccess(e:CommonEvent) : void
      {
         if(gc.lastPaymentString != "LadnBlessInterface")
         {
            return;
         }
         FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
            "id":10520,
            "ename":"custom"
         },1,1],[{
            "id":10520,
            "ename":"custom"
         },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         gc.gameVip.dataObject.lastMoney = e.data[0];
         gc.lastPaymentString = "";
         this._anti.ehp += 1;
         this.setTxt();
         this._anti.renewalseType = -1;
      }
      
      private function paymentFail(e:CommonEvent) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         this._anti.renewalseType = -1;
      }
      
      private function xClick(e:MouseEvent) : void
      {
         this._anti.renewalseType = 1;
         this.addRenewalseMask("关掉此页面将不保存信息，确定关闭吗？");
      }
   }
}
