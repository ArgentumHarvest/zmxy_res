package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import export.level.StageListener81;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster36 extends BaseMonster
   {
       
      
      private var monster36Bullet3Count:uint;
      
      public function Monster36()
      {
         super();
         this.normalAttackRate = 0.5;
         this.horizenSpeed = 5;
         this.setHp(200000);
         this.setSHp(200000);
         this.attackRange = 250;
         this.alertRange = 2500;
         this._anti.def = 70;
         this._anti.exp = 500;
         this._anti.gxp = 250;
         this._anti.mDef = 0.2;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":424,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":500,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-25,0],
            "attackInterval":8,
            "power":80,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-25,0],
            "attackInterval":8,
            "power":600,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.MONSTER36Bullet4,
               "time":2,
               "hurt":10
            }]
         };
         this.isBoss = true;
         this.isFly = true;
         this.graity = 0;
         this.monsterName = "雷震子";
         this.setToCountSuppressLevel(30);
         this.setAction("wait");
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"xltszzs",
            "bigtype":"dj"
         },{
            "name":"xlczzzs",
            "bigtype":"dj"
         }];
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 12];
         this.skillCD2 = [gc.frameClips * 3,gc.frameClips * 8];
         this.skillCD3 = [gc.frameClips * 5,gc.frameClips * 12];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster36");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
            bbdc.setOffsetXY(0,-25);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,3,2,4],[8],[2,2,2,10],[2,2,2,2,10],[2,2,2,2,5,10],[2,10],[4,5],[2,2,2,20]]);
            bbdc.setFrameCount([6,6,1,4,5,6,2,2,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster36--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite5") as Sprite;
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
            case "hit4_1":
               if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(str);
               break;
            case "hit4_2":
               if(curPoint.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
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
            case "hit4_1":
               this.setPositionAfterTarget();
               this.setAction("hit4_2");
               break;
            case "hit4_2":
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
      
      private function setPositionAfterTarget() : void
      {
         if(this.curAttackTarget)
         {
            if(this.curAttackTarget.getBBDC().getDirect() == 0)
            {
               this.x = this.curAttackTarget.x + 100;
               this.turnLeft();
            }
            else
            {
               this.x = this.curAttackTarget.x - 100;
               this.turnRight();
            }
            this.y = this.curAttackTarget.y - 60;
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
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHit1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHit2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 5)
                  {
                     this.doHit3(direct);
                  }
               }
               break;
            case "hit4_1":
               this.speed.y = -15;
               this.speed.x = 0;
               break;
            case "hit4_2":
               this.speed.y = 0;
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHit4(direct);
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
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster36Bullet3")
            {
               return false;
            }
         }
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 400;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 400;
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
         this.setYourFather(20);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.setYourFather(20);
         this.setAction("hit4_1");
         this.lastHit = "hit4_1";
      }
      
      private function doHit1(direct:uint) : void
      {
         var b:EnemyMoveBullet = new EnemyMoveBullet("Monster36Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 140;
         }
         else
         {
            b.x = this.x + 140;
         }
         b.y = this.y - 50;
         b.setRole(this);
         var point:Point = AUtils.GetNextPointByTwoObj(this,this.curAttackTarget);
         b.setSpeed(point.x * 3,point.y * 3);
         b.setAddSpeed(point.x,point.y);
         b.setDistance(1000);
         b.setDestroyWhenLastFrame(false);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2(direct:uint) : void
      {
         var b:* = null;
         var rand:int = (RandomControllor.getIns().getRandom() - 0.5) * 200;
         b = new SpecialEffectBullet("Monster36Bullet2");
         b.x = this.curAttackTarget.x + rand - 150;
         b.y = 510;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster36Bullet2");
         b.x = this.curAttackTarget.x + rand;
         b.y = 510;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster36Bullet2");
         b.x = this.curAttackTarget.x + rand + 150;
         b.y = 510;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster36Bullet2");
         b.x = this.curAttackTarget.x + rand + 300;
         b.y = 510;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster36Bullet3");
         b.x = this.curAttackTarget.x;
         b.y = 250;
         b.setDisable();
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 33);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         this.monster36Bullet3Count = gc.frameClips * 8;
      }
      
      private function doHit4(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster36Bullet4");
         if(direct == 0)
         {
            b.x = this.x - 200;
         }
         else
         {
            b.x = this.x + 200;
         }
         b.y = this.y - 100;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
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
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster36Bullet3")
            {
               if(this.monster36Bullet3Count > 0)
               {
                  this.monster36Bullet3Count--;
                  if(this.monster36Bullet3Count == 0)
                  {
                     for each(var bh in gc.getPlayerArray())
                     {
                        if(!bh.isYourFather())
                        {
                           bh.addCurAddEffect([{
                              "name":BaseAddEffect.SIDATIANWANG_SAN_MP_LOST,
                              "time":gc.frameClips * 4,
                              "mpSource":bh.roleProperies.getMMP()
                           }]);
                           TweenMax.to(bh,1,{
                              "x":bb.x,
                              "y":bb.y
                           });
                        }
                     }
                     this.monster36Bullet3Count = gc.frameClips * 8;
                  }
               }
            }
         }
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit4_1";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4_1" || this.curAction == "hit4_2";
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         super.destroy();
         if(this.getHp() <= 0)
         {
            if(gc.pWorld.getBaseLevelListener() is StageListener81)
            {
               StageListener81(gc.pWorld.getBaseLevelListener()).showJwealSprite();
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
      }
   }
}
