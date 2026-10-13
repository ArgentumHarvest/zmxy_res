package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import export.bullet.EnemyMoveBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster61 extends BaseMonster
   {
       
      
      public function Monster61()
      {
         super();
         this.horizenSpeed = 3;
         this.setHp(10000);
         this.setSHp(10000);
         this.attackRange = 700;
         this.alertRange = 5000;
         this.alertRangeY = 200;
         this._anti.mDef = 0;
         this._anti.def = 100;
         this._anti.exp = 200;
         this._anti.gxp = 100;
         this.normalAttackRate = 0.3;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":300,
            "attackKind":"magic"
         };
         this.isBoss = false;
         this.setAction("wait");
         this.isFly = true;
         this.graity = 0;
         this._anti.fallProbability = 0.05;
         this._anti.fallList = [];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster61");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(-5,-6);
            bbdc.setFrameStopCount([[3,3,3,4,3,4],[8],[2,2,2,2,9],[2,2,2,19],[2,2,2,9]]);
            bbdc.setFrameCount([6,1,5,4,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster61--BitmapData Error!");
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
            case "dead":
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
            if(p.x == 3)
            {
               if(this.bbdc.getCurFrameCount() == 9)
               {
                  this.doHi1(direct);
               }
            }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:EnemyMoveBullet = new EnemyMoveBullet("Monster61Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 82;
         }
         else
         {
            b.x = this.x + 82;
         }
         b.y = this.y - 21;
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
