package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import export.pet.PetMouse4Bullet3;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster175 extends BaseMonster
   {
       
      
      private var averLevel:uint = 0;
      
      public function Monster175()
      {
         super();
         this.horizenSpeed = 4;
         averLevel = gc.getAverageLevel();
         if(averLevel > 85)
         {
            averLevel = 85;
         }
         this.normalAttackRate = 0.6;
         this.horizenSpeed = 6;
         var temp:uint = Math.ceil(averLevel / 10);
         this.setHp(temp * temp * 10000 * (0.4 + averLevel * 0.01));
         this.setSHp(this.getHp());
         this.normalAttackRate = 0.7;
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = averLevel * 4;
         this._anti.exp = 500;
         this._anti.gxp = 250;
         this._anti.mDef = averLevel / 400;
         var hit2Hurt:int = averLevel * 20 - 150;
         hit2Hurt = hit2Hurt > 1 ? hit2Hurt : 1;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":averLevel * 10,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[1,0],
            "attackInterval":15,
            "power":hit2Hurt,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-14,-5],
            "attackInterval":24,
            "power":averLevel * 15,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "魔.何仙姑";
         this.setAction("wait");
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"hehua",
            "bigtype":"zb"
         }];
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 14];
         this.skillCD2 = [gc.frameClips * 8,gc.frameClips * 10];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster175");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(5,-20);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,10],[2,10],[2,10]]);
            bbdc.setFrameCount([6,4,1,5,3,2,2]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster175--BitmapData Error!");
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
                  if(this.bbdc.getCurFrameCount() == 10)
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
            case "hit3":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi3(direct);
                  }
               }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster175Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 30;
         }
         else
         {
            b.x = this.x + 30;
         }
         b.y = this.y - 0;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster169Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 0;
         }
         else
         {
            b.x = this.x + 0;
         }
         b.y = this.y - 0;
         b.setDestroyInCount(gc.frameClips * 5);
         b.setDestroyWhenLastFrame(false);
         b.setDisable();
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3(direct:uint) : void
      {
         var b:PetMouse4Bullet3 = new PetMouse4Bullet3("Monster175Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 20;
            b.setSpeed(-30,0);
            b.setAddSpeed(1,0);
         }
         else
         {
            b.x = this.x + 20;
            b.setSpeed(30,0);
            b.setAddSpeed(-1,0);
         }
         b.y = this.y;
         b.setFuncWhenHit(hitOver);
         b.setDestroyWhenLastFrame(false);
         b.setDistance(9999);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new PetMouse4Bullet3("Monster175Bullet3");
         if(direct == 0)
         {
            b.x = this.x + 20;
            b.setSpeed(30,0);
            b.setAddSpeed(-1,0);
         }
         else
         {
            b.x = this.x - 20;
            b.setSpeed(-30,0);
            b.setAddSpeed(1,0);
         }
         b.y = this.y;
         b.setFuncWhenHit(hitOver);
         b.setDestroyWhenLastFrame(false);
         b.setDistance(9999);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function hitOver(bb:BaseBullet) : void
      {
         this.cureHp(bb.hurt);
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         var flag:Boolean = true;
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster169Bullet2")
            {
               flag = false;
            }
         }
         if(flag)
         {
            super.reduceHp(re,canHurt);
         }
         else
         {
            this.cureHp(re);
         }
      }
      
      override public function addMonHurtMc(_hurt:int, isCrit:Boolean, _isShadow:Boolean = false) : *
      {
         var flag:Boolean = true;
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster169Bullet2")
            {
               flag = false;
            }
         }
         if(flag)
         {
            super.addMonHurtMc(_hurt,isCrit,_isShadow);
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.standInObj && this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.standInObj && this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(15);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(15);
         this.setAction("hit3");
         this.lastHit = "hit3";
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
