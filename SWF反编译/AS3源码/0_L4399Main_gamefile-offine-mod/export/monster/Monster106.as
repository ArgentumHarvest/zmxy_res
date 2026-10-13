package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class Monster106 extends BaseMonster
   {
       
      
      public function Monster106()
      {
         super();
         this.horizenSpeed = 4;
         this.setHp(100000);
         this.setSHp(100000);
         this.attackRange = 200;
         this.alertRange = 1000;
         this._anti.def = 200;
         this._anti.exp = 330;
         this._anti.gxp = 150;
         this._anti.mDef = 0.4;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":200,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2_1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-5,0],
            "attackInterval":999,
            "power":200,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2_2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-5,0],
            "attackInterval":999,
            "power":400,
            "attackKind":"magic"
         };
         this.isFly = true;
         this.graity = 0;
         this.isBoss = true;
         this.monsterName = "转轮王";
         this.setAction("wait");
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
         this.skillCD1 = [gc.frameClips * 7,gc.frameClips * 7];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster106");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(0,-10);
            bbdc.setFrameStopCount([[2,2,2,2,2,2],[8],[2,10],[2,2,2,2,2,2]]);
            bbdc.setFrameCount([6,1,2,6]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster106--BitmapData Error!");
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
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               this.setYourFather(10);
               this.dropAura();
               this.destroy();
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
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         switch(state)
         {
            case "hit1":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi2(direct);
                  }
               }
               else if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi2(direct);
                  }
               }
               else if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi2(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && this.curAttackTarget.standInObj;
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
         var point:* = null;
         if(this.curAttackTarget)
         {
            b = new EnemyMoveBullet("Monster106Bullet1");
            if(direct == 0)
            {
               b.x = this.x - 10;
            }
            else
            {
               b.x = this.x + 10;
            }
            b.y = this.y;
            b.setRole(this);
            point = AUtils.GetNextPointByTwoObj(this,this.curAttackTarget);
            b.setSpeed(point.x * 3,point.y * 3);
            b.setAddSpeed(point.x,point.y);
            b.setDistance(1000);
            b.setDestroyWhenLastFrame(false);
            b.setDirect(direct);
            b.setAction("hit1");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
         }
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:EnemyMoveBullet = new EnemyMoveBullet("Monster106Bullet1");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         var speedX:int = 5 + RandomControllor.getIns().getRandom() * 40;
         var speedY:int = 3 + RandomControllor.getIns().getRandom() * 5;
         b.setSpeed(speedX,speedY);
         b.setAddSpeed(1,2);
         b.setDestroyWhenLastFrame(false);
         b.setFuncWhenHitWall(this.explode);
         b.setDistance(9999);
         b.setAction("hit2_1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function explode(bb:BaseBullet) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster106Bullet2");
         b.x = bb.x;
         b.y = 502;
         b.setRole(this);
         b.setAction("hit2_2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2";
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         MainGame.getInstance().createMonster(107,470,370);
      }
   }
}
