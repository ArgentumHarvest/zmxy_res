package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import base.BaseObject;
   import base.BasePet;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.level.stagelistener531Children.Stagelistener531Sun;
   import export.monster.Monster173;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.PayManager;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class StageListener531 extends BaseLevelListenering
   {
       
      
      private var tw:TweenMax;
      
      private var boss:Monster173;
      
      private var sumAry:Array;
      
      private const MAX_SUN_COUNT:uint = 10;
      
      private var callSword:SimpleButton;
      
      private var isClickPay:Boolean = false;
      
      private var _anti:Antiwear;
      
      private var renewalse:RenewalseThisSZ;
      
      private var secCount:uint = 24;
      
      public function StageListener531()
      {
         sumAry = [];
         super();
         this.waitForRegisterDataArray = ["Monster172","Monster173"];
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this._anti = new Antiwear(new binaryEncrypt());
         this._anti.resetPropertyCost = 200;
      }
      
      private function __zhaohuanSwordClick(evt:MouseEvent) : void
      {
         MainGame.getInstance().stopGame();
         this.addRenewalseMask("你确定花200点券召唤后羿来协助你？后羿在场时太阳灼烧效果减半");
      }
      
      public function addRenewalseMask(inst:String) : void
      {
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
         if(gc.gameVip.dataObject.lastMoney < this._anti.resetPropertyCost)
         {
            gc.ts.setTxt("账户余额不足");
            gc.stage.addChild(gc.ts);
            enough = false;
         }
         if(enough)
         {
            this.isClickPay = true;
            gc.pay.money = this._anti.resetPropertyCost;
            if(GMain.serviceHold)
            {
               PayManager.getInstance().pay(32,"道具32",gc.pay.money,1);
               gc.lastPaymentString = "StageListener531";
               gc.addActionMask("renewalse");
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
         if(gc.lastPaymentString != "StageListener531")
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
         if(this.isClickPay)
         {
            this.isClickPay = false;
            this.callSummonHouyi();
            if(this.callSword && this.callSword.parent)
            {
               this.callSword.parent.removeChild(this.callSword);
            }
            if(renewalse && gc.gameInfo.contains(renewalse))
            {
               gc.gameInfo.removeChild(renewalse);
            }
            MainGame.getInstance().continueGame();
            return;
         }
      }
      
      private function paymentFail(e:CommonEvent) : void
      {
         this.isClickPay = false;
         gc.renewalseFail();
         MainGame.getInstance().continueGame();
      }
      
      override public function step() : void
      {
         var level:* = 0;
         var hurt:Number = NaN;
         var totalHurt:* = 0;
         super.step();
         if(this.boss)
         {
            this.boss.step();
            if(this.boss.isDead())
            {
               this.callSun();
               this.boss = null;
            }
         }
         if(sumAry.length > 1)
         {
            if(secCount > 0)
            {
               secCount--;
               if(secCount == 0)
               {
                  for each(var bo in gc.getPlayerAndPetArray())
                  {
                     level = uint(sumAry.length + 1);
                     hurt = level * 0.002;
                     if(this.summon)
                     {
                        hurt /= 2;
                     }
                     totalHurt = uint(0);
                     if(bo is BaseHero)
                     {
                        totalHurt = uint(hurt * BaseHero(bo).roleProperies.getSHHP());
                        BaseHero(bo).reduceHp(totalHurt);
                     }
                     else if(bo is BasePet)
                     {
                        totalHurt = uint(hurt * BasePet(bo).petInfo.getSHp());
                        BasePet(bo).reduceHp(totalHurt);
                     }
                  }
                  secCount = 24;
               }
            }
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
         if(gc.stage531Type == 1)
         {
            this.initSun();
         }
         super.start();
         if(gc.stage531Type == 0)
         {
            tw = TweenMax.delayedCall(1,function():*
            {
               MainGame.getInstance().createMonster(172,500,200);
            });
         }
         else
         {
            this.callSun();
            this.callSword = AUtils.getNewObj("houyiCall") as SimpleButton;
            this.callSword.x = 400;
            this.callSword.y = 80;
            gc.gameInfo.addChild(this.callSword);
            this.callSword.addEventListener("click",__zhaohuanSwordClick,false,0,true);
         }
         gc.eventManger.addEventListener("BuySuccess",buySuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
      }
      
      private function callSun() : void
      {
         if(sumAry.length == 1)
         {
            return;
         }
         tw = TweenMax.delayedCall(1,function(_self:StageListener531):*
         {
            _self.callBoss();
         },[this]);
      }
      
      public function callBoss() : void
      {
         var rand:uint = RandomControllor.getIns().getRandom() * sumAry.length;
         var bmAry:Array = sumAry.splice(rand,1);
         if(Stagelistener531Sun(bmAry[0]).parent)
         {
            Stagelistener531Sun(bmAry[0]).parent.removeChild(Stagelistener531Sun(bmAry[0]));
         }
         var curLevel:uint = 10 - sumAry.length;
         this.boss = MainGame.getInstance().createMonster(173,Stagelistener531Sun(bmAry[0]).x,Stagelistener531Sun(bmAry[0]).y) as Monster173;
         this.boss.setLevel(curLevel);
      }
      
      private function initSun() : void
      {
         var i:* = 0;
         var bm:* = null;
         var posXArr:Array = [80,160,240,320,400,480,560,640,720,800];
         for(i = uint(0); i < 10; )
         {
            bm = new Stagelistener531Sun();
            bm.x = posXArr[i] + (RandomControllor.getIns().getRandom() - 0.5) * 40;
            bm.y = 50 + RandomControllor.getIns().getRandom() * 150;
            gc.gameSence.addChild(bm);
            sumAry.push(bm);
            i++;
         }
      }
      
      override public function destroy() : void
      {
         if(this.tw)
         {
            this.tw.kill();
            this.tw = null;
         }
         if(this.renewalse)
         {
            if(this.renewalse.parent)
            {
               this.renewalse.parent.removeChild(this.renewalse);
            }
            this.renewalse = null;
         }
         if(this.callSword)
         {
            this.callSword.removeEventListener("click",__zhaohuanSwordClick);
            this.callSword = null;
         }
         gc.eventManger.removeEventListener("BuySuccess",buySuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         if(this.boss)
         {
            this.boss.destroy();
            this.boss = null;
         }
         for each(var bm in sumAry)
         {
            bm.destroy();
         }
         sumAry = null;
         super.destroy();
      }
   }
}
