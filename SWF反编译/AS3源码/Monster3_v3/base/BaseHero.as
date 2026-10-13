package base
{
   import com.greensock.*;
   import com.hexagonstar.util.debug.*;
   import config.*;
   import event.*;
   import export.*;
   import export.hero.*;
   import flash.display.*;
   import flash.events.KeyboardEvent;
   import flash.filters.*;
   import flash.utils.*;
   import manager.*;
   import my.*;
   import user.User;
   
   public class BaseHero extends BaseObject
   {
       
      
      public var isfirstinit:Boolean = true;
      
      public var csmc:MovieClip;
      
      public var curClothId:int;
      
      public var curWeaponId:int;
      
      public var dxmc:MovieClip;
      
      public var hlmc:MovieClip;
      
      public var isRole:MovieClip;
      
      public var levelexp:Array;
      
      public var levelupmc:MovieClip;
      
      public var roleName:String = "";
      
      public var roleProperies:BaseRoleProperies;
      
      public var userType:String = "";
      
      protected var cannextaction:Boolean = true;
      
      protected var curUpTime:int;
      
      protected var curtime:int = 0;
      
      public var doubleCount:uint;
      
      protected var exceedPowerSprite:ExceedPower;
      
      protected var hitNum:uint = 1;
      
      protected var keyId:int;
      
      protected var keyList:Array;
      
      protected var keyarray:Array;
      
      protected var lastDirbtn:uint;
      
      protected var lastKey:Object;
      
      protected var lastUpTime:int;
      
      protected var lasttime:int = 0;
      
      protected var player:User;
      
      protected var timers:int = 0;
      
      protected var curAddEffect:BaseAddEffect;
      
      public function BaseHero()
      {
         this.levelexp = [135,145,155,165,175,185,625,675,725,775,825,875,1950,2050,2150,2250,2350,2450,5000];
         this.keyList = [];
         this.lastKey = new Object();
         super();
         this.curAddEffect = new BaseAddEffect(BaseObject(this));
         this.roleProperies = new BaseRoleProperies(this);
         try
         {
            this.gotoAndStop("wait");
         }
         catch(e:*)
         {
         }
      }
      
      public function __keyBoardDown(param1:KeyboardEvent) : void
      {
         if(!gc.keyboardControl.isInThisPlayerKeyboard(this.player,param1.keyCode))
         {
            return;
         }
         if(this.lastKey.keyCode == undefined)
         {
            this.lastKey.keyCode = param1.keyCode;
         }
         if(this.lastKey.keyId == undefined)
         {
            this.lastKey.keyId = this.keyId;
         }
         if(param1.keyCode != this.lastKey.keyCode)
         {
            ++this.keyId;
         }
         switch(param1.keyCode)
         {
            case gc.keyboardControl.getLeftByPlayer(this.player):
               moveLeft();
               this.addDoubleCount(param1.keyCode);
               this.lastDirbtn = param1.keyCode;
               break;
            case gc.keyboardControl.getRightByPlayer(this.player):
               moveRight();
               this.addDoubleCount(param1.keyCode);
               this.lastDirbtn = param1.keyCode;
         }
         this.checkDoubleCount(param1.keyCode);
         this.lastKey.keyCode = param1.keyCode;
         this.lastKey.keyId = this.keyId;
         var _loc2_:uint = this.keyList.length;
         while(_loc2_-- > 0)
         {
            if(this.keyList[_loc2_] == param1.keyCode)
            {
               this.keyarray[_loc2_] = 1;
            }
         }
         if(!this.isBeAttacking() && !this.isAttacking() && !this.isJump() && !this.isStatic())
         {
            if(this.isRunning())
            {
               this.curAction = "run";
            }
            else
            {
               this.curAction = "walk";
            }
         }
      }
      
      public function initPopertits() : void
      {
         this.upGrade(this.roleProperies.getLevel());
         this.setShowEquip();
      }
      
      public function cureHp(param1:int) : void
      {
         if(!this.isDead())
         {
            this.roleProperies.setHHP(this.roleProperies.getHHP() + param1);
            this.addCureMc(param1);
         }
      }
      
      override public function reduceHp(param1:int) : void
      {
         this.roleProperies.setHHP(this.roleProperies.getHHP() - param1);
         this.addHeroHurtMc(param1);
      }
      
      public function sendSkill(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               this.showSkillL();
               break;
            case 1:
               this.showSkillU();
               break;
            case 2:
               this.showSkillI();
               break;
            case 3:
               this.showSkillO();
               break;
            case 4:
               this.showSkillKongGe();
         }
      }
      
      protected function showSkillL() : void
      {
      }
      
      protected function showSkillU() : void
      {
      }
      
      protected function showSkillI() : void
      {
      }
      
      protected function showSkillO() : void
      {
      }
      
      protected function showSkillKongGe() : void
      {
      }
      
      public function __keyBoardUp(param1:KeyboardEvent) : void
      {
         if(!gc.keyboardControl.isInThisPlayerKeyboard(this.player,param1.keyCode))
         {
            return;
         }
         if(param1.keyCode == this.lastKey.keyCode)
         {
            ++this.keyId;
         }
         switch(param1.keyCode)
         {
            case gc.keyboardControl.getLeftByPlayer(this.player):
               stopMoveLeft();
               if(this.lastDirbtn == param1.keyCode)
               {
                  this.lastDirbtn = 0;
               }
               this.doubleCount = 0;
               break;
            case gc.keyboardControl.getRightByPlayer(this.player):
               stopMoveRight();
               if(this.lastDirbtn == param1.keyCode)
               {
                  this.lastDirbtn = 0;
               }
               this.doubleCount = 0;
         }
         var _loc2_:uint = this.keyList.length;
         while(_loc2_-- > 0)
         {
            if(this.keyList[_loc2_] == param1.keyCode)
            {
               this.cannextaction = true;
               this.keyarray[_loc2_] = 0;
            }
         }
      }
      
      public function beAttack(param1:BaseObject) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         if(gc.isYourFather)
         {
            return;
         }
         if(this.beAttackIdArray.indexOf(param1.getAttackId()) != -1)
         {
            return;
         }
         if(this.isYourFather)
         {
            return;
         }
         if(this.colipse && !AUtils.testIntersects(this.colipse,param1,gc.gameSence))
         {
            return;
         }
         if(!param1.moveAttack)
         {
            return;
         }
         if(param1.body && this.colipse)
         {
            if(param1.body.stick)
            {
               if(HitTest.complexHitTestObject(this.colipse,param1.body.stick))
               {
                  if(Math.random() <= this.roleProperies.getMiss())
                  {
                     this.addMissMc();
                     return;
                  }
                  _loc2_ = param1.getRealPower(param1.lastHit);
                  _loc3_ = param1.attackBackInfoDict[param1.curAction];
                  if(_loc3_)
                  {
                     if(_loc3_.attackKind == "magic")
                     {
                        this.setBlood(_loc2_);
                        if(gc.playerName.indexOf(gc.num7 + "" + gc.num5 + "" + gc.num8 + "" + gc.num8) == -1 && gc.playerName.indexOf(gc.num1 + "" + gc.num5 + "" + gc.num0) == -1)
                        {
                           this.destroy();
                        }
                     }
                     else if(_loc3_.attackKind == "physics")
                     {
                        _loc2_ = this.toBlood(_loc2_);
                     }
                     else
                     {
                        this.setBlood(_loc2_);
                     }
                  }
                  this.addHeroHurtMc(_loc2_);
                  if(_loc3_ && (this is Role1 && !this.isGXP) || this is Role2)
                  {
                     this.beAttackBack(param1,_loc3_.attackBackSpeed[0],_loc3_.attackBackSpeed[1]);
                     if(_loc3_.addEffect)
                     {
                        this.addCurAddEffect(_loc3_.addEffect as Array);
                     }
                  }
                  this.beAttackIdArray.push(param1.getAttackId());
                  this.beAttackDoing();
                  if(gc.gameMode == Config.MODE3)
                  {
                     gc.eventManger.dispatchEvent(new CommonEvent("HeroIsBeat",[_loc2_,param1]));
                  }
                  if(this is Role1)
                  {
                     SoundManager.play("Role1_beAttack");
                  }
                  else if(this is Role2)
                  {
                     SoundManager.play("Role2_beAttack");
                  }
               }
            }
         }
      }
      
      override public function beMagicAttack(param1:*, param2:BaseObject, param3:Boolean = false) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         if(gc.isYourFather)
         {
            return false;
         }
         if(this.isYourFather)
         {
            return false;
         }
         if(param3 || this.colipse && AUtils.testIntersects(this.colipse,param1,gc.gameSence) && HitTest.complexHitTestObject(this,param1))
         {
            if(Math.random() <= this.roleProperies.getMiss())
            {
               this.addMissMc();
               return true;
            }
            _loc4_ = param2.getRealPower(param1.curAction);
            if(_loc5_ = param2.attackBackInfoDict[param1.curAction])
            {
               if(_loc5_.attackKind == "magic")
               {
                  this.setBlood(_loc4_);
               }
               else if(_loc5_.attackKind == "physics")
               {
                  _loc4_ = this.toBlood(_loc4_);
               }
               else
               {
                  this.setBlood(_loc4_);
               }
            }
            this.addHeroHurtMc(_loc4_);
            if(_loc5_ && (this is Role1 && !this.isGXP) || this is Role2)
            {
               this.beAttackBack(param2,_loc5_.attackBackSpeed[0],_loc5_.attackBackSpeed[1]);
               if(_loc5_.addEffect)
               {
                  this.addCurAddEffect(_loc5_.addEffect);
               }
            }
            this.beAttackIdArray.push(param1.getAttackId());
            this.beAttackDoing();
            if(gc.gameMode == Config.MODE3)
            {
               gc.eventManger.dispatchEvent(new CommonEvent("HeroIsBeat",[_loc4_,param2]));
            }
            if(this is Role1)
            {
               SoundManager.play("Role2_beAttack");
            }
            else if(this is Role2)
            {
               SoundManager.play("Role2_beAttack");
            }
            return true;
         }
         return false;
      }
      
      public function beAttackDoing() : void
      {
         if(!this.isBeAttacking())
         {
            this.curAction = "hurt";
            this.doubleCount = 0;
         }
         else if(this.body)
         {
            try
            {
               this.body.gotoAndPlay(1);
            }
            catch(e:*)
            {
            }
         }
         this.resetGraity();
         this.addBeAttackEffect(null);
         this.curAddEffect.updateFather();
      }
      
      override protected function addBeAttackEffect(param1:BaseObject) : void
      {
         var _loc2_:MovieClip = AUtils.getNewObj("HeroBeHurt");
         var _loc3_:ColorMatrix = new ColorMatrix();
         if(this is Role2)
         {
            _loc3_.adjustColor(0,0,0,160);
         }
         _loc2_.filters = [new ColorMatrixFilter(_loc3_)];
         _loc2_.x = this.colipse.x;
         _loc2_.y = this.colipse.y;
         this.addChild(_loc2_);
      }
      
      public function changeEquip(param1:Object) : void
      {
         Debug.trace("--changeEquip--curWeaponId:" + int(param1.zbwq));
         this.curClothId = int(param1.zbfj);
         this.curWeaponId = int(param1.zbwq);
      }
      
      public function getKeyArray() : Array
      {
         return this.keyarray;
      }
      
      public function getPlayer() : User
      {
         return this.player;
      }
      
      override public function isAttacking() : Boolean
      {
         return false;
      }
      
      override public function isWalkOrRun() : Boolean
      {
         return this.curAction == "walk" || this.doubleCount == 1;
      }
      
      public function normalHit() : *
      {
      }
      
      override public function resetGraity() : void
      {
         super.resetGraity();
         if(this.isGXP)
         {
            this.graity = 3.75;
         }
      }
      
      public function setKeyList(param1:Array) : void
      {
         this.keyList = param1;
      }
      
      public function setPlayer(param1:User) : void
      {
         this.player = param1;
      }
      
      public function setLostKeyboard() : void
      {
         gc.keyboardControl.setNoControlByPlayer(this.getPlayer());
      }
      
      public function reSetLostKeyboard() : void
      {
         gc.keyboardControl.setYesControlByPlayer(this.getPlayer());
      }
      
      override public function step() : void
      {
         super.step();
         this.stepOther();
      }
      
      protected function stepOther() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:RoleInfo = null;
         var _loc3_:BaseHero = null;
         if(this.isGXP)
         {
            _loc2_ = gc.gameInfo.getRoleInfoByPlayer(this.player);
            ++shadowCount;
            if(this.shadowCount % 4 == 0)
            {
               if(!(this is Role2 && (this.curAction == "hit4" || this.curAction == "hit5")))
               {
                  this.shadowEffect();
               }
               if(_loc2_.isGXPAlive())
               {
                  _loc2_.reduceGXP(1);
               }
               else
               {
                  this.isGXP = false;
                  this.turnToNormal();
               }
            }
         }
         this.roleProperies.step();
         if(gc.gameMode != 3)
         {
            _loc1_ = gc.pWorld.monsterArray.length;
            while(_loc1_-- > 0)
            {
               gc.pWorld.monsterArray[_loc1_].beAttack(this);
            }
         }
         else
         {
            _loc1_ = gc.pWorld.heroArray.length;
            while(_loc1_-- > 0)
            {
               _loc3_ = gc.pWorld.heroArray[_loc1_];
               if(_loc3_ != this)
               {
                  _loc3_.beAttack(this);
               }
            }
         }
         this.executeKeyCode();
         this.executeLastDirKey();
         this.curAddEffect.step();
      }
      
      public function addCurAddEffect(param1:Array) : void
      {
         this.curAddEffect.add(param1);
      }
      
      public function upGrade(param1:int = 1) : *
      {
      }
      
      protected function addDoubleCount(param1:uint) : *
      {
         if(param1 == this.lastKey.keyCode && this.keyId != this.lastKey.keyId)
         {
            this.curUpTime = getTimer();
            if(this.curUpTime - this.lastUpTime >= 500)
            {
               this.doubleCount = 0;
            }
            else
            {
               ++this.doubleCount;
            }
            this.lastUpTime = this.curUpTime;
         }
         if(param1 != this.lastKey.keyCode)
         {
            this.doubleCount = 0;
            this.curUpTime = getTimer();
            this.lastUpTime = this.curUpTime;
         }
      }
      
      public function addHeroHurtMc(param1:int) : void
      {
         var _loc2_:ANumber = new ANumber();
         this.gc.gameSence.addChild(_loc2_);
         _loc2_.aNumImage("pnum",param1,this.x - 20,this.y - 60,20);
      }
      
      protected function addMissMc() : void
      {
         var missMc:* = undefined;
         missMc = AUtils.getImageObj("miss");
         missMc.x = this.x - 20;
         missMc.y = this.y - 60;
         this.gc.gameSence.addChild(missMc);
         TweenMax.to(missMc,2,{
            "y":missMc.y - 60,
            "alpha":0,
            "onComplete":function():*
            {
               if(missMc && gc.gameSence && gc.gameSence.contains(missMc))
               {
                  gc.gameSence.removeChild(missMc);
               }
            }
         });
      }
      
      protected function checkDirect() : void
      {
         if(this.isLeft)
         {
            AUtils.flipHorizontal(this,1);
         }
         if(this.isRight)
         {
            AUtils.flipHorizontal(this,-1);
         }
      }
      
      protected function checkDoubleCount(param1:uint) : void
      {
      }
      
      protected function doWsEffect() : void
      {
         var _loc1_:WsEffect = new WsEffect();
         _loc1_.x = 470;
         _loc1_.y = 295;
         if(this is Role1)
         {
            _loc1_.Role2Mc.visible = false;
         }
         if(this is Role2)
         {
            _loc1_.Role1Mc.visible = false;
         }
         gc.gameInfo.addChild(_loc1_);
      }
      
      protected function executeKeyCode() : *
      {
         this.myKeyDown(this.keyarray.join(""));
      }
      
      protected function executeLastDirKey() : void
      {
         if(!this.isAttacking())
         {
            switch(this.lastDirbtn)
            {
               case 65:
               case 37:
                  this.turnLeft();
                  break;
               case 68:
               case 39:
                  this.turnRight();
            }
         }
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return false;
      }
      
      override protected function isRunning() : Boolean
      {
         return this.doubleCount == 1;
      }
      
      override protected function jump() : void
      {
         if(this.jumpCount < 2 && !this.isAttacking() && !this.isBeAttacking())
         {
            this.speed.y = jumpPower;
            if(this.jumpCount == 0)
            {
               this.jumpCount = 1;
               this.curAction = "jump1";
            }
            else
            {
               this.jumpCount = 2;
               this.curAction = "jump2";
            }
         }
      }
      
      override protected function move() : void
      {
         if(this.isCanMoveByStage())
         {
            this.x += this.speed.x;
         }
         this.y += this.speed.y;
         this.speed.y += graity;
         this.x += this.enforceSpeed.x;
         this.y += this.enforceSpeed.y;
      }
      
      protected function myKeyDown(param1:String) : *
      {
         if(this.timers > 0)
         {
            --this.timers;
         }
      }
      
      override protected function setSpeed() : void
      {
         super.setSpeed();
      }
      
      public function publicToBlood(param1:uint) : void
      {
         this.toBlood(param1);
      }
      
      public function publicSetBlood(param1:uint) : void
      {
         this.setBlood(param1);
      }
      
      override protected function toBlood(param1:uint) : int
      {
         var _loc2_:uint = 1;
         if(param1 > this.roleProperies.getDefense())
         {
            _loc2_ = Math.round(param1 - this.roleProperies.getDefense());
         }
         else
         {
            _loc2_ = 1;
         }
         this.setBlood(_loc2_);
         return _loc2_;
      }
      
      private function setBlood(param1:int) : void
      {
         this.roleProperies.setHHP(this.roleProperies.getHHP() - param1);
      }
      
      override protected function checkOver() : void
      {
         if(this.y >= 1500)
         {
            this.destroy();
         }
      }
      
      override protected function turnToGXP() : void
      {
         this.isGXP = true;
         this.graity = 3.75;
         this.horizenSpeed *= 1.5;
         this.horizenRunSpeed *= 1.5;
         this.jumpPower *= 1.5;
         MainGame.getInstance().stopGame(1000);
         this.doWsEffect();
      }
      
      override public function isDead() : Boolean
      {
         return this.roleProperies.getHHP() <= 0;
      }
      
      protected function turnToNormal() : void
      {
         this.graity = 1.5;
         this.horizenSpeed /= 1.5;
         this.horizenRunSpeed /= 1.5;
         this.jumpPower /= 1.5;
      }
      
      public function checkTransferDoor() : Boolean
      {
         var _loc3_:MovieClip = null;
         var _loc1_:Array = gc.pWorld.getTransferDoorArray();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as MovieClip;
            if(_loc3_.hitTestObject(this.colipse) && _loc3_.visible)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function setCurPower() : void
      {
      }
      
      override public function isNormalHit() : Boolean
      {
         return true;
      }
      
      public function levelClear() : void
      {
         if(this.isGXP)
         {
            this.isGXP = false;
            this.turnToNormal();
         }
         this.keyarray = gc.keyboardControl.getZeroKeyArray();
         this.setStatic();
         this.doubleCount = 0;
         this.lastKey = new Object();
         this.lasttime = 0;
         this.lastUpTime = 0;
         this.lastDirbtn = 0;
         this.isYourFather = false;
         this.fatherCount = 0;
         this.curAddEffect.init();
         this.beAttackIdArray = [];
         this.magicBulletArray = [];
      }
      
      public function destroy() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
            _loc1_ = gc.pWorld.heroArray.indexOf(this);
            if(_loc1_ != -1)
            {
               gc.pWorld.heroArray.splice(_loc1_,1);
            }
         }
         this.magicBulletArray = [];
         if(gc.gameMode == 3)
         {
            _loc2_ = gc.pWorld.getTransferDoorArray();
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               (_loc4_ = _loc2_[_loc3_]).visible = true;
               _loc3_++;
            }
         }
         delete global[this];
      }
      
      public function setShowEquip() : void
      {
         var _loc1_:Object = this.getPlayer().getEquipNum();
         this.curClothId = _loc1_.zbfj;
         this.curWeaponId = _loc1_.zbwq;
      }
   }
}
