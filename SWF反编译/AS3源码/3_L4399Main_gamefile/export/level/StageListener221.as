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
   import export.level.StageListener221Children.MovingFloor;
   import export.level.StageListener221Children.MusicSprite;
   import export.monster.Monster131;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.PayManager;
   import mvc.controllor.RandomControllor;
   import my.FinancialInfo;
   import my.KeyboardInput;
   import my.MainGame;
   
   public class StageListener221 extends BaseLevelListenering
   {
       
      
      private var moveAbleFloorsArray:Array;
      
      private var musicSprite:MusicSprite;
      
      private var m131:Monster131;
      
      private var monsterAppearCount:uint = 96;
      
      private var currentMonsterAppearCount:uint;
      
      private var m131TotalNums:int = 100;
      
      private var callSword:SimpleButton;
      
      private var isClickPay:Boolean = false;
      
      private var _anti:Antiwear;
      
      var tw:TweenMax;
      
      var bm:BaseMonster;
      
      private var renewalse:RenewalseThisSZ;
      
      public function StageListener221()
      {
         moveAbleFloorsArray = [];
         currentMonsterAppearCount = monsterAppearCount;
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
         if(this.musicSprite)
         {
            if(this.musicSprite.currentState == 0)
            {
               if(this.m131TotalNums > 0)
               {
                  if(gc.pWorld.monsterArray.length < 5)
                  {
                     if(this.currentMonsterAppearCount > 0)
                     {
                        this.currentMonsterAppearCount--;
                        if(this.currentMonsterAppearCount == 0)
                        {
                           this.addMonster133();
                           this.currentMonsterAppearCount = this.monsterAppearCount;
                           this.m131TotalNums--;
                        }
                     }
                  }
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
         this.createWall();
         for each(var bo in gc.getPlayerAndPetArray())
         {
            bo.x = 100;
         }
         for each(var bp in gc.getPetArray())
         {
            this.addBoatByBaseObject(bp);
         }
         this.musicSprite = new MusicSprite();
         this.musicSprite.x = 480;
         this.musicSprite.y = 50;
         gc.gameInfo.addChild(this.musicSprite);
         var door:MovieClip = AUtils.getNewObj("transferDoor") as MovieClip;
         door.x = 1030;
         door.y = 395;
         door.visible = false;
         gc.gameSence.addChild(door);
         gc.pWorld.getTransferDoorArray().push(door);
         gc.eventManger.addEventListener("BuySuccess",buySuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         this.callSword = AUtils.getNewObj("callQinglongSword") as SimpleButton;
         this.callSword.x = 400;
         this.callSword.y = 80;
         gc.gameInfo.addChild(this.callSword);
         this.callSword.addEventListener("click",__zhaohuanSwordClick);
      }
      
      private function createWall() : void
      {
         var i:* = 0;
         var mf:* = null;
         for(i = uint(1); i <= 7; )
         {
            mf = new MovingFloor(i);
            mf.setStatic();
            mf.x = 40 + (i - 1) * 165;
            mf.y = 450;
            mf.width = 100;
            gc.gameSence.addChildAt(mf,gc.getMinIdxInHeroAndPet());
            gc.pWorld.getWallArray().push(mf);
            this.moveAbleFloorsArray.push(mf);
            i++;
         }
      }
      
      public function addMusic(kind:uint) : void
      {
         if(this.musicSprite)
         {
            if(this.musicSprite.currentState == 1)
            {
               this.musicSprite.addMusic(kind);
            }
         }
      }
      
      public function addBoss() : void
      {
         if(!this.m131)
         {
            if(this.musicSprite)
            {
               this.musicSprite.destroy();
               this.musicSprite = null;
            }
            this.m131 = MainGame.getInstance().createMonster(131,500,200) as Monster131;
         }
      }
      
      public function addMonster133() : void
      {
         MainGame.getInstance().createMonster(133,400 + RandomControllor.getIns().getRandom() * 500,200);
      }
      
      public function addMu(p:Point) : void
      {
         this.musicSprite.addRandomMusicByPoint(p);
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
               PayManager.getInstance().pay(27,"道具27",gc.pay.money,1);
               gc.lastPaymentString = "StageListener221";
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
         if(gc.lastPaymentString != "StageListener221")
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
      
      override public function destroy() : void
      {
         this.renewalse = null;
         for each(var mf in this.moveAbleFloorsArray)
         {
            mf.destroy();
         }
         this.moveAbleFloorsArray.length = 0;
         if(gc.isStopGame)
         {
            MainGame.getInstance().continueGame();
         }
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
