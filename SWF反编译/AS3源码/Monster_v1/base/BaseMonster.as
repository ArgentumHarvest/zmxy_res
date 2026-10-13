package base
{
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.aura.auraBlue;
   import export.aura.auraGreen;
   import export.aura.auraRed;
   import export.aura.auraWhile;
   import export.cure.BigHP;
   import export.cure.SmallHP;
   import export.cure.SmallMP;
   import export.hero.Role1;
   import export.hero.Role2;
   import export.hero.Role2Shadow;
   import export.monster.Monster1;
   import export.monster.Monster24;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import manager.SoundManager;
   import my.ANumber;
   import my.ColorMatrix;
   import my.FallEquipObj;
   import my.HitTest;
   import my.MainGame;
   import user.User;
   
   public class BaseMonster extends BaseObject
   {
       
      
      public var isattack:Boolean = false;
      
      protected var count:int = 0;
      
      protected var curAttackTarget;
      
      protected var lastAttackTarget;
      
      protected var stopNum:uint = 72;
      
      private var hpSlip:Sprite;
      
      private var flush:Boolean = true;
      
      protected var mysee:uint;
      
      protected var isattback:uint;
      
      protected var skillCD1:uint = 1;
      
      protected var skillCD2:uint;
      
      protected var skillCD3:uint;
      
      protected var skillCD4:uint;
      
      protected var exp:uint;
      
      protected var gxp:int;
      
      protected var def:int;
      
      public var isBoss:Boolean = false;
      
      public var fallList:Array;
      
      protected var probability:Number = 0.15;
      
      protected var backTime:int = 0;
      
      protected var BACK_TIME:int = 72.0;
      
      private var bcount:int;
      
      private var tcount:int;
      
      public var monsterName:String = "";
      
      protected var baoxiang61:BaseMonster;
      
      public function BaseMonster()
      {
         this.fallList = [];
         super();
         this.newHpSlip();
      }
      
      override protected function __added(param1:Event) : void
      {
         super.__added(param1);
         if(gc.huodong61Flag)
         {
            if(this.isBoss)
            {
               if(gc.curStage == 1 && gc.curLevel == 2 || gc.curStage == 1 && gc.curLevel == 3 || gc.curStage == 2 && gc.curLevel == 2 || gc.curStage == 2 && gc.curLevel == 3 || gc.curStage == 3 && gc.curLevel == 2 || gc.curStage == 3 && gc.curLevel == 3)
               {
                  this.baoxiang61 = MainGame.getInstance().createMonster(27,this.x - 300,this.y);
               }
               else if(gc.curStage == 4 && gc.curLevel == 1 && this is Monster24)
               {
                  this.baoxiang61 = MainGame.getInstance().createMonster(27,this.x + (Math.random() - 0.5) * 300,this.y);
               }
            }
         }
      }
      
      override public function step() : void
      {
         if(this.isBoss)
         {
            gc.gameInfo.addBossBlood(this.monsterName,100 - Math.round(100 * (this.Hp / this.sHp)));
         }
         if(!this.flush)
         {
            this.flush = true;
            return;
         }
         this.adjustSpeed();
         super.step();
         this.addcount();
         if(!this.isDead())
         {
            this.judgeAttackHero();
            if(this.checkCanPass())
            {
               this.IntelligenceTime();
            }
         }
         else if(!this.isBoss)
         {
            if(this.curAction != "dead")
            {
               BaseHero(this.curAttackTarget).roleProperies.setExper(this.exp);
               this.curAction = "dead";
            }
         }
         this.drawMonsterHp();
         this.countCD();
         if(this.backTime > 0)
         {
            --this.backTime;
         }
         if(this.isFly)
         {
            if(Math.abs(this.speed.y) > 8)
            {
               this.speed.y *= 0.8;
            }
         }
      }
      
      protected function IntelligenceTime() : void
      {
         if(this.bcount-- <= 0)
         {
            this.myIntelligence();
         }
      }
      
      protected function checkCanPass() : Boolean
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:Number = NaN;
         var _loc1_:Boolean = true;
         var _loc2_:Array = gc.pWorld.getNoContinueArray();
         var _loc3_:uint = _loc2_.length;
         while(_loc3_-- > 0)
         {
            _loc6_ = _loc2_[_loc3_];
            if(Math.abs(this.x - _loc6_.x) <= 30)
            {
               _loc1_ = false;
            }
         }
         var _loc4_:Array;
         var _loc5_:uint = (_loc4_ = gc.pWorld.getMarkArray()).length;
         while(_loc5_-- > 0)
         {
            _loc7_ = _loc4_[_loc5_];
            _loc8_ = this.y - this.height / 2;
            if(!this.isattack || !_loc1_)
            {
               if(_loc8_ > _loc7_.y - _loc7_.height / 2 && _loc8_ < _loc7_.y + _loc7_.height / 2)
               {
                  if(Math.abs(this.x - _loc7_.x) <= 30)
                  {
                     this.bcount = 24;
                     if(Math.abs(this.x - _loc7_.x) <= 20)
                     {
                        return true;
                     }
                     if(this.isRight)
                     {
                        this.turnLeft();
                     }
                     else if(this.isLeft)
                     {
                        this.turnRight();
                     }
                     if(this.curAttackTarget)
                     {
                        this.lastAttackTarget = this.curAttackTarget;
                        this.curAttackTarget = null;
                     }
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      public function enhanceByWaves(param1:int) : void
      {
      }
      
      protected function assignTarget() : Boolean
      {
         if(this.curAttackTarget == null)
         {
            if(this.lastAttackTarget != null)
            {
               if(Math.abs(this.y - this.lastAttackTarget.y) <= Math.abs(this.height - this.lastAttackTarget.height))
               {
                  this.curAttackTarget = this.lastAttackTarget;
                  return true;
               }
            }
         }
         return false;
      }
      
      protected function countCD() : void
      {
         if(this.skillCD1-- <= 0)
         {
            this.skillCD1 = 0;
         }
         if(this.skillCD2-- <= 0)
         {
            this.skillCD2 = 0;
         }
         if(this.skillCD3-- <= 0)
         {
            this.skillCD3 = 0;
         }
         if(this.skillCD4-- <= 0)
         {
            this.skillCD4 = 0;
         }
      }
      
      protected function adjustSpeed() : void
      {
         if(!this.isCanMoveWhenAttack())
         {
            if(Math.abs(this.speed.x) > this.horizenSpeed)
            {
               this.speed.x *= 0.8;
               if(Math.abs(this.speed.x) < this.horizenSpeed)
               {
                  this.speed.x = this.speed.x > 0 ? Number(this.horizenSpeed) : Number(-this.horizenSpeed);
               }
            }
         }
      }
      
      protected function judgeAttackHero() : *
      {
         if(gc.hero1)
         {
            gc.hero1.beAttack(this);
         }
         if(gc.hero2)
         {
            gc.hero2.beAttack(this);
         }
      }
      
      protected function myIntelligence() : void
      {
         if(this.curAttackTarget == null)
         {
            this.normalWalk();
            if(!(this is Monster1) || this.isattack)
            {
               this.selectTarget();
            }
         }
         else
         {
            this.hasAttackTarget();
         }
      }
      
      protected function hasAttackTarget() : void
      {
         if(this.curAttackTarget.isDead())
         {
            this.curAttackTarget = null;
            return;
         }
         if(this.curAttackTarget)
         {
            if(!this.isFly && this.isInSky())
            {
            }
            if(this.backTime > 0)
            {
               if(this.speed.x > 0)
               {
                  this.turnRight();
               }
               else
               {
                  this.turnLeft();
               }
               if(this.y <= 150)
               {
                  this.speed.y = 0;
               }
               else
               {
                  this.speed.y = -3;
               }
            }
            else if(Math.abs(this.y - this.curAttackTarget.y) <= this.attackRange * 2)
            {
               if(this.followHero())
               {
                  this.followTarget();
               }
               else
               {
                  if(this.count % 36 == 0)
                  {
                     if(this.randomNum(this.isattback))
                     {
                        this.attackTarget();
                        this.setThisBackTime();
                     }
                     else
                     {
                        this.stopMove();
                     }
                  }
                  if(this.isFly)
                  {
                     this.speed.y = 0;
                  }
               }
            }
            else
            {
               this.normalWalk();
            }
         }
      }
      
      protected function followHero() : Boolean
      {
         return Math.abs(this.x - this.curAttackTarget.x) > this.attackRange;
      }
      
      protected function setThisBackTime() : void
      {
      }
      
      protected function attackTarget() : void
      {
         this.newAttackId();
         this.curAction = "hit1";
         this.lastHit = "hit1";
         if(this.x > this.curAttackTarget.x)
         {
            AUtils.flipHorizontal(this,1);
         }
         else
         {
            AUtils.flipHorizontal(this,-1);
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
      
      protected function selectTarget() : void
      {
         if(this.assignTarget())
         {
            return;
         }
         if(gc.hero1 && !gc.hero1.isDead())
         {
            if(Math.abs(this.y - this.gc.hero1.y) <= this.attackRange)
            {
               if(Math.abs(this.x - this.gc.hero1.x) < this.mysee)
               {
                  this.curAttackTarget = gc.hero1;
                  return;
               }
            }
         }
         if(gc.hero2 && !gc.hero2.isDead())
         {
            if(Math.abs(this.y - this.gc.hero2.y) <= this.attackRange)
            {
               if(Math.abs(this.x - this.gc.hero2.x) < this.mysee)
               {
                  this.curAttackTarget = gc.hero2;
                  return;
               }
            }
         }
      }
      
      public function beAttack(param1:BaseHero) : void
      {
         var m:int = 0;
         var bb:BaseBullet = null;
         var t:* = undefined;
         var obj:Object = null;
         var hurt:int = 0;
         var basehurt:int = 0;
         var lastint:int = 0;
         var ismag:Boolean = false;
         var _target:BaseHero = param1;
         if(_target.body)
         {
            if(_target.body.stick)
            {
               m = 0;
               while(m < this.magicBulletArray.length)
               {
                  bb = this.magicBulletArray[m] as BaseBullet;
                  if(bb.isCanBeAttack)
                  {
                     if(AUtils.testIntersects(bb,_target.body.stick,gc.gameSence))
                     {
                        bb.setDisable();
                        t = bb;
                        TweenMax.to(t,1,{
                           "alpha":0,
                           "onComplete":function():*
                           {
                              t.destroy();
                           }
                        });
                     }
                  }
                  m++;
               }
            }
         }
         if(this.beAttackIdArray.indexOf(_target.getAttackId()) != -1)
         {
            return;
         }
         if(this.isBoss && this.curAction == "dead")
         {
            return;
         }
         if(this.isYourFather)
         {
            return;
         }
         if(_target.body && this.colipse)
         {
            if(_target.body.stick)
            {
               if(!this.colipse.hitTestObject(_target.body.stick))
               {
                  return;
               }
               if(HitTest.complexHitTestObject(this.colipse,_target.body.stick))
               {
                  ++User.batterNum;
                  this.isattack = true;
                  if(!(_target is Role2Shadow))
                  {
                     this.curAttackTarget = _target;
                  }
                  else
                  {
                     this.curAttackTarget = Role2Shadow(_target).source;
                  }
                  if(_target is Role1)
                  {
                     SoundManager.play("BeattackByRole1");
                  }
                  else if(_target is Role2 || _target is Role2Shadow)
                  {
                     SoundManager.play("BeattackByRole2");
                  }
                  this.drawMonsterHp();
                  this.showHpSlip();
                  obj = _target.attackBackInfoDict[_target.curAction];
                  hurt = _target.getRealPower(_target.lastHit);
                  basehurt = _target.roleProperies.getBasePower();
                  lastint = this.getRealHurt(hurt,obj);
                  this.Hp -= lastint;
                  if(obj)
                  {
                     ismag = obj.attackKind == "magic" ? true : false;
                     this.beAttackBack(_target,obj.attackBackSpeed[0],obj.attackBackSpeed[1]);
                  }
                  if(this.isDead())
                  {
                     if(this.curAction != "dead")
                     {
                        BaseHero(this.curAttackTarget).roleProperies.setExper(this.exp);
                        this.curAction = "dead";
                     }
                  }
                  else
                  {
                     if(this.curAction == "hurt")
                     {
                        if(this.body)
                        {
                           this.body.gotoAndPlay(1);
                        }
                     }
                     else
                     {
                        this.curAction = "hurt";
                     }
                     this.stop1Frame();
                  }
                  this.beAttackIdArray.push(_target.getAttackId());
                  gc.eventManger.dispatchEvent(new CommonEvent("MonsterIsBeat",[lastint,this.curAttackTarget]));
                  this.addMonHurtMc(lastint,basehurt,ismag);
                  this.addBeAttackEffect(_target);
               }
            }
         }
      }
      
      override protected function addBeAttackEffect(param1:BaseObject) : void
      {
         var _loc3_:String = null;
         var _loc2_:Number = Math.random();
         if(_loc2_ > 0.5)
         {
            _loc3_ = "MonsterBeHurt1";
         }
         else
         {
            _loc3_ = "MonsterBeHurt2";
         }
         var _loc4_:MovieClip = AUtils.getNewObj(_loc3_);
         var _loc5_:ColorMatrix = new ColorMatrix();
         if(param1 is Role2)
         {
            _loc5_.adjustColor(0,0,0,160);
         }
         _loc4_.filters = [new ColorMatrixFilter(_loc5_)];
         _loc4_.x = this.colipse.x;
         _loc4_.y = this.colipse.y;
         this.addChild(_loc4_);
      }
      
      public function destroy() : void
      {
         var temp:BaseMonster = null;
         if(gc.huodong61Flag)
         {
            if(this.baoxiang61 && this.baoxiang61.Hp > 0)
            {
               this.baoxiang61.destroy();
            }
         }
         temp = this;
         TweenMax.to(temp,1,{
            "alpha":0,
            "onComplete":function():*
            {
               removeFromStage(temp);
            }
         });
         var idx:int = gc.pWorld.monsterArray.indexOf(this);
         if(idx != -1)
         {
            gc.pWorld.monsterArray.splice(idx,1);
         }
         this.magicBulletArray = [];
         this.dispose();
         delete global[this];
      }
      
      private function removeFromStage(param1:BaseMonster) : void
      {
         if(parent)
         {
            parent.removeChild(param1);
         }
      }
      
      public function stop1Frame() : void
      {
         this.flush = false;
      }
      
      override protected function checkOver() : void
      {
         if(this.y >= 1500)
         {
            this.destroy();
         }
      }
      
      override public function beMagicAttack(param1:*, param2:BaseObject, param3:Boolean = false) : Boolean
      {
         var _loc4_:Object = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(this.isYourFather)
         {
            return false;
         }
         if(param3 || this.colipse && AUtils.testIntersects(this.colipse,param1,gc.gameSence) && HitTest.complexHitTestObject(this,param1))
         {
            ++User.batterNum;
            if(!(param2 is Role2Shadow))
            {
               this.curAttackTarget = param2;
            }
            else
            {
               this.curAttackTarget = Role2Shadow(param2).source;
            }
            if(_loc4_ = param2.attackBackInfoDict[param1.curAction])
            {
               _loc5_ = _loc4_.attackKind == "magic" ? true : false;
               this.beAttackBack(param1,_loc4_.attackBackSpeed[0],_loc4_.attackBackSpeed[1]);
            }
            this.drawMonsterHp();
            this.isattack = true;
            this.showHpSlip();
            if(param2 is Role2Shadow)
            {
               _loc6_ = param2.getRealPower(param2.curAction);
            }
            else
            {
               _loc6_ = param2.getRealPower(param1.curAction);
            }
            if(param2 is Role1)
            {
               SoundManager.play("BeattackByRole1");
            }
            else if(param2 is Role2 || param2 is Role2Shadow)
            {
               SoundManager.play("BeattackByRole2");
            }
            _loc7_ = this.getRealHurt(_loc6_,_loc4_);
            this.Hp -= _loc7_;
            gc.eventManger.dispatchEvent(new CommonEvent("MonsterIsBeat",[_loc6_,this.curAttackTarget]));
            if(param2 is BaseHero)
            {
               _loc8_ = BaseHero(param2).roleProperies.getBasePower();
            }
            else
            {
               _loc8_ = _loc7_;
            }
            if(param2 is Role2Shadow)
            {
               this.addMonHurtMc(_loc7_,_loc8_,_loc5_,true);
            }
            else
            {
               this.addMonHurtMc(_loc7_,_loc8_,_loc5_,false);
            }
            if(this.isDead())
            {
               if(this.curAction != "dead")
               {
                  BaseHero(this.curAttackTarget).roleProperies.setExper(this.exp);
                  this.curAction = "dead";
               }
            }
            else
            {
               if(this.curAction == "hurt")
               {
                  if(this.body)
                  {
                     this.body.gotoAndPlay(1);
                  }
               }
               else
               {
                  this.curAction = "hurt";
               }
               this.stop1Frame();
            }
            this.addBeAttackEffect(param2);
            return true;
         }
         return false;
      }
      
      protected function getRealHurt(param1:int, param2:Object) : int
      {
         var _loc3_:int = 0;
         if(param2)
         {
            if(param2.attackKind == "physics")
            {
               if(param1 > this.def)
               {
                  _loc3_ = param1 - this.def;
               }
               else
               {
                  _loc3_ = 1;
               }
            }
            else if(param2.attackKind == "magic")
            {
               _loc3_ = param1;
            }
         }
         else
         {
            _loc3_ = 1;
         }
         return _loc3_;
      }
      
      override public function reduceHp(param1:int) : void
      {
         this.Hp -= param1;
         if(this.isDead())
         {
            if(this.curAction != "dead")
            {
               BaseHero(this.curAttackTarget).roleProperies.setExper(this.exp);
               this.curAction = "dead";
            }
         }
      }
      
      public function dropAura() : void
      {
         var _loc1_:BaseAura = null;
         var _loc4_:Number = NaN;
         this.addMedicine();
         this.fallEquip();
         var _loc2_:int = 2 + Math.floor(Math.random() * 3);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new auraRed(this,this.curAttackTarget);
            _loc1_.x = this.x + (Math.random() - 0.5) * 10;
            _loc1_.y = this.y + (Math.random() - 0.5) * 10;
            _loc1_.setPower(this.gxp);
            gc.gameSence.addChild(_loc1_);
            _loc3_++;
         }
         _loc4_ = Math.random();
         _loc2_ = 0;
         if(_loc4_ < 0.04)
         {
            _loc2_ = 3;
         }
         else if(_loc4_ < 0.08)
         {
            _loc2_ = 2;
         }
         else if(_loc4_ < 0.12)
         {
            _loc2_ = 1;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new auraGreen(this,this.curAttackTarget);
            _loc1_.x = this.x + (Math.random() - 0.5) * 20;
            _loc1_.y = this.y + (Math.random() - 0.5) * 20;
            gc.gameSence.addChild(_loc1_);
            _loc3_++;
         }
         _loc4_ = Math.random();
         _loc2_ = 0;
         if(_loc4_ < 0.04)
         {
            _loc2_ = 3;
         }
         else if(_loc4_ < 0.08)
         {
            _loc2_ = 2;
         }
         else if(_loc4_ < 0.12)
         {
            _loc2_ = 1;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new auraBlue(this,this.curAttackTarget);
            _loc1_.x = this.x + (Math.random() - 0.5) * 30;
            _loc1_.y = this.y + (Math.random() - 0.5) * 30;
            gc.gameSence.addChild(_loc1_);
            _loc3_++;
         }
         _loc4_ = Math.random();
         _loc2_ = 0;
         if(_loc4_ < 0.04)
         {
            _loc2_ = 3;
         }
         else if(_loc4_ < 0.08)
         {
            _loc2_ = 2;
         }
         else if(_loc4_ < 0.12)
         {
            _loc2_ = 1;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new auraWhile(this,this.curAttackTarget);
            _loc1_.x = this.x + (Math.random() - 0.5) * 40;
            _loc1_.y = this.y + (Math.random() - 0.5) * 40;
            gc.gameSence.addChild(_loc1_);
            _loc3_++;
         }
      }
      
      protected function addcount() : void
      {
         if(this.count++ > 240)
         {
            this.count = 0;
         }
      }
      
      protected function randomNum(param1:uint) : Boolean
      {
         var _loc2_:Number = param1 / 100;
         if(Math.random() > _loc2_)
         {
            return false;
         }
         return true;
      }
      
      protected function moveRorL(param1:uint) : *
      {
         if(this.randomNum(param1))
         {
            this.moveLeft();
         }
         else
         {
            this.moveRight();
         }
         this.curAction = "walk";
      }
      
      protected function normalWalk() : void
      {
         var _loc1_:uint = 50;
         if(this.count == 12)
         {
            if(this.parent.localToGlobal(new Point(this.x,this.y)).x - gc.gameInfo.pointmc.x < -400)
            {
               _loc1_ = 0;
            }
            else if(this.parent.localToGlobal(new Point(this.x,this.y)).x - gc.gameInfo.pointmc.x > 400)
            {
               _loc1_ = 100;
            }
            this.moveRorL(_loc1_);
            if(this.randomNum(50))
            {
               this.stopNum = 72;
            }
            else
            {
               this.stopNum = 96;
            }
         }
         this.waitamonent();
      }
      
      protected function waitamonent() : void
      {
         if(this.count >= this.stopNum)
         {
            if(this.randomNum(50))
            {
               this.stopMove();
            }
            if(this.count >= this.stopNum + Math.random() * 30)
            {
               this.count = 0;
            }
         }
      }
      
      protected function drawMonsterHp() : void
      {
         this.hpSlip.graphics.clear();
         this.hpSlip.alpha = 1;
         var _loc1_:Number = this.Hp / this.sHp;
         _loc1_ = _loc1_ < 0 ? Number(0) : Number(_loc1_);
         if(this.Hp >= 0)
         {
            this.hpSlip.graphics.lineStyle(1.2,0);
            this.hpSlip.graphics.drawRect(0,5,50,5);
            this.hpSlip.graphics.beginFill(16711680);
            if(this.transform.matrix.a == 1)
            {
               this.hpSlip.graphics.drawRect(0,5,50 * _loc1_,5);
            }
            else if(this.transform.matrix.a == -1)
            {
               this.hpSlip.graphics.drawRect(50 - 50 * _loc1_,5,50 * _loc1_,5);
            }
            this.hpSlip.graphics.endFill();
         }
      }
      
      protected function removedHpSlip() : void
      {
         this.hpSlip.visible = false;
      }
      
      protected function showHpSlip() : void
      {
         this.hpSlip.visible = true;
         TweenMax.to(this.hpSlip,2,{
            "alpha":0,
            "onComplete":this.removedHpSlip
         });
      }
      
      protected function newHpSlip() : void
      {
         this.hpSlip = new Sprite();
         this.hpSlip.x = -23;
         this.hpSlip.y = -66;
         this.hpSlip.visible = false;
         addChild(this.hpSlip);
      }
      
      protected function addMonHurtMc(param1:int, param2:int, param3:Boolean, param4:Boolean = false) : *
      {
         var _loc5_:ANumber = new ANumber();
         this.gc.gameSence.addChild(_loc5_);
         if(param4)
         {
            _loc5_.aNumImage("hurtnum",param1,this.x - 20,this.y - 60,20);
         }
         else if(param1 / param2 > 1.3)
         {
            _loc5_.aNumImage("bnum",param1,this.x - 20,this.y - 60,16);
         }
         else
         {
            _loc5_.aNumImage("hurtnum",param1,this.x - 20,this.y - 60,20);
         }
      }
      
      public function judgeAlive(param1:BaseHero) : *
      {
         param1.roleProperies.setExper(this.exp);
      }
      
      public function fallEquip() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:FallEquipObj = null;
         if(Math.random() <= this.probability)
         {
            _loc1_ = Math.round(Math.random() * (this.fallList.length - 1));
            if(this.fallList[_loc1_] || this.fallList[_loc1_] != undefined)
            {
               _loc2_ = new FallEquipObj(this.fallList[_loc1_]);
               _loc2_.x = this.x;
               _loc2_.y = this.y - this.height;
               this.gc.gameSence.addChild(_loc2_);
               this.gc.otherList.push(_loc2_);
            }
         }
      }
      
      public function addMedicine() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:Number = NaN;
         if(Math.random() >= 0.5)
         {
            _loc2_ = Math.random();
            if(_loc2_ <= 0.1)
            {
               if(_loc2_ <= 0.05)
               {
                  if(Math.random() >= 0.5)
                  {
                     _loc1_ = new SmallHP();
                     _loc1_.x = this.x;
                     _loc1_.y = this.y - _loc1_.height;
                  }
                  else
                  {
                     _loc1_ = new BigHP();
                     _loc1_.x = this.x;
                     _loc1_.y = this.y - _loc1_.height;
                  }
               }
               else
               {
                  _loc1_ = new SmallHP();
                  _loc1_.x = this.x;
                  _loc1_.y = this.y - _loc1_.height;
               }
            }
         }
         else if(Math.random() <= 0.1)
         {
            _loc1_ = new SmallMP();
            _loc1_.x = this.x;
            _loc1_.y = this.y - _loc1_.height;
         }
         if(_loc1_ != null)
         {
            this.gc.gameSence.addChild(_loc1_);
            this.gc.otherList.push(_loc1_);
         }
      }
      
      override public function getRealPower(param1:String) : int
      {
         var _loc2_:Object = this.attackBackInfoDict[param1];
         if(_loc2_)
         {
            return _loc2_.power;
         }
         return 0;
      }
      
      override public function isWalkOrRun() : Boolean
      {
         return this.curAction == "walk";
      }
      
      override public function isNormalHit() : Boolean
      {
         return true;
      }
   }
}
