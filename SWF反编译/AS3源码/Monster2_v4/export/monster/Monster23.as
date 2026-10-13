package export.monster
{
   import base.*;
   import my.*;
   
   public class Monster23 extends BaseMonster
   {
       
      
      protected var addEffectObj:Object;
      
      public var swapHero:BaseHero;
      
      public function Monster23()
      {
         trace("===Monster23===");
         super();
         this.isBoss = true;
         this.monsterName = "牛魔王";
         this.horizenSpeed = 5;
         this.Hp = sHp = 20000;
         this.mysee = 300;
         this.isattback = 50;
         this.attackRange = 400;
         this.def = 100;
         this.exp = 100;
         this.gxp = 40;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":30,
            "attackBackSpeed":[6,-5],
            "attackInterval":4,
            "power":200,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":30,
            "attackBackSpeed":[2,-7],
            "attackInterval":4,
            "power":210,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":40,
            "attackBackSpeed":[2,-4],
            "attackInterval":999,
            "power":100,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":30,
            "attackBackSpeed":[8,-2],
            "attackInterval":4,
            "power":85,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":30,
            "attackBackSpeed":[2,-7],
            "attackInterval":4,
            "power":50,
            "attackKind":"magic"
         };
      }
      
      override protected function myIntelligence() : void
      {
         super.myIntelligence();
      }
      
      override protected function hasAttackTarget() : void
      {
         var _loc1_:Number = NaN;
         if(this.isAttacking())
         {
            return;
         }
         if(this.curAttackTarget && !this.isInSky())
         {
            if(Math.abs(this.x - this.curAttackTarget.x) <= 80)
            {
               if(this.skillCD4 == 0)
               {
                  this.releSkill4();
                  this.skillCD4 = 360;
               }
            }
            else if(Math.abs(this.x - this.curAttackTarget.x) <= 100)
            {
               if(this.skillCD3 == 0)
               {
                  this.releSkill3();
                  this.skillCD3 = 360;
               }
               else if(Math.random() < 0.8)
               {
                  this.attackTarget();
               }
               else
               {
                  this.normalWalk();
               }
            }
            else if(Math.abs(this.x - this.curAttackTarget.x) <= 200)
            {
               if(this.skillCD1 == 0 && this.skillCD2 == 0)
               {
                  _loc1_ = Math.random();
                  if(_loc1_ < 0.5)
                  {
                     this.releSkill1();
                     this.skillCD1 = 360;
                  }
                  else
                  {
                     this.releSkill2();
                     this.skillCD2 = 360;
                  }
               }
               else if(this.skillCD1 == 0)
               {
                  this.releSkill1();
                  this.skillCD1 = 360;
               }
               else if(this.skillCD2 == 0)
               {
                  this.releSkill2();
                  this.skillCD2 = 360;
               }
               else if(Math.random() < 0.8)
               {
                  this.attackTarget();
               }
               else
               {
                  this.normalWalk();
               }
            }
            else
            {
               this.normalWalk();
            }
         }
      }
      
      public function checkDohit5() : Boolean
      {
         var _loc2_:BaseHero = null;
         var _loc1_:int = 0;
         while(_loc1_ < gc.getPlayerArray().length)
         {
            _loc2_ = gc.getPlayerArray()[_loc1_] as BaseHero;
            if(!_loc2_.isYourFather)
            {
               if(!gc.isYourFather)
               {
                  if(Math.abs(this.x - _loc2_.x) <= 200)
                  {
                     this.swapHero = _loc2_;
                     this.swapHero.setStatic();
                     this.swapHero.gotoAndStop("wait");
                     this.swapHero.curAction = "wait";
                     this.swapHero.setLostKeyboard();
                     this.swapHero.visible = false;
                     return true;
                  }
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function cureHp(param1:int) : void
      {
         if(!this.isDead())
         {
            this.Hp += param1 * 10;
         }
         this.addCureMc(param1 * 10);
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(60);
         this.lastHit = "hit2";
         this.curAction = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.setYourFather(67);
         this.newAttackId();
         this.lastHit = "hit3";
         this.curAction = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.setYourFather(54);
         this.newAttackId();
         this.lastHit = "hit4";
         this.curAction = "hit4";
      }
      
      override protected function releSkill4() : void
      {
         this.newAttackId();
         this.lastHit = "hit5";
         this.curAction = "hit5";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit2";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      override public function destroy() : void
      {
         this.fallEquip();
         MainGame.getInstance().createMonster(24,1350,300);
         super.destroy();
      }
   }
}
