package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import base.BaseObject;
   import base.BasePet;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.level.StageListener151Child.Stage151Boat;
   import export.level.StageListener222Children.MovingFloorSl222;
   import export.level.StageListener222Children.Stage222Boat;
   import export.monster.Monster135;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.PayManager;
   import mvc.controllor.RandomControllor;
   import my.FinancialInfo;
   import my.KeyboardInput;
   import my.MainGame;
   
   public class StageListener222 extends BaseLevelListenering
   {
       
      
      private var moveAbleFloorsArray:Array;
      
      private const WALLAPPEARCOUNT:uint = 72;
      
      private var wallAppearCurrentCount:int = 72;
      
      private var monsterAppearCount:uint = 72;
      
      private var monsterCurAppearCount:uint;
      
      private var totalMonsterCount:int = 20;
      
      private var callSword:SimpleButton;
      
      private var isClickPay:Boolean = false;
      
      private var boss:Monster135;
      
      private var _anti:Antiwear;
      
      var tw:TweenMax;
      
      var bm:BaseMonster;
      
      private var renewalse:RenewalseThisSZ;
      
      public function StageListener222()
      {
         moveAbleFloorsArray = [];
         monsterCurAppearCount = monsterAppearCount;
         super();
         waitForRegisterDataArray = [];
         this._anti = new Antiwear(new binaryEncrypt());
         this._anti.resetPropertyCost = 100;
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
      }
      
      override public function step() : void
      {
         super.step();
         if(this.wallAppearCurrentCount > 0)
         {
            this.wallAppearCurrentCount--;
            if(this.wallAppearCurrentCount == 0)
            {
               this.createWall();
               this.wallAppearCurrentCount = 72;
            }
         }
         if(this.totalMonsterCount > 0)
         {
            if(this.monsterCurAppearCount > 0)
            {
               this.monsterCurAppearCount--;
               if(this.monsterCurAppearCount == 0)
               {
                  this.createMonster();
                  this.monsterCurAppearCount = this.monsterAppearCount;
               }
            }
         }
         else if(this.totalMonsterCount == 0)
         {
            if(gc.pWorld.monsterArray.length == 0)
            {
               this.createBoss();
               this.totalMonsterCount--;
            }
         }
         if(this.boss)
         {
            if(this.boss.getHp() / this.boss.getSHp() < 0.01)
            {
               for each(var mf in this.moveAbleFloorsArray)
               {
                  mf.setStatic();
                  this.wallAppearCurrentCount = -1;
               }
            }
         }
         if(!gc.isStopGame)
         {
            if(KeyboardInput.getIns().isJustKeyDown(81))
            {
               this.callSword.dispatchEvent(new MouseEvent("click"));
            }
         }
      }
      
      private function createMonster() : void
      {
         if(gc.pWorld.monsterArray.length < 10)
         {
            MainGame.getInstance().createMonster(136,300 + RandomControllor.getIns().getRandom() * 800,100 + RandomControllor.getIns().getRandom() * 200);
         }
         this.totalMonsterCount--;
      }
      
      override public function callRewardMonster() : BaseMonster
      {
         var bm:BaseMonster = super.callRewardMonster();
         if(bm)
         {
            this.addBoatByBaseObject(bm);
         }
         return bm;
      }
      
      private function createBoss() : void
      {
         this.boss = MainGame.getInstance().createMonster(135,300 + RandomControllor.getIns().getRandom() * 800,100 + RandomControllor.getIns().getRandom() * 200) as Monster135;
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
         this.createInitHeroWall();
         for each(var bo in gc.getPlayerAndPetArray())
         {
            bo.x = 100;
         }
         for each(var bp in gc.getPetArray())
         {
            this.addBoatByBaseObject(bp);
         }
         gc.eventManger.addEventListener("BuySuccess",buySuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         this.callSword = AUtils.getNewObj("callQinglongSword") as SimpleButton;
         this.callSword.x = 400;
         this.callSword.y = 80;
         gc.gameInfo.addChild(this.callSword);
         this.callSword.addEventListener("click",__zhaohuanSwordClick);
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
               PayManager.getInstance().pay(28,"道具28",gc.pay.money,1);
               gc.lastPaymentString = "StageListener222";
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
         if(gc.lastPaymentString != "StageListener222")
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
      
      override protected function callMonsterById(id:int, xx:Number, yy:Number) : BaseMonster
      {
         var bm:BaseMonster = super.callMonsterById(id,xx,yy);
         this.addBoatByBaseObject(bm);
         return bm;
      }
      
      public function addMonsterBoatByBaseObject(bo:BaseObject) : void
      {
         var swordBoat:Stage222Boat = new Stage222Boat(bo,-1);
         swordBoat.x = bo.x;
         swordBoat.y = bo.y + 90;
         gc.pWorld.getWallArray().push(swordBoat);
         gc.gameSence.addChild(swordBoat);
      }
      
      private function createInitHeroWall() : void
      {
         var mf:MovingFloorSl222 = new MovingFloorSl222();
         mf.x = 100;
         mf.y = 450;
         mf.speedX = 3;
         mf.width = 110;
         mf.visible = false;
         gc.gameSence.addChildAt(mf,gc.getMinIdxInHeroAndPet());
         gc.pWorld.getWallArray().push(mf);
         this.moveAbleFloorsArray.push(mf);
      }
      
      private function createWall() : void
      {
         var mf:MovingFloorSl222 = new MovingFloorSl222();
         mf.randomInit();
         gc.gameSence.addChildAt(mf,gc.getMinIdxInHeroAndPet());
         gc.pWorld.getWallArray().push(mf);
         this.moveAbleFloorsArray.push(mf);
      }
      
      public function addTransferDoor() : void
      {
         var mf:MovingFloorSl222 = new MovingFloorSl222();
         mf.randomInit();
         mf.x = 800;
         mf.y = 350;
         gc.gameSence.addChildAt(mf,gc.getMinIdxInHeroAndPet());
         gc.pWorld.getWallArray().push(mf);
         this.moveAbleFloorsArray.push(mf);
         var door:MovieClip = AUtils.getNewObj("transferDoor") as MovieClip;
         door.x = mf.x;
         door.y = mf.y - 50;
         gc.gameSence.addChild(door);
         gc.pWorld.getTransferDoorArray().push(door);
      }
      
      override public function destroy() : void
      {
         for each(var mf in this.moveAbleFloorsArray)
         {
            mf.destroy();
         }
         this.callSword.removeEventListener("click",__zhaohuanSwordClick);
         this.callSword = null;
         this.boss = null;
         this.moveAbleFloorsArray.length = 0;
         this.renewalse = null;
         gc.eventManger.removeEventListener("BuySuccess",buySuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         super.destroy();
      }
   }
}
