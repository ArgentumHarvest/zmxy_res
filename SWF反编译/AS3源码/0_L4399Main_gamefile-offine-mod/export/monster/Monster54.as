package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster54 extends BaseMonster
   {
       
      
      private const HIT4TIMESCOUNT:uint = 3;
      
      private var hit4Times:uint = 3;
      
      public function Monster54()
      {
         super();
         this.normalAttackRate = 0.6;
         this.horizenSpeed = 3;
         this.setHp(700000);
         this.setSHp(700000);
         this.attackRange = 300;
         this.alertRange = 1000;
         this._anti.def = 200;
         this._anti.exp = 1000;
         this._anti.gxp = 500;
         this._anti.mDef = 0.2;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":800,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":80,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-25,0],
            "attackInterval":999,
            "power":800,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[10,0],
            "attackInterval":8,
            "power":800,
            "attackKind":"physics"
         };
         this.isBoss = true;
         this.monsterName = "金角大王";
         this.setAction("wait");
         this.setToCountSuppressLevel(40);
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"yjpyansp",
            "bigtype":"dj"
         }];
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 15];
         this.skillCD2 = [gc.frameClips * 7,gc.frameClips * 15];
         this.skillCD3 = [gc.frameClips * 8,gc.frameClips * 10];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster54");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],350,350,new Point(0,0));
            bbdc.setOffsetXY(0,-40);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,9,2,2,10],[24],[12,12,12],[2,4,2,4,2,5]]);
            bbdc.setFrameCount([6,4,1,5,6,1,[1,1,1],6]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster54--BitmapData Error!");
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
               this.setYourFather(10);
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               this.setYourFather(10);
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "hit3_1":
               this.setYourFather(24);
               if(curPoint.y != 6 || curPoint.x != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit3_2":
               this.setYourFather(24);
               if(curPoint.y != 6 || curPoint.x != 1)
               {
                  this.bbdc.setFramePointX(1);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit4_1":
               this.setYourFather(24);
               if(curPoint.y != 6 || curPoint.x != 2)
               {
                  this.bbdc.setFramePointX(2);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit4_2":
               this.setYourFather(24);
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
               this.setAction("wait");
               break;
            case "hit3_1":
               this.setAction("hit3_2");
               break;
            case "hit3_2":
               this.setAction("wait");
               break;
            case "hit4_1":
               this.setAction("hit4_2");
               break;
            case "hit4_2":
               if(this.hit4Times > 1)
               {
                  this.hit4Times--;
                  this.setAction("hit4_1");
               }
               else
               {
                  this.setAction("wait");
               }
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
                  if(this.bbdc.getCurFrameCount() == 9)
                  {
                     this.doHit1_1(direct);
                  }
               }
               else if(p.x == 5)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHit1_2(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHit2(direct);
                  }
               }
               break;
            case "hit3_1":
               if(p.x == 0)
               {
                  this.speed.x = 0;
                  this.speed.y = -30;
               }
               break;
            case "hit3_2":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 12)
                  {
                     this.doHit3_2(direct);
                  }
                  this.speed.x = 0;
                  this.speed.y = 30;
               }
               break;
            case "hit4_1":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 12)
                  {
                     this.doHit4_1(direct);
                  }
               }
               break;
            case "hit4_2":
               if(this.curAttackTarget)
               {
                  if(this.x > this.curAttackTarget.x)
                  {
                     this.turnLeft();
                  }
                  else
                  {
                     this.turnRight();
                  }
               }
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 4)
                  {
                     this.doHit4_2(direct);
                  }
               }
               this.speed.x = 0;
               this.speed.y = 0;
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.standInObj && this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 800;
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
         this.setYourFather(24);
         this.setAction("hit3_1");
         this.lastHit = "hit3_1";
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.setYourFather(24);
         this.setAction("hit4_1");
         this.lastHit = "hit4_1";
         this.hit4Times = 3;
      }
      
      private function doHit1_1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster54Bullet1_1");
         if(direct == 0)
         {
            b.x = this.x - 155;
         }
         else
         {
            b.x = this.x + 155;
         }
         b.y = this.y - 60;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit1_2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster54Bullet1_2");
         if(direct == 0)
         {
            b.x = this.x - 235;
         }
         else
         {
            b.x = this.x + 235;
         }
         b.y = this.y - 15;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2(direct:uint) : void
      {
         var b:* = null;
         var idx:* = 0;
         var targetPoint:* = null;
         if(this.standInObj)
         {
            b = new SpecialEffectBullet("Monster54Bullet2");
            if(direct == 0)
            {
               b.x = this.x - 100;
            }
            else
            {
               b.x = this.x + 100;
            }
            b.y = this.y - 115;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit2");
            idx = uint(gc.gameSence.getChildIndex(this));
            gc.gameSence.addChildAt(b,idx);
            this.magicBulletArray.push(b);
            targetPoint = new Point(0,0);
            if(this.getBBDC().getDirect() == 0)
            {
               targetPoint.x = this.x - 100;
            }
            else
            {
               targetPoint.x = this.x + 100;
            }
            targetPoint.y = this.y - 40;
            for each(var bo in gc.getPlayerAndPetArray())
            {
               if(this.getBBDC().getDirect() == 0)
               {
                  if(bo.x < this.x)
                  {
                     bo.curAddEffect.add([{
                        "name":BaseAddEffect.MONSTER54_HOUJIAO,
                        "point":targetPoint,
                        "time":gc.frameClips * 3
                     }]);
                  }
               }
               else if(bo.x > this.x)
               {
                  bo.curAddEffect.add([{
                     "name":BaseAddEffect.MONSTER54_HOUJIAO,
                     "point":targetPoint,
                     "time":gc.frameClips * 3
                  }]);
               }
            }
         }
      }
      
      private function doHit3_1(direct:uint) : void
      {
      }
      
      private function doHit3_2(direct:uint) : void
      {
         if(this.curAttackTarget)
         {
            this.x = this.curAttackTarget.x;
         }
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster54Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 100;
         }
         else
         {
            b.x = this.x + 100;
         }
         b.y = this.y;
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(12);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4_1(direct:uint) : void
      {
         var targetPoint:* = null;
         var targetDirect:int = 0;
         if(this.curAttackTarget)
         {
            targetPoint = new Point();
            targetDirect = 0;
            if(RandomControllor.getIns().getRandom() <= 0.5)
            {
               targetPoint.x = this.curAttackTarget.x + 100;
            }
            else
            {
               targetPoint.x = this.curAttackTarget.x - 100;
            }
            targetPoint.y = this.curAttackTarget.y - 100;
            if(this.x < targetPoint.x)
            {
               this.turnRight();
            }
            else
            {
               this.turnLeft();
            }
            TweenMax.to(this,0.3,{
               "x":targetPoint.x,
               "y":targetPoint.y
            });
         }
      }
      
      private function doHit4_2(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster54Bullet4");
         if(direct == 0)
         {
            b.x = this.x - 50;
         }
         else
         {
            b.x = this.x + 50;
         }
         b.y = this.y - 110;
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
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3_1" || this.curAction == "hit3_2" || this.curAction == "hit4_1" || this.curAction == "hit4_2";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit3_1" || this.curAction == "hit3_2" || this.curAction == "hit4_1" || this.curAction == "hit4_2";
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         super.destroy();
         if(this.getHp() <= 0)
         {
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
