package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import base.BaseObject;
   import event.CommonEvent;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster149 extends BaseMonster
   {
      
      public static var Monster149DEAD_EVENT:String = "Monster149dead_event";
       
      
      private var propertyLevel:uint = 1;
      
      private var hit2Target:BaseHero;
      
      public function Monster149()
      {
         super();
         this.normalAttackRate = 0.8;
         this.horizenSpeed = 4;
         this.setPropertyByLevel(1);
         this.isCanBeCatchSkill = true;
         this.isBoss = true;
         this.monsterName = "鬼宿";
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 20];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 15];
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
            "attackBackSpeed":[-10,0],
            "attackInterval":10,
            "power":500 * lv,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-15,0],
            "attackInterval":10,
            "power":500 * lv,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":24,
            "power":250 * lv,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":48,
            "power":250 * lv,
            "attackKind":"physics"
         };
         this.setIsZhuque(lv);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster149");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
            bbdc.setOffsetXY(5,-22);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[1,1,1,4],[1,1,1,4],[2,2,10],[2,20]]);
            bbdc.setFrameCount([6,4,1,5,4,4,4,3,2]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster149--BitmapData Error!");
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
            case "hit5":
               if(curPoint.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
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
               this.setStatic();
               this.setAction("hit3");
               if(this.hit2Target && !this.hit2Target.isDead())
               {
                  this.curAttackTarget = this.hit2Target;
                  if(this.hit2Target.getBBDC().getDirect() == 0)
                  {
                     this.x = this.hit2Target.x + 100;
                  }
                  else
                  {
                     this.x = this.hit2Target.x - 100;
                  }
                  this.faceToTarget();
               }
               break;
            case "hit3":
               this.setStatic();
               this.setAction("hit1");
               break;
            case "hit4":
               this.setAction("wait");
               break;
            case "hit5":
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
               this.dispatchEvent(new CommonEvent(Monster149DEAD_EVENT));
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
               if(direct == 0)
               {
                  this.speed.x = -15;
               }
               else
               {
                  this.speed.x = 15;
               }
               break;
            case "hit3":
               if(direct == 0)
               {
                  this.speed.x = -15;
               }
               else
               {
                  this.speed.x = 15;
               }
               break;
            case "hit4":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi2(direct);
                  }
               }
               break;
            case "hit5":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     this.doHi3(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return true;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 400;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return true;
      }
      
      override protected function releSkill1() : void
      {
         this.hit2Target = gc.getRandomPlayer();
         if(this.hit2Target)
         {
            this.curAttackTarget = this.hit2Target;
            this.faceToTarget();
            this.newAttackId();
            this.setYourFather(20);
            this.setAction("hit2");
            this.lastHit = "hit2";
         }
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(24);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.setYourFather(24);
         this.setAction("hit5");
         this.lastHit = "hit5";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster149Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 170;
         }
         else
         {
            b.x = this.x + 170;
         }
         b.y = this.y - 45;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster149Bullet3");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDestroyInCount(gc.frameClips * 8);
         b.setDestroyWhenLastFrame(false);
         b.setDirect(direct);
         b.setAction("hit3");
         b.setFollowDisplayObj(this);
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster149Bullet4");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setDisable();
         b.setAction("hit4");
         b.setFollowDisplayObj(this);
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b.setFuncWhenDestroy(hit3Effect);
      }
      
      private function hit3Effect(bb:BaseBullet) : void
      {
         var flag:Boolean = false;
         for each(var bh in gc.getPlayerArray())
         {
            flag = false;
            if(bh.x < this.x && (bh.getBBDC().getDirect() == 1 && this.bbdc.getDirect() == 0))
            {
               flag = true;
            }
            else if(bh.x > this.x && (bh.getBBDC().getDirect() == 0 && this.bbdc.getDirect() == 1))
            {
               flag = true;
            }
            if(flag)
            {
               if(!bh.isYourFather())
               {
                  bh.reduceHp(500 * this.propertyLevel,true);
                  bh.addCurAddEffect([{
                     "name":BaseAddEffect.MONSTER149Buff,
                     "time":gc.frameClips * 10
                  }]);
               }
            }
         }
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,canHurt);
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         return Boolean(super.beMagicAttack(_target,sr,force));
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function step() : void
      {
         super.step();
         if(this.x > 1100)
         {
            this.x = 800;
         }
         else if(this.x < -100)
         {
            this.x = 100;
         }
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit2" || this.curAction == "hit3";
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.hit2Target = null;
      }
   }
}
