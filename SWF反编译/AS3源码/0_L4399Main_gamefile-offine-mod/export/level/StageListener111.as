package export.level
{
   import base.BaseLevelListenering;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import event.CommonEvent;
   import export.level.StageListener111Child.Stage111Info;
   import export.level.StageListener111Child.Stage111Resule;
   import export.monster.Monster48;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.controllor.RandomControllor;
   import my.FinancialInfo;
   import my.MainGame;
   
   public class StageListener111 extends BaseLevelListenering
   {
       
      
      private var _kindArray:Array;
      
      private var _anti:Antiwear;
      
      private var _stage111Info:Stage111Info;
      
      private var jixiangBtn:SimpleButton;
      
      private var fuxingBtn:SimpleButton;
      
      private var renewalse:RenewalseThisSZ;
      
      private var chooseType:uint = 0;
      
      private var liuliudashun:Boolean = false;
      
      private var yifanfengshun:Boolean = false;
      
      private var sijipingan:Boolean = false;
      
      public function StageListener111()
      {
         this._kindArray = [20,21,22,23,24];
         super();
         this.waitForRegisterDataArray = ["Monster48"];
         this._anti = new Antiwear(new binaryEncrypt());
         this._anti.timeCount = gc.frameClips * 60;
         this._anti.dropRateAdd = 0;
         this._anti.buyTimesAdd = 0;
         this._anti.resetPropertyCost = 300;
      }
      
      override public function step() : void
      {
         var stage111Result:Stage111Resule = null;
         super.step();
         if(this._anti.timeCount > 0)
         {
            if(this._anti.timeCount > gc.frameClips * 10)
            {
               this.checkMonsterAppear();
            }
            var _loc4_:* = this._anti;
            var _loc5_:* = Number(_loc4_.timeCount) - 1;
            _loc4_.timeCount = _loc5_;
            if(this._anti.timeCount == 0)
            {
               fuxingBtn.visible = false;
               jixiangBtn.visible = false;
               for each(var bm in gc.pWorld.monsterArray)
               {
                  bm.destroy();
               }
               stage111Result = new Stage111Resule(this._anti.dropRateAdd,this._anti.buyTimesAdd);
               stage111Result.x = 480;
               stage111Result.y = 250;
               GMain.getInstance().getTopSence().addChild(stage111Result);
            }
            else if(this._anti.timeCount == gc.frameClips * 10)
            {
               this.monsterAppear(true);
            }
         }
         if(this._stage111Info)
         {
            this._stage111Info.updateTimeCountDisplay(this._anti.timeCount / gc.frameClips);
         }
         var sec:int = this._anti.timeCount / gc.frameClips;
         if(!this.yifanfengshun)
         {
            if(int(this._anti.dropRateAdd + this._anti.buyTimesAdd * 3 + sec) == 111)
            {
               this.callMonster48(1,11);
               gc.ts.setTxt("一帆风顺",5);
               gc.stage.addChild(gc.ts);
               this.setLeftTime(10);
               this.yifanfengshun = true;
            }
         }
         if(!this.sijipingan)
         {
            if(int(this._anti.dropRateAdd + this._anti.buyTimesAdd * 3 + sec) == 44)
            {
               this.callMonster48(1,4);
               gc.ts.setTxt("四季平安",5);
               gc.stage.addChild(gc.ts);
               this.setLeftTime(10);
               this.sijipingan = true;
            }
         }
         if(!this.liuliudashun)
         {
            if(int(this._anti.dropRateAdd + this._anti.buyTimesAdd * 3 + sec) == 66)
            {
               this.callMonster48(4,1);
               gc.ts.setTxt("六六大顺",5);
               gc.stage.addChild(gc.ts);
               this.setLeftTime(10);
               this.liuliudashun = true;
            }
         }
      }
      
      private function setLeftTime(sec:uint) : void
      {
         if(this._anti.timeCount < gc.frameClips * sec)
         {
            this._anti.timeCount = gc.frameClips * sec;
         }
      }
      
      override public function start() : void
      {
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         super.start();
         gc.threebossChanllenge[0] = 1;
         if(!this._stage111Info)
         {
            this._stage111Info = new Stage111Info();
            this._stage111Info.x = 480;
            this._stage111Info.y = 70;
            if(gc.gameInfo)
            {
               gc.gameInfo.addChild(this._stage111Info);
            }
         }
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.fuxingBtn = AUtils.getNewObj("fuxingBtn") as SimpleButton;
         this.fuxingBtn.x = 750;
         this.fuxingBtn.y = 250;
         this.fuxingBtn.addEventListener("click",__fuxingClick);
         this.jixiangBtn = AUtils.getNewObj("jixiangBtn") as SimpleButton;
         this.jixiangBtn.x = 750;
         this.jixiangBtn.y = 310;
         this.jixiangBtn.addEventListener("click",__jixiangClick);
         gc.gameInfo.addChild(this.fuxingBtn);
         gc.gameInfo.addChild(this.jixiangBtn);
         gc.eventManger.addEventListener("BuySuccess",buySuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
      }
      
      private function __fuxingClick(evt:MouseEvent) : void
      {
         MainGame.getInstance().stopGame();
         this.addRenewalseMask("您确定花300点券召唤一个黄金骰子吗？",0);
      }
      
      private function __jixiangClick(evt:MouseEvent) : void
      {
         MainGame.getInstance().stopGame();
         this.addRenewalseMask("您确定花10000灵魂召唤5个红色骰子吗？",1);
      }
      
      public function addRenewalseMask(inst:String, type:uint) : void
      {
         this.chooseType = type;
         renewalse["txt"].text = inst;
         gc.gameInfo.addChild(renewalse);
         renewalse["okbtn"].addEventListener("click",renewalseOk);
         renewalse["nobtn"].addEventListener("click",renewalseChange);
      }
      
      private function renewalseOk(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         var enough:Boolean = true;
         if(this.chooseType == 0)
         {
            if(gc.gameVip.dataObject.lastMoney < this._anti.resetPropertyCost)
            {
               gc.ts.setTxt("账户余额不足");
               gc.stage.addChild(gc.ts);
               enough = false;
            }
         }
         else
         {
            for each(var bh in gc.getPlayerArray())
            {
               if(bh.getPlayer().getLhValue() < 10000)
               {
                  gc.ts.setTxt("灵魂不足");
                  gc.stage.addChild(gc.ts);
                  enough = false;
                  break;
               }
            }
         }
         if(enough)
         {
            if(this.chooseType == 0)
            {
               gc.pay.money = this._anti.resetPropertyCost;
               gc.lastPaymentString = "SatgeListener111";
               gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[100000]));
            }
            else
            {
               for each(bh in gc.getPlayerArray())
               {
                  bh.getPlayer().setLhValue(bh.getPlayer().getLhValue() - 10000);
               }
               this.jixiangBtn.removeEventListener("click",__jixiangClick);
               this.jixiangBtn.visible = false;
               this.callMonster48(1,5);
               this.setLeftTime(10);
               if(renewalse && gc.gameInfo.contains(renewalse))
               {
                  gc.gameInfo.removeChild(renewalse);
               }
               MainGame.getInstance().continueGame();
            }
         }
         else
         {
            if(renewalse && gc.gameInfo.contains(renewalse))
            {
               gc.gameInfo.removeChild(renewalse);
            }
            MainGame.getInstance().continueGame();
         }
      }
      
      private function renewalseChange(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && gc.gameInfo.contains(renewalse))
         {
            gc.gameInfo.removeChild(renewalse);
         }
         MainGame.getInstance().continueGame();
      }
      
      private function buySuccess(evt:CommonEvent) : void
      {
         if(gc.lastPaymentString != "SatgeListener111")
         {
            return;
         }
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         gc.lastPaymentString = "";
         this.setLeftTime(10);
         this.monsterAppear(true);
         FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
            "id":10410,
            "ename":"custom"
         },1,1],[{
            "id":10410,
            "ename":"custom"
         },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         if(renewalse && gc.gameInfo.contains(renewalse))
         {
            gc.gameInfo.removeChild(renewalse);
         }
         MainGame.getInstance().continueGame();
      }
      
      private function paymentFail(e:CommonEvent) : void
      {
         gc.renewalseFail();
         MainGame.getInstance().continueGame();
      }
      
      public function setKillNumByKind(k:uint) : void
      {
         var rate:int = 20;
         if(k == 20)
         {
            this._anti.dropRateAdd += 1 * rate;
         }
         else if(k == 21)
         {
            this._anti.buyTimesAdd += 1 * rate;
         }
         else if(k == 22)
         {
            this._anti.dropRateAdd += 5 * rate;
         }
         else if(k == 23)
         {
            this._anti.dropRateAdd += 2 * rate;
         }
         else if(k == 24)
         {
            this._anti.dropRateAdd += 50 * rate;
         }
         if(this._stage111Info)
         {
            this._stage111Info.updateThrowTimeDisplay(this._anti.dropRateAdd);
            this._stage111Info.updateChangeLuckDisplay(this._anti.buyTimesAdd);
         }
      }
      
      public function setDropRateAddByGoldHurt() : void
      {
         this._anti.dropRateAdd += 10;
         if(this._stage111Info)
         {
            this._stage111Info.updateThrowTimeDisplay(this._anti.dropRateAdd);
            this._stage111Info.updateChangeLuckDisplay(this._anti.buyTimesAdd);
         }
      }
      
      private function checkMonsterAppear() : void
      {
         if(gc.pWorld.monsterArray.length == 0)
         {
            this.monsterAppear();
         }
      }
      
      private function monsterAppear(gold:Boolean = false) : void
      {
         var pointX:Number = Number(NaN);
         var pointY:Number = Number(NaN);
         var bm48:Monster48 = null;
         var i:* = 0;
         var kind:* = 0;
         pointX = Number(NaN);
         pointY = Number(NaN);
         bm48 = null;
         if(gold)
         {
            pointX = 450 + (RandomControllor.getIns().getRandom() - 0.5) * 700;
            pointY = 50;
            bm48 = MainGame.getInstance().createMonster(48,pointX,pointY) as Monster48;
            bm48.setKind(24);
         }
         else
         {
            i = 0;
            while(i < 5)
            {
               kind = int(RandomControllor.getIns().getRandom() * this._kindArray.length);
               if(kind == 4)
               {
                  kind = 3;
               }
               pointX = 450 + (RandomControllor.getIns().getRandom() - 0.5) * 700;
               pointY = 50;
               bm48 = MainGame.getInstance().createMonster(48,pointX,pointY) as Monster48;
               bm48.setKind(this._kindArray[kind]);
               i++;
            }
         }
      }
      
      private function callMonster48(kind:uint, num:uint) : void
      {
         var i:* = 0;
         var pointX:Number = Number(NaN);
         var pointY:Number = Number(NaN);
         var bm48:Monster48 = null;
         i = 0;
         while(i < num)
         {
            pointX = 450 + (RandomControllor.getIns().getRandom() - 0.5) * 700;
            pointY = 50;
            bm48 = MainGame.getInstance().createMonster(48,pointX,pointY) as Monster48;
            bm48.setKind(this._kindArray[kind]);
            i++;
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this._kindArray.length = 0;
         this._anti = null;
         if(this._stage111Info)
         {
            this._stage111Info.destroy();
            this._stage111Info = null;
         }
         gc.eventManger.removeEventListener("BuySuccess",buySuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
      }
   }
}
