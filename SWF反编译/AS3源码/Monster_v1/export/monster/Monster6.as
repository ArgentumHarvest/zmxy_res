package export.monster
{
   import base.BaseMonster;
   import flash.display.MovieClip;
   
   public class Monster6 extends BaseMonster
   {
       
      
      public function Monster6()
      {
         super();
         this.isBoss = true;
         this.monsterName = "禺狨王";
         this.horizenSpeed = 4;
         this.Hp = sHp = 3000;
         this.mysee = 300;
         this.isattback = 50;
         this.attackRange = 450;
         this.def = 6;
         this.exp = 35;
         this.gxp = 20;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[12,-2],
            "attackInterval":4,
            "power":30,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[2,-12],
            "attackInterval":4,
            "power":40,
            "attackKind":"magic"
         };
         this.probability = 0.35;
         this.fallList = [{
            "name":"dsyj",
            "bigtype":"zb"
         },{
            "name":"dsqz",
            "bigtype":"zb"
         }];
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
               if(Math.abs(this.x - this.curAttackTarget.x) > 250)
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
      
      override protected function releSkill1() : void
      {
         this.setYourFather(48);
         this.lastHit = "hit2";
         this.curAction = "hit2";
      }
      
      override protected function myIntelligence() : void
      {
         super.myIntelligence();
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
