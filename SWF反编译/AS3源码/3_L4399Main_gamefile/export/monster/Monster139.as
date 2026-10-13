package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.bullet.SpecialEffectBullet;
   import export.level.StageListener223;
   import export.level.StageListener223Children.Monster139KuiLei;
   import export.level.StageListener223Children.Monster139TantantanBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster139 extends BaseMonster
   {
       
      
      private var monster139kuilei:Monster139KuiLei;
      
      public function Monster139()
      {
         super();
         this.normalAttackRate = 0.8;
         this.horizenSpeed = 4;
         this.setHp(2000000);
         this.setSHp(2000000);
         this.attackRange = 400;
         this.attackRangeY = 50;
         this.alertRangeY = 20;
         this.alertRange = 2500;
         this._anti.def = 300;
         this._anti.exp = 2000;
         this._anti.gxp = 500;
         this._anti.mDef = 0.25;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":1500,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":10,
            "power":1500,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":24,
            "power":1500,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":1500,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":2000,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "云霄";
         this.setAction("wait");
         this.isFly = true;
         this.graity = 0;
         this._anti.fallProbability = 0.05;
         this._anti.fallList = [{
            "name":"bxhyzzs",
            "bigtype":"dj"
         }];
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 12];
         this.skillCD2 = [gc.frameClips * 10,gc.frameClips * 70];
         this.skillCD3 = [gc.frameClips * 8,gc.frameClips * 13];
         this.skillCD4 = [gc.frameClips * 10,gc.frameClips * 15];
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
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster139");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
            bbdc.setOffsetXY(0,-55);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,10],[2,2,2,10],[2,2,10],[2,2,10],[2,10],[2,2,36,10]]);
            bbdc.setFrameCount([6,1,5,4,3,3,2,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster139--BitmapData Error!");
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
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit5":
               if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               this.setStatic();
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
            case "hit3":
               this.setAction("wait");
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
               break;
            case "hit3":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
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
               break;
            case "hit5":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi5_1(direct);
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
         return this.getHp() / this.getSHp() <= 0.7 && !this.monster139kuilei;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.getHp() / this.getSHp() <= 0.4;
      }
      
      override protected function beforeSkill4Start() : Boolean
      {
         return this.curAttackTarget && this.getHp() / this.getSHp() <= 0.2 && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 800;
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
         this.setYourFather(20);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      override protected function releSkill4() : void
      {
         this.newAttackId();
         this.setYourFather(40);
         this.setAction("hit5");
         this.lastHit = "hit5";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster139Bullet1_1");
         if(direct == 0)
         {
            b.x = this.x - 150;
         }
         else
         {
            b.x = this.x + 150;
         }
         b.y = this.y - 180;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster139Bullet1_2");
         if(direct == 0)
         {
            b.x = this.x - 330;
         }
         else
         {
            b.x = this.x + 330;
         }
         b.y = this.y - 130;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:* = null;
         b = new SpecialEffectBullet("Monster139Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 190;
         }
         else
         {
            b.x = this.x + 190;
         }
         b.y = this.y - 340;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3(direct:uint) : void
      {
         var randHero:BaseHero = gc.getRandomPlayer();
         if(randHero)
         {
            this.monster139kuilei = new Monster139KuiLei(randHero,this);
            this.monster139kuilei.x = this.x;
            this.monster139kuilei.y = this.y;
            gc.gameSence.addChild(this.monster139kuilei);
         }
      }
      
      private function selectHitTarget(curTarget:BaseObject = null) : BaseObject
      {
         var idx:int = 0;
         var targetArr:Array = [];
         if(this.monster139kuilei)
         {
            targetArr.push(this.monster139kuilei);
         }
         for each(var bh in gc.getPlayerArray())
         {
            targetArr.push(bh);
            if(bh.getPet())
            {
               targetArr.push(bh.getPet());
            }
            if(bh.getSummon())
            {
               targetArr.push(bh.getSummon());
            }
         }
         if(targetArr.length > 0)
         {
            if(curTarget)
            {
               idx = targetArr.indexOf(curTarget);
               if(idx != -1)
               {
                  targetArr.splice(idx,1);
               }
            }
            if(targetArr.length > 0)
            {
               return targetArr[int(RandomControllor.getIns().getRandom() * targetArr.length)];
            }
            return null;
         }
         return null;
      }
      
      private function doHi4(direct:uint) : void
      {
         var b:* = null;
         var target:BaseObject = this.selectHitTarget();
         if(target)
         {
            b = new Monster139TantantanBullet("Monster139Bullet4");
            b.x = this.x;
            b.y = this.y;
            b.setSpeed(6,6);
            b.setDistance(99999);
            b.setDestroyWhenLastFrame(false);
            b.setDestroyInCount(gc.frameClips * 10);
            b.setMoveTarget(target);
            b.setRole(this);
            b.setFuncWhenHit(hit4Hit);
            b.setDirect(direct);
            b.setAction("hit4");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
         }
      }
      
      public function hit4Hit(bb:BaseBullet) : void
      {
         bb = bb;
         TweenMax.delayedCall(1,function(_bb:BaseBullet):*
         {
            _bb.newAttackId();
         },[bb]);
         for each(bb in this.magicBulletArray)
         {
            if(bb is Monster139TantantanBullet)
            {
               (bb as Monster139TantantanBullet).hitTimes--;
               var newTarget:BaseObject = this.selectHitTarget((bb as Monster139TantantanBullet).getMoveTarget());
               if(newTarget)
               {
                  (bb as Monster139TantantanBullet).setMoveTarget(newTarget);
               }
               else
               {
                  (bb as Monster139TantantanBullet).hitTimes = 0;
               }
            }
         }
      }
      
      private function doHi5_1(direct:uint) : void
      {
         var b:* = null;
         if(this.curAttackTarget)
         {
            b = new SpecialEffectBullet("Monster139Bullet5_1");
            b.x = this.x;
            b.y = this.y;
            b.setDestroyWhenLastFrame(false);
            b.setDestroyInCount(42);
            b.setFuncWhenDestroy(doHi5_2);
            b.setRole(this);
            b.setDisable();
            b.setDirect(direct);
            b.setAction("hit5");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
            TweenMax.to(b,0.8,{
               "x":this.curAttackTarget.x,
               "y":this.curAttackTarget.y
            });
         }
      }
      
      private function doHi5_2(bb:BaseBullet) : void
      {
         var b:* = null;
         b = new SpecialEffectBullet("Monster139Bullet5_2");
         b.x = bb.x;
         b.y = bb.y;
         b.setRole(this);
         b.setFuncWhenHit(hit5Hit);
         b.setDirect(0);
         b.setAction("hit5");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function hit5Hit(bb:BaseBullet) : void
      {
         this.cureHp(this.getSHp() / 10);
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function step() : void
      {
         super.step();
         if(this.monster139kuilei)
         {
            this.monster139kuilei.step();
            if(this.monster139kuilei.continueCount <= 0)
            {
               this.monster139kuilei.destroy();
               this.monster139kuilei = null;
            }
         }
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
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(this.monster139kuilei)
         {
            this.monster139kuilei.destroy();
            this.monster139kuilei = null;
         }
         if(this.isDead())
         {
            if(gc.pWorld.getBaseLevelListener() is StageListener223)
            {
               (gc.pWorld.getBaseLevelListener() as StageListener223).addTransferDoor();
            }
         }
      }
   }
}
