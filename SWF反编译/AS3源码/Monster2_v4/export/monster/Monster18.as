package export.monster
{
   import base.BaseMonster;
   import export.bullet.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import my.*;
   
   public class Monster18 extends BaseMonster
   {
       
      
      private var directChangeTime:int = 72.0;
      
      private var curDirectChangeTime:int = 0;
      
      public function Monster18()
      {
         super();
         this.horizenSpeed = 6;
         this.Hp = sHp = 999999;
         this.mysee = 300;
         this.isattback = 50;
         this.attackRange = 450;
         this.def = 25;
         this.exp = 500;
         this.gxp = 500;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,-2],
            "AttackInterval":4,
            "power":150,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit1-1"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[2,-5],
            "AttackInterval":999,
            "power":150,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[5,-5],
            "AttackInterval":999,
            "power":300,
            "attackKind":"physics"
         };
         this.isFly = true;
         this.graity = 0;
         this.isBoss = false;
         this.directChangeTime = (1 + 2 * Math.random()) * 24;
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
                  if(this.count % 24 == 0)
                  {
                     if(this.randomNum(isattback))
                     {
                        this.attackTarget();
                        this.setThisBackTime();
                     }
                     else if(this.skillCD1 == 0)
                     {
                        this.releSkill1();
                        this.skillCD1 = 96;
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
      
      override protected function releSkill1() : void
      {
         this.setYourFather(30);
         this.lastHit = "hit2";
         this.curAction = "hit2";
         var _loc1_:SpecialEffectBullet = new SpecialEffectBullet("Monster18Bullet2");
         _loc1_.y = this.y;
         _loc1_.x = this.x;
         _loc1_.setRole(this);
         _loc1_.setAction("hit2");
         gc.gameSence.addChild(_loc1_);
         this.magicBulletArray.push(_loc1_);
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.visible)
         {
            return;
         }
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
         if(this.curAction == "hit1")
         {
            if(!this.body.stick)
            {
               return;
            }
            if(!this.curAttackTarget)
            {
               return;
            }
            if(this.curAttackTarget.isYourFather)
            {
               return;
            }
            if(HitTest.complexHitTestObject(this,this.curAttackTarget.colipse))
            {
               this.showHit1(this.curAttackTarget.x - 100,this.curAttackTarget.y - 100);
               this.curAction = "wait";
               this.gotoAndStop("wait");
            }
         }
      }
      
      public function dohit2Pre() : void
      {
         this.visible = false;
         this.setStatic();
         var _loc1_:MovieClip = AUtils.getNewObj("Monster18Bullet2Pre");
         _loc1_.addEventListener(Event.ENTER_FRAME,this.__enter);
         _loc1_.x = this.curAttackTarget.x;
         _loc1_.y = 510;
         gc.gameSence.addChild(_loc1_);
      }
      
      function __enter(param1:Event) : void
      {
         if(gc.isStopGame)
         {
            MovieClip(param1.currentTarget).stop();
         }
         else
         {
            MovieClip(param1.currentTarget).play();
         }
         if(MovieClip(param1.currentTarget).currentFrame == MovieClip(param1.currentTarget).totalFrames)
         {
            this.dohit2(MovieClip(param1.currentTarget).x,MovieClip(param1.currentTarget).y);
         }
      }
      
      public function dohit2(param1:Number, param2:Number) : void
      {
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Monster18Bullet2");
         _loc3_.y = param2;
         _loc3_.x = param1;
         _loc3_.setRole(this);
         _loc3_.setAction("hit2");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
         this.visible = true;
      }
      
      private function showHit1(param1:Number, param2:Number) : void
      {
         if(!this.body.stick)
         {
            return;
         }
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Monster18Bullet1");
         _loc3_.y = param2;
         _loc3_.x = param1;
         _loc3_.setRole(this);
         _loc3_.setAction("hit1-1");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
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
         return Math.abs(this.x - this.curAttackTarget.x) > 250 || Math.abs(this.y - this.curAttackTarget.y) > 50;
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
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2";
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
      }
   }
}
