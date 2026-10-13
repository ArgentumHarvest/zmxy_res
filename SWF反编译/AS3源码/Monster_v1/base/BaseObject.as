package base
{
   import com.greensock.TweenMax;
   import config.Config;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import export.hero.Role1;
   import export.monster.Monster26;
   import export.scene.Thron;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import my.ANumber;
   
   public class BaseObject extends MovieClip
   {
       
      
      private var selfBitmap:Bitmap;
      
      private var wallBitmap:Bitmap;
      
      public var standInObj:MovieClip;
      
      public var headInObj:MovieClip;
      
      public var leftInObj:MovieClip;
      
      public var rightInObj:MovieClip;
      
      public var isRight:Boolean = false;
      
      public var isLeft:Boolean = false;
      
      public var isFly:Boolean = false;
      
      public var attackId:int = 0;
      
      public var beAttackIdArray:Array;
      
      protected var attackRange:uint = 20;
      
      protected var horizenSpeed:int = 5;
      
      protected var horizenRunSpeed:int = 10;
      
      protected var graity:Number = 1.5;
      
      protected var jumpPower:int = -20;
      
      protected var Hp:int = 0;
      
      protected var sHp:int = 0;
      
      protected var jumpCount:int = 0;
      
      public var curAction:String = "wait";
      
      public var body:MovieClip;
      
      public var colipse:MovieClip;
      
      protected var gc:Config;
      
      public var speed:Point;
      
      public var magicBulletArray:Array;
      
      public var attackBackArray:Array;
      
      public var attackBackSpeedArray:Array;
      
      public var hitMaxAttackCountArray:Array;
      
      public var attackBackInfoDict:Dictionary;
      
      public var isYourFather:Boolean = false;
      
      protected var fatherCount:int;
      
      public var isGXP:Boolean = false;
      
      protected var shadowCount:int = 0;
      
      public var lastHit:String = "";
      
      public var enforceSpeed:Point;
      
      public var moveAttack:Boolean = true;
      
      public function BaseObject()
      {
         this.beAttackIdArray = new Array();
         this.speed = new Point(0,4);
         this.magicBulletArray = new Array();
         this.attackBackInfoDict = new Dictionary();
         this.enforceSpeed = new Point();
         super();
         this.gc = Config.getInstance();
         this.addEventListener(Event.ADDED_TO_STAGE,this.__added);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.__removed);
      }
      
      protected function __removed(param1:Event) : void
      {
      }
      
      protected function __added(param1:Event) : void
      {
      }
      
      public function step() : void
      {
         this.mygotoAndStop(this,this.curAction);
         if(!this.isBeAttacking())
         {
            this.setSpeed();
         }
         if(!this.isFly)
         {
            this.checkCanMove();
         }
         else if(this.isCanMoveByStage())
         {
            this.move();
         }
         if(this.fatherCount > 0)
         {
            --this.fatherCount;
            if(this.fatherCount <= 0)
            {
               this.fatherCount = 0;
               this.isYourFather = false;
            }
         }
         this.checkOver();
      }
      
      protected function checkOver() : void
      {
      }
      
      protected function mygotoAndStop(param1:BaseObject, param2:String) : *
      {
         if(param1.currentLabel != param2)
         {
            param1.gotoAndStop(param2);
         }
      }
      
      protected function turnToGXP() : void
      {
      }
      
      protected function setSpeed() : void
      {
         if(this.isCannotMoveWhenAttack())
         {
            this.speed.x = 0;
            this.speed.y = 0;
            return;
         }
         if(!this.isInSky())
         {
            if(this.isCannotMoveWhenAttackOnFloor())
            {
               this.speed.x = 0;
               return;
            }
         }
         if(this.isLeft)
         {
            if(!this.isCanMoveWhenAttack())
            {
               if(!this.isRunning())
               {
                  this.speed.x = -this.horizenSpeed;
               }
               else
               {
                  this.speed.x = -this.horizenRunSpeed;
               }
            }
         }
         if(this.isRight)
         {
            if(!this.isCanMoveWhenAttack())
            {
               if(!this.isRunning())
               {
                  this.speed.x = this.horizenSpeed;
               }
               else
               {
                  this.speed.x = this.horizenRunSpeed;
               }
            }
         }
      }
      
      protected function addCureMc(param1:int, param2:String = "bunum") : void
      {
         var _loc3_:ANumber = new ANumber();
         this.gc.gameSence.addChild(_loc3_);
         _loc3_.aNumImage(param2,param1,this.x - 20,this.y - 60,20);
      }
      
      public function isCanMoveWhenAttack() : Boolean
      {
         return false;
      }
      
      protected function isRunning() : Boolean
      {
         return false;
      }
      
      protected function checkCanMove() : void
      {
         var _loc3_:* = undefined;
         var _loc4_:Rectangle = null;
         var _loc5_:Matrix = null;
         var _loc6_:BitmapData = null;
         var _loc7_:BitmapData = null;
         var _loc8_:Number = NaN;
         var _loc9_:Point = null;
         this.standInObj = null;
         this.headInObj = null;
         this.leftInObj = null;
         this.rightInObj = null;
         var _loc1_:Array = this.gc.pWorld.getWallArray();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            if((_loc4_ = _loc3_.getBounds(this.gc.gameSence)).intersects(this.getNextFrameBounds()))
            {
               if(_loc3_.rotation != 0 && !_loc3_.isOutOfThisLine(this) || _loc3_.rotation != 0 && _loc3_.isOutOfThisLine(this) && _loc4_.intersects(this.getNextFrameXBounds()))
               {
                  if(!this.selfBitmap)
                  {
                     (_loc6_ = new BitmapData(this.colipse.width,this.colipse.height,true,2236962)).draw(this.colipse,new Matrix(1,0,0,1,this.colipse.width / 2,this.colipse.height / 2));
                     this.selfBitmap = new Bitmap(_loc6_);
                     this.selfBitmap.x = this.x - this.selfBitmap.width / 2 + this.speed.x;
                     this.selfBitmap.y = this.y - this.selfBitmap.height / 2 + this.speed.y;
                  }
                  else
                  {
                     this.selfBitmap.x = this.x - this.selfBitmap.width / 2 + this.speed.x;
                     this.selfBitmap.y = this.y - this.selfBitmap.height / 2 + this.speed.y;
                  }
                  (_loc5_ = _loc3_.transform.matrix).tx = _loc3_.width / 2;
                  _loc5_.ty = _loc3_.height / 2;
                  if(!this.wallBitmap)
                  {
                     _loc7_ = new BitmapData(_loc3_.width,_loc3_.height,true,2236962);
                     _loc8_ = _loc3_.rotation * Math.PI / 180;
                     _loc7_.draw(_loc3_,_loc5_);
                     this.wallBitmap = new Bitmap(_loc7_);
                     this.wallBitmap.name = _loc3_.name;
                     this.wallBitmap.x = _loc3_.x - this.wallBitmap.width / 2;
                     this.wallBitmap.y = _loc3_.y - this.wallBitmap.height / 2;
                  }
                  else if(this.wallBitmap.name != _loc3_.name)
                  {
                     this.wallBitmap.bitmapData.fillRect(this.wallBitmap.bitmapData.rect,16777215);
                     this.wallBitmap.bitmapData.draw(_loc3_,_loc5_);
                     this.wallBitmap.x = _loc3_.x - this.wallBitmap.width / 2;
                     this.wallBitmap.y = _loc3_.y - this.wallBitmap.height / 2;
                     this.wallBitmap.name = _loc3_.name;
                  }
                  else
                  {
                     this.wallBitmap.x = _loc3_.x - this.wallBitmap.width / 2;
                     this.wallBitmap.y = _loc3_.y - this.wallBitmap.height / 2;
                  }
                  if(this.selfBitmap.bitmapData.hitTest(new Point(this.selfBitmap.x,this.selfBitmap.y),0,this.wallBitmap.bitmapData,new Point(this.wallBitmap.x,this.wallBitmap.y),1))
                  {
                     _loc9_ = _loc3_.setYByRole(this);
                     this.standInObj = _loc3_;
                     this.speed.x = _loc9_.x;
                     this.speed.y = _loc9_.y;
                     if(!this.isLeft && !this.isRight && !this.isAttacking() && !this.isBeAttacking())
                     {
                        this.curAction = "wait";
                     }
                     this.getDownFloor();
                  }
               }
               else
               {
                  if(this.selfBitmap)
                  {
                     this.selfBitmap.bitmapData.dispose();
                     this.selfBitmap = null;
                  }
                  if(this.wallBitmap)
                  {
                     this.wallBitmap.bitmapData.dispose();
                     this.wallBitmap = null;
                  }
                  this.nearToWall(_loc3_);
               }
            }
            _loc2_++;
         }
         this.move();
      }
      
      protected function nearToWall(param1:MovieClip) : void
      {
         var _loc2_:Rectangle = param1.getBounds(this.gc.gameSence);
         var _loc3_:Rectangle = this.getNextFrameXBounds();
         if(this.speed.y > 0 && this.getBottom() <= _loc2_.y + 8)
         {
            this.standInObj = param1;
            this.y = _loc2_.y - 0.1 - (this.colipse.y + this.colipse.height / 2);
            this.speed.y = 0;
            this.getDownFloor();
         }
         if(!param1.getChildByName("isThroughWall"))
         {
            if(this.speed.y < 0 && this.getTop() >= _loc2_.y + _loc2_.height)
            {
               this.headInObj = param1;
               this.y = _loc2_.y + _loc2_.height + 0.1 + this.colipse.height / 2;
               this.speed.y = 0;
            }
            if(this.speed.x < 0 && _loc3_.x <= _loc2_.x + _loc2_.width && _loc3_.x >= _loc2_.x && this.getBottom() > _loc2_.y + 5)
            {
               this.leftInObj = param1;
               this.x = _loc2_.x + _loc2_.width + 0.1 + this.colipse.width / 2;
               this.speed.x = 0;
            }
            if(this.speed.x > 0 && _loc3_.x + _loc3_.width >= _loc2_.x && _loc3_.x + _loc3_.width <= _loc2_.x + _loc2_.width && this.getBottom() > _loc2_.y + 5)
            {
               this.rightInObj = param1;
               this.x = _loc2_.x - 0.1 - this.colipse.width / 2;
               this.speed.x = 0;
            }
         }
      }
      
      protected function move() : void
      {
         if(this.isWalkOrRun() || this.isInSky() || this.isBeAttacking() || this.isCanMoveWhenAttack())
         {
            if(this.x + this.speed.x >= 100 && this.x + this.speed.x <= this.gc.gameSence.width - 150)
            {
               this.x += this.speed.x;
            }
         }
         this.y += this.speed.y;
         this.speed.y += this.graity;
         this.x += this.enforceSpeed.x;
         this.y += this.enforceSpeed.y;
      }
      
      protected function moveLeft() : void
      {
         if(!this.isAttacking())
         {
            this.turnLeft();
            if(!this.isInSky() && !this.isAttacking() && !this.isBeAttacking())
            {
               this.iswor();
            }
         }
      }
      
      protected function turnLeft() : *
      {
         this.isLeft = true;
         this.isRight = false;
         AUtils.flipHorizontal(this,1);
      }
      
      protected function moveRight() : void
      {
         if(!this.isAttacking())
         {
            this.turnRight();
            if(!this.isInSky() && !this.isAttacking() && !this.isBeAttacking())
            {
               this.iswor();
            }
         }
      }
      
      protected function turnRight() : *
      {
         this.isRight = true;
         this.isLeft = false;
         AUtils.flipHorizontal(this,-1);
      }
      
      protected function stopMoveLeft() : void
      {
         if(!this.isRight)
         {
            if(!this.isAttacking())
            {
               if(!this.isInSky())
               {
                  this.curAction = "wait";
               }
            }
            if(!this.isCanMoveWhenAttack())
            {
               this.speed.x = 0;
            }
         }
         else
         {
            AUtils.flipHorizontal(this,-1);
         }
         this.isLeft = false;
      }
      
      protected function stopMoveRight() : void
      {
         if(!this.isLeft)
         {
            if(!this.isAttacking())
            {
               if(!this.isInSky())
               {
                  this.curAction = "wait";
               }
            }
            if(!this.isCanMoveWhenAttack())
            {
               this.speed.x = 0;
            }
         }
         else
         {
            AUtils.flipHorizontal(this,1);
         }
         this.isRight = false;
      }
      
      protected function stopMove() : void
      {
         if(this.isLeft)
         {
            this.stopMoveLeft();
         }
         else if(this.isRight)
         {
            this.stopMoveRight();
         }
         this.curAction = "wait";
      }
      
      protected function addBeAttackEffect(param1:BaseObject) : void
      {
      }
      
      protected function shadowEffect() : void
      {
         var bm:Bitmap = null;
         var b:BitmapData = new BitmapData(this.width,this.height,true,16777215);
         b.draw(this,new Matrix(this.transform.matrix.a,0,0,1,this.width / 2,this.height / 2));
         bm = new Bitmap(b);
         bm.x = this.x - this.width / 2;
         bm.y = this.y - this.height / 2;
         if(this.isStatic())
         {
            bm.x += (Math.random() - 0.5) * 5;
         }
         var idx:int = this.parent.getChildIndex(this);
         this.parent.addChildAt(bm,idx);
         TweenMax.to(bm,1,{
            "alpha":0,
            "onComplete":function():*
            {
               if(parent && parent.contains(bm))
               {
                  parent.removeChild(bm);
               }
            }
         });
      }
      
      public function beAttackBack(param1:*, param2:Number, param3:Number) : void
      {
         if(param1 is BaseBullet)
         {
            if(param1 is EnemyMoveBullet)
            {
               if(param1.speed < 0)
               {
                  this.beAttackBackLeft(param2,param3);
               }
               else
               {
                  this.beAttackBackRight(param2,param3);
               }
            }
            if(param1 is SpecialEffectBullet)
            {
               if(param1.x > this.x)
               {
                  this.beAttackBackLeft(param2,param3);
               }
               else
               {
                  this.beAttackBackRight(param2,param3);
               }
            }
         }
         else if(param1 is BaseHero || param1 is BaseMonster)
         {
            if(param1 is Role1 && param1.curAction == "hit9")
            {
               if(param1.x > this.x)
               {
                  this.beAttackBackLeft(param2,param3);
               }
               else
               {
                  this.beAttackBackRight(param2,param3);
               }
            }
            else if(param1 is Monster26 && param1.curAction == "hit2")
            {
               if(param1.x > this.x)
               {
                  this.beAttackBackLeft(param2,param3);
               }
               else
               {
                  this.beAttackBackRight(param2,param3);
               }
            }
            else if(param1.transform.matrix.a == 1)
            {
               this.beAttackBackLeft(param2,param3);
            }
            else
            {
               this.beAttackBackRight(param2,param3);
            }
         }
         else if(param1 is Thron)
         {
            if(param1.x > this.x)
            {
               this.beAttackBackLeft(param2,param3);
            }
            else
            {
               this.beAttackBackRight(param2,param3);
            }
         }
      }
      
      private function beAttackBackLeft(param1:Number, param2:Number) : void
      {
         this.isLeft = true;
         this.isRight = false;
         this.speed.x = -param1;
         this.speed.y = param2;
      }
      
      private function beAttackBackRight(param1:Number, param2:Number) : void
      {
         this.isLeft = false;
         this.isRight = true;
         this.speed.x = param1;
         this.speed.y = param2;
      }
      
      public function beMagicAttack(param1:*, param2:BaseObject, param3:Boolean = false) : Boolean
      {
         return false;
      }
      
      protected function toBlood(param1:uint) : int
      {
         return 0;
      }
      
      protected function jump() : void
      {
         this.speed.y = this.jumpPower;
      }
      
      protected function getBottom() : Number
      {
         return this.colipse.y + this.colipse.height / 2 + this.y;
      }
      
      public function isCanMoveByStage() : Boolean
      {
         var _loc1_:Rectangle = this.colipse.getBounds(this.gc.gameSence.parent);
         var _loc2_:Number = _loc1_.x + this.speed.x;
         var _loc3_:Number = _loc1_.x + _loc1_.width + this.speed.x;
         return _loc2_ >= 20 && _loc3_ <= 920 || this.isLeft && _loc3_ > 920 || this.isRight && _loc2_ < 20;
      }
      
      protected function getTop() : Number
      {
         return this.colipse.y - this.colipse.height / 2 + this.y;
      }
      
      protected function getLeft() : Number
      {
         return this.colipse.x - this.colipse.width / 2 + this.x;
      }
      
      protected function getRight() : Number
      {
         return this.colipse.x + this.colipse.width / 2 + this.x;
      }
      
      protected function getDownFloor() : void
      {
         if(!this.isAttacking() && !this.isBeAttacking())
         {
            if(this.isLeft || this.isRight)
            {
               this.iswor();
            }
            else
            {
               this.curAction = "wait";
            }
         }
         this.jumpCount = 0;
      }
      
      protected function getFallDown() : void
      {
         if(this.standInObj && this.standInObj.getChildByName("isThroughWall"))
         {
            this.y += 10;
            this.curAction = "jump1";
            this.jumpCount = 1;
         }
      }
      
      protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return false;
      }
      
      protected function isCannotMoveWhenAttack() : Boolean
      {
         return false;
      }
      
      public function getNextFrameBounds() : Rectangle
      {
         var _loc1_:Rectangle = this.colipse.getBounds(this.gc.gameSence);
         _loc1_.offsetPoint(this.speed);
         return _loc1_;
      }
      
      public function getNextFrameXBounds() : Rectangle
      {
         var _loc1_:Rectangle = this.colipse.getBounds(this.gc.gameSence);
         _loc1_.offset(this.speed.x,0);
         return _loc1_;
      }
      
      public function getRealPower(param1:String) : int
      {
         return 0;
      }
      
      public function isNormalHit() : Boolean
      {
         return true;
      }
      
      public function newAttackId() : void
      {
         ++this.attackId;
      }
      
      public function getAttackId() : String
      {
         return this.name + this.attackId;
      }
      
      public function getNumAttackId() : int
      {
         return this.attackId;
      }
      
      public function isJump() : Boolean
      {
         return this.curAction == "jump1" || this.curAction == "jump2" || this.curAction == "jump3";
      }
      
      public function isInSky() : Boolean
      {
         return !this.standInObj;
      }
      
      public function isWalkOrRun() : Boolean
      {
         return true;
      }
      
      public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3";
      }
      
      public function isBeAttacking() : Boolean
      {
         return this.curAction == "hurt" || this.curAction == "afterHurt" || this.curAction == "dead";
      }
      
      public function isStatic() : Boolean
      {
         return !this.isLeft && !this.isRight;
      }
      
      public function isDead() : Boolean
      {
         return this.Hp <= 0;
      }
      
      public function reduceHp(param1:int) : void
      {
      }
      
      public function isCanBeHurt() : Boolean
      {
         return true;
      }
      
      public function setStatic() : void
      {
         this.isLeft = false;
         this.isRight = false;
         this.speed.x = 0;
      }
      
      public function setYourFather(param1:int) : void
      {
         this.isYourFather = true;
         this.fatherCount = param1;
      }
      
      public function setLostGraity() : void
      {
         this.graity = 0;
         this.isYourFather = true;
      }
      
      public function resetGraity() : void
      {
         if(!this.isGXP)
         {
            this.graity = 1.5;
         }
         else
         {
            this.graity = 3.75;
         }
         this.isYourFather = false;
      }
      
      public function getPowerByHit() : int
      {
         var _loc1_:Object = this.attackBackInfoDict[this.curAction];
         if(_loc1_)
         {
            return _loc1_.power;
         }
         return 0;
      }
      
      public function iswor() : *
      {
         if(!this.isRunning())
         {
            this.curAction = "walk";
         }
         else
         {
            this.curAction = "run";
         }
      }
      
      public function dispose() : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.__added);
         this.removeEventListener(Event.ADDED_TO_STAGE,this.__removed);
      }
   }
}
