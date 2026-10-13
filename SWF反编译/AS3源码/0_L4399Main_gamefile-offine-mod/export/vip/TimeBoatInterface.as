package export.vip
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import my.FinancialInfo;
   
   public class TimeBoatInterface extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var qlbtn:SimpleButton;
      
      public var cebtn:SimpleButton;
      
      private var renewalse:RenewalseThisSZ;
      
      private var _anti:Antiwear;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      private var gc:Config;
      
      private var isSave:Boolean = false;
      
      public function TimeBoatInterface()
      {
         this._anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this._anti.whichone = 1;
         this._anti.needtopay = 300;
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         var bgImg:Bitmap = null;
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         qlbtn.addEventListener("click",qlClick);
         cebtn.addEventListener("click",ceClick);
         xbtn.addEventListener("click",xClick);
         var ary:Array = String(gc.dataObject.hasgetanniversary).split("_") as Array;
         if(ary[1] == "false")
         {
            bgImg = AUtils.getImageObj("sgzzbgnew");
            bgImg.x = 263.95;
            bgImg.y = 161.95;
            this.addChild(bgImg);
         }
      }
      
      private function removed(e:Event) : void
      {
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         qlbtn.removeEventListener("click",qlClick);
         cebtn.removeEventListener("click",ceClick);
         xbtn.removeEventListener("click",xClick);
         if(isSave)
         {
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         gc.eventManger.dispatchEvent(new CommonEvent("TIMEBOATINTERFACE_CLOSE"));
      }
      
      private function qlClick(e:MouseEvent) : void
      {
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "qlbtn";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
         this._anti.whichone = 1;
         var ary:Array = String(gc.dataObject.hasgetanniversary).split("_") as Array;
         if(ary[1] == "false")
         {
            this.isSave = true;
            ary[1] = "true";
            gc.dataObject.hasgetanniversary = ary[0] + "_" + ary[1];
            this.intoFuBen();
         }
         else
         {
            this.isSave = false;
            this.addRenewalseMask("您确定要花费" + this._anti.needtopay + "点券进入六一副本?");
         }
      }
      
      private function ceClick(e:MouseEvent) : void
      {
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "cebtn";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
         this._anti.whichone = 2;
         var ary:Array = String(gc.dataObject.hasgetanniversary).split("_") as Array;
         if(ary[1] == "false")
         {
            this.isSave = true;
            ary[1] = "true";
            gc.dataObject.hasgetanniversary = ary[0] + "_" + ary[1];
            this.intoFuBen();
         }
         else
         {
            this.isSave = false;
            this.addRenewalseMask("您确定要花费" + this._anti.needtopay + "点券进入中秋副本?");
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
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         gc.lastPaymentString = "TimeBoatInterface";
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
         if(gc.lastPaymentString != "TimeBoatInterface")
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
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
         if(this._anti.whichone == 1 || this._anti.whichone == 2)
         {
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
               "id":10680,
               "ename":"custom"
            },1,1],[{
               "id":10680,
               "ename":"custom"
            },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         }
         this.intoFuBen();
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
      
      private function intoFuBen() : void
      {
         if(this._anti.whichone == 1)
         {
            gc.curStageAndCurLevel.curStage = 15;
            gc.curStageAndCurLevel.curLevel = 1;
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
         }
         else if(this._anti.whichone == 2)
         {
            gc.curStageAndCurLevel.curStage = 46;
            gc.curStageAndCurLevel.curLevel = 1;
            gc.stage461Type = 1;
            gc.guoqingMonsterId = 130;
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
         }
         else
         {
            gc.ts.setTxt("请选择你要穿越的副本");
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
