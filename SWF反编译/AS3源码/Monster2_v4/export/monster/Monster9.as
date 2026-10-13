package export.monster
{
   import base.*;
   import com.greensock.*;
   import event.*;
   import export.bullet.*;
   import export.hero.*;
   import flash.display.*;
   import flash.geom.*;
   import manager.*;
   import my.*;
   import user.*;
   
   public class Monster9 extends BaseMonster
   {
       
      
      private var flyTime:int = 720.0;
      
      private var floorTime:int = 240.0;
      
      private var maxHighLen:int = 150;
      
      private var maxHitWhenEgg:int;
      
      private var eggTime:int = 168.0;
      
      private var curEggTime:int = 0;
      
      private var hhhhp:int = 10000;
      
      public function Monster9()
      {
         super();
         this.isBoss = true;
         this.monsterName = "彭魔王";
         this.horizenSpeed = 3;
         this.Hp = sHp = this.hhhhp;
         this.mysee = 300;
         this.isattback = 30;
         this.attackRange = 400;
         this.def = 20;
         this.exp = 130;
         this.gxp = 20;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[2,0],
            "attackInterval":999,
            "power":100,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[2,-2],
            "attackInterval":4,
            "power":200,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[2,0],
            "attackInterval":999,
            "power":100,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[2,0],
            "attackInterval":999,
            "power":70,
            "attackKind":"magic"
         };
         this.probability = 0.25;
         this.fallList = [{
            "name":"tsyp",
            "bigtype":"zb"
         },{
            "name":"tsyj",
            "bigtype":"zb"
         }];
         this.setMaxHitWhenEgg();
      }
      
      private function setMaxHitWhenEgg() : void
      {
         if(gc.playNum == 1)
         {
            this.maxHitWhenEgg = 5;
         }
         else if(gc.playNum == 2)
         {
            this.maxHitWhenEgg = 10;
         }
      }
      
      override protected function hasAttackTarget() : void
      {
         var _loc1_:Number = NaN;
         if(this.isAttacking() || this.isEgging())
         {
            return;
         }
         if(this.curAttackTarget)
         {
            if(!this.isFly && this.isInSky())
            {
               return;
            }
            if(Math.abs(this.y - this.curAttackTarget.y) <= this.attackRange * 2)
            {
               if(AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) > this.attackRange)
               {
                  if(!this.isFly)
                  {
                     this.followTarget();
                  }
                  else if(this.count % 24 == 0)
                  {
                     if(this.randomNum(50))
                     {
                        this.checkDirect();
                        this.releSkill1();
                     }
                  }
               }
               else if(this.count % 24 == 0)
               {
                  this.speed.x = 0;
                  this.speed.y = 0;
                  if(AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= 150)
                  {
                     if(!this.isFly)
                     {
                        this.attackTarget();
                     }
                  }
                  else
                  {
                     _loc1_ = Math.random();
                     if(_loc1_ < 0.3)
                     {
                        if(this.skillCD2 == 0)
                        {
                           this.checkDirect();
                           this.newAttackId();
                           this.releSkill2();
                           this.skillCD2 = 130;
                        }
                     }
                     else if(this.skillCD1 == 0)
                     {
                        this.checkDirect();
                        this.newAttackId();
                        this.releSkill1();
                        this.skillCD1 = 48;
                     }
                  }
               }
               else
               {
                  this.followTarget();
               }
            }
            else
            {
               this.normalWalk();
            }
         }
      }
      
      private function checkDirect() : void
      {
         if(this.curAttackTarget)
         {
            if(this.x > this.curAttackTarget.x)
            {
               this.turnLeft();
            }
            else if(this.x < this.curAttackTarget.x)
            {
               this.turnRight();
            }
         }
      }
      
      private function isEgging() : Boolean
      {
         return this.curAction == "turnToEgg" || this.curAction == "reBurn";
      }
      
      public function turnToEgg() : void
      {
         this.curAction = "turnToEgg";
         this.gotoAndStop("turnToEgg");
         this.curEggTime = 1;
         this.isFly = false;
         this.graity = 1.5;
         this.setStatic();
      }
      
      override public function isCanMoveByStage() : Boolean
      {
         if(!this.colipse)
         {
            return false;
         }
         return this.x < gc.vControllor.getLastPointX() - 50;
      }
      
      public function reBurn() : void
      {
         if(this.curAction != "dead")
         {
            this.curAction = "reBurn";
            this.curEggTime = 0;
            this.Hp = this.hhhhp;
            this.setMaxHitWhenEgg();
         }
      }
      
      private function flyToTargetY() : void
      {
         if(this.y > this.maxHighLen)
         {
            if(this.y - this.horizenSpeed >= this.maxHighLen)
            {
               this.speed.y = -this.horizenSpeed;
            }
            else
            {
               this.speed.y = this.maxHighLen - this.y;
            }
         }
         else if(this.y < 150)
         {
            if(this.y + this.horizenSpeed <= this.maxHighLen)
            {
               this.speed.y = this.horizenSpeed;
            }
            else
            {
               this.speed.y = this.maxHighLen - this.y;
            }
         }
      }
      
      override protected function followTarget() : void
      {
         if(!this.isFly)
         {
            super.followTarget();
         }
         else if(this.curAttackTarget)
         {
            if(this.x > this.curAttackTarget.x + 150 && this.count % 48 == 0)
            {
               this.turnLeft();
            }
            else if(this.x < this.curAttackTarget.x - 150 && this.count % 48 == 0)
            {
               this.turnRight();
            }
            if(this.y != this.maxHighLen)
            {
               this.flyToTargetY();
            }
         }
      }
      
      override protected function followHero() : Boolean
      {
         if(!this.isFly)
         {
            return Math.abs(this.x - this.curAttackTarget.x) > this.attackRange;
         }
         return Math.abs(this.x - this.curAttackTarget.x) > 200;
      }
      
      override protected function normalWalk() : void
      {
         this.newAttackId();
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
            if(this.isFly)
            {
               if(!this.isAttacking())
               {
                  if(this.curAttackTarget)
                  {
                     this.followTarget();
                  }
                  else
                  {
                     this.moveRorL(_loc1_);
                     this.speed.y = 0;
                  }
               }
               else
               {
                  this.speed.x = 0;
                  this.speed.y = 0;
               }
            }
            else
            {
               this.moveRorL(_loc1_);
            }
            if(this.randomNum(50))
            {
               stopNum = 72;
            }
            else
            {
               stopNum = 96;
            }
         }
         this.waitamonent();
      }
      
      override public function step() : void
      {
         var _loc1_:int = 0;
         if(this.isFly)
         {
            if(this.curAction == "walk")
            {
               this.curAction = "fly";
            }
         }
         if(!this.isDead() && !this.isEgging())
         {
            if(!this.isFly)
            {
               --this.floorTime;
               if(this.floorTime <= 0)
               {
                  isFly = true;
                  speed.y = -10;
                  graity = 0;
                  _loc1_ = 10 + Math.random() * 10;
                  this.flyTime = 24 * _loc1_;
                  this.setYourFather(72);
               }
            }
            else
            {
               --this.flyTime;
               if(this.flyTime <= 0)
               {
                  isFly = false;
                  this.y = 150;
                  this.graity = 1.5;
                  _loc1_ = 10 + Math.random() * 10;
                  this.floorTime = 24 * _loc1_;
               }
            }
         }
         if(this.curEggTime > 0)
         {
            ++this.curEggTime;
            if(this.curEggTime >= this.eggTime)
            {
               this.reBurn();
            }
            if(this.curEggTime % 24 == 0)
            {
               this.fireHit();
            }
         }
         super.step();
      }
      
      override protected function attackTarget() : void
      {
         this.newAttackId();
         this.curAction = "hit4";
         this.lastHit = "hit4";
         if(this.x > this.curAttackTarget.x)
         {
            AUtils.flipHorizontal(this,1);
         }
         else
         {
            AUtils.flipHorizontal(this,-1);
         }
      }
      
      public function fireHit() : void
      {
         var b:SpecialEffectBullet = null;
         var mc:MovieClip = null;
         var offsetX:Number = NaN;
         var rand1:int = 0;
         var rand2:int = 0;
         b = new SpecialEffectBullet("Boss4Bullet1");
         b.alpha = 0;
         AUtils.stopAllChildren(b);
         if(this.body)
         {
            mc = this.body.getChildByName("fire") as MovieClip;
            offsetX = 30 + Math.random() * 200;
            if(mc)
            {
               if(this.transform.matrix.a == 1)
               {
                  b.x = this.x - offsetX;
               }
               else
               {
                  b.x = this.x + offsetX;
               }
               b.y = mc.y + this.y;
            }
            else
            {
               rand1 = (Math.random() - 0.5) * 200;
               rand2 = Math.random() * 150;
               b.x = this.x + rand1;
               b.y = this.y - 100 - rand2;
            }
         }
         b.setRole(this);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         TweenMax.to(b,0.6,{
            "alpha":1,
            "onComplete":function():*
            {
               AUtils.startAllChildren(b);
            }
         });
      }
      
      override protected function releSkill1() : void
      {
         if(this.isFly)
         {
            this.lastHit = "hit1";
            this.curAction = "hit1";
         }
         else
         {
            this.lastHit = "hit3";
            this.curAction = "hit3";
         }
      }
      
      override protected function releSkill2() : void
      {
         this.lastHit = "hit2";
         this.curAction = "hit2";
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
         return this.curAction == "hit2";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "turnToEgg" || this.curAction == "reBurn";
      }
      
      override public function destroy() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         super.destroy();
         if(this.isBoss)
         {
            _loc1_ = gc.pWorld.getTransferDoorArray();
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               _loc3_ = _loc1_[_loc2_];
               _loc3_.visible = true;
               _loc2_++;
            }
         }
      }
      
      override public function beAttack(param1:BaseHero) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         if(this.beAttackIdArray.indexOf(param1.getAttackId()) != -1)
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
         if(param1.body)
         {
            if(param1.body.stick)
            {
               if(this.colipse && !AUtils.testIntersects(this.colipse,param1,gc.gameSence))
               {
                  return;
               }
               if(HitTest.complexHitTestObject(this.colipse,param1.body.stick))
               {
                  ++User.batterNum;
                  this.isattack = true;
                  if(!(param1 is Role2Shadow))
                  {
                     this.curAttackTarget = param1;
                  }
                  else
                  {
                     this.curAttackTarget = Role2Shadow(param1).source;
                  }
                  if(param1 is Role1)
                  {
                     SoundManager.play("BeattackByRole1");
                  }
                  else if(param1 is Role2 || param1 is Role2Shadow)
                  {
                     SoundManager.play("BeattackByRole2");
                  }
                  if(this.curAction != "turnToEgg" && this.curAction != "dead")
                  {
                     this.drawMonsterHp();
                     this.showHpSlip();
                     _loc2_ = param1.getRealPower(param1.lastHit);
                     _loc3_ = param1.roleProperies.getBasePower();
                     _loc4_ = param1.attackBackInfoDict[param1.curAction];
                     _loc5_ = this.getRealHurt(_loc2_,_loc4_);
                     this.Hp -= _loc5_;
                     if(_loc4_)
                     {
                        _loc6_ = _loc4_.attackKind == "magic" ? true : false;
                        this.beAttackBack(param1,_loc4_.attackBackSpeed[0],_loc4_.attackBackSpeed[1]);
                     }
                     if(this.isDead())
                     {
                        this.turnToEgg();
                     }
                     else if(this.curAction == "hurt")
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
                     gc.eventManger.dispatchEvent(new CommonEvent("MonsterIsBeat",[_loc5_,this.curAttackTarget]));
                     this.addMonHurtMc(_loc5_,_loc3_,_loc6_);
                  }
                  else
                  {
                     --this.maxHitWhenEgg;
                     if(this.maxHitWhenEgg <= 0)
                     {
                        this.curAction = "dead";
                        this.gotoAndStop("dead");
                     }
                  }
                  this.beAttackIdArray.push(param1.getAttackId());
                  this.addBeAttackEffect(param1);
               }
            }
         }
      }
      
      override public function beMagicAttack(param1:*, param2:BaseObject, param3:Boolean = false) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(this.isYourFather)
         {
            return false;
         }
         if(this.colipse && !AUtils.testIntersects(this.colipse,param1,gc.gameSence))
         {
            return false;
         }
         if(HitTest.complexHitTestObject(this,param1))
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
            if(this.curAction != "turnToEgg" && this.curAction != "dead")
            {
               this.drawMonsterHp();
               this.isattack = true;
               this.showHpSlip();
               _loc4_ = param2.getRealPower(param1.curAction);
               if(_loc5_ = param2.attackBackInfoDict[param1.curAction])
               {
                  _loc6_ = _loc5_.attackKind == "magic" ? true : false;
               }
               _loc7_ = this.getRealHurt(_loc4_,_loc5_);
               this.Hp -= _loc7_;
               if(param2 is BaseHero)
               {
                  _loc8_ = BaseHero(param2).roleProperies.getBasePower();
               }
               else
               {
                  _loc8_ = _loc7_;
               }
               if(param2 is Role1)
               {
                  SoundManager.play("BeattackByRole1");
               }
               else if(param2 is Role2 || param2 is Role2Shadow)
               {
                  SoundManager.play("BeattackByRole2");
               }
               gc.eventManger.dispatchEvent(new CommonEvent("MonsterIsBeat",[_loc4_,this.curAttackTarget]));
               this.addMonHurtMc(_loc7_,_loc8_,_loc6_);
               if(this.isDead())
               {
                  this.turnToEgg();
               }
               else if(this.curAction == "hurt")
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
            }
            else
            {
               --this.maxHitWhenEgg;
               if(this.maxHitWhenEgg <= 0)
               {
                  this.curAction = "dead";
                  this.gotoAndStop("dead");
               }
            }
            this.addBeAttackEffect(param2);
            return true;
         }
         return false;
      }
   }
}
