package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster55 extends BaseMonster
   {
       
      
      private var linkedArray:Array;
      
      public function Monster55()
      {
         linkedArray = [];
         super();
         this.horizenSpeed = 4;
         this.setHp(55000);
         this.setSHp(55000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 100;
         this._anti.exp = 312;
         this._anti.gxp = 156;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":500,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["dead"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":800,
            "attackKind":"magic"
         };
         this.isBoss = false;
         this.setAction("wait");
         this._anti.fallProbability = 0.05;
         this._anti.fallList = [{
            "name":"wplh",
            "bigtype":"dj"
         }];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster55");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
            bbdc.setOffsetXY(4,2);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[26,2,2,10],[2,2,20]]);
            bbdc.setFrameCount([6,4,1,4,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster55--BitmapData Error!");
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
               this.setYourFather(10);
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
         switch(state)
         {
            case "hit1":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     this.doHi1_1(direct);
                  }
               }
               break;
            case "dead":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 26)
                  {
                     this.doDead(direct);
                  }
               }
               this.speed.x = 0;
               this.speed.y = 0;
         }
      }
      
      private function doHi1_1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster55Bullet2_1");
         if(direct == 0)
         {
            b.x = this.x - 50;
         }
         else
         {
            b.x = this.x + 50;
         }
         b.y = this.y - 25;
         b.setRole(this);
         b.setDisable();
         b.setFuncWhenDestroy(hit1Destroy);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function hit1Destroy(bb:BaseBullet) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster55Bullet2_2");
         b.x = bb.x;
         b.y = bb.y + 45;
         b.setRole(this);
         b.setDirect(0);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doDead(direct:uint) : void
      {
         var b2:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster55Bullet1");
         if(direct == 0)
         {
            b2.x = this.x - 120;
         }
         else
         {
            b2.x = this.x + 120;
         }
         b2.y = this.y - 185;
         b2.setRole(this);
         b2.setDirect(direct);
         b2.setAction("dead");
         gc.gameSence.addChild(b2);
         this.magicBulletArray.push(b2);
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
