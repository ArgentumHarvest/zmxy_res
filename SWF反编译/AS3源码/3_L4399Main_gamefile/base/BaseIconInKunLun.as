package base
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.PayManager;
   
   public class BaseIconInKunLun extends Sprite
   {
       
      
      protected var gc:Config;
      
      protected var renewalse:RenewalseThisSZ;
      
      protected var _anti:Antiwear;
      
      protected var myName:String = "";
      
      private var _outsideDoFunction:Function = null;
      
      public function BaseIconInKunLun()
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.buttonMode = true;
         this._anti.needtopay = 10;
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         this.removeEventListener("addedToStage",added);
         this.addEventListener("click",onClick);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         gc.eventManger.addEventListener("DLREFRESH",refreshTxt);
         this.setTxt();
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         this.removeEventListener("click",onClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         gc.eventManger.removeEventListener("DLREFRESH",refreshTxt);
         this.renewalse = null;
         this._outsideDoFunction = null;
      }
      
      protected function onClick(e:MouseEvent) : void
      {
      }
      
      protected function addRenewalseMask(inst:String) : void
      {
         renewalse["txt"].text = inst;
         gc.gameInfo.addChild(renewalse);
         renewalse["okbtn"].addEventListener("click",renewalseOk);
         renewalse["nobtn"].addEventListener("click",renewalseChange);
      }
      
      protected function renewalseOk(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         var enough:Boolean = true;
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
               PayManager.getInstance().pay(4,"道具4",gc.pay.money,1);
               gc.lastPaymentString = this.myName;
               gc.addActionMask("renewalse");
            }
         }
         if(renewalse && gc.gameInfo.contains(renewalse))
         {
            gc.gameInfo.removeChild(renewalse);
         }
      }
      
      protected function renewalseChange(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && gc.gameInfo.contains(renewalse))
         {
            gc.gameInfo.removeChild(renewalse);
         }
      }
      
      protected function paymentSuccess(e:CommonEvent) : void
      {
         trace("=====paymentSuccess===gc.lastPaymentString:" + gc.lastPaymentString + ",this.myName:" + this.myName);
         if(gc.lastPaymentString != this.myName)
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
         this.doFunction();
      }
      
      protected function paymentFail(e:CommonEvent) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         gc.lastPaymentString = "";
      }
      
      protected function doFunction() : void
      {
         if(outsideDoFunction != null)
         {
            this.outsideDoFunction();
         }
      }
      
      protected function setTxt() : void
      {
      }
      
      public function get outsideDoFunction() : Function
      {
         return _outsideDoFunction;
      }
      
      public function set outsideDoFunction(value:Function) : void
      {
         _outsideDoFunction = value;
      }
      
      protected function refreshTxt(e:Event) : void
      {
         this.setTxt();
      }
   }
}
