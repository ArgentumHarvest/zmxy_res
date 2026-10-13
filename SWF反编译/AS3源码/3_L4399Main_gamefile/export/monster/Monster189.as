package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import export.bullet.BounceBullet;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class Monster189 extends BaseMonster
   {
       
      
      private var _isFenshen:Boolean = false;
      
      private var continueCount:int = 240;
      
      private var inReadyForRelive:Boolean = false;
      
      private var boundBullets:Array;
      
      public function Monster189()
      {
         boundBullets = [];
         super();
         this.horizenSpeed = 5;
         this.setHp(4200000);
         this.setSHp(4200000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.mDef = 0.66;
         this._anti.def = 600;
         this._anti.exp = 5000;
         this._anti.gxp = 100;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":2400,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":24,
            "power":2500,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2_2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":24,
            "power":4000,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.STUN,
               "time":gc.frameClips * 2
            }]
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":24,
            "power":1000,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":24,
            "power":3000,
            "attackKind":"physics"
         };
         this._anti.fallList = [];
         this.setAction("wait");
         this.setToCountSuppressLevel(60);
         this.isBoss = true;
         this.monsterName = "禅妖";
         this._anti.fallList = [{
            "name":"ttslsp2",
            "bigtype":"dj"
         },{
            "name":"hyjjjns3",
            "bigtype":"jns"
         },{
            "name":"smbjns3",
            "bigtype":"jns"
         },{
            "name":"tmcjns3",
            "bigtype":"jns"
         },{
            "name":"mmwjns3",
            "bigtype":"jns"
         }];
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 15];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 20];
         this.skillCD3 = [gc.frameClips * 3,gc.frameClips * 10];
         this._anti.fallProbability = 0.5;
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster189");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],400,300,new Point(0,0));
            bbdc.setOffsetXY(-10,-25);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,4,10],[2,4,10],[2,2,7,2,2,5],[2,2]]);
            bbdc.setFrameCount([6,4,1,5,3,3,6,20]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster189--BitmapData Error!");
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
               if(!this.isFenshen)
               {
                  this.checkRelive();
               }
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
         return !this.isFenshen;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return true;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(20);
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
         this.setYourFather(40);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var repeatIdx:int = 0;
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
               if(p.x == 4)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi3(direct);
                  }
               }
               break;
            case "hit4":
               repeatIdx = this.bbdc.getCurKeyFrameIndex();
               if(repeatIdx == 0)
               {
                  if(p.x == 0)
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        this.doHi4(direct);
                     }
                  }
               }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster189Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 130;
         }
         else
         {
            b.x = this.x + 130;
         }
         b.y = this.y - 100;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var i:* = 0;
         var tb:* = null;
         var randSpeedX:Number = NaN;
         var randSpeedY:Number = NaN;
         var nums:int = 2 + Math.ceil(RandomControllor.getIns().getRandom() * 4);
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
               tb = new BounceBullet("Monster189Bullet2_1",new Point(-randSpeedX,randSpeedY));
               tb.x = this.x - 100;
            }
            else
            {
               tb = new BounceBullet("Monster189Bullet2_1",new Point(randSpeedX,randSpeedY));
               tb.x = this.x + 100;
            }
            tb.y = this.y;
            tb.setRole(this);
            tb.setDestroyInCount(gc.frameClips * 10);
            tb.setDestroyWhenLastFrame(false);
            tb.setAction("hit2");
            tb.setFuncWhenDestroy(doHi2_2);
            gc.gameSence.addChild(tb);
            this.magicBulletArray.push(tb);
            boundBullets.push(tb);
            i++;
         }
      }
      
      private function doHi2_2(bb:BaseBullet) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster189Bullet2_2");
         b.x = bb.x;
         b.y = bb.y;
         b.setRole(this);
         b.setDirect(0);
         b.setAction("hit2_2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         boundBullets.splice(boundBullets.indexOf(bb),1);
      }
      
      private function doHi3(direct:uint) : void
      {
         var i:* = 0;
         var mon:* = null;
         var num:int = 1 + RandomControllor.getIns().getRandom() * 2;
         for(i = uint(0); i < num; )
         {
            mon = MainGame.getInstance().createMonster(189,this.x,this.y) as Monster189;
            mon.isFenshen = true;
            i++;
         }
         this.setYourFather(gc.frameClips * 10);
      }
      
      private function doHi4(direct:uint) : void
      {
         var bh:* = null;
         var playerArray:Array = gc.getPlayerArray();
         if(playerArray.length > 0)
         {
            bh = playerArray[0] as BaseHero;
            if(RandomControllor.getIns().getRandom() < 0.5)
            {
               this.x = bh.x - 80;
            }
            else
            {
               this.x = bh.x + 80;
            }
            this.y = bh.y - 120;
            this.curAttackTarget = bh;
            this.faceToTarget();
         }
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster189Bullet3");
         direct = this.bbdc.getDirect();
         if(direct == 0)
         {
            b.x = this.x - 190;
         }
         else
         {
            b.x = this.x + 190;
         }
         b.y = this.y - 140;
         b.setHurtCanCutDownEffect(false);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(40);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
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
         if(this.isFenshen)
         {
            if(continueCount > 0)
            {
               continueCount--;
               if(continueCount == 0)
               {
                  this.destroy();
               }
            }
         }
      }
      
      private function checkRelive() : void
      {
         if(this.isDead())
         {
            if(boundBullets.length > 0)
            {
               this.inReadyForRelive = true;
               setTimeout(function(_self:Monster189):*
               {
                  MainGame.getInstance().createMonster(189,_self.x,_self.y);
               },500,this);
            }
         }
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         super.destroy();
         this.boundBullets = null;
         if(!this.inReadyForRelive && !this.isFenshen && this.isBoss)
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
      
      public function get isFenshen() : Boolean
      {
         return _isFenshen;
      }
      
      public function set isFenshen(value:Boolean) : void
      {
         _isFenshen = value;
         if(this.isFenshen)
         {
            this.isBoss = false;
            this.monsterName = "";
            this._anti.fallList = [];
         }
      }
      
      override public function fallEquip() : void
      {
         if(!this.isFenshen)
         {
            super.fallEquip();
         }
      }
   }
}
