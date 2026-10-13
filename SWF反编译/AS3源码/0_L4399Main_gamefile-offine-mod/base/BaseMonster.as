package base
{
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.aura.auraBlue;
   import export.aura.auraGreen;
   import export.aura.auraRed;
   import export.aura.auraWhile;
   import export.bullet.FollowBaseObjectBullet;
   import export.cure.BigHP;
   import export.cure.SmallHP;
   import export.cure.SmallMP;
   import export.level.StageListener131;
   import export.monster.Monster191;
   import export.monster.Monster31;
   import export.monster.Monster32;
   import export.monster.Monster33;
   import export.monster.Monster34;
   import export.monster.Monster52;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import manager.MusicManager;
   import mvc.controllor.RandomControllor;
   import my.ColorMatrix;
   import my.FallEquipObj;
   import my.HitTest;
   import my.SingleSavedBuff;
   import user.User;
   
   public class BaseMonster extends BaseObject
   {
      
      public static const MONSTER_DESTROY:String = "monsterdestroy";
       
      
      protected var alertRange:int = 1000;
      
      protected var attackRange:int = 100;
      
      protected var attackRangeY:int = 200;
      
      protected var alertRangeY:int = 150;
      
      protected var normalAttackRate:Number = 0.5;
      
      protected var count:int;
      
      protected var waitRateWhenNoTarget:Number = 0.1;
      
      protected var curAttackTarget:BaseObject;
      
      protected var lastAttackTarget:BaseObject;
      
      private var hpSlip:Sprite;
      
      private var hp1:int;
      
      private var hp2:int;
      
      private var sHp1:int;
      
      private var sHp2:int;
      
      protected var skillCD1:Array;
      
      protected var skillCD2:Array;
      
      protected var skillCD3:Array;
      
      protected var skillCD4:Array;
      
      public var isBoss:Boolean = false;
      
      public var isCanBeCatchSkill:Boolean = false;
      
      public var isBeTryCatchSkill:Boolean = false;
      
      public var monsterName:String = "";
      
      private var isGetExp:Boolean = false;
      
      private var isFallEquip:Boolean = false;
      
      private var mm:MusicManager;
      
      public var fallEquipOffset:Point;
      
      public var entityId:uint = 0;
      
      public var forceTarget:BaseObject;
      
      protected var isCrit:Boolean = false;
      
      public function BaseMonster()
      {
         skillCD1 = [-1,30];
         skillCD2 = [-1,30];
         skillCD3 = [-1,30];
         skillCD4 = [-1,30];
         fallEquipOffset = new Point(0,0);
         super();
         mm = MusicManager.getInstance();
         this._anti.exp = 0;
         this._anti.gxp = 0;
         this._anti.def = 0;
         this._anti.fallProbability = 0.15;
         this._anti.mDef = 0;
         this._anti.stoneFallRate = 0;
         this._anti.level = 0;
         this._anti.lingdian5 = 0.5;
         this._anti.yi = 1;
         this._anti.toCountSuppressLevel = -1;
         this._anti.suppressLevel = 0;
         this._anti.miss = 0;
         this._anti.crit = 0;
         this._anti.eatBlood = 0;
         this.newHpSlip();
         this.curAddEffect = new BaseAddEffect(BaseObject(this));
      }
      
      override protected function __added(evt:Event) : void
      {
         var playerAvgLevel:* = 0;
         super.__added(evt);
         if(gc.curStageAndCurLevel.curStage != 13)
         {
            if(this.isBoss)
            {
               gc.gameInfo.addBossBlood(this.monsterName,100 - Math.round(100 * (this.getHp() / this.getSHp())));
            }
         }
         if(this.getToCountSuppressLevel() >= 0)
         {
            if(this.isBoss)
            {
               playerAvgLevel = uint(gc.getAverageLevel());
               this.setSuppressLevel(playerAvgLevel - this.getToCountSuppressLevel());
            }
         }
      }
      
      public function doWhenStage13(hp:uint, def:uint, mDef:Number, mAtk:uint, exp:uint, round:uint) : void
      {
         if(this is Monster31 || this is Monster32 || this is Monster33 || this is Monster34)
         {
            this.setHp(hp + 50000 * (round - 1));
            this.setSHp(this.getHp());
            this._anti.exp = exp + 100 * (round - 1);
            this._anti.mDef = mDef + (round - 1) * 0.02;
            this._anti.def = def + 10 * (round - 1);
            for each(var key in this.attackBackInfoDict)
            {
               key.attackKind = "magic";
            }
         }
         else
         {
            for each(key in this.attackBackInfoDict)
            {
               key.power = mAtk + mAtk * (0.25 * (round - 1));
               key.attackKind = "magic";
            }
            this.setHp(hp + hp * (0.5 * (round - 1)));
            this.setSHp(this.getHp());
            this._anti.exp = exp + exp * (round - 1) * 0.1;
            this._anti.mDef = mDef + (round - 1) * 0.02;
            this._anti.def = def + def * (0.5 * (round - 1));
         }
         this.alertRange = 2000;
         this.isBoss = false;
         this._anti.fallList = [];
      }
      
      protected function addAoyiBuff() : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("AoyiBuff");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDirect(0);
         b.setDisable();
         b.setAction("null");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function initBBDC() : void
      {
      }
      
      override public function step() : void
      {
         super.step();
         this.addcount();
         if(!this.isDead())
         {
            this.IntelligenceTime();
         }
         this.countCD();
         if(this.curAttackTarget)
         {
            if(this.curAttackTarget.isDead() || this.curAttackTarget.isReadyToDestroy)
            {
               this.curAttackTarget = null;
            }
         }
         if(this.isFly)
         {
            if(this.isBeAttacking())
            {
               this.speed.y *= 0.8;
            }
            if(Math.abs(this.speed.y) > 4)
            {
               this.speed.y *= 0.7;
            }
            if(this.y >= 800)
            {
               this.y = 200;
            }
         }
      }
      
      protected function IntelligenceTime() : void
      {
         this.myIntelligence();
      }
      
      protected function countCD() : void
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
         if(this.skillCD4[0] > 0)
         {
            if(this.skillCD4[0]-- <= 0)
            {
               this.skillCD4[0] = 0;
            }
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
      
      protected function beforeSkill4Start() : Boolean
      {
         return false;
      }
      
      protected function normalWalk() : void
      {
         if(this.standInObj)
         {
            if(this.x >= this.standInObj.x + this.standInObj.width / 2)
            {
               this.turnLeft();
            }
            else if(this.x <= this.standInObj.x - this.standInObj.width / 2)
            {
               this.turnRight();
            }
            else if(this.count % gc.frameClips == 0)
            {
               if(RandomControllor.getIns().getRandom() < this.waitRateWhenNoTarget)
               {
                  this.setAction("wait");
                  this.setStatic();
                  if(this.isFly)
                  {
                     this.speed.y = 0;
                  }
                  if(gc.isInRoom())
                  {
                     if(gc.isRoomOnwer)
                     {
                        gc.sendMonsterAction(this);
                     }
                  }
               }
               else
               {
                  this.randomWalk();
               }
            }
         }
      }
      
      override public function setAction(str:String) : void
      {
         super.setAction(str);
      }
      
      override protected function turnLeft() : *
      {
         super.turnLeft();
         if(gc.isInRoom())
         {
            if(gc.isRoomOnwer)
            {
               gc.sendMonsterWalk(this);
            }
         }
      }
      
      override protected function turnRight() : *
      {
         super.turnRight();
         if(gc.isInRoom())
         {
            if(gc.isRoomOnwer)
            {
               gc.sendMonsterWalk(this);
            }
         }
      }
      
      private function randomWalk() : void
      {
         var point:Point = gc.gameSence.localToGlobal(new Point(this.x,0));
         if(point.x > 940)
         {
            this.turnLeft();
         }
         else if(point.x < 0)
         {
            this.turnRight();
         }
         else if(RandomControllor.getIns().getRandom() < 0.5)
         {
            this.turnLeft();
         }
         else
         {
            this.turnRight();
         }
      }
      
      protected function followHero() : Boolean
      {
         return false;
      }
      
      protected function myIntelligence() : void
      {
         if(gc.isInRoom() && !gc.isRoomOnwer)
         {
            return;
         }
         if(!(this.curAddEffect && (this.curAddEffect.curDebuff(BaseAddEffect.Pet_TIGER_SXHZ) || this.curAddEffect.curDebuff(BaseAddEffect.STUN) || this.curAddEffect.curDebuff(BaseAddEffect.PETHORSE_ICE))))
         {
            if(this.curAttackTarget == null)
            {
               this.normalWalk();
               this.selectTarget();
            }
            else if(BaseObject(this.curAttackTarget).isDead())
            {
               this.curAttackTarget = null;
            }
            else
            {
               this.hasAttackTarget();
            }
         }
      }
      
      override protected function move() : void
      {
         if(this.rightInObj)
         {
            if(this.speed.x > 0)
            {
               this.speed.x = 0;
            }
         }
         if(this.leftInObj)
         {
            if(this.speed.x < 0)
            {
               this.speed.x = 0;
            }
         }
         if(this.curAddEffect)
         {
            if(this.curAddEffect.isAnyThingElseStun(""))
            {
               return;
            }
         }
         if(this.x < -100)
         {
            if(this.speed.x < 0)
            {
               this.speed.x = 0;
            }
         }
         super.move();
      }
      
      protected function hasAttackTarget() : void
      {
         var addTime:int = 0;
         var attackFlag:Boolean = false;
         if(this.isBeAttacking() || this.isAttacking())
         {
            return;
         }
         if(!this.isAttacking() && !this.isBeAttacking())
         {
            addTime = 0;
            if(this.getSuppressLevel() != 0)
            {
               addTime = this.getSuppressLevel() / 10;
               if(addTime > 3)
               {
                  addTime = 3;
               }
               if(addTime < -2)
               {
                  addTime = -2;
               }
               addTime *= gc.frameClips;
            }
            if(this.beforeSkill1Start() && this.skillCD1[0] == 0)
            {
               this.releSkill1();
               this.skillCD1[0] = this.skillCD1[1] + addTime;
            }
            else if(this.beforeSkill2Start() && this.skillCD2[0] == 0)
            {
               this.releSkill2();
               this.skillCD2[0] = this.skillCD2[1] + addTime;
            }
            else if(this.beforeSkill3Start() && this.skillCD3[0] == 0)
            {
               this.releSkill3();
               this.skillCD3[0] = this.skillCD3[1] + addTime;
            }
            else if(this.beforeSkill4Start() && this.skillCD4[0] == 0)
            {
               this.releSkill4();
               this.skillCD4[0] = this.skillCD4[1] + addTime;
            }
            else if(this.count % gc.frameClips == 0)
            {
               attackFlag = false;
               if(!this.isFly)
               {
                  if(AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= this.attackRange)
                  {
                     attackFlag = true;
                  }
               }
               else if(AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= this.attackRange && Math.abs(this.y - this.curAttackTarget.y) <= attackRangeY)
               {
                  attackFlag = true;
               }
               if(attackFlag)
               {
                  if(RandomControllor.getIns().getRandom() <= this.normalAttackRate)
                  {
                     this.attackTarget();
                  }
                  else
                  {
                     this.setAction("wait");
                     this.setStatic();
                     if(this.isFly)
                     {
                        this.flyFollowTarget();
                     }
                     if(gc.isInRoom())
                     {
                        if(gc.isRoomOnwer)
                        {
                           gc.sendMonsterAction(this);
                        }
                     }
                  }
               }
               else if(!this.isFly)
               {
                  this.followTarget();
               }
               else
               {
                  this.flyFollowTarget();
               }
            }
         }
      }
      
      protected function attackTarget() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setAction("hit1");
         this.lastHit = "hit1";
         if(gc.isInRoom())
         {
            if(gc.isRoomOnwer)
            {
               gc.sendMonsterAction(this);
            }
         }
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
      
      protected function releSkill4() : void
      {
      }
      
      protected function followTarget() : void
      {
         if(this.curAttackTarget)
         {
            if(this.x > this.curAttackTarget.x)
            {
               this.moveLeft();
            }
            else if(this.x < this.curAttackTarget.x)
            {
               this.moveRight();
            }
         }
      }
      
      protected function flyFollowTarget() : void
      {
         if(this.curAttackTarget)
         {
            if(this.x > this.curAttackTarget.x)
            {
               this.moveLeft();
            }
            else if(this.x < this.curAttackTarget.x)
            {
               this.moveRight();
            }
            if(this.y < this.curAttackTarget.y - this.alertRangeY)
            {
               this.speed.y = 3;
            }
            else
            {
               this.speed.y = -3;
            }
         }
      }
      
      protected function selectTarget() : void
      {
         var otherPlayerArray:* = null;
         var bh:* = null;
         var i:int = 0;
         var playerArray:Array = gc.getPlayerArray();
         if(gc.isInRoom())
         {
            otherPlayerArray = gc.pWorld.getOtherHeroArray();
            playerArray = playerArray.concat(otherPlayerArray);
         }
         for(i = 0; i < playerArray.length; )
         {
            bh = playerArray[i] as BaseHero;
            if(AUtils.GetDisBetweenTwoObj(bh,this) <= this.alertRange)
            {
               this.setCurAttackTarget(bh);
               break;
            }
            i++;
         }
      }
      
      override protected function addBeAttackEffect(b:BaseObject) : void
      {
         var rand:Number = NaN;
         var effectName:* = null;
         var img:* = null;
         var cm:* = null;
         if(this.colipse)
         {
            rand = RandomControllor.getIns().getRandom();
            if(rand > 0.5)
            {
               effectName = "MonsterBeHurt1";
            }
            else
            {
               effectName = "MonsterBeHurt2";
            }
            img = AUtils.getNewObj(effectName);
            cm = new ColorMatrix();
            img.filters = [new ColorMatrixFilter(cm)];
            img.x = this.colipse.x;
            img.y = this.colipse.y;
            this.addChild(img);
         }
      }
      
      public function destroy() : void
      {
         this.dispatchEvent(new Event("monsterdestroy"));
         if(this.curAddEffect)
         {
            this.curAddEffect.destroy();
            this.curAddEffect = null;
         }
         TweenMax.to(this,1,{
            "alpha":0,
            "onComplete":function(_self:BaseMonster):*
            {
               removeFromStage(_self);
            },
            "onCompleteParams":[this]
         });
         this.isReadyToDestroy = true;
         for(var i:int = 0; i < this.magicBulletArray.length; )
         {
            var bb:BaseBullet = this.magicBulletArray[i] as BaseBullet;
            bb.destroy();
            i++;
         }
         this.forceTarget = null;
         this.magicBulletArray = [];
         this.curAttackTarget = null;
         this.lastAttackTarget = null;
      }
      
      private function removeFromStage(b:BaseMonster) : void
      {
         if(b.parent)
         {
            b.parent.removeChild(b);
         }
         if(this.bbdc)
         {
            this.bbdc.destroy();
         }
      }
      
      override protected function checkOver() : void
      {
         if(this.y >= 2500)
         {
            this.y = 300;
         }
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         var curBuff:* = null;
         var obj:* = null;
         var point:* = null;
         var arr:* = null;
         var i:* = 0;
         var o:* = null;
         var hurt:int = 0;
         var dis:Number = NaN;
         var lastint:int = 0;
         var eb:Number = NaN;
         var cureHpValue:* = 0;
         cureHpValue = 0;
         if(this._anti.isYourFather)
         {
            return false;
         }
         if(force || this.colipse && HitTest.complexHitTestObject(this.colipse,_target))
         {
            if(RandomControllor.getIns().getRandom() < this.getMiss())
            {
               this.addMissMc();
               this.beAttackIdArray.push(_target.getAttackId());
               return false;
            }
            if(this.curAddEffect)
            {
               curBuff = this.curAddEffect.getBuffByName(BaseAddEffect.FLUTE_SLEEP);
               if(curBuff)
               {
                  curBuff.time = 1;
               }
            }
            User.batterNum++;
            this.setCurAttackTarget(sr);
            obj = _target.sourceRoleAttackInfoObject;
            if(obj)
            {
               point = this.getBeattackBackSpeed(_target,obj);
               if(_target.getImcName() != "Role1Bullet12" && _target.getImcName() != "PetRoomHorseBullet2")
               {
                  this.setAttackBack(point);
                  if(gc.isInRoom())
                  {
                     gc.sendMonsterHurted(this,sr.getRoleId(),point.x,point.y,_target.initTimer);
                  }
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
            this.isCrit = _target.isCrit;
            if(_target.getImcName() == "Role1Bullet12")
            {
               trace("--火眼晶晶--");
               dis = AUtils.GetDisBetweenTwoObj(this,sr);
               if(dis > 1000)
               {
                  dis = 1000;
               }
               hurt *= (1000 - dis) / 1000;
            }
            lastint = this.getRealHurt(hurt,obj);
            eb = 0;
            if(sr is BaseHero)
            {
               if(obj && obj.attackKind == "physics")
               {
                  eb = BaseHero(sr).roleProperies.getEatBlood();
                  cureHpValue = uint(int(eb / 100 * lastint));
                  if(cureHpValue > 0)
                  {
                     BaseHero(sr).cureHp(cureHpValue);
                  }
               }
            }
            else if(sr is BasePet)
            {
               if(obj && obj.attackKind == "physics")
               {
                  eb = BasePet(sr).petInfo.getEatBlood();
                  cureHpValue = uint(int(eb * lastint));
                  if(cureHpValue > 0)
                  {
                     BasePet(sr).cureHp(cureHpValue);
                  }
               }
            }
            if(this.curAddEffect)
            {
               this.curAddEffect.updateFather();
            }
            _target.finallHurt = lastint;
            if(_target.getImcName() == "Role1Bullet12" || _target.getImcName() == "PetRoomHorseBullet2")
            {
               this.reduceHp(lastint,false);
            }
            else
            {
               this.reduceHp(lastint,true);
            }
            this.showHpSlip();
            gc.eventManger.dispatchEvent(new CommonEvent("MonsterIsBeat",[hurt,this.curAttackTarget]));
            this.addBeAttackEffect(sr);
            mm.play("BeattackByRole1");
            return true;
         }
         return false;
      }
      
      protected function addMissMc() : void
      {
         var missMc:* = AUtils.getImageObj("miss");
         missMc.x = this.x - 20;
         missMc.y = this.y - 60;
         this.gc.gameSence.addChild(missMc);
         TweenMax.to(missMc,2,{
            "y":missMc.y - 60,
            "alpha":0,
            "onComplete":function():*
            {
               if(missMc && gc.gameSence && gc.gameSence.contains(missMc))
               {
                  gc.gameSence.removeChild(missMc);
               }
            }
         });
      }
      
      protected function getRealHurt(hurt:int, obj:Object) : int
      {
         var lastint:* = 0;
         if(obj)
         {
            if(obj.attackKind == "physics")
            {
               if(hurt > this.getDef())
               {
                  lastint = int(hurt - this.getDef());
               }
               else
               {
                  lastint = int(1);
               }
            }
            else if(obj.attackKind == "magic")
            {
               if(this.getMDef() > 0 && this.getMDef() <= 1)
               {
                  lastint = int(hurt * (1 - this.getMDef()));
               }
               else
               {
                  lastint = hurt;
               }
            }
         }
         else
         {
            lastint = int(1);
         }
         return lastint;
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         var ssb:* = null;
         var obj:* = null;
         var hp:int = 0;
         super.reduceHp(re,canHurt);
         if(re > 0)
         {
            this.addMonHurtMc(re,this.isCrit);
            gc.sendMonsterHpChange(this,re);
         }
         this.isCrit = false;
         this.setHp(this.getHp() - re);
         this.drawMonsterHp();
         if(this.isDead())
         {
            if(this.curAction != "dead")
            {
               if(gc.isSingleGame())
               {
                  if(!this.isGetExp)
                  {
                     if(gc.gameInfo)
                     {
                        if(gc.savedBuff)
                        {
                           ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_EXP_ADD);
                           if(ssb)
                           {
                              this._anti.exp *= ssb.value;
                           }
                        }
                        if(gc.isDoubleExp)
                        {
                           this._anti.exp *= 2;
                        }
                     }
                     if(this.curAttackTarget is BaseHero)
                     {
                        if(BaseHero(this.curAttackTarget).getPlayer() != gc.player3)
                        {
                           if(BaseHero(this.curAttackTarget).getPet())
                           {
                              BaseHero(this.curAttackTarget).roleProperies.dispatchEvent(new CommonEvent("AddExper",[this._anti.exp / 2]));
                              BaseHero(this.curAttackTarget).getPet().addExp(this._anti.exp / 2);
                           }
                           else
                           {
                              BaseHero(this.curAttackTarget).roleProperies.dispatchEvent(new CommonEvent("AddExper",[this._anti.exp]));
                           }
                        }
                        obj = BaseHero(this.curAttackTarget).curAddEffect.getBuffByName(BaseAddEffect.SHENMISHANGRENSHIZHUANG);
                        if(obj)
                        {
                           BaseHero(this.curAttackTarget).cureHp(obj.hurt);
                        }
                     }
                     else if(this.curAttackTarget is BasePet)
                     {
                        if(BasePet(this.curAttackTarget).getSourceRole().getPlayer() != gc.player3)
                        {
                           if(!BasePet(this.curAttackTarget).isDead())
                           {
                              BasePet(this.curAttackTarget).addExp(this._anti.exp);
                           }
                        }
                     }
                     else if(this.curAttackTarget is BaseSummon)
                     {
                        if(BaseSummon(this.curAttackTarget).getSourceRole())
                        {
                           BaseSummon(this.curAttackTarget).getSourceRole().roleProperies.dispatchEvent(new CommonEvent("AddExper",[this._anti.exp]));
                        }
                     }
                     this.isGetExp = true;
                     this.setAction("dead");
                  }
               }
               else if(gc.isInRoom())
               {
                  if(gc.isRoomOnwer)
                  {
                     this.setAction("dead");
                     gc.sendMonsterAction(this);
                  }
               }
            }
         }
         else if(canHurt)
         {
            if(this.curAction == "hurt")
            {
               if(this.bbdc)
               {
                  this.bbdc.setFramePointX(0);
               }
            }
            else
            {
               this.setAction("hurt");
            }
         }
         if(this.isBoss)
         {
            hp = this.getHp();
            if(hp < 0)
            {
               hp = 0;
            }
            gc.gameInfo.addBossBlood(this.monsterName,100 - Math.round(100 * (hp / this.getSHp())));
         }
      }
      
      public function setFullHp() : void
      {
         this.setHp(this.getSHp());
      }
      
      override public function isDead() : Boolean
      {
         return this.getHp() <= 0;
      }
      
      public function dropAura() : void
      {
         var tempCurAttackTarget:* = null;
         var aura:* = null;
         var maxCount:int = 0;
         var i:int = 0;
         var rand:Number = NaN;
         var count:int = 0;
         var fe:* = null;
         var p:* = null;
         var xx:int = 0;
         if(this.isFallEquip)
         {
            return;
         }
         this.isFallEquip = true;
         this.addMedicine();
         this.fallEquip();
         if(gc.curStageAndCurLevel.curStage == 13)
         {
            if(gc.pWorld.getBaseLevelListener() is StageListener131)
            {
               if(this is Monster31 || this is Monster32 || this is Monster33 || this is Monster34)
               {
                  StageListener131(gc.pWorld.getBaseLevelListener()).fallFlower(new Point(this.x,this.y - 100));
               }
            }
         }
         if(this.curAttackTarget is BasePet)
         {
            tempCurAttackTarget = (this.curAttackTarget as BasePet).getSourceRole();
         }
         else if(this.curAttackTarget is BaseHero)
         {
            tempCurAttackTarget = this.curAttackTarget as BaseHero;
         }
         else if(this.curAttackTarget is BaseSummon)
         {
            tempCurAttackTarget = (this.curAttackTarget as BaseSummon).getSourceRole();
         }
         if(tempCurAttackTarget)
         {
            maxCount = 2 + Math.floor(RandomControllor.getIns().getRandom() * 3);
            for(i = 0; i < maxCount; )
            {
               aura = new auraRed(this,tempCurAttackTarget);
               aura.x = this.x + (RandomControllor.getIns().getRandom() - 0.5) * 10;
               aura.y = this.y + (RandomControllor.getIns().getRandom() - 0.5) * 10;
               aura.setPower(this._anti.gxp);
               gc.gameSence.addChild(aura);
               gc.pWorld.getAuraArray().push(aura);
               i++;
            }
            rand = RandomControllor.getIns().getRandom();
            maxCount = 0;
            if(rand < 0.04)
            {
               maxCount = 3;
            }
            else if(rand < 0.08)
            {
               maxCount = 2;
            }
            else if(rand < 0.12)
            {
               maxCount = 1;
            }
            for(i = 0; i < maxCount; )
            {
               aura = new auraGreen(this,tempCurAttackTarget);
               aura.x = this.x + (RandomControllor.getIns().getRandom() - 0.5) * 20;
               aura.y = this.y + (RandomControllor.getIns().getRandom() - 0.5) * 20;
               gc.gameSence.addChild(aura);
               gc.pWorld.getAuraArray().push(aura);
               i++;
            }
            rand = RandomControllor.getIns().getRandom();
            maxCount = 0;
            if(rand < 0.04)
            {
               maxCount = 3;
            }
            else if(rand < 0.08)
            {
               maxCount = 2;
            }
            else if(rand < 0.12)
            {
               maxCount = 1;
            }
            for(i = 0; i < maxCount; )
            {
               aura = new auraBlue(this,tempCurAttackTarget);
               aura.x = this.x + (RandomControllor.getIns().getRandom() - 0.5) * 30;
               aura.y = this.y + (RandomControllor.getIns().getRandom() - 0.5) * 30;
               gc.gameSence.addChild(aura);
               gc.pWorld.getAuraArray().push(aura);
               i++;
            }
            rand = RandomControllor.getIns().getRandom();
            maxCount = 0;
            if(rand < 0.04)
            {
               maxCount = 3;
            }
            else if(rand < 0.08)
            {
               maxCount = 2;
            }
            else if(rand < 0.12)
            {
               maxCount = 1;
            }
            for(i = 0; i < maxCount; )
            {
               aura = new auraWhile(this,tempCurAttackTarget);
               aura.x = this.x + (RandomControllor.getIns().getRandom() - 0.5) * 40;
               aura.y = this.y + (RandomControllor.getIns().getRandom() - 0.5) * 40;
               gc.gameSence.addChild(aura);
               gc.pWorld.getAuraArray().push(aura);
               i++;
            }
         }
         if(this.isBoss && this is Monster191)
         {
            count = 1 + Math.floor(RandomControllor.getIns().getRandom() * 3);
            fe = new FallEquipObj({
               "name":"wpmgh",
               "bigtype":"dj",
               "num":count
            });
            p = gc.gameSence.localToGlobal(new Point(this.x,0));
            xx = 0;
            if(p.x > 930)
            {
               xx = -150;
            }
            else if(p.x < 10)
            {
               xx = 150;
            }
            fe.x = this.x + xx;
            fe.y = this.y - 100;
            this.gc.gameSence.addChild(fe);
            this.gc.otherList.push(fe);
         }
      }
      
      protected function addcount() : void
      {
         if(count++ >= gc.frameClips * 10)
         {
            count = 0;
         }
      }
      
      protected function drawMonsterHp() : void
      {
         hpSlip.graphics.clear();
         hpSlip.alpha = 1;
         var reduce:* = Number(this.getHp() / this.getSHp());
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
      
      protected function removedHpSlip() : void
      {
         hpSlip.visible = false;
      }
      
      protected function showHpSlip() : void
      {
         this.hpSlip.visible = true;
         TweenMax.to(this.hpSlip,2,{
            "alpha":0,
            "onComplete":removedHpSlip
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
      
      public function addMonHurtMc(_hurt:int, isCrit:Boolean, _isShadow:Boolean = false) : *
      {
         var sourceY:Number = this.y - this.height / 2;
         if(this is Monster52)
         {
            sourceY += 60;
         }
         if(_isShadow)
         {
            if(this.cureHpQueue)
            {
               this.cureHpQueue.addMonsterHurt(_hurt,x - 20,sourceY);
            }
         }
         else if(isCrit)
         {
            if(this.cureHpQueue)
            {
               this.cureHpQueue.addMonsterCritHurt(_hurt,x - 20,sourceY);
            }
         }
         else if(this.cureHpQueue)
         {
            this.cureHpQueue.addMonsterHurt(_hurt,x - 20,sourceY);
         }
      }
      
      public function judgeAlive(_target:BaseHero) : *
      {
         _target.roleProperies.dispatchEvent(new CommonEvent("AddExper",[this._anti.exp]));
      }
      
      public function fallEquip() : void
      {
         var ssb:* = null;
         var r:* = 0;
         var fe:* = null;
         var p:* = null;
         var xx:int = 0;
         gc.allTask.killMonster(this);
         var rate:Number = this._anti.fallProbability;
         var rateAdd:Number = 0;
         var rateAdd1:Number = 0;
         var rateAdd2:Number = 0;
         if(gc.hero1)
         {
            rateAdd1 = gc.hero1.getPlayer().getCurFashionEquipFallThingProbability();
         }
         if(gc.hero2)
         {
            rateAdd2 = gc.hero2.getPlayer().getCurFashionEquipFallThingProbability();
         }
         rateAdd = Math.max(rateAdd1,rateAdd2);
         rate *= 1 + rateAdd;
         if(gc.gameInfo)
         {
            if(gc.savedBuff)
            {
               ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_DROPRATE_ADD);
               if(ssb)
               {
                  rate *= 1 + ssb.value / 100;
               }
            }
         }
         var touxianRateAdd:Number = 0;
         var touxianRateAdd1:Number = 0;
         var touxianRateAdd2:Number = 0;
         var touxianName:String = "";
         if(gc.hero1)
         {
            touxianName = gc.hero1.getPlayer().getSomeEquipNameInCurrentEquip("zbtx");
            if(touxianName == "_4399zswj")
            {
               touxianRateAdd1 = 0.2;
            }
         }
         if(gc.hero2)
         {
            touxianName = gc.hero2.getPlayer().getSomeEquipNameInCurrentEquip("zbtx");
            if(touxianName == "_4399zswj")
            {
               touxianRateAdd2 = 0.2;
            }
         }
         touxianRateAdd = Math.max(touxianRateAdd1,touxianRateAdd2);
         rate *= 1 + touxianRateAdd;
         trace("rate:" + rate);
         trace("this._anti.fallList.length:" + this._anti.fallList.length);
         if(RandomControllor.getIns().getRandom() <= rate)
         {
            gc.pWorld.getBaseLevelListener().beforeFallEquip(this);
            try
            {
               r = uint(Math.round(RandomControllor.getIns().getRandom() * (this._anti.fallList.length - 1)));
               if(this._anti.fallList[r] || this._anti.fallList[r] != undefined)
               {
                  trace("this._anti.fallList[r]：" + this._anti.fallList[r].name);
                  fe = new FallEquipObj(this._anti.fallList[r]);
                  p = gc.gameSence.localToGlobal(new Point(this.x,0));
                  xx = 0;
                  if(p.x > 930)
                  {
                     xx = 930 - p.x - 50;
                  }
                  else if(p.x < 10)
                  {
                     xx = 10 - p.x + 50;
                  }
                  fe.x = this.x + xx + this.fallEquipOffset.x;
                  fe.y = this.y - 100 + this.fallEquipOffset.y;
                  this.gc.gameSence.addChild(fe);
                  this.gc.otherList.push(fe);
                  gc.pWorld.getBaseLevelListener().afterFallEquip(fe.getEName());
               }
            }
            catch(e:*)
            {
               trace("掉落东西素材有误！");
            }
         }
      }
      
      public function fallStone() : void
      {
         var fe:* = null;
         var p:* = null;
         var xx:int = 0;
         var rateAdd:Number = 0;
         var rateAdd1:Number = 0;
         var rateAdd2:Number = 0;
         if(gc.hero1)
         {
            rateAdd1 = gc.hero1.getPlayer().getCurFashionEquipFallThingProbability();
         }
         if(gc.hero2)
         {
            rateAdd2 = gc.hero2.getPlayer().getCurFashionEquipFallThingProbability();
         }
         rateAdd = Math.max(rateAdd1,rateAdd2);
         var rate:Number = this._anti.stoneFallRate;
         rate *= 1 + rateAdd;
         if(RandomControllor.getIns().getRandom() <= rate)
         {
            fe = new FallEquipObj({
               "name":"wpqhs1",
               "bigtype":"dj"
            });
            p = gc.gameSence.localToGlobal(new Point(this.x,0));
            xx = 0;
            if(p.x > 930)
            {
               xx = -150;
            }
            else if(p.x < 10)
            {
               xx = 150;
            }
            fe.x = this.x + xx;
            fe.y = this.y - 100;
            this.gc.gameSence.addChild(fe);
            this.gc.otherList.push(fe);
         }
      }
      
      public function addMedicine() : *
      {
         var temp:* = undefined;
         var random:Number = NaN;
         if(RandomControllor.getIns().getRandom() >= this._anti.lingdian5)
         {
            random = RandomControllor.getIns().getRandom();
            if(random <= this._anti.lingdian5 / 10)
            {
               if(random <= this._anti.lingdian5 / 10)
               {
                  if(RandomControllor.getIns().getRandom() >= this._anti.lingdian5)
                  {
                     temp = new SmallHP();
                     temp.x = this.x;
                     temp.y = this.y - temp.height;
                  }
                  else
                  {
                     temp = new BigHP();
                     temp.x = this.x;
                     temp.y = this.y - temp.height;
                  }
               }
               else
               {
                  temp = new SmallHP();
                  temp.x = this.x;
                  temp.y = this.y - temp.height;
               }
            }
         }
         else if(RandomControllor.getIns().getRandom() <= this._anti.lingdian5 / 5)
         {
            temp = new SmallMP();
            temp.x = this.x;
            temp.y = this.y - temp.height;
         }
         if(temp != null)
         {
            this.gc.gameSence.addChild(temp);
            this.gc.otherList.push(temp);
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
      
      public function cureHp(addHp:int) : void
      {
         if(!this.isDead())
         {
            if(this.getHp() + addHp > this.getSHp())
            {
               this.setHp(this.getSHp());
            }
            else
            {
               this.setHp(this.getHp() + addHp);
            }
            gc.sendMonsterHpChange(this,-addHp);
            if(this.isBoss)
            {
               gc.gameInfo.addBossBlood(this.monsterName,100 - Math.round(100 * (this.getHp() / this.getSHp())));
            }
            this.addCureMc(addHp);
         }
      }
      
      public function getCurAttackTarget() : BaseObject
      {
         return this.curAttackTarget;
      }
      
      public function setCurAttackTarget(target:BaseObject) : void
      {
         if(this.forceTarget)
         {
            this.curAttackTarget = this.forceTarget;
         }
         else
         {
            this.curAttackTarget = target;
         }
      }
      
      public function getExp() : int
      {
         return this._anti.exp;
      }
      
      public function getGxp() : int
      {
         return this._anti.gxp;
      }
      
      public function getDef() : int
      {
         if(this.getCurAddEffect(BaseAddEffect.TIANTINGZHANSHEN))
         {
            return 0;
         }
         return this._anti.def;
      }
      
      public function getMDef() : Number
      {
         if(this.getCurAddEffect(BaseAddEffect.TIANTINGZHANSHEN))
         {
            return 0;
         }
         return this._anti.mDef;
      }
      
      public function getProbability() : Number
      {
         return this._anti.fallProbability;
      }
      
      public function setProbability(l:Number) : void
      {
         this._anti.fallProbability = l;
      }
      
      public function setFallList(list:Array) : void
      {
         this._anti.fallList = list;
      }
      
      public function getFallList() : Array
      {
         return this._anti.fallList;
      }
      
      public function setLevel(v:uint) : void
      {
         if(v > 75)
         {
            v = 75;
         }
         this._anti.level = v;
      }
      
      public function getLevel() : int
      {
         return this._anti.level;
      }
      
      public function setToCountSuppressLevel(v:int) : void
      {
         this._anti.toCountSuppressLevel = v;
      }
      
      public function getToCountSuppressLevel() : int
      {
         return this._anti.toCountSuppressLevel;
      }
      
      public function setSuppressLevel(v:int) : void
      {
         this._anti.suppressLevel = v;
      }
      
      public function getSuppressLevel() : int
      {
         return this._anti.suppressLevel;
      }
      
      public function setHp(h:int) : void
      {
         this.hp1 = AUtils.getRandomValue();
         this.hp2 = h - this.hp1;
      }
      
      public function getHp() : int
      {
         return this.hp1 + this.hp2;
      }
      
      public function setSHp(h:int) : void
      {
         this.sHp1 = AUtils.getRandomValue();
         this.sHp2 = h - this.sHp1;
      }
      
      public function getSHp() : int
      {
         return this.sHp1 + this.sHp2;
      }
      
      public function setEatBlood(v:Number) : void
      {
         this._anti.eatBlood = v;
      }
      
      public function getEatBlood() : Number
      {
         return this._anti.eatBlood;
      }
      
      public function setCrit(v:Number) : void
      {
         this._anti.crit = v;
      }
      
      public function getCrit() : Number
      {
         return this._anti.crit;
      }
      
      public function setMiss(v:Number) : void
      {
         this._anti.miss = v;
      }
      
      public function getMiss() : Number
      {
         return this._anti.miss;
      }
      
      public function clearFallList() : void
      {
         this._anti.fallList = [];
      }
      
      public function getFootBottom() : Number
      {
         return this.y + this.colipse.y + this.colipse.height / 2;
      }
      
      override public function getRealPower(cur:String, crit:Boolean = true) : int
      {
         var power:int = 0;
         var o:Object = this.attackBackInfoDict[cur];
         if(o)
         {
            power = o.power;
         }
         if(crit)
         {
            if(RandomControllor.getIns().getRandom() < this.getCrit())
            {
               power *= 2;
            }
         }
         return power;
      }
      
      protected function setIsZhuque(lv:uint) : void
      {
         this._anti.fallProbability = 0.05 * lv;
         if(lv >= 4)
         {
            this._anti.fallList = [{
               "name":"zqjystone",
               "bigtype":"formationStone"
            },{
               "name":"zqymstone",
               "bigtype":"formationStone"
            },{
               "name":"zqymstone",
               "bigtype":"formationStone"
            },{
               "name":"zqymstone",
               "bigtype":"formationStone"
            },{
               "name":"zqymstone",
               "bigtype":"formationStone"
            }];
         }
         else
         {
            this._anti.fallList = [{
               "name":"zqymstone",
               "bigtype":"formationStone"
            }];
         }
      }
      
      protected function setIsXuanwu(lv:uint) : void
      {
         this._anti.fallProbability = 0.05 * lv;
         if(lv >= 4)
         {
            this._anti.fallList = [{
               "name":"xwjystone",
               "bigtype":"formationStone"
            },{
               "name":"xwljstone",
               "bigtype":"formationStone"
            },{
               "name":"xwljstone",
               "bigtype":"formationStone"
            },{
               "name":"xwljstone",
               "bigtype":"formationStone"
            },{
               "name":"xwljstone",
               "bigtype":"formationStone"
            }];
         }
         else
         {
            this._anti.fallList = [{
               "name":"xwljstone",
               "bigtype":"formationStone"
            }];
         }
      }
      
      override public function isWalkOrRun() : Boolean
      {
         return this.curAction == "walk" || this.curAction == "run";
      }
      
      override public function isNormalHit() : Boolean
      {
         return true;
      }
      
      public function beAttackByRole2Hit7(p:Point) : void
      {
         p = p;
         this.resetGraity();
         TweenMax.to(this,0.625,{
            "x":p.x,
            "y":p.y - 30,
            "onComplete":function(_bo:BaseObject):*
            {
               if(!_bo.isDead())
               {
                  TweenMax.to(_bo,0.625,{"y":_bo.y - 20});
               }
            },
            "onCompleteParams":[this]
         });
      }
      
      public function beAttackByRole3Hit6(p:Point) : void
      {
         this.resetGraity();
         TweenMax.to(this,1,{
            "x":p.x,
            "y":p.y
         });
      }
   }
}
