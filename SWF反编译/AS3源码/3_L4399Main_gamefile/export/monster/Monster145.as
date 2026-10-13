package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster145 extends BaseMonster
   {
       
      
      public function Monster145()
      {
         super();
         this.normalAttackRate = 0.8;
         this.horizenSpeed = 4;
         this.setPropertyByLevel(1);
         this.attackRange = 300;
         this.attackRangeY = 50;
         this.alertRangeY = 20;
         this.alertRange = 2500;
         this._anti.def = 0;
         this._anti.exp = 0;
         this._anti.gxp = 0;
         this._anti.mDef = 0;
         this.isBoss = false;
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 8];
      }
      
      public function setPropertyByLevel(lv:uint = 1) : void
      {
         if(lv > 10)
         {
            lv = 10;
         }
         this.setHp(30000 * lv);
         this.setSHp(30000 * lv);
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":250 * lv,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":250 * lv,
            "attackKind":"magic"
         };
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster145");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(2,22);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2,10],[2,2,15],[1,1,1,1,10]]);
            bbdc.setFrameCount([6,4,1,6,3,5]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster145--BitmapData Error!");
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
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
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
                  if(this.bbdc.getCurFrameCount() == 15)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 4)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi2(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return true;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:* = null;
         var target:BaseHero = gc.getRandomPlayer();
         if(target)
         {
            b = new SpecialEffectBullet("Monster145Bullet1");
            b.x = target.x;
            b.y = 480;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit1");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
         }
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:* = null;
         var target:BaseMonster = gc.pWorld.monsterArray[int(RandomControllor.getIns().getRandom() * gc.pWorld.monsterArray.length)];
         if(target)
         {
            b = new SpecialEffectBullet("Monster145Bullet2");
            b.x = this.x;
            b.y = this.y;
            b.setRole(this);
            b.setDisable();
            b.setFollowDisplayObj(target);
            b.setFuncWhenDestroy(hit2Destroy);
            b.setDirect(direct);
            b.setAction("hit2");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
         }
      }
      
      private function hit2Destroy(bb:BaseBullet) : void
      {
         var target:BaseMonster = bb.getFollowDisplayObject() as BaseMonster;
         if(target)
         {
            target.cureHp(1000);
         }
      }
      
      override protected function move() : void
      {
         super.move();
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
