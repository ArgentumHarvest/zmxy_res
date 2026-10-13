package export.monster
{
   import base.BaseMonster;
   import export.bullet.*;
   import flash.display.*;
   import flash.events.*;
   import my.*;
   
   public class Monster19 extends BaseMonster
   {
       
      
      private var isFirstLowHp:Boolean = true;
      
      private var baby:BaseMonster;
      
      public function Monster19()
      {
         super();
         this.isBoss = true;
         this.monsterName = "鲨魔王";
         this.horizenSpeed = 3;
         this.Hp = sHp = 48000;
         this.mysee = 300;
         this.isattback = 50;
         this.attackRange = 150;
         this.def = 90;
         this.exp = 300;
         this.gxp = 100;
         this.attackBackInfoDict["hit1-1"] = {
            "hitMaxCount":2,
            "attackBackSpeed":[6,-5],
            "attackInterval":4,
            "power":150,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit1-2"] = {
            "hitMaxCount":2,
            "attackBackSpeed":[6,-5],
            "attackInterval":4,
            "power":150,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2-1"] = {
            "hitMaxCount":30,
            "attackBackSpeed":[2,-7],
            "attackInterval":4,
            "power":130,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2-2"] = {
            "hitMaxCount":30,
            "attackBackSpeed":[2,-7],
            "attackInterval":4,
            "power":130,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":30,
            "attackBackSpeed":[2,-7],
            "attackInterval":999,
            "power":100,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3-1"] = {
            "hitMaxCount":40,
            "attackBackSpeed":[15,0],
            "attackInterval":4,
            "power":250,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3-2"] = {
            "hitMaxCount":40,
            "attackBackSpeed":[15,0],
            "attackInterval":4,
            "power":250,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":40,
            "attackBackSpeed":[15,0],
            "attackInterval":999,
            "power":300,
            "attackKind":"magic"
         };
         this.probability = 0.15;
         this.fallList = [{
            "name":"xhxh",
            "bigtype":"zb"
         },{
            "name":"xhmj",
            "bigtype":"zb"
         }];
         this.curAction = "wait1";
      }
      
      public function doHit2() : void
      {
         var _loc1_:SpecialEffectBullet = new SpecialEffectBullet("Monster19Bullet1");
         if(this.transform.matrix.a == 1)
         {
            _loc1_.x = this.x + 600;
         }
         else
         {
            _loc1_.x = this.x - 600;
         }
         _loc1_.y = this.y - 40;
         _loc1_.setRole(this);
         _loc1_.setAction("hit2");
         gc.gameSence.addChild(_loc1_);
         this.magicBulletArray.push(_loc1_);
      }
      
      public function doHit3Pre() : void
      {
         var _loc1_:MovieClip = AUtils.getNewObj("Monster19Bullet2Pre");
         _loc1_.x = this.curAttackTarget.x - 100;
         _loc1_.y = this.curAttackTarget.y - 100;
         gc.gameSence.addChild(_loc1_);
         _loc1_.addEventListener(Event.ENTER_FRAME,this.__enterFrame);
      }
      
      private function __enterFrame(param1:Event) : void
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
            this.doHit3(MovieClip(param1.currentTarget).x,MovieClip(param1.currentTarget).y);
            MovieClip(param1.currentTarget).removeEventListener(Event.ENTER_FRAME,this.__enterFrame);
         }
      }
      
      public function doHit3(param1:Number, param2:Number) : void
      {
         var _loc3_:SpecialEffectBullet = new SpecialEffectBullet("Monster19Bullet2");
         _loc3_.x = param1;
         _loc3_.y = param2;
         _loc3_.setRole(this);
         _loc3_.setAction("hit3");
         gc.gameSence.addChild(_loc3_);
         this.magicBulletArray.push(_loc3_);
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
         if(this.isFirstLowHp)
         {
            if(this.isLowHp())
            {
               this.baby = MainGame.getInstance().createMonster(18,this.x,this.y);
               this.isFirstLowHp = false;
            }
         }
      }
      
      override public function isWalkOrRun() : Boolean
      {
         return this.curAction == "walk1" || this.curAction == "walk2";
      }
      
      override protected function moveRorL(param1:uint) : *
      {
         if(this.randomNum(param1))
         {
            this.moveLeft();
         }
         else
         {
            this.moveRight();
         }
         if(!this.isLowHp())
         {
            this.curAction = "walk1";
         }
         else
         {
            this.curAction = "walk2";
         }
      }
      
      override public function iswor() : *
      {
         if(!this.isLowHp())
         {
            this.curAction = "walk1";
         }
         else
         {
            this.curAction = "walk2";
         }
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
                     this.skillCD1 = 360;
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
                     this.skillCD2 = 480;
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
      
      public function isLowHp() : Boolean
      {
         return this.Hp / this.sHp < 0.7;
      }
      
      override protected function releSkill1() : void
      {
         this.setYourFather(18);
         this.newAttackId();
         if(!this.isLowHp())
         {
            this.lastHit = "hit3-1";
            this.curAction = "hit3-1";
         }
         else
         {
            this.lastHit = "hit3-2";
            this.curAction = "hit3-2";
         }
      }
      
      override protected function releSkill2() : void
      {
         this.setYourFather(20);
         this.newAttackId();
         if(!this.isLowHp())
         {
            this.lastHit = "hit2-1";
            this.curAction = "hit2-1";
         }
         else
         {
            this.lastHit = "hit2-2";
            this.curAction = "hit2-2";
         }
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1-1" || this.curAction == "hit2-1" || this.curAction == "hit3-1" || this.curAction == "hit1-2" || this.curAction == "hit2-2" || this.curAction == "hit3-2";
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
         if(this.baby)
         {
            this.baby.destroy();
         }
      }
      
      override protected function attackTarget() : void
      {
         this.newAttackId();
         if(!this.isLowHp())
         {
            this.curAction = "hit1-1";
            this.lastHit = "hit1-1";
         }
         else
         {
            this.curAction = "hit1-2";
            this.lastHit = "hit1-2";
         }
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
