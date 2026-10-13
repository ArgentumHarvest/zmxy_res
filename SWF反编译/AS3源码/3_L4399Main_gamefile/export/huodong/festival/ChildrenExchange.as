package export.huodong.festival
{
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import manager.PayManager;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   import my.MyEquipObj;
   
   public class ChildrenExchange extends Sprite
   {
       
      
      public var xBtn:SimpleButton;
      
      public var dhbtn:SimpleButton;
      
      public var infbBtn:SimpleButton;
      
      public var needtxt:TextField;
      
      public var zjycbtn:SimpleButton;
      
      private var gc:Config;
      
      private var renewalse:RenewalseThisSZ;
      
      public function ChildrenExchange()
      {
         super();
         gc = Config.getInstance();
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         gc.dataObject.moreNeedMoney = 300;
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         this.removeEventListener("addedToStage",added);
         xBtn.addEventListener("click",xClick);
         dhbtn.addEventListener("click",dhClick);
         infbBtn.addEventListener("click",infbClick);
         this.setTxt();
         if(gc.dataObject.intoChildrenDayTime >= 1)
         {
            zjycbtn.visible = false;
            infbBtn.visible = true;
         }
         else
         {
            zjycbtn.visible = true;
            infbBtn.visible = false;
            zjycbtn.addEventListener("click",zjycClick);
         }
         this.needtxt.selectable = false;
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         xBtn.removeEventListener("click",xClick);
         dhbtn.removeEventListener("click",dhClick);
         infbBtn.removeEventListener("click",infbClick);
         zjycbtn.removeEventListener("click",zjycClick);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
      }
      
      private function dhClick(e:MouseEvent) : void
      {
         if(gc.dataObject.whiteQiqiu >= 10)
         {
            if(this.judgeZBBackPack())
            {
               return;
            }
            gc.dataObject.whiteQiqiu -= 10;
            this.randomQiQiuFB();
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else
         {
            gc.ts.setTxt("白色气球数量不够");
            gc.stage.addChild(gc.ts);
         }
         this.setTxt();
      }
      
      private function randomQiQiuFB() : void
      {
         var random:uint = int(RandomControllor.getIns().getRandom() * 3);
         var fname:String = "hsqq";
         var msg:String = "";
         if(random == 0)
         {
            fname = "hsqq";
            msg = "成功兑换 红色气球X1";
         }
         else if(random == 1)
         {
            fname = "h_sqq";
            msg = "成功兑换 黄色气球X1";
         }
         else
         {
            fname = "lsqq";
            msg = "成功兑换 蓝色气球X1";
         }
         gc.ts.setTxt(msg);
         gc.stage.addChild(gc.ts);
         var equip:MyEquipObj = gc.allEquip.findByName(fname);
         if(equip)
         {
            gc.player1.zblist.push(equip);
         }
      }
      
      private function judgeZBBackPack() : Boolean
      {
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            if(gc.player1.zblist.length >= gc.player1.getMax())
            {
               bool = true;
               gc.ts.setTxt("1P装备栏已满");
               gc.stage.addChild(gc.ts);
            }
         }
         return bool;
      }
      
      private function infbClick(e:MouseEvent) : void
      {
         if(gc.dataObject.intoChildrenDayTime >= 1)
         {
            gc.dataObject.intoChildrenDayTime--;
            this.intoFB();
         }
      }
      
      private function zjycClick(e:MouseEvent) : void
      {
         this.addRenewalseMask("您确定花300点券再进一次吗？");
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
         if(gc.gameVip.dataObject.lastMoney < gc.dataObject.moreNeedMoney)
         {
            gc.ts.setTxt("账户余额不足");
            gc.stage.addChild(gc.ts);
            enough = false;
         }
         gc.pay.money = gc.dataObject.moreNeedMoney;
         if(enough)
         {
            if(GMain.serviceHold)
            {
               PayManager.getInstance().pay(7,"道具7",gc.pay.money,1);
               gc.lastPaymentString = "ChildrenExchange";
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
         if(gc.lastPaymentString != "ChildrenExchange")
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
         this.intoFB();
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
      
      private function intoFB() : void
      {
         if(MainGame.getInstance())
         {
            MainGame.getInstance().destroyGame();
         }
         gc.curStageAndCurLevel.curStage = 51;
         gc.curStageAndCurLevel.curLevel = 1;
         gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         gc.eventManger.dispatchEvent(new CommonEvent("ShowOtherScene"));
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function setTxt() : void
      {
         this.needtxt.text = gc.dataObject.whiteQiqiu + "";
      }
      
      private function xClick(e:Event) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
