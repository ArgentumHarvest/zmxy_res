package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import export.bullet.BounceBullet;
   import export.bullet.NetBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster125 extends BaseMonster
   {
       
      
      public function Monster125()
      {
         super();
         this.horizenSpeed = 5;
         this.setHp(1500000);
         this.setSHp(1500000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.mDef = 0.2;
         this._anti.def = 300;
         this._anti.exp = 4000;
         this._anti.gxp = 100;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":1600,
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
            "attackInterval":24,
            "power":1000,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "狴犴圣者";
         this.setAction("wait");
         this.setToCountSuppressLevel(60);
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 15];
         this.skillCD2 = [gc.frameClips * 3,gc.frameClips * 6];
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"p_cysx",
            "bigtype":"cwzb"
         }];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster125");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],350,350,new Point(0,0));
            bbdc.setOffsetXY(-10,-55);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[2,2,5,2,2],[2,2,2,2,10],[2,2,10]]);
            bbdc.setFrameCount([6,4,1,5,4,5,5,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster125--BitmapData Error!");
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
            case "hit2_1":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "hit2_2":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
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
         var playerArray:* = null;
         var bh:* = null;
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
            case "hit2_1":
               this.speed.y = 0;
               this.setStatic();
               playerArray = gc.getPlayerArray();
               if(playerArray.length > 0)
               {
                  bh = playerArray[0] as BaseHero;
                  if(RandomControllor.getIns().getRandom() < 0.5)
                  {
                     this.x = bh.x - 40;
                  }
                  else
                  {
                     this.x = bh.x + 40;
                  }
                  this.curAttackTarget = bh;
                  this.faceToTarget();
               }
               this.setAction("hit2_2");
               break;
            case "hit2_2":
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
      
      override protected function beforeSkill1Start() : Boolean
      {
         return true;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return true;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(48);
         this.setAction("hit2_1");
         this.lastHit = "hit2_1";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(24);
         this.setAction("hit3");
         this.lastHit = "hit3";
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
            case "hit2_1":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi2_1(direct);
                  }
               }
               else if(p.x == 3 || p.x == 4)
               {
                  if(direct == 0)
                  {
                     this.speed.x = -10;
                  }
                  else
                  {
                     this.speed.x = 10;
                  }
                  this.speed.y = -10;
               }
               break;
            case "hit2_2":
               if(p.x < 3)
               {
                  if(!this.standInObj)
                  {
                     if(direct == 0)
                     {
                        this.speed.x = -10;
                     }
                     else
                     {
                        this.speed.x = 10;
                     }
                     this.speed.y = 10;
                  }
               }
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi2_2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 2)
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
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster125Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 160;
         }
         else
         {
            b.x = this.x + 160;
         }
         b.y = this.y - 60;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster125Bullet2_1");
         if(direct == 0)
         {
            b.x = this.x;
         }
         else
         {
            b.x = this.x;
         }
         b.y = this.y + 40;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster125Bullet2_2");
         if(direct == 0)
         {
            b.x = this.x;
         }
         else
         {
            b.x = this.x;
         }
         b.y = this.y + 40;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         var nb:NetBullet = new NetBullet("Monster125Bullet2_net");
         if(direct == 0)
         {
            nb.x = this.x;
         }
         else
         {
            nb.x = this.x;
         }
         nb.y = this.y - 10;
         nb.setRole(this);
         nb.setDestroyWhenLastFrame(false);
         nb.setDestroyInCount(gc.frameClips * 10);
         nb.setDisable();
         nb.setDirect(direct);
         nb.setAction("hit2");
         gc.gameSence.addChild(nb);
         this.magicBulletArray.push(nb);
      }
      
      private function doHi3(direct:uint) : void
      {
         var i:* = 0;
         var tb:* = null;
         var randSpeedX:Number = NaN;
         var randSpeedY:Number = NaN;
         var nums:int = Math.ceil(RandomControllor.getIns().getRandom() * 3);
         for(i = uint(0); i < nums; )
         {
            randSpeedX = 10 + RandomControllor.getIns().getRandom() * 5;
            randSpeedY = 10 + RandomControllor.getIns().getRandom() * 5;
            if(RandomControllor.getIns().getRandom() < 0.5)
            {
               randSpeedY *= -1;
            }
            if(direct == 0)
            {
               tb = new BounceBullet("Monster125Bullet3_1",new Point(-randSpeedX,randSpeedY));
               tb.x = this.x - 100;
            }
            else
            {
               tb = new BounceBullet("Monster125Bullet3_1",new Point(randSpeedX,randSpeedY));
               tb.x = this.x + 100;
            }
            tb.y = this.y;
            tb.setRole(this);
            tb.setDestroyInCount(gc.frameClips * 15);
            tb.setDestroyWhenLastFrame(false);
            tb.setAction("hit3");
            gc.gameSence.addChild(tb);
            this.magicBulletArray.push(tb);
            i++;
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit2_1" || this.curAction == "hit2_2";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2_1" || this.curAction == "hit2_2" || this.curAction == "hit3";
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
