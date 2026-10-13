package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import base.BaseObject;
   import event.CommonEvent;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster229 extends BaseMonster
   {
      
      public static var Monster146DEAD_EVENT:String = "Monster146dead_event";
       
      
      private var propertyLevel:uint = 1;
      
      public function Monster229()
      {
         super();
         this.normalAttackRate = 0.8;
         this.horizenSpeed = 4;
         this.setPropertyByLevel(5);
         this.isCanBeCatchSkill = true;
         this.isBoss = true;
         this.monsterName = "邪.星宿";
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 10];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 15];
         this.skillCD3 = [gc.frameClips * 8,gc.frameClips * 15];
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
         this.setHue(-150);
      }
      
      public function setPropertyByLevel(lv:uint = 1) : void
      {
         this.propertyLevel = lv;
         if(lv > 10)
         {
            lv = 10;
         }
         this.setHp(500000 * lv);
         this.setSHp(500000 * lv);
         this.attackRange = 200;
         this.attackRangeY = 50;
         this.alertRangeY = 20;
         this.alertRange = 2500;
         this._anti.def = 50 * lv;
         this._anti.exp = 2000 * lv;
         this._anti.gxp = 500;
         this._anti.mDef = 0.05 * lv;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":10,
            "power":500 * lv,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-15,0],
            "attackInterval":10,
            "power":500 * lv,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "power":500 * lv,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":300 * lv,
            "attackKind":"physics"
         };
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"_ptjsxstx",
            "bigtype":"zb"
         }];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster146");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
            bbdc.setOffsetXY(10,-15);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,10],[2,2,2,2],[2,2,10],[2,2,48]]);
            bbdc.setFrameCount([6,4,1,5,3,16,3,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster146--BitmapData Error!");
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
               this.setStatic();
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
               this.dispatchEvent(new CommonEvent(Monster146DEAD_EVENT));
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
               if(direct == 0)
               {
                  this.speed.x = -15;
               }
               else
               {
                  this.speed.x = 15;
               }
               break;
            case "hit3":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi3(direct);
                  }
               }
               break;
            case "hit4":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() % 4 == 0)
                  {
                     this.doHi4(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 400;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(20);
         this.doHi2(this.bbdc.getDirect());
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
         this.setYourFather(20);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster146Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 80;
         }
         else
         {
            b.x = this.x + 80;
         }
         b.y = this.y - 35;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster146Bullet2");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(48);
         b.setHurtCanCutDownEffect(false);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster146Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 160;
         }
         else
         {
            b.x = this.x + 160;
         }
         b.y = this.y - 75;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi4(direct:uint) : void
      {
         var i:* = 0;
         var b:* = null;
         var nums:uint = 1 + RandomControllor.getIns().getRandom() * 2;
         for(i = uint(0); i < nums; )
         {
            b = new EnemyMoveBullet("Monster146Bullet4");
            b.x = this.x + (RandomControllor.getIns().getRandom() - 0.5) * 1000;
            b.y = this.y - 300 - (RandomControllor.getIns().getRandom() - 0.5) * 200;
            b.setRole(this);
            if(direct == 0)
            {
               b.setSpeed(-3,3);
               b.setAddSpeed(-0.3,0.3);
            }
            else
            {
               b.setSpeed(3,3);
               b.setAddSpeed(0.3,0.3);
            }
            b.setFuncWhenHitWall(hit4Destroy);
            b.setDistance(1000);
            b.setDestroyWhenLastFrame(false);
            b.setDirect(direct);
            b.setAction("hit4");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
            i++;
         }
      }
      
      private function hit4Destroy(bb:BaseBullet) : void
      {
         bb.destroy();
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function step() : void
      {
         super.step();
         if(this.x > 1100)
         {
            this.x = 800;
         }
         else if(this.x < -100)
         {
            this.x = 100;
         }
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
         return Boolean(super.beMagicAttack(_target,sr,force));
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit2";
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
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
