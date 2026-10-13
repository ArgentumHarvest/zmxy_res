package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import base.BaseObject;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import export.level.StageListener222;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import mvc.controllor.RandomControllor;
   
   public class Monster135 extends BaseMonster
   {
       
      
      private var fenshen:BaseMonster;
      
      private var isStop:Boolean = false;
      
      private var continueCount:int = 168;
      
      public function Monster135()
      {
         super();
         this.normalAttackRate = 0.8;
         this.horizenSpeed = 4;
         this.setHp(2000000);
         this.setSHp(2000000);
         this.attackRange = 400;
         this.alertRange = 2000;
         this._anti.def = 300;
         this._anti.exp = 2000;
         this._anti.gxp = 500;
         this._anti.mDef = 0.25;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":1800,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":1200,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[-3,0],
            "attackInterval":24,
            "power":1800,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.MONSTER135Buff,
               "time":gc.frameClips * 10,
               "hurt":300
            }]
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":1000,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "碧霄";
         this.setAction("wait");
         this.isFly = true;
         this.graity = 0;
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"phhlzzs",
            "bigtype":"dj"
         }];
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 10];
         this.skillCD2 = [gc.frameClips * 7,gc.frameClips * 20];
         this.skillCD3 = [gc.frameClips * 8,gc.frameClips * 20];
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster135");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
            bbdc.setOffsetXY(0,-15);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,10],[2,2,2,10],[2,2,24],[2,3,3,3,3,10],[2,2,2,10]]);
            bbdc.setFrameCount([6,1,5,4,3,6,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster135--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite2") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         super.setAction(str);
         var curPoint:Point = this.bbdc.getCurPoint();
         switch(str)
         {
            case "wait":
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "walk":
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "hit4":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               this.setStatic();
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
         }
      }
      
      override protected function scriptFrameOverFunc(row:int) : void
      {
         var state:String = this.bbdc.getState();
         switch(state)
         {
            case "walk":
               this.bbdc.setFramePointX(0);
               break;
            case "wait":
               this.bbdc.setFramePointX(0);
               break;
            case "hit1":
               this.setAction("wait");
               break;
            case "hit2":
               this.setAction("wait");
               break;
            case "hit3":
               this.setAction("wait");
               break;
            case "hit4":
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
               this.dropAura();
               this.destroy();
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         switch(state)
         {
            case "hit1":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 24)
                  {
                     this.doHi2(direct);
                  }
                  else if(this.bbdc.getCurFrameCount() == 16)
                  {
                     this.doHi2(direct);
                  }
                  else if(this.bbdc.getCurFrameCount() == 8)
                  {
                     this.doHi2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 3)
                  {
                     this.doHi3(direct);
                  }
               }
               break;
            case "hit4":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi4(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 450;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && Math.abs(this.x - this.curAttackTarget.x) <= 600 && Math.abs(this.x - this.curAttackTarget.x) <= 100;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return !this.fenshen;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(20);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(24);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.setYourFather(99999);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:EnemyMoveBullet = new EnemyMoveBullet("Monster135Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 130;
            b.setSpeed(-15);
         }
         else
         {
            b.x = this.x + 130;
            b.setSpeed(15);
         }
         b.setDistance(600);
         b.y = this.y - 10;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:* = null;
         b = new SpecialEffectBullet("Monster135Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 150;
         }
         else
         {
            b.x = this.x + 150;
         }
         b.y = this.y - 300;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster135Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 415;
         }
         else
         {
            b.x = this.x + 415;
         }
         b.y = this.y - 320;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster135Bullet2");
         if(direct == 0)
         {
            b.x = this.x + 115;
         }
         else
         {
            b.x = this.x - 115;
         }
         b.y = this.y - 320;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3(direct:uint) : void
      {
         var b1:* = null;
         for each(var bh in gc.getPlayerArray())
         {
            b1 = new EnemyMoveBullet("Monster135Bullet3");
            b1.x = this.x;
            b1.y = this.y;
            b1.setMoveTarget(bh);
            b1.setSpeed(4,4);
            b1.setDistance(9000);
            b1.setDestroyWhenLastFrame(false);
            b1.setDestroyInCount(gc.frameClips * 8);
            b1.setRole(this);
            b1.setDirect(direct);
            b1.setAction("hit3");
            gc.gameSence.addChild(b1);
            this.magicBulletArray.push(b1);
         }
      }
      
      private function doHi4(direct:uint) : void
      {
         this.isStop = true;
         this.bbdc.hide();
         this.continueCount = 168;
         var kind:uint = 31 + RandomControllor.getIns().getRandom() * 4;
         this.fenshen = AUtils.getNewObj("export.monster.Monster" + kind);
         this.fenshen.isBoss = false;
         this.fenshen.clearFallList();
         this.fenshen.x = this.x;
         this.fenshen.y = this.y;
         this.fenshen.sid = getTimer();
         gc.pWorld.monsterArray.push(this.fenshen);
         var minIdx:int = gc.getMinIdxInHeroAndPet();
         gc.gameSence.addChildAt(this.fenshen,minIdx);
         if(gc.pWorld.getBaseLevelListener() is StageListener222)
         {
            (gc.pWorld.getBaseLevelListener() as StageListener222).addMonsterBoatByBaseObject(this.fenshen);
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function step() : void
      {
         var hurt:* = 0;
         if(this.isStop)
         {
            if(this.fenshen)
            {
               if(this.fenshen.y < -100)
               {
                  this.fenshen.y = 350;
               }
               if(this.fenshen.x > 1000 || this.fenshen.x < -100)
               {
                  this.fenshen.x = 500;
               }
               if(this.continueCount > 0)
               {
                  this.continueCount--;
               }
               if(this.continueCount == 0)
               {
                  if(this.fenshen.curAction == "wait")
                  {
                     hurt = uint(this.fenshen.getSHp() - this.fenshen.getHp());
                     if(this.getHp() > hurt)
                     {
                        this.reduceHp(hurt);
                     }
                     this.fenshen.destroy();
                     this.continueCount--;
                  }
               }
               if(this.fenshen.isReadyToDestroy)
               {
                  this.setYourFather(10);
                  this.isStop = false;
                  this.bbdc.show();
                  this.setAction("wait");
                  this.x = this.fenshen.x;
                  this.y = this.fenshen.y - 50;
                  this.fenshen = null;
               }
            }
            return;
         }
         super.step();
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         var obj:* = null;
         var flag:Boolean = super.beMagicAttack(_target,sr,force);
         if(flag)
         {
            for each(var bh in gc.getPlayerArray())
            {
               obj = bh.curAddEffect.getBuffByName(BaseAddEffect.MONSTER135Buff);
               if(obj)
               {
                  bh.curAddEffect.remove(obj);
               }
            }
         }
         return flag;
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
      }
      
      override public function destroy() : void
      {
         if(this.isDead())
         {
            if(gc.pWorld.getBaseLevelListener() is StageListener222)
            {
               (gc.pWorld.getBaseLevelListener() as StageListener222).addTransferDoor();
            }
         }
         super.destroy();
         this.fenshen = null;
      }
   }
}
