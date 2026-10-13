package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import export.bullet.FollowBaseObjectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster44 extends BaseMonster
   {
       
      
      private var isReadyToSwim:Boolean = false;
      
      public function Monster44()
      {
         super();
         this.horizenSpeed = 3;
         this.normalAttackRate = 0.7;
         this._anti.def = 100;
         this._anti.exp = 100;
         this._anti.gxp = 50;
         this._anti.mDef = 0.5;
         this.setHp(29000);
         this.setSHp(29000);
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":260,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.STUN,
               "time":gc.frameClips * 2
            }]
         };
         this.attackRange = 80;
         this.alertRange = 1000;
         this.isBoss = false;
         this.graity = 0.2;
         this.setAction("wait");
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster44");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],250,150,new Point(0,0));
            bbdc.setOffsetXY(2,-32);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8,8,8,20],[2,2,2,2,2,10],[2,2,10]]);
            bbdc.setFrameCount([6,4,4,6,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster44--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite7") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override protected function attackTarget() : void
      {
         if(RandomControllor.getIns().getRandom() < 0.2)
         {
            this.attackBackInfoDict["hit1"] = {
               "hitMaxCount":99,
               "attackBackSpeed":[6,-5],
               "attackInterval":999,
               "power":260,
               "attackKind":"physics",
               "addEffect":[{
                  "name":BaseAddEffect.STUN,
                  "time":gc.frameClips * 2
               }]
            };
         }
         else
         {
            this.attackBackInfoDict["hit1"] = {
               "hitMaxCount":99,
               "attackBackSpeed":[6,-5],
               "attackInterval":999,
               "power":260,
               "attackKind":"physics"
            };
         }
         super.attackTarget();
      }
      
      override public function setAction(str:String) : void
      {
         if(!(!this.isReadyToSwim && this.standInObj))
         {
            if(this.curAction == "swim")
            {
               if(str != "dead" && str != "hit1")
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
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
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
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "swim":
               if(p.x == 2)
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
               else if(p.x == 3)
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
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,false);
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster44Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 130;
         }
         else
         {
            b.x = this.x + 130;
         }
         b.y = this.y - 125;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
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
         if(this.curAction != "swim" && !this.isAttacking())
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
