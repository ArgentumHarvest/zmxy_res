package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.level.StageListener131Children.Stage131FollowHero;
   import export.level.StageListener131Children.Stage13ResultSprite;
   import export.level.StageListener131Children.StageListener131Jweal;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class StageListener131 extends BaseLevelListenering
   {
       
      
      private var stage131FollowHero:Stage131FollowHero;
      
      private var monsterArray:Array;
      
      private var monsterCurrentWave:Array;
      
      private var _anti:Antiwear;
      
      private var getedFlowersArray:Array;
      
      private var flowerArray:Array;
      
      private var resultMc:Stage13ResultSprite;
      
      private var prizeId:uint = 0;
      
      private var stage13WaveShow:MovieClip;
      
      private var bossDialogue:MovieClip;
      
      private var falledFlowers:uint = 10;
      
      private var isOver:Boolean = false;
      
      private var bgMask:Bitmap;
      
      public function StageListener131()
      {
         monsterArray = [55,56,57,59,9,10,19,18,17,1,11,12,13,14];
         monsterCurrentWave = [];
         _anti = new Antiwear(new binaryEncrypt());
         getedFlowersArray = [0,0,0,0,0,0,0];
         flowerArray = [];
         super();
         waitForRegisterDataArray = ["Stage131FollowHeroBMD","Monster55","Monster56","Monster57","Monster59","Monster9","Monster10","Monster19","Monster18","Monster17","Monster1","Monster11","Monster12","Monster13","Monster14"];
         this._anti.curWave = 0;
         this._anti.baseHp = 1000;
         this._anti.hpAdd = 300;
         this._anti.baseDef = 20;
         this._anti.defAdd = 2;
         this._anti.baseMDef = 0.2;
         this._anti.baseAtk = 40;
         this._anti.atkAndExpAdd = 5;
         this._anti.baseExp = 40;
         this._anti.baseBossHp = 50000;
         this._anti.baseBossDef = 10;
         this._anti.baseBossMDef = 0.1;
         this._anti.baseBossAtk = 50;
         this._anti.baseBossExp = 100;
      }
      
      override public function step() : void
      {
         var idx:int = 0;
         if(this.isOver)
         {
            return;
         }
         super.step();
         var temp:Array = [];
         for each(var flower in this.flowerArray)
         {
            flower.step();
            if(flower.isDestroy)
            {
               temp.push(flower);
            }
            else if(this.stage131FollowHero)
            {
               flower.checkGet(this.stage131FollowHero);
            }
         }
         for each(var fh in temp)
         {
            idx = this.flowerArray.indexOf(fh);
            if(idx != -1)
            {
               this.flowerArray.splice(idx,1);
            }
         }
         temp.length = 0;
         if(this.stage131FollowHero)
         {
            this.stage131FollowHero.step();
            if(this.stage131FollowHero.isReadyToDestroy)
            {
               this.stage131FollowHero = null;
               this.showResult();
               return;
            }
         }
         var hlen:uint = gc.getPlayerArray().length;
         if(hlen == 0)
         {
            this.showResult();
            return;
         }
         if(this._anti.curWave > 0)
         {
            this.checkMonsterAppear();
         }
      }
      
      private function showResult() : void
      {
         this.isOver = true;
         this.resultMc = new Stage13ResultSprite(this.getedFlowersArray,1,this.prizeId,this._anti.curWave);
         GMain.getInstance().getTopSence().addChild(this.resultMc);
         this.resultMc.addEventListener("close",_returnToSelectMap);
      }
      
      private function _returnToSelectMap(evt:CommonEvent) : void
      {
         MainGame.getInstance().continueGame();
         this.resultMc.removeEventListener("close",_returnToSelectMap);
         MainGame.getInstance().destroyGameAndSaveGame();
         GMain.getInstance().switchSence("showStageMap");
      }
      
      override public function start() : void
      {
         super.start();
         this.stage13WaveShow = AUtils.getNewObj("Stage13WaveShow") as MovieClip;
         this.stage13WaveShow.x = 460;
         this.stage13WaveShow.y = 90;
         gc.gameInfo.addChild(this.stage13WaveShow);
         gc.dataObject.onedaytime = 1;
         this.stage131FollowHero = new Stage131FollowHero(gc.hero1);
         this.stage131FollowHero.x = gc.hero1.x + 50;
         this.stage131FollowHero.y = gc.hero1.y + 5;
         gc.gameSence.addChild(this.stage131FollowHero);
         this.nextWave();
         var playersArray:Array = gc.getPlayerArray();
         var randIdx:uint = RandomControllor.getIns().getRandom() * playersArray.length;
         var bh:BaseHero = playersArray[randIdx] as BaseHero;
         if(bh == gc.hero3)
         {
            bh = gc.hero1;
         }
         this.prizeId = bh.getRoleId();
         if(!gc.hasGetMoney)
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.getBalance();
            }
         }
         this.bgMask = AUtils.getImageObj("Stage131BlackBG") as Bitmap;
         this.bgMask.x = -20;
         gc.gameSence.bgContainer.addChild(this.bgMask);
         this.showMaskByTime();
         TweenMax.delayedCall(0.1,function(_self:StageListener131):*
         {
            _self.showDio();
         },[this]);
      }
      
      private function showMaskByTime() : void
      {
         var hour:uint = (gc.dataObjectInstance.curTime as String).split(":")[0];
         this.bgMask.alpha = Math.abs(12 - hour) / 12;
         trace("this.bgMask.alpha:" + this.bgMask.alpha);
      }
      
      private function showDio() : void
      {
         gc.stage.addEventListener("keyDown",__keyDown);
         gc.stage.addEventListener("click",__click);
         this.bossDialogue = AUtils.getNewObj("Stage13Dialogue") as MovieClip;
         this.bossDialogue.y = 360;
         var heroHead:MovieClip = this.bossDialogue.getChildByName("heroHead") as MovieClip;
         var monsterHead:MovieClip = this.bossDialogue.getChildByName("bossHead") as MovieClip;
         var xiannvHead:MovieClip = this.bossDialogue.getChildByName("xiannvHead") as MovieClip;
         monsterHead.visible = false;
         xiannvHead.visible = false;
         heroHead.gotoAndStop(gc.player1.roleid);
         MainGame.getInstance().stopGame();
         GMain.getInstance().getTopSence().addChild(this.bossDialogue);
         this.bossDialogue.gotoAndStop(1);
      }
      
      private function __keyDown(evt:KeyboardEvent) : void
      {
         this.nextDialogue();
      }
      
      private function __click(evt:MouseEvent) : void
      {
         this.nextDialogue();
      }
      
      private function nextDialogue() : void
      {
         var heroHead:* = null;
         var monsterHead:* = null;
         var xiannvHead:* = null;
         if(this.bossDialogue)
         {
            if(this.bossDialogue.currentFrame == 11)
            {
               gc.stage.removeEventListener("keyDown",__keyDown);
               gc.stage.removeEventListener("click",__click);
               MainGame.getInstance().continueGame();
               if(this.bossDialogue.parent)
               {
                  this.bossDialogue.parent.removeChild(this.bossDialogue);
               }
               return;
            }
            this.bossDialogue.gotoAndStop(this.bossDialogue.currentFrame + 1);
            heroHead = this.bossDialogue.getChildByName("heroHead") as MovieClip;
            monsterHead = this.bossDialogue.getChildByName("bossHead") as MovieClip;
            xiannvHead = this.bossDialogue.getChildByName("xiannvHead") as MovieClip;
            if(this.bossDialogue.currentFrame == 1)
            {
               xiannvHead.visible = false;
               monsterHead.visible = false;
               heroHead.visible = true;
            }
            else if(this.bossDialogue.currentFrame == 2)
            {
               xiannvHead.visible = false;
               monsterHead.visible = true;
               heroHead.visible = false;
            }
            else if(this.bossDialogue.currentFrame == 3)
            {
               xiannvHead.visible = false;
               monsterHead.visible = false;
               heroHead.visible = true;
            }
            else if(this.bossDialogue.currentFrame == 4)
            {
               xiannvHead.visible = false;
               monsterHead.visible = true;
               heroHead.visible = false;
            }
            else if(this.bossDialogue.currentFrame == 5)
            {
               xiannvHead.visible = false;
               monsterHead.visible = false;
               heroHead.visible = true;
            }
            else if(this.bossDialogue.currentFrame == 6)
            {
               xiannvHead.visible = false;
               monsterHead.visible = false;
               heroHead.visible = true;
            }
            else if(this.bossDialogue.currentFrame == 7)
            {
               xiannvHead.visible = false;
               monsterHead.visible = true;
               heroHead.visible = false;
            }
            else if(this.bossDialogue.currentFrame == 8)
            {
               xiannvHead.visible = false;
               monsterHead.visible = true;
               heroHead.visible = false;
            }
            else if(this.bossDialogue.currentFrame == 9)
            {
               xiannvHead.visible = true;
               monsterHead.visible = false;
               heroHead.visible = false;
            }
            else if(this.bossDialogue.currentFrame == 10)
            {
               xiannvHead.visible = false;
               monsterHead.visible = true;
               heroHead.visible = false;
            }
            else if(this.bossDialogue.currentFrame == 11)
            {
               xiannvHead.visible = true;
               monsterHead.visible = false;
               heroHead.visible = false;
            }
         }
      }
      
      private function nextWave() : void
      {
         var i:* = 0;
         var bossType:* = 0;
         var needToRemoveMC:* = null;
         var waveNum:* = null;
         var num1:* = null;
         var num2:* = null;
         var num3:* = null;
         var num1Idx:* = 0;
         var num2Idx:* = 0;
         var num3Idx:* = 0;
         num1 = null;
         num2 = null;
         num1Idx = 0;
         num2Idx = 0;
         this._anti.curWave++;
         this._anti.maxMonsterNums = this._anti.curWave + 3;
         if(this._anti.maxMonsterNums > 70)
         {
            this._anti.maxMonsterNums = 70;
         }
         this._anti.round = Math.ceil(this._anti.curWave / 10);
         this._anti.maxMonstersPerScreen = 5 + (this._anti.round - 1) * 1;
         if(this._anti.maxMonstersPerScreen > 10)
         {
            this._anti.maxMonstersPerScreen = 10;
         }
         var waveInRelative:uint = this._anti.curWave % 10;
         if(waveInRelative == 0)
         {
            waveInRelative = 10;
         }
         this.monsterCurrentWave.length = 0;
         if(waveInRelative < 9)
         {
            for(i = uint(0); i < 3; )
            {
               this.monsterCurrentWave.push(this.monsterArray[waveInRelative - 1 + i]);
               i++;
            }
         }
         else if(waveInRelative == 9)
         {
            this.monsterCurrentWave = this.monsterArray.concat();
         }
         else if(waveInRelative == 10)
         {
            this.monsterCurrentWave = [1,11,12,13,14];
            bossType = uint(0);
            if(int(this._anti.curWave) % 40 == 10)
            {
               bossType = uint(32);
            }
            else if(int(this._anti.curWave) % 40 == 20)
            {
               bossType = uint(33);
            }
            else if(int(this._anti.curWave) % 40 == 30)
            {
               bossType = uint(31);
            }
            else if(int(this._anti.curWave) % 40 == 0)
            {
               bossType = uint(34);
            }
            if(bossType > 0)
            {
               this.createBossByTypeInThisStage(bossType);
            }
         }
         if(this.stage13WaveShow)
         {
            needToRemoveMC = this.stage13WaveShow.getChildByName("WaveNum1") as MovieClip;
            if(needToRemoveMC)
            {
               this.stage13WaveShow.removeChild(needToRemoveMC);
            }
            needToRemoveMC = this.stage13WaveShow.getChildByName("WaveNum2") as MovieClip;
            if(needToRemoveMC)
            {
               this.stage13WaveShow.removeChild(needToRemoveMC);
            }
            needToRemoveMC = this.stage13WaveShow.getChildByName("WaveNum3") as MovieClip;
            if(needToRemoveMC)
            {
               this.stage13WaveShow.removeChild(needToRemoveMC);
            }
            if(this._anti.curWave >= 100)
            {
               waveNum = AUtils.getNewObj("WaveNum3") as MovieClip;
               waveNum.name = "WaveNum3";
               num1 = waveNum.getChildByName("num1") as MovieClip;
               num2 = waveNum.getChildByName("num2") as MovieClip;
               num3 = waveNum.getChildByName("num3") as MovieClip;
               if(num1 && num2 && num3)
               {
                  num1Idx = uint(this._anti.curWave / 100);
                  num2Idx = uint(this._anti.curWave % 100 / 10);
                  num3Idx = uint(this._anti.curWave % 10);
                  if(num2Idx == 0)
                  {
                     num2Idx = uint(10);
                  }
                  if(num3Idx == 0)
                  {
                     num3Idx = uint(10);
                  }
                  num1.gotoAndStop(num1Idx);
                  num2.gotoAndStop(num2Idx);
                  num3.gotoAndStop(num3Idx);
               }
            }
            else if(this._anti.curWave >= 10)
            {
               waveNum = AUtils.getNewObj("WaveNum2") as MovieClip;
               waveNum.name = "WaveNum2";
               num1 = waveNum.getChildByName("num1") as MovieClip;
               num2 = waveNum.getChildByName("num2") as MovieClip;
               if(num1 && num2)
               {
                  num1Idx = uint(this._anti.curWave / 10);
                  num2Idx = uint(this._anti.curWave % 10);
                  if(num2Idx == 0)
                  {
                     num2Idx = uint(10);
                  }
                  num1.gotoAndStop(num1Idx);
                  num2.gotoAndStop(num2Idx);
               }
            }
            else
            {
               waveNum = AUtils.getNewObj("WaveNum1") as MovieClip;
               waveNum.name = "WaveNum1";
               waveNum.gotoAndStop(this._anti.curWave);
            }
            this.stage13WaveShow.addChild(waveNum);
         }
      }
      
      public function fallFlower(point:Point) : void
      {
         var rand:* = 0;
         var aaa:* = null;
         var p:* = null;
         var xx:int = 0;
         if(this.falledFlowers >= 20)
         {
            return;
         }
         if(this._anti.curWave <= 100)
         {
            rand = uint(RandomControllor.getIns().getRandom() * 7);
            aaa = new StageListener131Jweal(rand);
            p = gc.gameSence.localToGlobal(new Point(point.x,0));
            xx = 0;
            if(p.x > 930)
            {
               xx = 930 - p.x - 50;
            }
            else if(p.x < 10)
            {
               xx = 10 - p.x + 50;
            }
            aaa.x = point.x + xx;
            aaa.y = 350;
            gc.gameSence.addChild(aaa);
            this.flowerArray.push(aaa);
            this.falledFlowers++;
         }
      }
      
      private function checkMonsterAppear() : void
      {
         var rand:Number = NaN;
         var randId:* = 0;
         var monsterKind:* = 0;
         if(this._anti.maxMonsterNums > 0)
         {
            if(gc.pWorld.monsterArray.length < this._anti.maxMonstersPerScreen)
            {
               rand = RandomControllor.getIns().getRandom();
               randId = uint(this.monsterCurrentWave.length * rand);
               monsterKind = uint(this.monsterCurrentWave[randId]);
               this.createMonsterByTypeInThisStage(monsterKind);
               this._anti.maxMonsterNums--;
            }
         }
         else if(gc.pWorld.monsterArray.length == 0)
         {
            this.nextWave();
         }
      }
      
      private function createMonsterByTypeInThisStage(type:uint) : void
      {
         var monsterKind:* = type;
         var appearPoint:Point = new Point(800 + (RandomControllor.getIns().getRandom() - 0.5) * 960,200);
         var idx:uint = this.monsterArray.indexOf(monsterKind);
         var bm:BaseMonster = MainGame.getInstance().createMonster(monsterKind,appearPoint.x,appearPoint.y);
         var hp:uint = this._anti.baseHp + this._anti.hpAdd * idx;
         var def:uint = this._anti.baseDef + this._anti.defAdd * idx;
         var mDef:Number = this._anti.baseMDef;
         var atk:uint = this._anti.baseAtk + this._anti.atkAndExpAdd * idx;
         var exp:uint = this._anti.baseExp + this._anti.atkAndExpAdd * idx;
         bm.doWhenStage13(hp,def,mDef,atk,exp,this._anti.round);
      }
      
      private function createBossByTypeInThisStage(type:uint) : void
      {
         var monsterKind:* = type;
         var appearPoint:Point = new Point(600 + (RandomControllor.getIns().getRandom() - 0.5) * 960,200);
         var idx:uint = this.monsterArray.indexOf(monsterKind);
         var bm:BaseMonster = MainGame.getInstance().createMonster(monsterKind,appearPoint.x,appearPoint.y);
         var hp:uint = this._anti.baseBossHp;
         var def:uint = this._anti.baseBossDef;
         var mDef:Number = this._anti.baseBossMDef;
         var atk:uint = this._anti.baseBossAtk;
         var exp:uint = this._anti.baseBossExp;
         bm.doWhenStage13(hp,def,mDef,atk,exp,this._anti.round);
      }
      
      public function getFlowerByType(type:uint) : void
      {
         this.getedFlowersArray[type]++;
         this._anti.siqian = 4000;
         if(this.stage131FollowHero)
         {
            this.stage131FollowHero.cureHp(this._anti.siqian);
         }
      }
      
      public function getFollowHero() : Stage131FollowHero
      {
         return this.stage131FollowHero;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.monsterCurrentWave.length = 0;
         this.monsterArray.length = 0;
         this.stage131FollowHero = null;
         this.flowerArray.length = 0;
         this.resultMc = null;
         if(this.stage13WaveShow)
         {
            if(this.stage13WaveShow.parent)
            {
               this.stage13WaveShow.parent.removeChild(this.stage13WaveShow);
            }
            this.stage13WaveShow = null;
         }
      }
   }
}
