package export.huodong.mysterious
{
   import AssetsClass.DragonMysteriousShopAssets;
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
   import mvc.controllor.RandomControllor;
   import my.FinancialInfo;
   
   public class MysteriousShop extends Sprite
   {
       
      
      public var x_btn:SimpleButton;
      
      public var open_btn:SimpleButton;
      
      public var addtime_btn:SimpleButton;
      
      public var gotoDragonShowBtn:SimpleButton;
      
      public var sp1:SingleShop;
      
      public var sp2:SingleShop;
      
      public var sp3:SingleShop;
      
      public var sp4:SingleShop;
      
      public var sp5:SingleShop;
      
      public var txttimes:TextField;
      
      public var txtlh:TextField;
      
      private var gc:Config;
      
      private var dataObject:Antiwear;
      
      private var biggest:int;
      
      private var hasbuy:Boolean = false;
      
      private var openall:String = "false";
      
      private var renewalse:RenewalseThisSZ;
      
      public function MysteriousShop()
      {
         super();
         gc = Config.getInstance();
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.dataObject = new Antiwear(new binaryEncrypt());
         this.dataObject.zoro_point_five = 0.5;
         this.dataObject.fifty = 50;
         this.dataObject.onehundred = 100;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         var i:* = 0;
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         this.x_btn.addEventListener("click",xClick);
         this.open_btn.addEventListener("click",openAllClick);
         this.addtime_btn.addEventListener("click",addTimesClick);
         this.gotoDragonShowBtn.visible = false;
         if(gc.getAverageLevelNumber() >= 40)
         {
            this.gotoDragonShowBtn.visible = true;
            this.gotoDragonShowBtn.addEventListener("click",gotoDragonClick);
         }
         for(i = uint(1); i <= 5; )
         {
            this["sp" + i].setTheShopNum(i);
            i++;
         }
         this.setBiggest(1);
         gc.eventManger.addEventListener("MysteriousShopBuySuccess",buyOver);
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         this.dataObject.whichstate = "";
         this.setText();
         gc.addMysteriousshoptimes();
      }
      
      private function removed(e:Event) : void
      {
         this.x_btn.removeEventListener("click",xClick);
         this.open_btn.removeEventListener("click",openAllClick);
         this.addtime_btn.removeEventListener("click",addTimesClick);
         gc.eventManger.removeEventListener("MysteriousShopBuySuccess",buyOver);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         this.gotoDragonShowBtn.removeEventListener("click",gotoDragonClick);
         if(this.hasbuy)
         {
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         this.openall == "false";
      }
      
      private function gotoDragonClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         var dragonmysteriousshop:DragonMysteriousShopAssets = new DragonMysteriousShopAssets();
         gc.stage.addChild(dragonmysteriousshop);
      }
      
      private function setText() : void
      {
         if(gc.player1.roleid > 0)
         {
            this.txtlh.text = gc.player1.getLhValue() + "";
         }
         if(gc.player1.roleid > 0 && gc.player2.roleid > 0)
         {
            this.txtlh.text = gc.player1.getLhValue() + gc.player2.getLhValue() + "";
         }
         this.txttimes.text = gc.dataObject.mysteriousshoptimes + "";
      }
      
      private function buyOver(e:CommonEvent) : void
      {
         var i:* = 0;
         i = 0;
         var curnum:* = null;
         this.hasbuy = true;
         for(i = uint(1); i <= 5; )
         {
            this["sp" + i].setTheShopNum(i);
            i++;
         }
         if(this.openall == "true")
         {
            for(i = uint(2); i <= 5; )
            {
               this["sp" + i].addMask();
               this.setBiggest(1);
               i++;
            }
            this.openall = "false";
         }
         else
         {
            curnum = e.data[0];
            if(curnum == "1")
            {
               if(this.getBiggest() == 1)
               {
                  if(RandomControllor.getIns().getRandom() > this.dataObject.zoro_point_five)
                  {
                     this.sp2.removedMask();
                     this.setBiggest(2);
                  }
               }
            }
            else if(curnum == "2")
            {
               if(RandomControllor.getIns().getRandom() > this.dataObject.zoro_point_five)
               {
                  this.sp3.removedMask();
                  this.setBiggest(3);
               }
               else
               {
                  this.setBiggest(1);
               }
               this.sp2.addMask();
            }
            else if(curnum == "3")
            {
               if(RandomControllor.getIns().getRandom() > this.dataObject.zoro_point_five)
               {
                  this.sp4.removedMask();
                  this.setBiggest(4);
               }
               else
               {
                  this.setBiggest(1);
               }
               this.sp3.addMask();
            }
            else if(curnum == "4")
            {
               if(RandomControllor.getIns().getRandom() > this.dataObject.zoro_point_five)
               {
                  this.sp5.removedMask();
                  this.setBiggest(5);
               }
               else
               {
                  this.setBiggest(1);
               }
               this.sp4.addMask();
            }
            else if(curnum == "5")
            {
               this.sp5.addMask();
               this.sp4.addMask();
               this.sp3.addMask();
               this.sp2.addMask();
               this.setBiggest(1);
            }
         }
         this.setText();
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function openAllClick(e:MouseEvent) : void
      {
         this.addRenewalseMask("openAllClick","您确定要花费50点券开启全部摊位?");
      }
      
      private function addTimesClick(e:MouseEvent) : void
      {
         this.addRenewalseMask("addTimesClick","您确定要花费100点券增加5次购买机会?");
      }
      
      private function paymentSuccess(e:CommonEvent) : void
      {
         var i:* = 0;
         if(gc.lastPaymentString != "MysteriouseShop")
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
         if(this.dataObject.whichstate == "openAllClick")
         {
            this.openall = "true";
            for(i = uint(1); i <= 5; )
            {
               this["sp" + i].removedMask();
               i++;
            }
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
               "id":10370,
               "ename":"custom"
            },1,1],[{
               "id":10370,
               "ename":"custom"
            },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         }
         else if(this.dataObject.whichstate == "addTimesClick")
         {
            gc.dataObject.mysteriousshoptimes += 5;
            trace("after :gc.getMysteriousShopTimes()---->>" + gc.dataObject.mysteriousshoptimes);
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
               "id":10380,
               "ename":"custom"
            },1,1],[{
               "id":10380,
               "ename":"custom"
            },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         }
         this.setText();
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
      
      private function setBiggest(v:int) : void
      {
         this.dataObject.biggest = v;
      }
      
      private function getBiggest() : int
      {
         return this.dataObject.biggest;
      }
      
      public function addRenewalseMask(ws:String, inst:String) : void
      {
         this.dataObject.whichstate = ws;
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
         if(this.dataObject.whichstate == "openAllClick")
         {
            if(gc.gameVip.dataObject.lastMoney < this.dataObject.fifty)
            {
               gc.ts.setTxt("账户余额不足");
               gc.stage.addChild(gc.ts);
               enough = false;
            }
            gc.pay.money = this.dataObject.fifty;
         }
         else if(this.dataObject.whichstate == "addTimesClick")
         {
            if(gc.gameVip.dataObject.lastMoney < this.dataObject.onehundred)
            {
               gc.ts.setTxt("账户余额不足");
               gc.stage.addChild(gc.ts);
               enough = false;
            }
            gc.pay.money = this.dataObject.onehundred;
         }
         if(enough)
         {
            if(GMain.serviceHold)
            {
               PayManager.getInstance().pay(18,"道具18",gc.pay.money,1);
               gc.lastPaymentString = "MysteriouseShop";
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
   }
}
