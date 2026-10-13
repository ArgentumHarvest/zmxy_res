package export.level
{
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import base.BaseObject;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.level.StageListener151Child.Stage151Boat;
   import export.level.StageListener223Children.MovingFloorSl223;
   import export.monster.Monster139;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.controllor.RandomControllor;
   import my.FinancialInfo;
   import my.KeyboardInput;
   import my.MainGame;
   
   public class StageListener223 extends BaseLevelListenering
   {
       
      
      private const WALLAPPEARCOUNT:uint = 72;
      
      private var wallAppearCurrentCount:int = 72;
      
      private var callSword:SimpleButton;
      
      private var isClickPay:Boolean = false;
      
      private var boss:Monster139;
      
      private var transferDoorBindFloor:MovingFloorSl223;
      
      private var transferDoor:MovieClip;
      
      private var maxMonsterCount:int = 30;
      
      private var monsterAppearCount:uint = 0;
      
      private var _anti:Antiwear;
      
      var tw:TweenMax;
      
      var bm:BaseMonster;
      
      private var renewalse:RenewalseThisSZ;
      
      public function StageListener223()
      {
         super();
         waitForRegisterDataArray = ["Monster139","Monster133","Monster136"];
         this._anti = new Antiwear(new binaryEncrypt());
         this._anti.resetPropertyCost = 100;
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
      }
      
      override public function step() : void
      {
         super.step();
         if(this.transferDoor)
         {
            if(this.transferDoorBindFloor)
            {
               this.transferDoor.x = this.transferDoorBindFloor.x;
               this.transferDoor.y = this.transferDoorBindFloor.y - 50;
            }
         }
         if(this.maxMonsterCount > 0)
         {
            if(this.monsterAppearCount == gc.frameClips)
            {
               this.createMonster();
               this.monsterAppearCount = 0;
            }
         }
         else if(this.maxMonsterCount == 0)
         {
            if(gc.pWorld.monsterArray.length == 0)
            {
               this.createBoss();
            }
         }
         if(this.monsterAppearCount < gc.frameClips)
         {
            var _loc1_:* = this;
            var _loc2_:* = _loc1_.monsterAppearCount + 1;
            _loc1_.monsterAppearCount = _loc2_;
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
            if(RandomControllor.getIns().getRandom() < 0.5)
            {
               MainGame.getInstance().createMonster(136,100 + RandomControllor.getIns().getRandom() * 600,RandomControllor.getIns().getRandom() * 400);
            }
            else
            {
               MainGame.getInstance().createMonster(133,100 + RandomControllor.getIns().getRandom() * 600,RandomControllor.getIns().getRandom() * 400);
            }
         }
         --this.maxMonsterCount;
      }
      
      private function createBoss() : void
      {
         this.boss = MainGame.getInstance().createMonster(139,100 + RandomControllor.getIns().getRandom() * 600,100 + RandomControllor.getIns().getRandom() * 200) as Monster139;
         --this.maxMonsterCount;
      }
      
      override public function start() : void
      {
         var wall:MovingFloorSl223 = new MovingFloorSl223(1);
         wall.x = 150;
         wall.y = 400;
         wall.initY = 400;
         gc.gameSence.addChild(wall);
         gc.pWorld.getWallArray().push(wall);
         wall = new MovingFloorSl223(2);
         wall.x = 450;
         wall.y = 300;
         wall.initY = 300;
         gc.gameSence.addChild(wall);
         gc.pWorld.getWallArray().push(wall);
         wall = new MovingFloorSl223(2);
         wall.x = 750;
         wall.y = 200;
         wall.initY = 200;
         gc.gameSence.addChild(wall);
         gc.pWorld.getWallArray().push(wall);
         wall = new MovingFloorSl223(2);
         wall.x = 450;
         wall.y = 100;
         wall.initY = 100;
         gc.gameSence.addChild(wall);
         gc.pWorld.getWallArray().push(wall);
         wall = new MovingFloorSl223(1);
         wall.x = 150;
         wall.y = 0;
         wall.initY = 0;
         gc.gameSence.addChild(wall);
         gc.pWorld.getWallArray().push(wall);
         wall = new MovingFloorSl223(2);
         wall.x = 450;
         wall.y = -200;
         wall.initY = -200;
         gc.gameSence.addChild(wall);
         gc.pWorld.getWallArray().push(wall);
         this.transferDoorBindFloor = wall;
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         super.start();
         gc.eventManger.addEventListener("BuySuccess",buySuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         this.callSword = AUtils.getNewObj("callQinglongSword") as SimpleButton;
         this.callSword.x = 400;
         this.callSword.y = 60;
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
         this.isClickPay = true;
         gc.pay.money = this._anti.resetPropertyCost;
         gc.lastPaymentString = "StageListener223";
         gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[100000]));
         if(renewalse && gc.gameInfo.contains(renewalse))
         {
            gc.gameInfo.removeChild(renewalse);
         }
         MainGame.getInstance().continueGame();
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
         if(gc.lastPaymentString != "StageListener223")
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
      
      override public function callRewardMonster() : BaseMonster
      {
         var bm:BaseMonster = super.callRewardMonster();
         if(bm)
         {
            this.addBoatByBaseObject(bm);
         }
         return bm;
      }
      
      override protected function callMonsterById(id:int, xx:Number, yy:Number) : BaseMonster
      {
         var bm:BaseMonster = super.callMonsterById(id,xx,yy);
         this.addBoatByBaseObject(bm);
         return bm;
      }
      
      public function addTransferDoor() : void
      {
         this.transferDoor = AUtils.getNewObj("transferDoor") as MovieClip;
         this.transferDoor.x = this.transferDoorBindFloor.x;
         this.transferDoor.y = this.transferDoorBindFloor.y - 50;
         gc.gameSence.addChild(this.transferDoor);
         gc.pWorld.getTransferDoorArray().push(this.transferDoor);
      }
      
      override public function destroy() : void
      {
         this.boss = null;
         this.renewalse = null;
         this.transferDoorBindFloor = null;
         this.transferDoor = null;
         if(this.callSword)
         {
            this.callSword.removeEventListener("click",__zhaohuanSwordClick);
            this.callSword = null;
         }
         gc.eventManger.removeEventListener("BuySuccess",buySuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
         super.destroy();
      }
   }
}
