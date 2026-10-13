package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class Monster210 extends BaseMonster
   {
       
      
      private var callSi:TweenMax;
      
      private var fenshen:Monster211;
      
      public function Monster210()
      {
         super();
         this.horizenSpeed = 5;
         this.normalAttackRate = 0.8;
         this._anti.def = 400;
         this._anti.exp = 175;
         this._anti.gxp = 80;
         this._anti.mDef = 0.3;
         this.setHp(12000000);
         this.setSHp(12000000);
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":99,
            "power":3500,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":99,
            "power":3700,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":24,
            "power":3900,
            "attackKind":"magic"
         };
         this.attackRange = 500;
         this.alertRange = 2000;
         this.isFly = true;
         this.graity = 0;
         this.isBoss = true;
         this.monsterName = "紫晴鹏王";
         this.setAction("wait");
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"wpst_3",
            "bigtype":"dj"
         },{
            "name":"wpsh_3",
            "bigtype":"dj"
         }];
         this.skillCD1 = [gc.frameClips * 5,gc.frameClips * 11];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 14];
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":800,
            "isForever":1
         }]);
         this.startCall();
      }
      
      protected function startCall() : void
      {
         this.callSi = TweenMax.delayedCall(15,function(_self:Monster210):*
         {
            _self.callFenshen();
         },[this]);
      }
      
      private function callFenshen() : void
      {
         if(this.fenshen)
         {
            return;
         }
         this.fenshen = MainGame.getInstance().createMonster(211,this.x,this.y) as Monster211;
         this.fenshen.master = this;
         this.fenshen.addEventListener("monsterdestroy",__fenshenDestroy);
      }
      
      protected function __fenshenDestroy(event:Event) : void
      {
         this.fenshen.removeEventListener("monsterdestroy",__fenshenDestroy);
         this.fenshen = null;
         if(!this.isDead())
         {
            this.cureHp(this.getSHp() / 400);
            this.startCall();
         }
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster210");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
            bbdc.setOffsetXY(-10,-45);
            bbdc.setFrameStopCount([[4,4,4,4],[8],[2,2,2,2,7],[2,2,10],[2,2,10],[20]]);
            bbdc.setFrameCount([4,1,5,3,3,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster210--BitmapData Error!");
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
            case "hit3":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "hit4":
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
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
         var targetY:int = 0;
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
               this.bbdc.setFramePointX(0);
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
               targetY = 200 - (this.y - 100);
               this.fallEquipOffset.y = targetY;
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
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     this.doHi3(direct);
                  }
               }
               break;
            case "hit4":
               if(direct == 0)
               {
                  this.speed.x = -10;
               }
               else
               {
                  this.speed.x = 10;
               }
               if(this.y > 400)
               {
                  this.speed.y = -1;
               }
               else if(this.y < 200)
               {
                  this.speed.y = 1;
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 6000;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 400;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(20);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(20);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      protected function doHi1(direct:uint) : void
      {
         var b:* = null;
         var speed:* = null;
         var bh:BaseHero = gc.getRandomPlayer();
         if(bh)
         {
            b = new EnemyMoveBullet("Monster210Bullet1");
            if(direct == 0)
            {
               b.x = this.x - 50;
            }
            else
            {
               b.x = this.x + 50;
            }
            b.y = this.y - 20;
            speed = AUtils.GetNextPointByTwoObj(this,bh);
            if(speed.x == 0 && speed.y == 7)
            {
               speed.x = 1;
               speed.y = 0;
            }
            b.setSpeed(speed.x * 5,speed.y * 5);
            b.setAddSpeed(speed.x,speed.y);
            b.setDestroyWhenLastFrame(false);
            b.setDestroyInCount(gc.frameClips * 5);
            b.setDistance(9999);
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit1");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
         }
      }
      
      protected function doHi2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster210Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 160;
         }
         else
         {
            b.x = this.x + 160;
         }
         b.y = this.y - 0;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      protected function doHi3(direct:uint) : void
      {
         var b:* = null;
         var bh:BaseHero = gc.getRandomPlayer();
         if(bh)
         {
            b = new EnemyMoveBullet("Monster210Bullet3");
            if(this.x > bh.x)
            {
               b.x = this.x - RandomControllor.getIns().getRandom() * 400;
            }
            else
            {
               b.x = this.x + RandomControllor.getIns().getRandom() * 400;
            }
            b.y = 290;
            b.setRole(this);
            b.setDistance(2000);
            b.setDestroyInCount(gc.frameClips * 30);
            b.setDestroyWhenLastFrame(false);
            b.setDirect(direct);
            b.setAction("hit3");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function isCanMoveByStage() : Boolean
      {
         return true;
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit4";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         if(this.fenshen)
         {
            this.fenshen.removeEventListener("monsterdestroy",__fenshenDestroy);
            this.fenshen.destroy();
            this.fenshen = null;
         }
         if(this.callSi)
         {
            this.callSi.kill();
            this.callSi = null;
         }
         if(this.isDead())
         {
            ta = gc.pWorld.getTransferDoorArray();
            for(i = 0; i < ta.length; )
            {
               mc = ta[i];
               mc.visible = true;
               i++;
            }
         }
         super.destroy();
      }
   }
}
