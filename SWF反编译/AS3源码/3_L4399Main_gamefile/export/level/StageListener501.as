package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import base.BaseObject;
   import base.Wall;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import event.CommonEvent;
   import export.level.StageListener151Child.Stage151Boat;
   import export.level.Stagelistener501Children.MovingFloorSl501;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.PayManager;
   import my.FinancialInfo;
   import my.KeyboardInput;
   import my.MainGame;
   
   public class StageListener501 extends BaseLevelListenering
   {
       
      
      private var boss:BaseMonster;
      
      private var isGameOver:Boolean = false;
      
      private var boat:MovingFloorSl501;
      
      private var transferDoor:MovieClip;
      
      private var callSword:SimpleButton;
      
      private var isClickPay:Boolean = false;
      
      private var _anti:Antiwear;
      
      private var renewalse:RenewalseThisSZ;
      
      public function StageListener501()
      {
         super();
         this.waitForRegisterDataArray = ["Monster" + gc.baxianMonsterId];
         this._anti = new Antiwear(new binaryEncrypt());
         this._anti.resetPropertyCost = 100;
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
      }
      
      override public function step() : void
      {
         super.step();
         if(!this.isGameOver)
         {
            if(this.boss)
            {
               if(this.boss.isDead())
               {
                  if(this.boat)
                  {
                     this.addTransferDoor();
                     this.boat.speedX = 0;
                     this.boss.fallEquipOffset.x = this.boat.x - this.boss.x;
                     this.boss.fallEquipOffset.y = -200;
                     this.isGameOver = true;
                  }
               }
            }
         }
         if(!gc.isStopGame)
         {
            if(this.callSword.parent)
            {
               if(KeyboardInput.getIns().isJustKeyDown(81))
               {
                  this.callSword.dispatchEvent(new MouseEvent("click"));
               }
            }
         }
      }
      
      override public function start() : void
      {
         var bossRoad:* = null;
         super.start();
         for each(var wall in gc.pWorld.getWallArray())
         {
            if(!bossRoad)
            {
               bossRoad = wall;
            }
            else
            {
               bossRoad = bossRoad.y > wall.y ? bossRoad : wall;
            }
         }
         if(bossRoad)
         {
            bossRoad.wallFilterIdx = 1;
         }
         for each(var bh in gc.getPlayerArray())
         {
            bh.wallFilterArray.push(1);
         }
         this.boat = new MovingFloorSl501();
         this.boat.x = 200;
         this.boat.y = 500;
         this.boat.width = 390;
         this.boat.visible = false;
         this.boat.wallFilterIdx = 2;
         gc.gameSence.addChildAt(this.boat,gc.getMinIdxInHeroAndPet());
         gc.pWorld.getWallArray().push(this.boat);
         this.boss = MainGame.getInstance().createMonster(gc.baxianMonsterId,600,200);
         this.boss.wallFilterArray.push(2);
         this.callSword = AUtils.getNewObj("callQinglongSwordsl501") as SimpleButton;
         this.callSword.x = 400;
         this.callSword.y = 80;
         gc.gameInfo.addChild(this.callSword);
         this.callSword.addEventListener("click",__zhaohuanSwordClick);
         gc.eventManger.addEventListener("BuySuccess",buySuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
      }
      
      private function __zhaohuanSwordClick(evt:MouseEvent) : void
      {
         MainGame.getInstance().stopGame();
         this.addRenewalseMask("你确定花100点券召唤一把永恒的青龙剑来协助你吗？");
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
         if(!gc.isHideDebug)
         {
            gc.lastPaymentString = "StageListener501";
            this.isClickPay = true;
            this.buySuccess(null);
            return;
         }
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
               PayManager.getInstance().pay(31,"道具31",gc.pay.money,1);
               gc.lastPaymentString = "StageListener501";
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
         if(gc.lastPaymentString != "StageListener501")
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
            FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
               "id":10620,
               "ename":"custom"
            },1,1],[{
               "id":10620,
               "ename":"custom"
            },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
            for each(var bh in gc.getPlayerArray())
            {
               this.addBoatByBaseObject(bh);
            }
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
      
      public function addBoatByBaseObject(bo:BaseObject) : void
      {
         var swordBoat:Stage151Boat = new Stage151Boat(bo,-1);
         swordBoat.x = bo.x;
         swordBoat.y = bo.y + 90;
         gc.pWorld.getWallArray().push(swordBoat);
         gc.gameSence.addChild(swordBoat);
      }
      
      private function addTransferDoor() : void
      {
         this.transferDoor = AUtils.getNewObj("transferDoor") as MovieClip;
         this.transferDoor.x = this.boat.x;
         this.transferDoor.y = this.boat.y - 60;
         gc.gameSence.addChild(this.transferDoor);
         gc.pWorld.getTransferDoorArray().push(this.transferDoor);
      }
      
      override public function destroy() : void
      {
         gc.eventManger.removeEventListener("BuySuccess",buySuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         this.callSword.removeEventListener("click",__zhaohuanSwordClick);
         this.boat = null;
         this.boss = null;
         this.transferDoor = null;
         this.callSword = null;
         super.destroy();
      }
   }
}
