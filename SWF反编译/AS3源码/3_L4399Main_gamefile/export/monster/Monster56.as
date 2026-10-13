package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.FollowBaseObjectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster56 extends BaseMonster
   {
       
      
      private var linkedArray:Array;
      
      public function Monster56()
      {
         linkedArray = [];
         super();
         this.horizenSpeed = 4;
         this.setHp(50000);
         this.setSHp(50000);
         this.normalAttackRate = 0.4;
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 100;
         this._anti.exp = 296;
         this._anti.gxp = 148;
         this.attackBackInfoDict["hit1_1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":300,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit1_2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":100,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 3,
               "power":100
            }]
         };
         this.isBoss = false;
         this.setAction("wait");
         this._anti.fallProbability = 0.05;
         this._anti.fallList = [{
            "name":"wpxm",
            "bigtype":"dj"
         }];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster56");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
            bbdc.setOffsetXY(4,-4);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,10]]);
            bbdc.setFrameCount([6,4,1,5,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster56--BitmapData Error!");
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
         var _loc4_:* = state;
         if("hit1" === _loc4_)
         {
            if(p.x == 2)
            {
               if(this.bbdc.getCurFrameCount() == 10)
               {
                  this.doHi1_1(direct);
               }
            }
         }
      }
      
      private function doHi1_1(direct:uint) : void
      {
         var b:EnemyMoveBullet = new EnemyMoveBullet("Monster56Bullet1_1");
         if(direct == 0)
         {
            b.x = this.x - 50;
         }
         else
         {
            b.x = this.x + 50;
         }
         b.y = this.y;
         b.setRole(this);
         if(this.getBBDC().getDirect() == 0)
         {
            b.setSpeed(-8);
         }
         else
         {
            b.setSpeed(8);
         }
         b.setDistance(500);
         b.setDestroyWhenLastFrame(false);
         b.setFuncWhenHit(hit1Hit);
         b.setDirect(direct);
         b.setAction("hit1_1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function hit1Hit(bb:BaseBullet) : void
      {
         var b2:* = null;
         for each(bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster56Bullet1_1")
            {
               b2 = new FollowBaseObjectBullet("Monster56Bullet1_2");
               b2.x = bb.x;
               b2.y = bb.y;
               b2.setRole(this);
               b2.setDirect(0);
               b2.setAction("hit1_2");
               gc.gameSence.addChild(b2);
               this.magicBulletArray.push(b2);
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
   }
}
