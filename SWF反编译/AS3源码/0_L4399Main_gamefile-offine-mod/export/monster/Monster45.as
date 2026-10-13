package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.FollowBaseObjectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster45 extends BaseMonster
   {
       
      
      private var isReadyToSwim:Boolean = false;
      
      public function Monster45()
      {
         super();
         this.horizenSpeed = 6;
         this.normalAttackRate = 0.5;
         this._anti.def = 50;
         this._anti.exp = 100;
         this._anti.gxp = 50;
         this.setHp(25000);
         this.setSHp(25000);
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":150,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":150,
            "attackKind":"magic"
         };
         this.attackRange = 600;
         this.alertRange = 1000;
         this.isBoss = false;
         this.graity = 0.2;
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 4,gc.frameClips * 5];
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster45");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(2,-12);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8,20],[8],[2,2,2,2,10],[2,10],[2,2,2,10]]);
            bbdc.setFrameCount([6,4,2,1,5,2,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster45--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         if(!(!this.isReadyToSwim && this.standInObj))
         {
            if(this.curAction == "swim")
            {
               if(str != "dead" && str != "hit1" && str != "hurt")
               {
                  if(!this.standInObj)
                  {
                     this.isReadyToSwim = false;
                  }
                  return;
               }
            }
         }
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
            case "swim":
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
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
            case "hurt":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
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
               if(!this.standInObj)
               {
                  this.setAction("swim");
               }
               else
               {
                  this.setAction("wait");
               }
               break;
            case "hit2":
               if(!this.standInObj)
               {
                  this.setAction("swim");
               }
               else
               {
                  this.setAction("wait");
               }
               break;
            case "hurt":
               if(!this.standInObj)
               {
                  this.setAction("swim");
               }
               else
               {
                  this.setAction("wait");
               }
               break;
            case "swim":
               this.bbdc.setFramePointX(0);
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
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi2(direct);
                  }
               }
               break;
            case "swim":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 8)
                  {
                     if(this.curAttackTarget)
                     {
                        if(this.y > this.curAttackTarget.y)
                        {
                           this.speed.y = -6;
                        }
                        else
                        {
                           this.speed.y = 5;
                        }
                     }
                  }
               }
               else if(p.x == 1)
               {
                  if(this.curAttackTarget)
                  {
                     if(this.y > this.curAttackTarget.y)
                     {
                        this.speed.y = -6 * this.bbdc.getCurFrameCount() / 20;
                     }
                  }
               }
         }
      }
      
      override protected function hasAttackTarget() : void
      {
         var dis:Number = NaN;
         if(this.isBeAttacking() || this.isAttacking())
         {
            return;
         }
         if(!this.isAttacking() && !this.isBeAttacking())
         {
            if(this.beforeSkill1Start() && this.skillCD1[0] == 0)
            {
               this.releSkill1();
               this.skillCD1[0] = this.skillCD1[1];
            }
            else if(this.beforeSkill2Start() && this.skillCD2[0] == 0)
            {
               this.releSkill2();
               this.skillCD2[0] = this.skillCD2[1];
            }
            else if(this.beforeSkill3Start() && this.skillCD3[0] == 0)
            {
               this.releSkill3();
               this.skillCD3[0] = this.skillCD3[1];
            }
            else if(this.beforeSkill4Start() && this.skillCD4[0] == 0)
            {
               this.releSkill4();
               this.skillCD4[0] = this.skillCD4[1];
            }
            else if(this.count % gc.frameClips == 0)
            {
               dis = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget);
               if(dis <= this.attackRange)
               {
                  if(RandomControllor.getIns().getRandom() <= this.normalAttackRate)
                  {
                     this.attackTarget();
                  }
                  else if(dis <= 500)
                  {
                     this.keepDisWithTarget();
                  }
                  else
                  {
                     this.setAction("wait");
                     this.setStatic();
                  }
               }
               else
               {
                  this.followTarget();
               }
            }
         }
      }
      
      private function keepDisWithTarget() : void
      {
         if(this.curAttackTarget)
         {
            if(this.x > this.curAttackTarget.x)
            {
               this.moveRight();
            }
            else if(this.x < this.curAttackTarget.x)
            {
               this.moveLeft();
            }
         }
      }
      
      override protected function attackTarget() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 100;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(10);
         this.setAction("hit1");
         this.lastHit = "hit1";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster45Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 60;
         }
         else
         {
            b.x = this.x + 60;
         }
         b.y = this.y - 30;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:EnemyMoveBullet = new EnemyMoveBullet("Monster45Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 20;
         }
         else
         {
            b.x = this.x + 20;
         }
         b.y = this.y - 20;
         var point:Point = AUtils.GetNextPointByTwoObj(b,this.curAttackTarget);
         b.setSpeed(point.x * 3,0);
         b.setAddSpeed(point.x,0);
         b.setDistance(1000);
         b.setDestroyWhenLastFrame(false);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
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
         if(this.curAction != "swim" && !this.isAttacking() && !this.isBeAttacking())
         {
            if(this.standInObj && this.curAttackTarget)
            {
               if(this.curAttackTarget.y < this.y - 200)
               {
                  this.isReadyToSwim = true;
                  this.setAction("swim");
               }
            }
         }
         if(this.curAction == "swim")
         {
            if(!this.isReadyToSwim && this.standInObj)
            {
               this.setAction("wait");
            }
         }
      }
   }
}
