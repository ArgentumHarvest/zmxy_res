package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import export.level.StageListener401;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster114 extends BaseMonster
   {
       
      
      private var isGetGardenExp:Boolean = false;
      
      public function Monster114()
      {
         super();
         this.horizenSpeed = 5;
         this.setHp(1200000);
         this.setSHp(1200000);
         this._anti.def = 0;
         this._anti.exp = 1000;
         this._anti.gxp = 500;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-15,-5],
            "attackInterval":999,
            "power":1500,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":4,
            "power":200,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":999,
            "power":1000,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.STUN,
               "time":gc.frameClips * 5
            }]
         };
         this.normalAttackRate = 0.6;
         this.attackRange = 300;
         this.alertRange = 600;
         this.isBoss = true;
         this.monsterName = "狰狞圣者";
         this.setAction("wait");
         this.setToCountSuppressLevel(50);
         this.skillCD1 = [gc.frameClips * 4,gc.frameClips * 8];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 10];
         this.skillCD3 = [gc.frameClips * 2,gc.frameClips * 27];
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster114");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
            bbdc.setOffsetXY(15,-35);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,12,10],[2,2,2,10],[2,2,48],[35,10]]);
            bbdc.setFrameCount([6,4,1,5,4,4,3,2]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster114--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("Monster114HitTestObject") as Sprite;
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
            case "hit4":
               if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
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
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 48)
                  {
                     this.doHi3(direct);
                  }
               }
               break;
            case "hit4":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 35)
                  {
                     this.doHi4_1(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return true;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return true;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.curAttackTarget != null;
      }
      
      override protected function releSkill1() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(32);
         this.setAction("hit1");
         this.lastHit = "hit1";
      }
      
      override protected function attackTarget() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(16);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(55);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      override protected function releSkill3() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(20);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster114Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 55;
         }
         else
         {
            b.x = this.x + 55;
         }
         b.y = this.y - 175;
         b.setRole(this);
         b.setDirect(direct);
         b.setFuncWhenDestroy(checkHit1);
         b.setDisable();
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function checkHit1(bb:BaseBullet) : void
      {
         var flag:Boolean = false;
         for each(var bo in gc.getPlayerAndPetArray())
         {
            flag = false;
            if(bo.x < this.x)
            {
               if(bo.getBBDC().getDirect() == 1 && this.getBBDC().getDirect() == 0)
               {
                  flag = true;
               }
            }
            else if(bo.x > this.x)
            {
               if(bo.getBBDC().getDirect() == 0 && this.getBBDC().getDirect() == 1)
               {
                  flag = true;
               }
            }
            if(flag)
            {
               bo.addCurAddEffect([{
                  "name":BaseAddEffect.MONSTER114FEAR,
                  "time":gc.frameClips * 6
               }]);
            }
         }
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster114Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 170;
         }
         else
         {
            b.x = this.x + 170;
         }
         b.y = this.y - 125;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3(direct:uint) : void
      {
         direct = direct;
         gc.pWorld.getBaseLevelListener().startBlackBG();
         TweenMax.delayedCall(25,function():*
         {
            gc.pWorld.getBaseLevelListener().stopBlackBG();
         });
      }
      
      private function doHi4_1(direct:uint) : void
      {
         var b:* = null;
         b = new SpecialEffectBullet("Monster114Bullet4_1");
         if(direct == 0)
         {
            b.x = this.x - 170;
         }
         else
         {
            b.x = this.x + 170;
         }
         b.y = this.y - 225;
         b.setDisable();
         b.setFuncWhenDestroy(checkHit4);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         for each(var bo in gc.getPlayerAndPetArray())
         {
            b = new SpecialEffectBullet("Monster114Bullet4_3");
            if(direct == 0)
            {
               b.x = bo.x;
            }
            else
            {
               b.x = bo.x;
            }
            b.y = this.y;
            b.setDisable();
            b.setRole(this);
            b.setFollowDisplayObj(bo);
            b.setDestroyWhenLastFrame(false);
            b.setDirect(direct);
            b.setAction("hit3");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
         }
      }
      
      private function checkHit4(bb:BaseBullet) : void
      {
         var b:* = null;
         var point:* = null;
         var dis:Number = NaN;
         for each(bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster114Bullet4_3")
            {
               bb.setFollowDisplayObj(null);
               b = new EnemyMoveBullet("Monster114Bullet4_2");
               b.x = this.x;
               b.y = this.y;
               b.setRole(this);
               point = AUtils.GetNextPointByTwoObj(this,bb);
               b.setSpeed(point.x * 15,point.y * 15);
               dis = AUtils.GetDisBetweenTwoObj(this,bb) + 10;
               b.setDistance(dis,hit4Over);
               b.setDestroyWhenLastFrame(false);
               b.setAction("hit3");
               gc.gameSence.addChild(b);
               this.magicBulletArray.push(b);
            }
         }
      }
      
      private function hit4Over(xx:Number, yy:Number) : void
      {
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster114Bullet4_3")
            {
               bb.destroy();
            }
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         if(this.getHp() < 0)
         {
            if(gc.pWorld.getBaseLevelListener() is StageListener401)
            {
               StageListener401(gc.pWorld.getBaseLevelListener()).stopDaojishi();
            }
            if(!this.isGetGardenExp)
            {
               gc.ts.setTxt("种植经验提高了");
               gc.stage.addChild(gc.ts);
               gc.eventManger.dispatchEvent(new CommonEvent("AddGardenExp"));
               this.isGetGardenExp = true;
            }
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
         super.destroy();
      }
   }
}
