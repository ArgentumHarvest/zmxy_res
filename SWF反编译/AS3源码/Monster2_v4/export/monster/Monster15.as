package export.monster
{
   import base.BaseMonster;
   import flash.geom.*;
   
   public class Monster15 extends BaseMonster
   {
       
      
      private var directChangeTime:int = 72.0;
      
      private var curDirectChangeTime:int = 0;
      
      public function Monster15()
      {
         super();
         this.horizenSpeed = 3;
         this.Hp = sHp = 800;
         this.mysee = 300;
         this.isattback = 50;
         this.attackRange = 450;
         this.def = 10;
         this.exp = 30;
         this.gxp = 14;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[5,-5],
            "AttackInterval":4,
            "power":55,
            "attackKind":"physics"
         };
         this.isFly = true;
         this.graity = 0;
         this.isBoss = false;
         this.directChangeTime = (1 + 2 * Math.random()) * 24;
         this.fallList = [{
            "name":"ptxzf",
            "bigtype":"zb"
         },{
            "name":"ptxzg",
            "bigtype":"zb"
         },{
            "name":"ptjs",
            "bigtype":"zb"
         },{
            "name":"ptsmz",
            "bigtype":"zb"
         }];
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking() && !this.isAttacking())
         {
            super.myIntelligence();
         }
         if(this.curDirectChangeTime > 0)
         {
            ++this.curDirectChangeTime;
            if(this.curDirectChangeTime >= this.directChangeTime)
            {
               this.curDirectChangeTime = 0;
            }
         }
      }
      
      override protected function setThisBackTime() : void
      {
         this.backTime = this.BACK_TIME;
      }
      
      override protected function followTarget() : void
      {
         if(this.curAttackTarget)
         {
            if(this.x > this.curAttackTarget.x)
            {
               if(this.curDirectChangeTime == 0)
               {
                  this.turnLeft();
                  this.curDirectChangeTime = 1;
               }
            }
            else if(this.curDirectChangeTime == 0)
            {
               this.turnRight();
               this.curDirectChangeTime = 1;
            }
            if(this.y < this.curAttackTarget.y - 60)
            {
               if(this.speed.y < 4)
               {
                  this.speed.y += 0.5;
               }
            }
            else if(this.speed.y > -4)
            {
               this.speed.y -= 0.5;
            }
         }
      }
      
      override protected function followHero() : Boolean
      {
         return Math.abs(this.x - this.curAttackTarget.x) > 150 || Math.abs(this.y - this.curAttackTarget.y) > 100;
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
      
      override protected function attackTarget() : void
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
         this.speed.x = 0;
         this.speed.y = 0;
      }
   }
}
