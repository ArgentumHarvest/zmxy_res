package export.hero
{
   import base.*;
   import com.greensock.*;
   import com.hexagonstar.util.debug.*;
   import config.*;
   import export.*;
   import export.bullet.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.geom.Rectangle;
   import flash.utils.*;
   import manager.*;
   
   public class Role1 extends BaseHero
   {
       
      
      public function Role1()
      {
         super();
         roleName = "孙悟空";
         userType = "战士";
         this.horizenSpeed = 6;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":4,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":4,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":4,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0.5,-3],
            "attackInterval":4,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[25,-4],
            "attackInterval":4,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit6"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[35,-2],
            "attackInterval":5,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit7"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,-2],
            "attackInterval":4,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit8"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[2,-22],
            "attackInterval":2,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit9"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[20,-2],
            "attackInterval":2,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10-1"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[2,-3],
            "attackInterval":999,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit10-2"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[40,-15],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit10-3"] = {
            "hitMaxCount":100,
            "attackBackSpeed":[40,25],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.curClothId = 1;
         this.curWeaponId = 1;
      }
      
      override protected function __added(param1:Event) : void
      {
         super.__added(param1);
         this.initPopertits();
         this.keyarray = gc.keyboardControl.getZeroKeyArray();
         if(gc.gameMode != 3)
         {
            this.curAddEffect.add([{
               "name":"father",
               "time":24 * 2,
               "interval":1000,
               "isForever":1
            }]);
         }
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override protected function myKeyDown(param1:String) : *
      {
         var keyStr:String = param1;
         super.myKeyDown(keyStr);
         if(cannextaction)
         {
            switch(keyStr)
            {
               case "0010":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  this.jump();
                  cannextaction = false;
                  break;
               case "0100":
               case "1100":
                  if(this.isBeAttacking())
                  {
                     return;
                  }
                  this.normalHit();
                  cannextaction = false;
                  break;
               case "1010":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  this.getFallDown();
                  cannextaction = false;
                  break;
               case "0110":
                  if(this.isAttacking() || this.isBeAttacking())
                  {
                     return;
                  }
                  cannextaction = false;
                  break;
               case "0101":
                  if(this.getPlayer().isstudyskill[0] != 1)
                  {
                     return;
                  }
                  if(!this.isAttackingButCanAttack() && (this.isAttacking() || this.isBeAttacking()))
                  {
                     return;
                  }
                  if(this.roleProperies.getMMP() >= 10)
                  {
                     SoundManager.play("Role1_hit8");
                     this.lastHit = "hit8";
                     this.curAction = "hit8";
                     this.hitNum = 0;
                     this.timers = 21;
                     this.roleProperies.setMMP(this.roleProperies.getMMP() - 10);
                     this.newAttackId();
                     if(this.jumpCount == 1)
                     {
                        this.jumpCount = 2;
                     }
                  }
                  else
                  {
                     this.normalHit();
                     cannextaction = false;
                  }
                  break;
               case "0001":
                  if(!gc.isLevelClear && this.checkTransferDoor())
                  {
                     gc.isLevelClear = true;
                     gc.keyboardControl.destroy();
                     TweenMax.to(gc.gameInfo,1,{"alpha":0});
                     TweenMax.to(gc.gameSence,1,{
                        "alpha":0,
                        "onComplete":function():*
                        {
                           gc.eventManger.dispatchEvent(new Event("LevelClear"));
                        }
                     });
                  }
            }
         }
      }
      
      override public function beAttackDoing() : void
      {
         if(!this.isGXP)
         {
            if(!this.isBeAttacking())
            {
               this.curAction = "hurt";
               this.doubleCount = 0;
            }
            else if(this.body)
            {
               this.body.gotoAndPlay(1);
            }
         }
         this.resetGraity();
         this.addBeAttackEffect(null);
         this.curAddEffect.updateFather();
      }
      
      override protected function showSkillL() : void
      {
      }
      
      override protected function showSkillU() : void
      {
         if(this.getPlayer().isstudyskill[2] != 1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         if(this.roleProperies.getMMP() >= 30)
         {
            SoundManager.play("Role1_hit7");
            this.lastHit = "hit7";
            this.curAction = "hit7";
            this.hitNum = 0;
            this.timers = 12;
            this.newAttackId();
            this.roleProperies.setMMP(this.roleProperies.getMMP() - 30);
         }
      }
      
      override protected function showSkillI() : void
      {
         if(this.getPlayer().isstudyskill[3] != 1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         if(this.roleProperies.getMMP() >= 40)
         {
            SoundManager.play("Role1_hit9");
            this.lastHit = "hit9";
            this.curAction = "hit9";
            this.hitNum = 0;
            this.timers = 10;
            this.roleProperies.setMMP(this.roleProperies.getMMP() - 40);
            if(this.jumpCount == 1)
            {
               this.jumpCount = 2;
            }
         }
      }
      
      override protected function showSkillO() : void
      {
         if(this.getPlayer().isstudyskill[4] != 1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         if(this.roleProperies.getMMP() >= 50)
         {
            SoundManager.play("Role1_hit10_1");
            this.lastHit = "hit10";
            this.curAction = "hit10";
            this.hitNum = 0;
            this.timers = 7;
            this.setYourFather(70);
            this.roleProperies.setMMP(this.roleProperies.getMMP() - 50);
         }
      }
      
      override protected function showSkillKongGe() : void
      {
         var _loc1_:RoleInfo = gc.gameInfo.getRoleInfoByPlayer(this.player) as RoleInfo;
         if(_loc1_.isGXPReady() && !this.isGXP)
         {
            this.turnToGXP();
         }
      }
      
      override public function normalHit() : *
      {
         this.curtime = getTimer();
         if(this.timers <= 0)
         {
            if(!this.isInSky())
            {
               if(!this.isRunning() && (!this.isAttacking() || this.isNormalHit()))
               {
                  if(this.hitNum == 4)
                  {
                     this.timers = 18;
                  }
                  else if(this.hitNum == 3)
                  {
                     this.timers = 15;
                  }
                  else
                  {
                     this.timers = 8;
                  }
                  if(this.curtime - this.lasttime > 1000)
                  {
                     this.hitNum = 1;
                  }
                  else if(++this.hitNum > 5)
                  {
                     this.hitNum = 1;
                  }
                  if(this.hitNum <= 2)
                  {
                     SoundManager.play("Role1_hit1AndHit2");
                  }
                  else if(this.hitNum <= 4)
                  {
                     SoundManager.play("Role1_hit3AndHit4");
                  }
                  else
                  {
                     SoundManager.play("Role1_hit5");
                  }
                  this.curAction = "hit" + this.hitNum;
                  this.lastHit = "hit" + this.hitNum;
                  this.newAttackId();
               }
               else if(this.isRunning() && !this.isAttacking())
               {
                  if(this.getPlayer().isstudyskill[1] != 1)
                  {
                     this.doubleCount = 0;
                     this.normalHit();
                  }
                  else
                  {
                     this.runAttack();
                  }
               }
            }
            else
            {
               this.timers = 15;
               this.lastHit = "hit3";
               this.curAction = "hit3";
               this.hitNum = 0;
               SoundManager.play("Role1_hit3AndHit4");
               this.newAttackId();
            }
         }
         this.lasttime = this.curtime;
      }
      
      public function addHit10Pre() : void
      {
         var _loc1_:MovieClip = AUtils.getNewObj("Hit10Pre");
         _loc1_.x = this.x;
         _loc1_.y = this.y + 20;
         AUtils.flipHorizontal(_loc1_,-this.transform.matrix.a);
         gc.gameSence.addChild(_loc1_);
      }
      
      public function addHit10Flush() : void
      {
         var _loc1_:SpecialEffectBullet = new SpecialEffectBullet("hit10Flush");
         _loc1_.setRole(this);
         this.lastHit = "hit10-3";
         _loc1_.setAction("hit10-3");
         _loc1_.x = this.x;
         _loc1_.y = this.y;
         AUtils.flipHorizontal(_loc1_,-this.transform.matrix.a);
         gc.gameSence.addChild(_loc1_);
      }
      
      public function addHit10And1() : void
      {
         var _loc1_:Array = null;
         var _loc3_:BaseObject = null;
         var _loc4_:Rectangle = null;
         var _loc5_:SpecialEffectBullet = null;
         if(gc.gameMode != 3)
         {
            _loc1_ = gc.pWorld.monsterArray;
         }
         else
         {
            _loc1_ = gc.pWorld.heroArray;
         }
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as BaseObject;
            if(_loc3_ != this)
            {
               if((_loc4_ = _loc3_.colipse.getBounds(gc.gameSence.parent)).x < 920 && _loc4_.x > 20 && AUtils.GetDisBetweenTwoObj(_loc3_,this) <= 130)
               {
                  (_loc5_ = new SpecialEffectBullet("Hit10And1")).setRole(this);
                  SoundManager.play("Role1_hit10_2");
                  this.lastHit = "hit10-1";
                  _loc5_.setAction("hit10-1");
                  _loc5_.x = _loc3_.x;
                  _loc5_.y = _loc3_.y;
                  gc.gameSence.addChild(_loc5_);
                  this.x = _loc3_.x;
                  this.y = _loc3_.y;
                  this.timers = 40;
                  return;
               }
            }
            _loc2_++;
         }
         this.body.gotoAndPlay(47);
      }
      
      public function addHit10And2() : void
      {
         var _loc1_:SpecialEffectBullet = new SpecialEffectBullet("Hit10And2");
         _loc1_.setRole(this);
         SoundManager.play("Role1_hit10_3");
         this.lastHit = "hit10-2";
         _loc1_.setAction("hit10-2");
         if(!this.isGXP)
         {
            _loc1_.setScale(2,2);
         }
         else
         {
            _loc1_.setScale(3,3);
         }
         _loc1_.x = this.x;
         _loc1_.y = this.y;
         this.timers = 13;
         gc.gameSence.addChild(_loc1_);
      }
      
      public function addFireEffect() : void
      {
         var _loc1_:MovieClip = AUtils.getNewObj("hit7Fire");
         _loc1_.x = this.x;
         _loc1_.y = this.y;
         AUtils.flipHorizontal(_loc1_,this.transform.matrix.a);
         gc.gameSence.addChild(_loc1_);
         this.speed.x = this.transform.matrix.a == 1 ? Number(-45) : Number(45);
         this.setYourFather(12);
      }
      
      override public function isNormalHit() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      private function runAttack() : void
      {
         if(!this.isInSky())
         {
            if(this.roleProperies.getMMP() >= 20)
            {
               SoundManager.play("Role1_hit6");
               this.hitNum = 1;
               this.doubleCount = 0;
               this.lastHit = "hit6";
               this.curAction = "hit6";
               this.newAttackId();
               this.roleProperies.setMMP(this.roleProperies.getMMP() - 20);
            }
            else
            {
               this.doubleCount = 0;
               this.normalHit();
            }
         }
      }
      
      override public function __keyBoardDown(param1:KeyboardEvent) : void
      {
         super.__keyBoardDown(param1);
      }
      
      override public function __keyBoardUp(param1:KeyboardEvent) : void
      {
         super.__keyBoardUp(param1);
      }
      
      override public function upGrade(param1:int = 1) : *
      {
         if(!this.isfirstinit)
         {
            this.roleProperies.destory();
         }
         this.isfirstinit = false;
         if(gc.gameMode == Config.MODE3)
         {
            this.roleProperies.setSHHP((80 + 50 * (this.roleProperies.getLevel() - 1)) * 500);
         }
         else
         {
            this.roleProperies.setSHHP(80 + 50 * (this.roleProperies.getLevel() - 1));
         }
         this.roleProperies.setHHP(this.roleProperies.getSHHP());
         this.roleProperies.setSMMP(50 + 20 * (this.roleProperies.getLevel() - 1));
         this.roleProperies.setMMP(this.roleProperies.getSMMP());
         this.roleProperies.baselowerpower = 10;
         this.roleProperies.baseuppower = 14;
         this.roleProperies.baseadd = 5;
         this.roleProperies.setPower(10 + Math.round(Math.random() * 4) + 5 * (this.roleProperies.getLevel() - 1));
         Debug.trace("===========getLevel:" + this.roleProperies.getLevel());
         if(this.roleProperies.getLevel() < 15)
         {
            this.roleProperies.setDefense(2 + 2 * (this.roleProperies.getLevel() - 1));
         }
         else
         {
            this.roleProperies.setDefense(2 + 2 * (14 - 1) + (this.roleProperies.getLevel() - 14) * 5);
         }
         Debug.trace("----defence:" + this.roleProperies.getDefense());
         if(this.roleProperies.getLevel() <= 19)
         {
            this.roleProperies.setexp(this.levelexp[this.roleProperies.getLevel() - 1]);
         }
         else
         {
            this.roleProperies.setexp(5000 + (this.roleProperies.getLevel() - 19) * 5000);
         }
         this.roleProperies.initAll();
      }
      
      override public function getRealPower(param1:String) : int
      {
         if(gc.isYourFather)
         {
            return 999999;
         }
         var _loc2_:Number = 1;
         if(this.isGXP)
         {
            _loc2_ = 1.5;
         }
         switch(param1)
         {
            case "hit1":
            case "hit2":
            case "hit3":
            case "hit4":
            case "hit5":
               return this.roleProperies.getPower() * _loc2_;
            case "hit6":
               return Math.round(this.roleProperies.getPower() * 0.5) * _loc2_;
            case "hit7":
               return 100 * _loc2_;
            case "hit8":
               return this.roleProperies.getPower() * 2 * _loc2_;
            case "hit9":
               return Math.round(this.roleProperies.getPower() * 1.2) * _loc2_;
            case "hit10-1":
               return Math.round(this.roleProperies.getPower()) * _loc2_;
            case "hit10-2":
               return Math.round(this.roleProperies.getPower()) * 3 * _loc2_;
            case "hit10-3":
               return Math.round(this.roleProperies.getPower()) * _loc2_;
            default:
               return 0;
         }
      }
      
      private function isAttackingButCanAttack() : Boolean
      {
         return (this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4") && this.body.currentFrame / this.body.totalFrames >= 0.7;
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" && this.jumpCount == 0 || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit9" || this.curAction == "hit10";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6" || this.curAction == "hit7" || this.curAction == "hit8" || this.curAction == "hit9" || this.curAction == "hit10";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit6" || this.curAction == "hit7";
      }
   }
}
