package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.HitTest;
   import my.MainGame;
   
   public class Monster120 extends BaseMonster
   {
       
      
      public function Monster120()
      {
         super();
         this.horizenSpeed = 5;
         this.setHp(1500000);
         this.setSHp(1500000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.mDef = 0.15;
         this._anti.def = 300;
         this._anti.exp = 3000;
         this._anti.gxp = 100;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":1500,
            "power":12,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":12,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":12,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.MONSTER120DEBUFF,
               "time":gc.frameClips * 3
            }]
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":24,
            "power":1500,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "狻猊圣者";
         this.setAction("wait");
         this.setToCountSuppressLevel(60);
         this.skillCD1 = [gc.frameClips * 10,gc.frameClips * 30];
         this.skillCD2 = [gc.frameClips * 15,gc.frameClips * 30];
         this.skillCD3 = [gc.frameClips * 10,gc.frameClips * 25];
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"p_cyxz",
            "bigtype":"cwzb"
         }];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster120");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
            bbdc.setOffsetXY(-10,-35);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[60],[2,20],[2,2,2,10]]);
            bbdc.setFrameCount([6,4,1,5,4,1,2,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster120--BitmapData Error!");
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
            case "hit3":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit4":
               if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
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
            case "hit3":
               this.setAction("wait");
               break;
            case "hit4":
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
      
      override protected function beforeSkill1Start() : Boolean
      {
         return true;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return true;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return true;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(60);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(24);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit4");
         this.lastHit = "hit4";
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
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 60)
                  {
                     this.doHi2_1(direct);
                  }
                  else if(this.bbdc.getCurFrameCount() == 35)
                  {
                     this.doHi2_2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     this.doHi3(direct);
                  }
               }
               break;
            case "hit4":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi4(direct);
                  }
               }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster120Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 75;
         }
         else
         {
            b.x = this.x + 75;
         }
         b.y = this.y - 20;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_1(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster120Bullet2_1");
         if(direct == 0)
         {
            b.x = this.x - 0;
         }
         else
         {
            b.x = this.x + 0;
         }
         b.y = this.y - 130;
         b.setDisable();
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_2(direct:uint) : void
      {
         var i:* = 0;
         var b:* = null;
         var point:Point = gc.gameSence.globalToLocal(new Point(0,0));
         var maxNums:uint = 2 + RandomControllor.getIns().getRandom() * 5;
         for(i = uint(0); i < maxNums; )
         {
            if(gc.pWorld.monsterArray.length < 7)
            {
               b = new FollowBaseObjectBullet("Monster120Bullet2_2");
               b.x = 100 + point.x + RandomControllor.getIns().getRandom() * 700;
               b.y = 400;
               b.setDisable();
               b.setFuncWhenDestroy(callMonster119);
               b.setRole(this);
               b.setDirect(direct);
               b.setAction("hit2");
               gc.gameSence.addChild(b);
               this.magicBulletArray.push(b);
            }
            i++;
         }
      }
      
      private function doHi3(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster120Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 0;
         }
         else
         {
            b.x = this.x + 0;
         }
         b.y = this.y - 0;
         b.setRole(this);
         b.setFuncWhenEnterFrame(hit3Enterframe);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 10);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function hit3Enterframe(bb:BaseBullet) : void
      {
         for each(var bm in gc.pWorld.monsterArray)
         {
            if(!bm.isDead() && bm.curAddEffect)
            {
               if(!bm.curAddEffect.getBuffByName(BaseAddEffect.MONSTER120DEBUFF))
               {
                  if(bb.hitTestObject(bm))
                  {
                     bm.addCurAddEffect([{
                        "name":BaseAddEffect.MONSTER120DEBUFF,
                        "time":gc.frameClips * 10
                     }]);
                  }
               }
            }
         }
      }
      
      private function doHi4(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster120Bullet4");
         b.x = this.x;
         b.setFuncWhenEnterFrame(hit4Enterframe);
         b.y = 350;
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 15);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function hit4Enterframe(bb:BaseBullet) : void
      {
         if(this.curAttackTarget)
         {
            if(bb.x > this.curAttackTarget.x)
            {
               bb.x -= 3;
            }
            else
            {
               bb.x += 3;
            }
         }
         for each(var bm in gc.pWorld.monsterArray)
         {
            if(!bm.isDead() && bm is Monster119)
            {
               if(!(bm as Monster119).isDoneHit3())
               {
                  if(HitTest.complexHitTestObject(bm,bb))
                  {
                     (bm as Monster119).doHit3();
                  }
               }
            }
         }
      }
      
      private function callMonster119(bb:BaseBullet) : void
      {
         MainGame.getInstance().createMonster(119,bb.x,bb.y);
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
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
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         super.destroy();
         if(this.isBoss)
         {
            ta = gc.pWorld.getTransferDoorArray();
            for(i = 0; i < ta.length; )
            {
               mc = ta[i];
               mc.visible = true;
               i++;
            }
         }
      }
   }
}
