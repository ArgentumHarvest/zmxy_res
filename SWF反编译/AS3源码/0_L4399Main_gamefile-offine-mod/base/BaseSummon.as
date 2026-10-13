package base
{
   import com.greensock.TweenMax;
   import export.level.StageListener151;
   import export.level.StageListener221;
   import export.level.StageListener222;
   import export.level.StageListener223;
   import export.monster.Monster16;
   import export.monster.Monster6;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.ANumber;
   import my.ColorMatrix;
   import my.HitTest;
   
   public class BaseSummon extends BaseObject
   {
      
      public static var SUMMON_TURTLE:uint = 0;
      
      public static var SUMMON_COWKING:uint = 1;
      
      public static var SUMMON_TURNROUNDKING:uint = 2;
       
      
      protected var sourceRole:BaseHero;
      
      private var hpSlip:Sprite;
      
      protected var attackRange:uint = 150;
      
      protected var searchRange:uint = 400;
      
      protected var followRange:uint = 200;
      
      protected var curAttackTarget:BaseObject;
      
      protected var lastBeAttackedTarget:BaseObject;
      
      protected var def:uint = 0;
      
      protected var hp:int = 100;
      
      protected var shp:int = 100;
      
      protected var atk:int = 10;
      
      protected var mdef:Number = 0;
      
      protected var continuedCount:uint = 480;
      
      protected var skillCD1:Array;
      
      protected var skillCD2:Array;
      
      protected var skillCD3:Array;
      
      protected var timeCount:uint = 0;
      
      protected var level:uint = 0;
      
      public function BaseSummon(bh:BaseHero, level:uint)
      {
         skillCD1 = [-1,30];
         skillCD2 = [-1,30];
         skillCD3 = [-1,30];
         super();
         this.level = level;
         this.sourceRole = bh;
         this.newHpSlip();
         this.jumpPower = -30;
         this.curAddEffect = new BaseAddEffect(BaseObject(this));
         this.bbdc.turnRight();
      }
      
      override protected function __added(evt:Event) : void
      {
         super.__added(evt);
         if(gc.pWorld.getBaseLevelListener() is StageListener151)
         {
            (gc.pWorld.getBaseLevelListener() as StageListener151).addBoatByBaseObject(this);
         }
         if(gc.pWorld.getBaseLevelListener() is StageListener221)
         {
            (gc.pWorld.getBaseLevelListener() as StageListener221).addBoatByBaseObject(this);
         }
         if(gc.pWorld.getBaseLevelListener() is StageListener222)
         {
            (gc.pWorld.getBaseLevelListener() as StageListener222).addBoatByBaseObject(this);
         }
         if(gc.pWorld.getBaseLevelListener() is StageListener223)
         {
            (gc.pWorld.getBaseLevelListener() as StageListener223).addBoatByBaseObject(this);
         }
      }
      
      override protected function initBBDC() : void
      {
      }
      
      override public function step() : void
      {
         var waitForDeleteArray:Array = [];
         for each(var bb in this.magicBulletArray)
         {
            bb.step2();
            if(bb.isReadyToDestroy)
            {
               waitForDeleteArray.push(bb);
            }
         }
         this.clearWaitFromParentArray(waitForDeleteArray,this.magicBulletArray);
         this.myIntelligence();
         this.countSkillCD();
         this.timeCount++;
         if(this.timeCount >= 59999)
         {
            this.timeCount = 0;
         }
         if(this.sourceRole)
         {
            if(AUtils.GetDisBetweenTwoObj(this,this.sourceRole) >= 800)
            {
               if(!this.isAttacking() && !this.isBeAttacking())
               {
                  this.x = this.sourceRole.x;
                  this.y = this.sourceRole.y - 30;
               }
            }
            if(this.continuedCount > 0)
            {
               this.continuedCount--;
               if(this.continuedCount == 0)
               {
                  this.sourceRole.clearSummon();
               }
            }
         }
         super.step();
      }
      
      private function countSkillCD() : void
      {
         if(this.skillCD1[0] > 0)
         {
            if(this.skillCD1[0]-- <= 0)
            {
               this.skillCD1[0] = 0;
            }
         }
         if(this.skillCD2[0] > 0)
         {
            if(this.skillCD2[0]-- <= 0)
            {
               this.skillCD2[0] = 0;
            }
         }
         if(this.skillCD3[0] > 0)
         {
            if(this.skillCD3[0]-- <= 0)
            {
               this.skillCD3[0] = 0;
            }
         }
      }
      
      private function clearWaitFromParentArray(wArray:Array, pArray:Array) : void
      {
         var temp:* = undefined;
         var i:* = 0;
         var idx:int = 0;
         for(i = uint(0); wArray.length > 0; )
         {
            temp = wArray.shift();
            idx = pArray.indexOf(temp);
            if(idx != -1)
            {
               pArray.splice(idx,1);
            }
            i++;
         }
      }
      
      protected function beforeSkill1Start() : Boolean
      {
         return false;
      }
      
      protected function beforeSkill2Start() : Boolean
      {
         return false;
      }
      
      protected function beforeSkill3Start() : Boolean
      {
         return false;
      }
      
      protected function releSkill1() : void
      {
      }
      
      protected function releSkill2() : void
      {
      }
      
      protected function releSkill3() : void
      {
      }
      
      override protected function move() : void
      {
         var curFrameAddSpeedX:Number = this.speed.x;
         var curFrameAddSpeedY:Number = this.speed.y;
         if(this.standInObj)
         {
            if(this.isWaiting())
            {
               if(this.standInObj is Wall)
               {
                  curFrameAddSpeedX = Wall(this.standInObj).speedX;
               }
               else
               {
                  curFrameAddSpeedX = 0;
               }
            }
         }
         if(gc.isInSea())
         {
            curFrameAddSpeedX /= 2;
            curFrameAddSpeedY /= 2;
            if(curFrameAddSpeedY > 8)
            {
               curFrameAddSpeedY = 8;
            }
            if(this.speed.y > 16)
            {
               this.speed.y = 16;
            }
         }
         this.x += curFrameAddSpeedX;
         this.y += curFrameAddSpeedY;
         this.speed.y += graity;
         this.x += this.enforceSpeed.x;
         this.y += this.enforceSpeed.y;
      }
      
      protected function myIntelligence() : void
      {
         if(this.curAddEffect)
         {
            if(this.curAddEffect.curDebuff(BaseAddEffect.FIX))
            {
               this.setStatic();
               return;
            }
         }
         if(!this.curAttackTarget)
         {
            this.searchTarget();
            if(this.timeCount % gc.frameClips == 0)
            {
               this.followSource();
            }
         }
         else
         {
            if(this.curAttackTarget.isDead())
            {
               this.curAttackTarget = null;
            }
            else if(AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) >= 500)
            {
               this.curAttackTarget = null;
            }
            else if(!this.isAttacking() && !this.isBeAttacking())
            {
               if(this.beforeSkill1Start() && this.skillCD1[0] == 0)
               {
                  this.releSkill1();
                  this.skillCD1[0] = this.skillCD1[1];
               }
               else if(this.beforeSkill2Start() && this.skillCD2[0] == 0)
               {
                  this.releSkill2();
                  this.skillCD2[0] = this.skillCD2[1];
               }
               else if(this.beforeSkill3Start() && this.skillCD3[0] == 0)
               {
                  this.releSkill3();
                  this.skillCD3[0] = this.skillCD3[1];
               }
               else if(this.timeCount % gc.frameClips == 0)
               {
                  if(AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= attackRange)
                  {
                     if(RandomControllor.getIns().getRandom() <= 0.8)
                     {
                        this.normalHit();
                     }
                     else if(RandomControllor.getIns().getRandom() < 0.3)
                     {
                        this.setStatic();
                     }
                     else
                     {
                        this.followTarget();
                     }
                  }
                  else
                  {
                     this.followTarget();
                  }
               }
            }
            if(this.sourceRole)
            {
               if(this.y - this.sourceRole.y > 300)
               {
                  if(!this.isAttacking() && !this.isBeAttacking())
                  {
                     this.jump();
                  }
               }
               else if(this.sourceRole.y - this.y > 50)
               {
                  if(!this.isAttacking() && !this.isBeAttacking())
                  {
                     this.getFallDown();
                  }
               }
            }
         }
      }
      
      public function setOtherAction(str:String) : void
      {
         var curPoint:Point = this.bbdc.getCurPoint();
         switch(str)
         {
            case "wait":
               this.setAction("wait");
               this.setStatic();
               break;
            case "jump":
               this.jump();
               break;
            case "turnLeft":
               this.turnLeft();
               this.setAction("walk");
               break;
            case "turnRight":
               this.turnRight();
               this.setAction("walk");
               break;
            case "getfalldown":
               this.getFallDown();
         }
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         var obj:* = null;
         var point:* = null;
         var arr:* = null;
         var i:* = 0;
         var o:* = null;
         var hurt:int = 0;
         var isCrit:Boolean = false;
         var dis:Number = NaN;
         if(this.isYourFather())
         {
            return false;
         }
         if(force || this.colipse && AUtils.testIntersects(this.colipse,_target,gc.gameSence) && HitTest.complexHitTestObject(this.colipse,_target))
         {
            this.lastBeAttackedTarget = sr;
            this.curAttackTarget = sr;
            obj = _target.sourceRoleAttackInfoObject;
            if(obj)
            {
               point = this.getBeattackBackSpeed(_target,obj);
               if(_target.getImcName() != "Role1Bullet12")
               {
                  this.setAttackBack(point);
               }
               if(obj.addEffect)
               {
                  arr = AUtils.clone(obj.addEffect) as Array;
                  for(i = uint(0); i < arr.length; )
                  {
                     o = arr[i];
                     if(o.time == BaseBullet.DESIDE_BY_FRAMES_LEFT)
                     {
                        o.time = _target.getFrameLeft();
                     }
                     i++;
                  }
                  this.addCurAddEffect(arr);
               }
            }
            hurt = _target.hurt;
            isCrit = _target.isCrit;
            hurt = sr.getRealPower(_target.curAction);
            if(_target.getImcName() == "Role1Bullet12")
            {
               dis = AUtils.GetDisBetweenTwoObj(this,sr);
               if(dis > 1000)
               {
                  dis = 1000;
               }
               hurt *= (1000 - dis) / 1000;
            }
            hurt = this.countHurt(hurt,obj);
            if(sr is Monster6)
            {
               if(RandomControllor.getIns().getRandom() <= 0.1)
               {
                  if(this.curAddEffect)
                  {
                     this.curAddEffect.add([{
                        "name":BaseAddEffect.PETHORSE_ICE,
                        "time":gc.frameClips * 1.5
                     }]);
                  }
               }
            }
            else if(sr is Monster16)
            {
               if(RandomControllor.getIns().getRandom() <= 0.2)
               {
                  if(this.curAddEffect)
                  {
                     this.curAddEffect.add([{
                        "name":BaseAddEffect.PETMONKEY_FIRE,
                        "hurt":10,
                        "time":gc.frameClips * 3
                     }]);
                  }
               }
            }
            if(_target.getImcName() == "Role1Bullet12")
            {
               this.reduceHp(hurt,false);
            }
            else
            {
               this.reduceHp(hurt,true);
            }
            this.addBeAttackEffect(sr);
            return true;
         }
         return false;
      }
      
      protected function countHurt(hurt:int, obj:Object) : int
      {
         if(obj)
         {
            if(obj.attackKind == "magic")
            {
               if(this.mdef > 0 && this.mdef <= 1)
               {
                  hurt = (1 - this.mdef) * hurt;
               }
               return hurt;
            }
            if(obj.attackKind == "physics")
            {
               if(hurt > this.def)
               {
                  hurt -= this.def;
               }
               else
               {
                  hurt = 1;
               }
               return hurt;
            }
         }
         return hurt;
      }
      
      public function setHp(hp:int) : void
      {
         this.hp = hp;
      }
      
      public function getHp() : int
      {
         return this.hp;
      }
      
      public function setShp(shp:int) : void
      {
         this.shp = shp;
      }
      
      public function getShp() : int
      {
         return this.shp;
      }
      
      public function setAtk(atk:int) : void
      {
         this.atk = atk;
      }
      
      public function getAtk() : int
      {
         return this.atk;
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         this.addMonHurtMc(re,false);
         this.showHpSlip();
         this.setHp(this.getHp() - re);
         this.drawPetHp();
         if(this.getHp() <= 0)
         {
            this.setHp(0);
            if(this.curAction != "dead")
            {
               this.setYourFather(200);
               this.setAction("dead");
            }
         }
         else if(canHurt)
         {
            if(this.curAction == "hurt")
            {
               this.bbdc.setFramePointX(0);
            }
            else
            {
               this.setAction("hurt");
            }
         }
      }
      
      public function cureHp(add:int) : void
      {
         if(!this.isDead())
         {
            if(this.getHp() + add > this.getShp())
            {
               this.setHp(this.getShp());
            }
            else
            {
               this.setHp(this.getHp() + add);
            }
            this.addCureMc(add);
         }
      }
      
      public function addMonHurtMc(_hurt:int, isCrit:Boolean, _isShadow:Boolean = false) : *
      {
         var monHurtNumMc:ANumber = new ANumber();
         this.gc.gameSence.addChild(monHurtNumMc);
         monHurtNumMc.aNumImage("pnum",_hurt,this.x - 20,this.y - 60,20);
      }
      
      override protected function addBeAttackEffect(b:BaseObject) : void
      {
         if(this.curAddEffect)
         {
            this.curAddEffect.updateFather();
         }
         var img:MovieClip = AUtils.getNewObj("HeroBeHurt");
         var cm:ColorMatrix = new ColorMatrix();
         cm.adjustColor(0,0,0,100);
         img.filters = [new ColorMatrixFilter(cm)];
         img.x = this.colipse.x;
         img.y = this.colipse.y;
         this.addChild(img);
      }
      
      public function addBeAttackEffectForOther() : void
      {
         this.addBeAttackEffect(null);
      }
      
      protected function normalHit() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setAction("hit1");
         this.lastHit = "hit1";
      }
      
      protected function followTarget() : void
      {
         if(this.x > this.curAttackTarget.x)
         {
            this.turnLeft();
         }
         else
         {
            this.turnRight();
         }
      }
      
      protected function followSource() : void
      {
         if(this.sourceRole)
         {
            if(AUtils.GetDisBetweenTwoObj(this,this.sourceRole) > this.followRange)
            {
               if(this.x > this.sourceRole.x)
               {
                  this.turnLeft();
               }
               else
               {
                  this.turnRight();
               }
            }
            else
            {
               this.setStatic();
            }
         }
      }
      
      public function faceToTarget() : void
      {
         if(this.curAttackTarget)
         {
            if(this.x < this.curAttackTarget.x)
            {
               this.turnRight();
            }
            else
            {
               this.turnLeft();
            }
         }
      }
      
      protected function searchTarget() : void
      {
         for each(var bo in gc.obbsiteArray)
         {
            if(AUtils.GetDisBetweenTwoObj(bo,this) <= this.searchRange)
            {
               this.curAttackTarget = bo;
               return;
            }
         }
      }
      
      protected function showHpSlip() : void
      {
         this.hpSlip.visible = true;
         TweenMax.to(this.hpSlip,2,{
            "alpha":0,
            "onComplete":function(_hpSlip:Sprite):*
            {
               _hpSlip.visible = false;
            },
            "onCompleteParams":[this.hpSlip]
         });
      }
      
      protected function newHpSlip() : void
      {
         hpSlip = new Sprite();
         hpSlip.x = -23;
         hpSlip.y = -this.colipse.height / 2 - 10;
         hpSlip.visible = false;
         addChild(hpSlip);
      }
      
      protected function drawPetHp() : void
      {
         hpSlip.graphics.clear();
         hpSlip.alpha = 1;
         var reduce:* = Number(this.getHp() / this.getShp());
         reduce = reduce < 0 ? 0 : reduce;
         if(this.getHp() >= 0)
         {
            hpSlip.graphics.lineStyle(1.2,0);
            hpSlip.graphics.drawRect(0,5,50,5);
            hpSlip.graphics.beginFill(16711680);
            if(this.getBBDC().getDirect() == 0)
            {
               hpSlip.graphics.drawRect(0,5,50 * reduce,5);
            }
            else if(this.getBBDC().getDirect() == 1)
            {
               hpSlip.graphics.drawRect(50 - 50 * reduce,5,50 * reduce,5);
            }
            hpSlip.graphics.endFill();
         }
      }
      
      override protected function jump() : void
      {
         if(this.speed.y >= 0)
         {
            this.speed.y = jumpPower;
         }
      }
      
      public function setSourceRole(bh:BaseHero) : void
      {
         this.sourceRole = bh;
      }
      
      public function getSourceRole() : BaseHero
      {
         return this.sourceRole;
      }
      
      public function destroy() : void
      {
         if(this.bbdc)
         {
            this.bbdc.destroy();
         }
         if(this.curAddEffect)
         {
            this.curAddEffect.destroy();
            this.curAddEffect = null;
         }
         this.isReadyToDestroy = true;
         TweenMax.to(this,1,{
            "alpha":0,
            "onComplete":function(_self:BaseSummon):*
            {
               if(_self.parent)
               {
                  _self.parent.removeChild(_self);
               }
            },
            "onCompleteParams":[this]
         });
         for(var i:int = 0; i < this.magicBulletArray.length; )
         {
            var bb:BaseBullet = this.magicBulletArray[i] as BaseBullet;
            bb.destroy();
            i++;
         }
         this.magicBulletArray = [];
      }
      
      override public function getRealPower(cur:String, crit:Boolean = true) : int
      {
         var _loc3_:* = cur;
         if("hit1" !== _loc3_)
         {
            return 0;
         }
         return 10;
      }
      
      override public function isDead() : Boolean
      {
         return this.getHp() <= 0;
      }
   }
}
