package export.monster
{
   import base.BaseMonster;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   
   public class Monster4 extends BaseMonster
   {
       
      
      public function Monster4()
      {
         super();
         this.isBoss = true;
         this.monsterName = "彌猴王";
         this.horizenSpeed = 3;
         this.Hp = sHp = 1500;
         this.mysee = 300;
         this.isattback = 50;
         this.attackRange = 150;
         this.def = 5;
         this.exp = 25;
         this.gxp = 20;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":2,
            "attackBackSpeed":[6,-5],
            "attackInterval":4,
            "power":30,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":50,
            "attackBackSpeed":[2,-7],
            "attackInterval":999,
            "power":20,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":40,
            "attackBackSpeed":[15,0],
            "attackInterval":999,
            "power":20,
            "attackKind":"magic"
         };
         this.probability = 0.4;
         this.fallList = [{
            "name":"dslj",
            "bigtype":"zb"
         }];
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
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
                     this.skillCD1 = 180;
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
                     this.skillCD2 = 260;
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
         this.lastHit = "hit3";
         this.curAction = "hit3";
      }
      
      override protected function releSkill2() : void
      {
         this.setYourFather(76);
         this.lastHit = "hit2";
         this.curAction = "hit2";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3";
      }
      
      public function doHit3() : void
      {
         var _loc1_:SpecialEffectBullet = new SpecialEffectBullet("Boss2Bullet1");
         _loc1_.x = this.x;
         _loc1_.y = this.y;
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
