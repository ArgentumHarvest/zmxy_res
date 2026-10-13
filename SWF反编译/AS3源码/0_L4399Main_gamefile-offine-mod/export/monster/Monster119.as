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
   
   public class Monster119 extends BaseMonster
   {
       
      
      public function Monster119()
      {
         var addBeishu:Number = NaN;
         super();
         this.horizenSpeed = 4;
         this.setHp(100000);
         this.setSHp(100000);
         this._anti.def = 100;
         this._anti.exp = 500;
         this._anti.gxp = 250;
         this._anti.mDef = 0.1;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":800,
            "power":600,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,-20],
            "attackInterval":999,
            "power":1000,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":600,
            "attackKind":"magic"
         };
         this.attackRange = 250;
         this.alertRange = 1000;
         this.isBoss = false;
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 5,gc.frameClips * 10];
         this._anti.fallProbability = 0.1;
         if(gc.curStageAndCurLevel.curStage == 23 || gc.curStageAndCurLevel.curStage == 25)
         {
            addBeishu = 2;
            if(gc.curStageAndCurLevel.curStage == 25)
            {
               addBeishu = 3;
            }
            this._anti.fallList = [{
               "name":"wpxt",
               "bigtype":"dj"
            }];
            this.setHp(100000 * addBeishu);
            this.setSHp(100000 * addBeishu);
            this._anti.def = 100 * addBeishu;
            this._anti.exp = 500 * addBeishu;
            this._anti.gxp = 250 * addBeishu;
            this._anti.mDef = 0.1 * addBeishu;
            this.attackBackInfoDict["hit1"] = {
               "hitMaxCount":99,
               "attackBackSpeed":[6,-5],
               "attackInterval":800,
               "power":600 * addBeishu,
               "attackKind":"magic"
            };
            this.attackBackInfoDict["hit2"] = {
               "hitMaxCount":99,
               "attackBackSpeed":[0,-20],
               "attackInterval":999,
               "power":1000 * addBeishu,
               "attackKind":"magic"
            };
            this.attackBackInfoDict["hit3"] = {
               "hitMaxCount":1,
               "attackBackSpeed":[0,0],
               "attackInterval":999,
               "power":600 * addBeishu,
               "attackKind":"magic"
            };
         }
         else
         {
            this._anti.fallList = [];
         }
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster119");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
            bbdc.setOffsetXY(-5,-11);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,7],[2,2,2,10],[2,2,10]]);
            bbdc.setFrameCount([6,1,5,4,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster119--BitmapData Error!");
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
            case "hit2":
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
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
            case "hit2":
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
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 2)
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
         this.setAction("hit2");
         this.lastHit = "hit2";
         this.setYourFather(10);
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster119Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 35;
         }
         else
         {
            b.x = this.x + 35;
         }
         b.y = this.y - 20;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:* = null;
         if(this.curAttackTarget)
         {
            b = new SpecialEffectBullet("Monster119Bullet2");
            b.x = this.curAttackTarget.x;
            b.y = 415;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit2");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
         }
      }
      
      public function doHit3() : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster119Bullet3");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setHurtCanCutDownEffect(false);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 10);
         b.setDirect(0);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      public function isDoneHit3() : Boolean
      {
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster119Bullet3")
            {
               return true;
            }
         }
         return false;
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
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
