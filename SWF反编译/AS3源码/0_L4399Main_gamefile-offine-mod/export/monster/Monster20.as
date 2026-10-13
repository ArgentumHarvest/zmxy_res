package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import event.CommonEvent;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import my.MainGame;
   
   public class Monster20 extends BaseMonster
   {
       
      
      private var fs:Monster20;
      
      private var fsCount:uint = 0;
      
      public function Monster20()
      {
         super();
         this.horizenSpeed = 4;
         this.monsterName = "袁洪";
         this.isBoss = true;
         this.isCanBeCatchSkill = true;
         this.setHp(60000);
         this.setSHp(60000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 92;
         this._anti.exp = 380;
         this._anti.gxp = 190;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":8,
            "power":280,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":24,
            "power":280,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,2],
            "attackInterval":24,
            "power":280,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,2],
            "attackInterval":8,
            "power":400,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,2],
            "attackInterval":4,
            "power":280,
            "attackKind":"magic"
         };
         this.setAction("wait");
         this.setToCountSuppressLevel(20);
         this.skillCD1 = [gc.frameClips * 10,gc.frameClips * 60];
         this.skillCD2 = [gc.frameClips * 20,gc.frameClips * 20];
         this.skillCD3 = [gc.frameClips * 10,gc.frameClips * 10];
         this.skillCD4 = [gc.frameClips * 10,gc.frameClips * 15];
         this._anti.fallProbability = 0.15;
         this._anti.fallList = [{
            "name":"zjbtg",
            "bigtype":"zb"
         },{
            "name":"jllm",
            "bigtype":"zb"
         },{
            "name":"smz",
            "bigtype":"zb"
         }];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster20");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],350,250,new Point(0,0));
            bbdc.setOffsetXY(0,-35);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2,10],[2,5,2,10],[1,1],[28],[48],[2,2,2,24]]);
            bbdc.setFrameCount([6,4,1,6,4,24,1,1,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster20--BitmapData Error!");
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
            case "hit4":
               if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(str);
               break;
            case "hit5":
               if(curPoint.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               if(this.isBoss)
               {
                  if(curPoint.y != 3)
                  {
                     this.bbdc.setFramePointX(0);
                     this.bbdc.setFramePointY(3);
                  }
               }
               else if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
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
               this.fenshen();
               this.setAction("wait");
               break;
            case "hit3":
               this.setAction("wait");
               break;
            case "hit4":
               this.setAction("wait");
               break;
            case "hit5":
               this.setStatic();
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
      
      private function fenshen() : void
      {
         if(!this.fs)
         {
            this.fs = MainGame.getInstance().createMonster(20,this.x,this.y - 10) as Monster20;
            this.fs.setHp(this.getHp());
            this.fs.isBoss = false;
            this.fs._anti.fallList = [];
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
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHit1(direct);
                  }
               }
               break;
            case "hit2":
               break;
            case "dead":
               if(!this.isBoss)
               {
                  if(p.x == 0)
                  {
                     if(this.bbdc.getCurFrameCount() == 28)
                     {
                        this.doHit3(direct);
                     }
                  }
               }
               break;
            case "hit4":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 24)
                  {
                     this.doHit4(direct);
                  }
               }
               break;
            case "hit5":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 24)
                  {
                     this.doHit5(direct);
                  }
                  if(direct == 0)
                  {
                     this.speed.x = -10;
                  }
                  else
                  {
                     this.speed.x = 10;
                  }
               }
         }
      }
      
      private function doHit1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster20Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 180;
         }
         else
         {
            b.x = this.x + 180;
         }
         b.y = this.y - 120;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(24);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && this.isBoss && !this.fs;
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(42);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return !this.isBoss;
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.fs && this.standInObj;
      }
      
      override protected function releSkill4() : void
      {
         this.newAttackId();
         this.setAction("hit5");
         this.lastHit = "hit5";
      }
      
      override protected function beforeSkill4Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= 350;
      }
      
      private function doHit3(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster20Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 100;
         }
         else
         {
            b.x = this.x + 100;
         }
         b.y = this.y - 100;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         for each(var bh in gc.getPlayerArray())
         {
            if(AUtils.GetDisBetweenTwoObj(bh,this) <= 250)
            {
               bh.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[bh.roleProperies.getMMP() - 500]));
            }
         }
      }
      
      private function doHit4(direct:uint) : void
      {
         var b:* = null;
         this.setYourFather(48);
         if(this.isBoss)
         {
            this.x = this.curAttackTarget.x + 270;
            this.turnLeft();
            if(this.fs && !this.fs.isDead())
            {
               this.fs.setAction("hit4");
               this.fs.x = this.curAttackTarget.x - 270;
               this.fs.y = this.y;
               this.fs.turnRight();
            }
            b = new SpecialEffectBullet("Monster20Bullet4");
            b.x = this.x - 200;
            b.y = this.y;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit4");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
         }
      }
      
      private function doHit5(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster20Bullet5");
         if(direct == 0)
         {
            b.x = this.x - 90;
         }
         else
         {
            b.x = this.x + 90;
         }
         b.y = this.y - 90;
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(24);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit5");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit5";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
         if(!this.isBoss && !this.isDead())
         {
            this.fsCount++;
            if(this.fsCount >= 360)
            {
               this._anti.exp = 0;
               this._anti.gxp = 0;
               this.reduceHp(this.getHp(),false);
            }
         }
         if(this.isBoss)
         {
            if(this.fs)
            {
               if(this.fs.isDead())
               {
                  this.fs = null;
               }
            }
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
