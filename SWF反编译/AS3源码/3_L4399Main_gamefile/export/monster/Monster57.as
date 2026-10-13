package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import base.BaseObject;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Monster57 extends BaseMonster
   {
       
      
      private var linkedArray:Array;
      
      public function Monster57()
      {
         linkedArray = [];
         super();
         this.horizenSpeed = 4;
         this.setHp(60000);
         this.setSHp(60000);
         this.normalAttackRate = 0.2;
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 100;
         this._anti.exp = 328;
         this._anti.gxp = 164;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":700,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.STUN,
               "time":gc.frameClips * 2.5
            }]
         };
         this.isBoss = false;
         this.setAction("wait");
         this._anti.fallProbability = 0.05;
         this._anti.fallList = [{
            "name":"wpll",
            "bigtype":"dj"
         }];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster57");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(4,-13);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,30]]);
            bbdc.setFrameCount([6,4,1,5,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster57--BitmapData Error!");
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
            if(p.x == 3)
            {
               if(this.bbdc.getCurFrameCount() == 30)
               {
                  this.doHi1(direct);
               }
            }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster57Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 52;
         }
         else
         {
            b.x = this.x + 52;
         }
         b.y = this.y + 2;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         var b2:SpecialEffectBullet = new SpecialEffectBullet("Monster57Bullet2");
         if(direct == 0)
         {
            b2.x = this.x - 52;
         }
         else
         {
            b2.x = this.x + 52;
         }
         b2.y = this.y + 2;
         b2.setRole(this);
         b2.setFuncWhenHit(hit1WhenHit);
         b2.setFuncWhenEnterFrame(hit1EnterFrame);
         b2.setFuncWhenDestroy(hit1Destroy);
         b2.setDirect(direct);
         b2.setAction("hit1");
         gc.gameSence.addChild(b2);
         this.magicBulletArray.push(b2);
      }
      
      private function hit1Destroy(bb:BaseBullet) : void
      {
         this.linkedArray.length = 0;
      }
      
      private function hit1EnterFrame(bb:BaseBullet) : void
      {
         var rect:* = null;
         for each(bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster57Bullet2")
            {
               rect = bb.getBounds(bb.parent);
               for each(var bo in this.linkedArray)
               {
                  bo.x = rect.x + rect.width / 2;
               }
            }
         }
      }
      
      private function hit1WhenHit(bb:BaseBullet) : void
      {
         var beHitedObject:* = null;
         for each(bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster57Bullet2" || bb.getImcName() == "Monster57Bullet1")
            {
               if(bb.getImgMc())
               {
                  if(bb.getImgMc().currentFrame < 15)
                  {
                     bb.getImgMc().gotoAndPlay(15 + (15 - bb.getImgMc().currentFrame));
                  }
               }
            }
            if(bb.getImcName() == "Monster57Bullet2")
            {
               beHitedObject = bb.hitObject;
               if(beHitedObject)
               {
                  this.linkedArray.push(beHitedObject);
               }
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
