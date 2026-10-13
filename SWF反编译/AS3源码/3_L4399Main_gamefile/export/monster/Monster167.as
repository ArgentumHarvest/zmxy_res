package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import export.level.StageListener511;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster167 extends BaseMonster
   {
       
      
      private var averLevel:uint = 0;
      
      public function Monster167()
      {
         super();
         this.horizenSpeed = 4;
         averLevel = gc.getAverageLevel();
         if(averLevel > 85)
         {
            averLevel = 85;
         }
         this.normalAttackRate = 0.6;
         this.horizenSpeed = 6;
         var temp:uint = Math.ceil(averLevel / 10);
         this.setHp(temp * temp * 10000 * (0.4 + averLevel * 0.01));
         this.setSHp(this.getHp());
         this.normalAttackRate = 0.7;
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = averLevel * 4;
         this._anti.exp = 500;
         this._anti.gxp = 250;
         this._anti.mDef = averLevel / 400;
         var hit3Hurt:int = averLevel * 20 - 150;
         hit3Hurt = hit3Hurt > 1 ? hit3Hurt : 1;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":averLevel * 10,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[1,0],
            "attackInterval":999,
            "power":averLevel * 15,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-14,-5],
            "attackInterval":24,
            "power":hit3Hurt,
            "attackKind":"physics"
         };
         this.isBoss = true;
         this.monsterName = "糖果皇帝";
         this.setAction("wait");
         this._anti.fallProbability = 0.07;
         this._anti.fallList = [{
            "name":"hsj",
            "bigtype":"dj"
         }];
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 9];
         this.skillCD2 = [gc.frameClips * 8,gc.frameClips * 15];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster167");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,350,new Point(0,0));
            bbdc.setOffsetXY(60,-120);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,10],[2,2,3,3,15,2,1,1,10],[1,1,1,1]]);
            bbdc.setFrameCount([6,4,1,5,3,9,8]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster167--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
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
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               this.setStatic();
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
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
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 5)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi2(direct);
                  }
               }
               else if(p.x == 4)
               {
                  this.bbdc.hide();
               }
               break;
            case "hit3":
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:* = null;
         b = new EnemyMoveBullet("Monster167Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 20;
            b.setSpeed(-10,0);
         }
         else
         {
            b.x = this.x + 20;
            b.setSpeed(10,0);
         }
         b.y = this.y;
         b.setDestroyWhenLastFrame(false);
         b.setDistance(600);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new EnemyMoveBullet("Monster167Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 20;
            b.setSpeed(-10,-4);
         }
         else
         {
            b.x = this.x + 20;
            b.setSpeed(10,-4);
         }
         b.y = this.y;
         b.setDestroyWhenLastFrame(false);
         b.setDistance(600);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new EnemyMoveBullet("Monster167Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 20;
            b.setSpeed(-10,4);
         }
         else
         {
            b.x = this.x + 20;
            b.setSpeed(10,4);
         }
         b.y = this.y;
         b.setDestroyWhenLastFrame(false);
         b.setDistance(600);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:* = null;
         var playerArr:Array = gc.getPlayerArray();
         var randomHero:BaseHero = playerArr[int(RandomControllor.getIns().getRandom() * playerArr.length)];
         if(randomHero)
         {
            this.x = randomHero.x;
            b = new SpecialEffectBullet("Monster167Bullet2");
            if(direct == 0)
            {
               b.x = this.x - 0;
            }
            else
            {
               b.x = this.x + 0;
            }
            b.y = this.y + 45;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit2");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
            gc.vControllor.shake(20);
         }
         this.bbdc.show();
      }
      
      private function doHi3(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster167Bullet3");
         b.x = this.x;
         b.y = this.y - 30;
         b.setRole(this);
         b.setDirect(0);
         b.setHurtCanCutDownEffect(false);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 2);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.standInObj && this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.standInObj && this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(30);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(10);
         this.setAction("hit3");
         this.lastHit = "hit3";
         this.doHi3(this.bbdc.getDirect());
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit3";
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         if(this.getHp() <= 0)
         {
            if(gc.pWorld.getBaseLevelListener() is StageListener511)
            {
               StageListener511(gc.pWorld.getBaseLevelListener()).showQiqiu();
            }
            if(this.isBoss)
            {
               ta = gc.pWorld.getTransferDoorArray();
               for(i = 0; i < ta.length; )
               {
                  mc = ta[i];
                  mc.visible = true;
                  i++;
               }
            }
         }
         super.destroy();
      }
   }
}
