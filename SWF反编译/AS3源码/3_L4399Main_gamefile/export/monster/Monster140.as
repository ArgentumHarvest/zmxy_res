package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.bullet.SpecialEffectBullet;
   import export.level.StageListener471Children.Monster140SpecialBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class Monster140 extends BaseMonster
   {
      
      public static var MONSTER140DEAD_EVENT:String = "monster140dead_event";
       
      
      private var m141Array:Array;
      
      private var propertyLevel:uint = 1;
      
      public function Monster140()
      {
         m141Array = [];
         super();
         this.normalAttackRate = 0.8;
         this.horizenSpeed = 4;
         this.setPropertyByLevel(1);
         this.isCanBeCatchSkill = true;
         this.isBoss = true;
         this.monsterName = "轸宿";
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 20];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 10];
         this.skillCD3 = [gc.frameClips * 8,gc.frameClips * 15];
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
      }
      
      public function setPropertyByLevel(lv:uint = 1) : void
      {
         this.propertyLevel = lv;
         if(lv > 10)
         {
            lv = 10;
         }
         this.setHp(500000 * lv);
         this.setSHp(500000 * lv);
         this.attackRange = 200;
         this.attackRangeY = 50;
         this.alertRangeY = 20;
         this.alertRange = 2500;
         this._anti.def = 50 * lv;
         this._anti.exp = 2000 * lv;
         this._anti.gxp = 500;
         this._anti.mDef = 0.05 * lv;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":500 * lv,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":500 * lv,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2_2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":24,
            "power":500 * lv,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":500 * lv,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":500,
            "attackKind":"physics"
         };
         this.setIsZhuque(lv);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster140");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
            bbdc.setOffsetXY(10,-15);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[2,30],[2,2,30],[2,10]]);
            bbdc.setFrameCount([6,4,1,5,4,2,3,2]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster140--BitmapData Error!");
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
            case "hit4":
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
               this.dispatchEvent(new CommonEvent(MONSTER140DEAD_EVENT));
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
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi2_1(direct);
                  }
               }
               else if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 30)
                  {
                     this.doHi2_2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 30)
                  {
                     this.doHi3(direct);
                  }
               }
               break;
            case "hit4":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi4(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 450;
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
         this.setYourFather(100000);
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
         this.setYourFather(20);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster140Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 55;
         }
         else
         {
            b.x = this.x + 55;
         }
         b.y = this.y - 125;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_1(direct:uint) : void
      {
         var b:* = null;
         b = new SpecialEffectBullet("Monster140Bullet2_1");
         if(direct == 0)
         {
            b.x = this.x - 90;
         }
         else
         {
            b.x = this.x + 90;
         }
         b.y = this.y - 115;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_2(direct:uint) : void
      {
         var b:* = null;
         b = new SpecialEffectBullet("Monster140Bullet2_2");
         b.x = this.x;
         b.y = this.y + 50;
         b.setRole(this);
         b.setDirect(direct);
         b.setFuncWhenDestroy(hit2_3);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function hit2_3(bb:BaseBullet) : void
      {
         var b:* = null;
         this.bbdc.stopFrame();
         this.bbdc.hide();
         b = new Monster140SpecialBullet("Monster140Bullet2_3");
         b.x = bb.x;
         b.y = bb.y;
         b.setRole(this);
         b.setDirect(0);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 5);
         b.setFuncWhenDestroy(hit2_4);
         b.setAction("hit2_2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function hit2_4(bb:BaseBullet) : void
      {
         var b:* = null;
         b = new SpecialEffectBullet("Monster140Bullet2_2");
         b.x = bb.x;
         b.y = bb.y;
         b.setRole(this);
         b.setDirect(0);
         b.setFuncWhenDestroy(hit2_5);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster140Bullet2_4");
         b.x = bb.x;
         b.y = bb.y - 100;
         b.setRole(this);
         b.setDirect(0);
         b.setFuncWhenDestroy(hit2_5);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function hit2_5(bb:BaseBullet) : void
      {
         this.x = bb.x;
         this.y = bb.y - 60;
         this.bbdc.continueFrame();
         this.bbdc.show();
         this.setYourFather(10);
      }
      
      private function doHi3(direct:uint) : void
      {
         var delay1:Number = NaN;
         var delay2:Number = NaN;
         var target:BaseHero = gc.getRandomPlayer();
         if(target)
         {
            this.doSingleHit4(target,"Monster140Bullet3_1");
            delay1 = RandomControllor.getIns().getRandom() / 2;
            TweenMax.delayedCall(delay1,doSingleHit4,[target,"Monster140Bullet3_2"]);
            delay2 = RandomControllor.getIns().getRandom() / 2;
            TweenMax.delayedCall(delay2,doSingleHit4,[target,"Monster140Bullet3_3"]);
         }
      }
      
      private function doSingleHit4(target:BaseHero, mcName:String) : void
      {
         var b:* = null;
         b = new SpecialEffectBullet(mcName);
         b.x = target.x - RandomControllor.getIns().getRandom() * 100;
         b.y = 500;
         b.setRole(this);
         b.setDirect(0);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi4(direct:uint) : void
      {
         var b:* = null;
         b = new SpecialEffectBullet("Monster140Bullet4");
         if(direct == 0)
         {
            b.x = this.x - 80;
         }
         else
         {
            b.x = this.x + 80;
         }
         b.y = this.y + 10;
         b.setRole(this);
         b.setFuncWhenDestroy(startHit4);
         b.setDirect(0);
         b.setDisable();
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function startHit4(bb:BaseBullet) : void
      {
         this.callMonster141(bb.x,bb.y - 50);
      }
      
      private function callMonster141(xx:Number, yy:Number) : void
      {
         xx = xx;
         yy = yy;
         if(gc.pWorld.monsterArray.length < 10)
         {
            var mon141:Monster141 = MainGame.getInstance().createMonster(141,xx,yy) as Monster141;
            mon141.addEventListener(Monster141.MONSTER141DEAD_EVENT,__monster141Dead);
            mon141.setPropertyByLevel(this.propertyLevel);
            this.m141Array.push(mon141);
            TweenMax.delayedCall(15,function(_m141:Monster141, _self:Monster140):*
            {
               _self.removeFromm141Array(_m141);
               _m141.destroy();
            },[mon141,this]);
         }
      }
      
      private function __monster141Dead(evt:CommonEvent) : void
      {
         var m141:Monster141 = evt.target as Monster141;
         m141.removeEventListener(Monster141.MONSTER141DEAD_EVENT,__monster141Dead);
         this.removeFromm141Array(m141);
         this.callMonster141(m141.x - 30,m141.y - 80);
         this.callMonster141(m141.x + 30,m141.y - 80);
      }
      
      private function removeFromm141Array(m141:Monster141) : void
      {
         var idx:int = this.m141Array.indexOf(m141);
         if(idx != -1)
         {
            this.m141Array.splice(idx,1);
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         return Boolean(super.beMagicAttack(_target,sr,force));
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
      }
      
      override public function destroy() : void
      {
         for each(var m141 in this.m141Array)
         {
            m141.removeEventListener(Monster141.MONSTER141DEAD_EVENT,__monster141Dead);
         }
         this.m141Array.length = 0;
         super.destroy();
      }
   }
}
