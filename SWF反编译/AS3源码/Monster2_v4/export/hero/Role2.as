package export.hero
{
   import base.*;
   import com.greensock.*;
   import config.*;
   import event.CommonEvent;
   import export.*;
   import export.bullet.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import manager.*;
   import my.*;
   
   public class Role2 extends BaseHero
   {
       
      
      public var hit2Count:int = 0;
      
      public var hit2NeedCount:int = 30;
      
      public var shadow:Role2Shadow;
      
      public function Role2()
      {
         super();
         roleName = "唐僧";
         userType = "法师";
         this.horizenSpeed = 6;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[4,-7],
            "attackInterval":4,
            "attackRange":60,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":200,
            "attackBackSpeed":[20,-5],
            "attackInterval":4,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":200,
            "attackBackSpeed":[6,-7],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":200,
            "attackBackSpeed":[25,-5],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4-1"] = {
            "hitMaxCount":200,
            "attackBackSpeed":[25,-5],
            "attackInterval":999,
            "attackKind":"magic"
         };
         this.exceedPowerSprite = new ExceedPower(this.width,9,this.hit2NeedCount);
         this.exceedPowerSprite.x = this.x - this.width / 2;
         this.exceedPowerSprite.y = this.y - this.height / 2 - 30;
         this.addChild(this.exceedPowerSprite);
         this.Hp = 100;
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
         gc.eventManger.addEventListener("cureRole",this.__cureRole);
      }
      
      override protected function __removed(param1:Event) : void
      {
         gc.eventManger.removeEventListener("cureRole",this.__cureRole);
      }
      
      public function doMagicAttack(param1:String, param2:int, param3:int, param4:Point, param5:String) : void
      {
         var _loc6_:EnemyMoveBullet;
         (_loc6_ = new EnemyMoveBullet(param1)).x = this.x;
         _loc6_.y = this.y;
         _loc6_.setRole(this);
         _loc6_.setSpeed(param2);
         _loc6_.setDistance(param3);
         _loc6_.setScale(param4.x,param4.y);
         _loc6_.setAction(param5);
         gc.gameSence.addChild(_loc6_);
         this.magicBulletArray.push(_loc6_);
      }
      
      override public function step() : void
      {
         super.step();
         if(this.curAction == "hit2")
         {
            if(this.body.currentFrame == 1)
            {
               ++this.hit2Count;
            }
         }
         else
         {
            this.hit2Count = 0;
         }
         if(this.hit2Count > this.hit2NeedCount)
         {
            this.hit2Count = this.hit2NeedCount;
         }
         this.exceedPowerSprite.step(this.hit2Count,this.transform.matrix.a);
         if(this.body)
         {
            this.setEquips(this.body);
         }
      }
      
      public function setEquips(param1:MovieClip) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc2_:MovieClip = param1;
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.numChildren)
            {
               if((_loc4_ = _loc2_.getChildAt(_loc3_)) is MovieClip)
               {
                  if(_loc4_.name == "bodyEquip")
                  {
                     if(this.curClothId > 3)
                     {
                        _loc4_.visible = false;
                        _loc4_.stop();
                     }
                     else
                     {
                        if(_loc4_.currentFrame != this.curClothId)
                        {
                           _loc4_.gotoAndStop(this.curClothId);
                        }
                        _loc4_.visible = true;
                     }
                  }
                  else
                  {
                     this.setEquips(_loc4_);
                  }
               }
               _loc3_++;
            }
         }
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
                  if(this.isAttacking() || this.isBeAttacking())
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
      
      public function judgexq() : Boolean
      {
         return this.getPlayer().isstudyskill[0] == 1;
      }
      
      public function __cureRole(param1:CommonEvent) : void
      {
         var _loc4_:int = 0;
         var _loc6_:BaseHero = null;
         var _loc2_:Point = param1.data[0] as Point;
         var _loc3_:Array = gc.getPlayerArray();
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_.length)
         {
            if((_loc6_ = BaseHero(_loc3_[_loc5_])) != this)
            {
               if(gc.gameMode != Config.MODE3)
               {
                  if(Math.abs(_loc6_.x - _loc2_.x) <= 200 && Math.abs(_loc6_.y - _loc2_.y) <= 200)
                  {
                     _loc4_ = this.getRealPower("hit5");
                     if(!_loc6_.isDead())
                     {
                        _loc6_.cureHp(_loc4_);
                     }
                  }
               }
            }
            else
            {
               _loc4_ = this.getRealPower("hit5");
               if(!this.isDead())
               {
                  this.cureHp(_loc4_);
               }
            }
            _loc5_++;
         }
      }
      
      override protected function showSkillL() : void
      {
         var _loc1_:SpecialEffectBullet = null;
         if(this.isInSky())
         {
            return;
         }
         if(this.getPlayer().isstudyskill[4] != 1)
         {
            return;
         }
         if(this.curAction == "hit4" && this.body && this.body.roundMc && this.body.contains(this.body.roundMc))
         {
            _loc1_ = new SpecialEffectBullet("hit4FallDown");
            _loc1_.setRole(this);
            this.lastHit = "hit4-1";
            _loc1_.setAction("hit4-1");
            if(this.transform.matrix.a == 1)
            {
               _loc1_.x = this.x + this.body.roundMc.x;
            }
            else
            {
               _loc1_.x = this.x - this.body.roundMc.x;
            }
            _loc1_.y = this.y + this.body.roundMc.y - 300;
            gc.gameSence.addChild(_loc1_);
            this.body.roundMc.stop();
            this.body.removeChild(this.body.roundMc);
            this.body.gotoAndPlay(43);
         }
         else
         {
            if(this.isAttacking() || this.isBeAttacking())
            {
               return;
            }
            if(this.roleProperies.getMMP() >= 100)
            {
               this.lastHit = "hit4";
               this.curAction = "hit4";
               this.newAttackId();
               this.roleProperies.setMMP(this.roleProperies.getMMP() - 100);
            }
         }
      }
      
      override protected function showSkillU() : void
      {
         if(this.getPlayer().isstudyskill[1] != 1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         if(this.roleProperies.getMMP() >= 40)
         {
            this.lastHit = "hit3";
            this.curAction = "hit3";
            if(this.shadow)
            {
               this.shadow.doHit3();
               this.shadow = null;
            }
            this.roleProperies.setMMP(this.roleProperies.getMMP() - 40);
         }
      }
      
      override public function levelClear() : void
      {
         super.levelClear();
         if(this.shadow)
         {
            this.shadow.destroy();
            this.shadow = null;
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         gc.eventManger.removeEventListener("cureRole",this.__cureRole);
      }
      
      override protected function showSkillI() : void
      {
         var _loc1_:Role2Shadow = null;
         if(this.getPlayer().isstudyskill[2] != 1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         if(this.shadow)
         {
            SoundManager.play("Role2_hit6");
            this.x = this.shadow.x;
            this.y = this.shadow.y;
            this.shadow.destroy();
            this.shadow = null;
         }
         else if(this.roleProperies.getMMP() >= 30)
         {
            SoundManager.play("Role2_hit6");
            _loc1_ = new Role2Shadow();
            if(this.transform.matrix.a == 1)
            {
               _loc1_.isLeft = true;
               AUtils.flipHorizontal(_loc1_,1);
            }
            else
            {
               _loc1_.isRight = true;
               AUtils.flipHorizontal(_loc1_,-1);
            }
            _loc1_.x = this.x;
            _loc1_.y = this.y;
            gc.gameSence.addChild(_loc1_);
            gc.otherList.push(_loc1_);
            this.shadow = _loc1_;
            _loc1_.setSource(this);
            this.roleProperies.setMMP(this.roleProperies.getMMP() - 30);
         }
      }
      
      override protected function showSkillO() : void
      {
         if(this.getPlayer().isstudyskill[3] != 1)
         {
            return;
         }
         if(this.isAttacking() || this.isBeAttacking())
         {
            return;
         }
         if(this.roleProperies.getMMP() >= 60)
         {
            this.doHit5Effect();
            SoundManager.play("Role2_hit5");
            this.lastHit = "hit5";
            this.curAction = "hit5";
            if(this.shadow)
            {
               SoundManager.play("Role2_hit5");
               this.shadow.doHit5();
               this.shadow = null;
            }
            this.roleProperies.setMMP(this.roleProperies.getMMP() - 60);
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
      
      public function doHit5Effect() : void
      {
         var _loc1_:MovieClip = AUtils.getNewObj("cureRoleMc");
         _loc1_.x = this.x;
         _loc1_.y = this.y - 60;
         if(this.isGXP)
         {
            _loc1_.scaleX = 1.6;
            _loc1_.scaleY = 1.6;
         }
         gc.gameSence.addChild(_loc1_);
      }
      
      public function SpecialAttack() : void
      {
         SoundManager.play("Role2_hit3");
         var _loc1_:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet3");
         _loc1_.x = this.x;
         _loc1_.y = this.y;
         _loc1_.setRole(this);
         if(this.isGXP)
         {
            _loc1_.setScale(1.8,1.8);
         }
         _loc1_.setAction(this.lastHit);
         gc.gameSence.addChild(_loc1_);
         this.magicBulletArray.push(_loc1_);
      }
      
      override public function normalHit() : *
      {
         this.curtime = getTimer();
         if(this.timers <= 0)
         {
            this.timers = 18;
            this.newAttackId();
            this.hitNum = 1;
            this.curAction = "hit1";
            this.lastHit = "hit1";
            SoundManager.play("Role2_hit1");
         }
         this.lasttime = this.curtime;
      }
      
      override public function __keyBoardDown(param1:KeyboardEvent) : void
      {
         super.__keyBoardDown(param1);
      }
      
      override public function __keyBoardUp(param1:KeyboardEvent) : void
      {
         super.__keyBoardUp(param1);
         if(param1.keyCode == gc.keyboardControl.getNormalAttackKeyCodeByPlayer(this.player))
         {
            if(this.curAction == "hit2")
            {
               this.body.play();
            }
         }
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
            this.roleProperies.setSHHP((50 + 20 * (this.roleProperies.getLevel() - 1)) * 500);
         }
         else
         {
            this.roleProperies.setSHHP(50 + 20 * (this.roleProperies.getLevel() - 1));
         }
         this.roleProperies.setHHP(this.roleProperies.getSHHP());
         this.roleProperies.setSMMP(100 + 40 * (this.roleProperies.getLevel() - 1));
         this.roleProperies.setMMP(this.roleProperies.getSMMP());
         this.roleProperies.baselowerpower = 12;
         this.roleProperies.baseuppower = 12;
         this.roleProperies.baseadd = 8;
         this.roleProperies.setPower(12 + 8 * (this.roleProperies.getLevel() - 1));
         this.roleProperies.setDefense(this.roleProperies.getLevel() - 1);
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
               return this.roleProperies.getPower() * _loc2_;
            case "hit2":
               return this.roleProperies.getPower() / 5 * _loc2_;
            case "hit3":
               return this.roleProperies.getPower() * 0.8 * _loc2_;
            case "hit4":
               return this.roleProperies.getPower() * 2 * _loc2_;
            case "hit4-1":
               return 8 * this.roleProperies.getPower() * _loc2_;
            case "hit5":
               return (this.roleProperies.getSMMP() / 8 + 8) * _loc2_;
            default:
               return 0;
         }
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" && this.jumpCount == 0 || this.curAction == "hit2" && this.jumpCount == 0 || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit3" || this.curAction == "hit5";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      override public function isNormalHit() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2";
      }
   }
}
