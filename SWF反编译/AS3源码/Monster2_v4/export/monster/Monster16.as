package export.monster
{
   import base.BaseMonster;
   import export.bullet.*;
   import flash.display.MovieClip;
   
   public class Monster16 extends BaseMonster
   {
       
      
      public function Monster16()
      {
         super();
         this.horizenSpeed = 3;
         this.Hp = sHp = 1200;
         this.mysee = 300;
         this.isattback = 50;
         this.attackRange = 150;
         this.def = 50;
         this.exp = 57;
         this.gxp = 27;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[6,-2],
            "attackInterval":4,
            "power":90,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":20,
            "attackBackSpeed":[2,-2],
            "attackInterval":999,
            "power":110,
            "attackKind":"magic"
         };
         this.fallList = [{
            "name":"yxxzf",
            "bigtype":"zb"
         },{
            "name":"yxxzg",
            "bigtype":"zb"
         },{
            "name":"yxjs",
            "bigtype":"zb"
         },{
            "name":"yxsmz",
            "bigtype":"zb"
         }];
      }
      
      override protected function hasAttackTarget() : void
      {
         if(this.isAttacking())
         {
            return;
         }
         if(this.curAttackTarget && !this.isInSky())
         {
            if(Math.abs(this.y - this.curAttackTarget.y) <= this.attackRange * 2)
            {
               if(Math.abs(this.x - this.curAttackTarget.x) > this.attackRange)
               {
                  this.followTarget();
               }
               else if(this.count % 24 == 0)
               {
                  if(this.skillCD1 == 0)
                  {
                     this.releSkill1();
                     this.skillCD1 = 240;
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
      
      public function throwKnife() : void
      {
         var _loc1_:SpecialEffectBullet = new SpecialEffectBullet("Monster13Bullet1");
         if(this.transform.matrix.a == 1)
         {
            _loc1_.x = this.x - 20;
         }
         else
         {
            _loc1_.x = this.x + 20;
         }
         _loc1_.y = this.y;
         _loc1_.setRole(this);
         _loc1_.setAction(this.lastHit);
         gc.gameSence.addChild(_loc1_);
         this.magicBulletArray.push(_loc1_);
      }
      
      override protected function releSkill1() : void
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
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2";
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
