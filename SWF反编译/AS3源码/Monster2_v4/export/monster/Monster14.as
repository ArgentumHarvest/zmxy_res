package export.monster
{
   import base.BaseMonster;
   import export.bullet.*;
   
   public class Monster14 extends BaseMonster
   {
       
      
      public function Monster14()
      {
         super();
         this.horizenSpeed = 5;
         this.Hp = sHp = 1000;
         this.mysee = 300;
         this.isattback = 40;
         this.attackRange = 450;
         this.def = 25;
         this.exp = 48;
         this.gxp = 24;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[2,-5],
            "AttackInterval":4,
            "power":30,
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
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override protected function hasAttackTarget() : void
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
               return;
            }
            if(this.count % 24 == 0)
            {
               if(this.randomNum(isattback))
               {
                  this.attackTarget();
               }
               else
               {
                  this.stopMove();
               }
            }
            else
            {
               this.keepDistanceWithHero();
            }
         }
      }
      
      private function keepDistanceWithHero() : void
      {
         if(Math.abs(this.x - this.curAttackTarget.x) <= 200)
         {
            if(this.x > this.curAttackTarget.x)
            {
               this.moveRight();
            }
            else
            {
               this.moveLeft();
            }
         }
         if(Math.abs(this.x - this.curAttackTarget.x) >= 350)
         {
            this.followTarget();
         }
      }
      
      public function doHit1() : void
      {
         var _loc1_:EnemyMoveBullet = new EnemyMoveBullet("Monster14Bullet1");
         _loc1_.x = this.x;
         _loc1_.y = this.y;
         _loc1_.setRole(this);
         _loc1_.setSpeed(4);
         _loc1_.setCanBeAttack();
         _loc1_.setAddSpeed();
         _loc1_.setDistance(1000);
         _loc1_.setAction("hit1");
         gc.gameSence.addChild(_loc1_);
         this.magicBulletArray.push(_loc1_);
      }
   }
}
