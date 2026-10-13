package export.huodong.midautumn
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
   
   public class MidAutumnInterface extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var gobtn:SimpleButton;
      
      public var morebtn:SimpleButton;
      
      public var dhbtn:SimpleButton;
      
      public var txt:TextField;
      
      private var gc:Config;
      
      private var renewalse:RenewalseThisSZ;
      
      private var _anti:Antiwear;
      
      public function MidAutumnInterface()
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this._anti.needtopay = 200;
         this._anti.needguihua = 10;
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
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         morebtn.addEventListener("click",costClick);
         xbtn.addEventListener("click",xClick);
         gobtn.addEventListener("click",goClick);
         dhbtn.addEventListener("click",dhClick);
         this.setShow();
      }
      
      private function removed(e:Event) : void
      {
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         morebtn.removeEventListener("click",costClick);
         xbtn.removeEventListener("click",xClick);
         gobtn.removeEventListener("click",goClick);
         dhbtn.removeEventListener("click",dhClick);
      }
      
      private function costClick(e:MouseEvent) : void
      {
         this.addRenewalseMask("您确定要花费" + this._anti.needtopay + "点券重新挑战一次?");
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
               PayManager.getInstance().pay(23,"道具23",gc.pay.money,1);
               gc.lastPaymentString = "MidAutumnInterface";
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
         if(gc.lastPaymentString != "MidAutumnInterface")
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
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
         this.intoChangEHome();
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
      
      private function goClick(e:MouseEvent) : void
      {
         if(gc.dataObject.chanllengeChangEr2)
         {
            gc.dataObject.chanllengeChangEr2 = false;
            this.intoChangEHome();
         }
         else
         {
            gc.ts.setTxt("今天挑战次数已经用完");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function dhClick(e:MouseEvent) : void
      {
         if(gc.dataObject.guiHuaNumber >= this._anti.needguihua)
         {
            if(gc.player1.roleid > 0)
            {
               gc.dataObject.guiHuaNumber -= this._anti.needguihua;
               gc.putQhsInBackPack(gc.player1,"ghyb",1);
               gc.ts.setTxt("兑换成功");
               gc.stage.addChild(gc.ts);
               if(gc.isHideDebug)
               {
                  gc.memory.setStorage(gc.luanqibazaojiami.saveId);
               }
            }
         }
         else
         {
            gc.ts.setTxt("桂花数量不够");
            gc.stage.addChild(gc.ts);
         }
         this.setShow();
      }
      
      private function intoChangEHome() : void
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
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function setShow() : void
      {
         if(!gc.dataObject.chanllengeChangEr2)
         {
            this.morebtn.visible = true;
         }
         else
         {
            this.morebtn.visible = false;
         }
         this.txt.text = "桂花" + gc.dataObject.guiHuaNumber + "/" + this._anti.needguihua;
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
