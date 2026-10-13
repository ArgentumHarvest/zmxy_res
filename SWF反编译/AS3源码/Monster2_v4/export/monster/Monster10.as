package export.monster
{
   import base.*;
   import event.*;
   import export.bullet.*;
   import export.hero.*;
   import flash.display.MovieClip;
   import manager.*;
   import my.*;
   import user.*;
   
   public class Monster10 extends BaseMonster
   {
       
      
      public function Monster10()
      {
         super();
         this.isBoss = true;
         this.monsterName = "鲛魔王";
         this.horizenSpeed = 3;
         this.Hp = sHp = 24000;
         this.mysee = 300;
         this.isattback = 50;
         this.attackRange = 250;
         this.def = 80;
         this.exp = 225;
         this.gxp = 70;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":2,
            "attackBackSpeed":[6,-5],
            "attackInterval":99,
            "power":120,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":30,
            "attackBackSpeed":[2,-7],
            "attackInterval":99,
            "power":200,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":40,
            "attackBackSpeed":[15,0],
            "attackInterval":99,
            "power":150,
            "attackKind":"magic"
         };
         this.probability = 0.2;
         this.fallList = [{
            "name":"xhyk",
            "bigtype":"zb"
         }];
      }
      
      override public function beMagicAttack(param1:*, param2:BaseObject, param3:Boolean = false) : Boolean
      {
         var _loc4_:Object = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(this.transform.matrix.a * param1.transform.matrix.a > 0)
         {
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
                  this.beAttackBack(param2,_loc4_.attackBackSpeed[0],_loc4_.attackBackSpeed[1]);
               }
               this.drawMonsterHp();
               this.isattack = true;
               this.showHpSlip();
               _loc6_ = 1;
               this.Hp -= _loc6_;
               gc.eventManger.dispatchEvent(new CommonEvent("MonsterIsBeat",[_loc6_,this.curAttackTarget]));
               if(param2 is BaseHero)
               {
                  _loc7_ = BaseHero(param2).roleProperies.getBasePower();
               }
               else
               {
                  _loc7_ = _loc6_;
               }
               if(param2 is Role1)
               {
                  SoundManager.play("BeattackByRole1");
               }
               else if(param2 is Role2 || param2 is Role2Shadow)
               {
                  SoundManager.play("BeattackByRole2");
               }
               this.addMonHurtMc(_loc6_,_loc7_,_loc5_);
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
         return super.beMagicAttack(param1,param2,param3);
      }
      
      override public function beAttack(param1:BaseHero) : void
      {
         var _loc2_:int = 0;
         if(this.transform.matrix.a * param1.transform.matrix.a > 0)
         {
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
                     this.drawMonsterHp();
                     this.showHpSlip();
                     _loc2_ = 1;
                     this.Hp -= _loc2_;
                     if(this.isDead())
                     {
                        if(this.curAction != "dead")
                        {
                           BaseHero(this.curAttackTarget).roleProperies.setExper(this.exp);
                           this.curAction = "dead";
                        }
                     }
                     this.beAttackIdArray.push(param1.getAttackId());
                     gc.eventManger.dispatchEvent(new CommonEvent("MonsterIsBeat",[_loc2_,this.curAttackTarget]));
                     this.addMonHurtMc(1,1,true);
                     this.addBackBeAttackEffect();
                  }
               }
            }
            return;
         }
         super.beAttack(param1);
      }
      
      private function addBackBeAttackEffect() : void
      {
         var _loc1_:MovieClip = AUtils.getNewObj("Monster10BeAttack");
         this.addChild(_loc1_);
      }
      
      override protected function myIntelligence() : void
      {
         super.myIntelligence();
      }
      
      override protected function hasAttackTarget() : void
      {
         if(this.isAttacking())
         {
            return;
         }
         if(this.curAttackTarget)
         {
            if(Math.abs(this.y - this.curAttackTarget.y) <= this.attackRange * 2)
            {
               if(Math.abs(this.x - this.curAttackTarget.x) > this.attackRange)
               {
                  if(this.skillCD1 == 0)
                  {
                     if(this.x > this.curAttackTarget.x)
                     {
                        this.turnLeft();
                     }
                     else
                     {
                        this.turnRight();
                     }
                     this.releSkill1();
                     this.skillCD1 = 240;
                  }
                  else
                  {
                     this.followTarget();
                  }
               }
               else if(this.count % 24 == 0)
               {
                  if(this.skillCD2 == 0)
                  {
                     this.releSkill2();
                     this.skillCD2 = 144;
                  }
                  else
                  {
                     this.attackTarget();
                  }
               }
            }
            else
            {
               this.normalWalk();
            }
         }
      }
      
      override protected function releSkill1() : void
      {
         this.setYourFather(45);
         this.lastHit = "hit3";
         this.curAction = "hit3";
      }
      
      override protected function releSkill2() : void
      {
         this.lastHit = "hit2";
         this.curAction = "hit2";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3";
      }
      
      public function doHit2Effect() : void
      {
         var _loc1_:SpecialEffectBullet = new SpecialEffectBullet("Boss5Bullet1");
         if(this.transform.matrix.a == 1)
         {
            _loc1_.x = this.x - 30;
            _loc1_.y = this.y - 30;
         }
         else
         {
            _loc1_.x = this.x + 30;
            _loc1_.y = this.y + 30;
         }
         _loc1_.setRole(this);
         _loc1_.setAction(this.lastHit);
         gc.gameSence.addChild(_loc1_);
         this.magicBulletArray.push(_loc1_);
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
   }
}
