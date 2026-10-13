package export.monster
{
   import base.*;
   import event.*;
   import export.hero.*;
   import flash.geom.*;
   import manager.*;
   import my.*;
   import user.*;
   
   public class Monster22 extends BaseMonster
   {
       
      
      private var changeFrames:int = 80;
      
      private var changeDirTime:uint = 24;
      
      private var isStopRuning:Boolean = false;
      
      private var lastDir:String = "";
      
      private var stoping:Boolean = false;
      
      public function Monster22()
      {
         super();
         trace("===Monster22===");
         this.horizenSpeed = 13;
         this.isBoss = true;
         this.monsterName = "牛魔王";
         this.Hp = sHp = 40000;
         this.mysee = 300;
         this.isattback = 40;
         this.attackRange = 450;
         this.def = 100;
         this.exp = 48;
         this.gxp = 24;
         this.attackBackInfoDict["walk"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[20,-2],
            "AttackInterval":4,
            "power":300,
            "attackKind":"physics"
         };
         this.changemove("Left");
      }
      
      override protected function myIntelligence() : void
      {
         if(this.parent.localToGlobal(new Point(this.x,this.y)).x - gc.gameInfo.pointmc.x < -360)
         {
            if(this.isStopRuning)
            {
               this.stopMoveLeft();
               this.lastDir = "Left";
            }
            this.stopRunAndBeAttack();
         }
         else if(this.parent.localToGlobal(new Point(this.x,this.y)).x - gc.gameInfo.pointmc.x > 400)
         {
            if(this.isStopRuning)
            {
               this.stopMoveRight();
               this.lastDir = "Right";
            }
            this.stopRunAndBeAttack();
         }
         else if(this.stoping)
         {
            if(this.lastDir == "Left")
            {
               this.changemove("Left");
            }
            else if(this.lastDir == "Right")
            {
               this.changemove("Right");
            }
         }
      }
      
      private function stopRunAndBeAttack() : void
      {
         this.stoping = true;
         if(this.changeDirTime-- <= 0)
         {
            this.changeDirTime = 24 * 3;
            this.changemove();
         }
      }
      
      public function changemove(param1:String = "") : void
      {
         this.lastHit = "walk";
         this.isStopRuning = true;
         this.stoping = false;
         this.newAttackId();
         this.isYourFather = true;
         this.moveAttack = true;
         if(param1 == "")
         {
            if(this.lastDir == "Left")
            {
               this.moveRight();
            }
            else if(this.lastDir == "Right")
            {
               this.moveLeft();
            }
         }
         else if(param1 == "Left")
         {
            this.moveLeft();
            this.lastDir = "Left";
         }
         else if(param1 == "Right")
         {
            this.moveRight();
            this.lastDir = "Right";
         }
      }
      
      override protected function IntelligenceTime() : void
      {
         this.myIntelligence();
      }
      
      override protected function stopMoveLeft() : void
      {
         super.stopMoveLeft();
         this.moveAttack = false;
         this.isYourFather = false;
      }
      
      override protected function stopMoveRight() : void
      {
         super.stopMoveRight();
         this.moveAttack = false;
         this.isYourFather = false;
      }
      
      override protected function moveLeft() : void
      {
         this.turnLeft();
         if(!this.isInSky() && !this.isBeAttacking())
         {
            this.iswor();
         }
      }
      
      override protected function moveRight() : void
      {
         this.turnRight();
         if(!this.isInSky() && !this.isBeAttacking())
         {
            this.iswor();
         }
      }
      
      override protected function hasAttackTarget() : void
      {
      }
      
      override public function beAttack(param1:BaseHero) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
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
         if(param1.body && this.colipse)
         {
            if(param1.body.stick)
            {
               if(AUtils.testIntersects(this.colipse,param1.body.stick,gc.gameSence) && HitTest.complexHitTestObject(this.colipse,param1.body.stick))
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
                  _loc2_ = param1.getRealPower(param1.lastHit);
                  _loc3_ = param1.roleProperies.getBasePower();
                  if(_loc4_ = param1.attackBackInfoDict[param1.lastHit])
                  {
                     _loc5_ = _loc4_.attackKind == "magic" ? true : false;
                  }
                  _loc6_ = this.getRealHurt(_loc2_,_loc4_);
                  this.Hp -= _loc6_;
                  if(this.isDead())
                  {
                     if(this.curAction != "dead")
                     {
                        BaseHero(this.curAttackTarget).roleProperies.setExper(this.exp);
                        this.curAction = "dead";
                     }
                  }
                  this.beAttackIdArray.push(param1.getAttackId());
                  gc.eventManger.dispatchEvent(new CommonEvent("MonsterIsBeat",[_loc6_,this.curAttackTarget]));
                  this.addMonHurtMc(_loc6_,_loc3_,_loc5_);
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
            this.drawMonsterHp();
            this.isattack = true;
            this.showHpSlip();
            if(param2 is Role2Shadow)
            {
               _loc4_ = param2.getRealPower(param2.curAction);
            }
            else
            {
               _loc4_ = param2.getRealPower(param1.curAction);
            }
            if(param2 is Role1)
            {
               SoundManager.play("BeattackByRole1");
            }
            else if(param2 is Role2 || param2 is Role2Shadow)
            {
               SoundManager.play("BeattackByRole2");
            }
            if(_loc5_ = param2.attackBackInfoDict[param1.curAction])
            {
               _loc6_ = _loc5_.attackKind == "magic" ? true : false;
            }
            _loc7_ = this.getRealHurt(_loc4_,_loc5_);
            this.Hp -= _loc7_;
            gc.eventManger.dispatchEvent(new CommonEvent("MonsterIsBeat",[_loc4_,this.curAttackTarget]));
            if(param2 is BaseHero)
            {
               _loc8_ = BaseHero(param2).roleProperies.getBasePower();
            }
            else
            {
               _loc8_ = _loc7_;
            }
            this.addMonHurtMc(_loc4_,_loc8_,_loc6_);
            if(this.isDead())
            {
               if(this.curAction != "dead")
               {
                  BaseHero(this.curAttackTarget).roleProperies.setExper(this.exp);
                  this.curAction = "dead";
               }
            }
            this.addBeAttackEffect(param2);
            return true;
         }
         return false;
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit1";
      }
      
      override public function destroy() : void
      {
         MainGame.getInstance().createMonster(23,1500,450);
         super.destroy();
      }
   }
}
