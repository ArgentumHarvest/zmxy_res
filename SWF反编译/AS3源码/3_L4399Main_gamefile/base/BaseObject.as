package base
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import com.greensock.TweenMax;
   import com.superkaka.Tools.ColorAdjust;
   import config.Config;
   import export.ThroughWall;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import export.hero.Role2Shadow;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import my.CureHpQueue;
   
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
      
      public var isAlreadyDead:Boolean = false;
      
      protected var horizenSpeed:Number = 5;
      
      protected var horizenRunSpeed:int = 10;
      
      protected var graity:Number = 1.5;
      
      protected var jumpPower:int = -20;
      
      public var isReadyToDestroy:Boolean = false;
      
      protected var nameTextField:TextField;
      
      public var curAction:String = "wait";
      
      public var body:Sprite;
      
      public var colipse:Sprite;
      
      protected var gc:Config;
      
      public var speed:Point;
      
      public var magicBulletArray:Array;
      
      public var attackBackArray:Array;
      
      public var attackBackSpeedArray:Array;
      
      public var hitMaxAttackCountArray:Array;
      
      public var attackBackInfoDict:Dictionary;
      
      protected var fatherCount:int;
      
      public var isGXP:Boolean = false;
      
      protected var shadowCount:int = 0;
      
      public var lastHit:String = "";
      
      public var enforceSpeed:Point;
      
      public var moveAttack:Boolean = true;
      
      public var curAddEffect:BaseAddEffect;
      
      protected var curMagicWeapon:BaseMagicWeapon;
      
      protected var lastWalkSendInterval:int;
      
      protected var lastRunSendInterval:int;
      
      public var sid:int;
      
      public var lastStandingObj:MovieClip;
      
      public var lastHitTime:uint = 0;
      
      protected var cureHpQueue:CureHpQueue;
      
      protected var _anti:Antiwear;
      
      protected var bbdc:BaseBitmapDataClip;
      
      private var _wallFilterArray:Array;
      
      public function BaseObject()
      {
         beAttackIdArray = [];
         nameTextField = new TextField();
         speed = new Point(0,4);
         magicBulletArray = [];
         attackBackInfoDict = new Dictionary();
         enforceSpeed = new Point();
         cureHpQueue = new CureHpQueue();
         _anti = new Antiwear(new binaryEncrypt());
         _wallFilterArray = [];
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",__added,false,0,true);
         this.addEventListener("removedFromStage",__removed,false,0,true);
         this.body = new Sprite();
         this.addChild(this.body);
         this.newColipse();
         this._anti.curClothId = 0;
         this._anti.curWeaponId = 0;
         this.initBBDC();
         this._anti.isYourFather = false;
         this._anti.jumpCount = 0;
      }
      
      protected function newColipse() : void
      {
      }
      
      protected function initBBDC() : void
      {
      }
      
      protected function __removed(evt:Event) : void
      {
      }
      
      protected function __added(evt:Event) : void
      {
      }
      
      protected function scriptFrameOverFunc(row:int) : void
      {
      }
      
      protected function enterFrameFunc(p:Point) : void
      {
      }
      
      protected function exitFrameFunc(p:Point) : void
      {
      }
      
      public function setHue(hue:int) : void
      {
         var ca:* = null;
         var cmf:* = null;
         if(this.bbdc)
         {
            ca = new ColorAdjust();
            ca.adjustHue(hue);
            cmf = new ColorMatrixFilter(ca);
            bbdc.filters = [cmf];
         }
      }
      
      public function step() : void
      {
         if(this.bbdc)
         {
            this.bbdc.step();
         }
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
         if(this.fatherCount >= 0)
         {
            this.fatherCount--;
            if(this.fatherCount < 0)
            {
               this.fatherCount = -1;
               this._anti.isYourFather = false;
            }
         }
         this.checkOver();
         if(this.curAddEffect)
         {
            this.curAddEffect.step();
         }
         if(this.curMagicWeapon)
         {
            this.curMagicWeapon.step();
         }
         if(this.cureHpQueue)
         {
            this.cureHpQueue.step();
         }
      }
      
      protected function checkOver() : void
      {
      }
      
      protected function mygotoAndStop(mc:BaseObject, flag:String) : *
      {
         if(this is BaseMonster)
         {
            if(mc.currentLabel != flag)
            {
               mc.gotoAndStop(flag);
            }
         }
      }
      
      protected function turnToGXP() : void
      {
      }
      
      public function addCurAddEffect(arr:Array) : void
      {
         if(this.curAddEffect)
         {
            this.curAddEffect.add(arr);
         }
      }
      
      public function cancelAllEffect() : void
      {
         if(this.curAddEffect)
         {
            this.curAddEffect.cancelAllEffect();
         }
      }
      
      public function getCurAddEffect(kind:String) : Boolean
      {
         if(!this.curAddEffect)
         {
            return false;
         }
         return this.curAddEffect.curDebuff(kind);
      }
      
      protected function setSpeed() : void
      {
         if(this.isCannotMoveWhenAttack())
         {
            this.speed.x = 0;
            this.speed.y = 0;
            return;
         }
         if(this.isCannotMoveXWhenAttack())
         {
            this.speed.x = 0;
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
      
      public function addCureMc(cure:int, col:String = "bunum") : void
      {
         if(cure > 0)
         {
            if(this.cureHpQueue)
            {
               this.cureHpQueue.addCure(cure,x - 20,y - 60);
            }
         }
      }
      
      public function addCureMpMc(cure:int) : void
      {
         if(cure > 0)
         {
            if(this.cureHpQueue)
            {
               this.cureHpQueue.addMpCure(cure,x - 20,y - 60);
            }
         }
      }
      
      public function addBingoMc() : void
      {
         var bm:Bitmap = AUtils.getImageObj("bingoBmd") as Bitmap;
         bm.x = this.x;
         bm.y = this.y - 30;
         gc.gameSence.addChild(bm);
         TweenMax.to(bm,1,{
            "y":this.y - 100,
            "onComplete":function(_bm:Bitmap):*
            {
               if(gc.gameSence)
               {
                  if(gc.gameSence.contains(_bm))
                  {
                     gc.gameSence.removeChild(_bm);
                  }
               }
            },
            "onCompleteParams":[bm]
         });
      }
      
      public function doWhenSetYourFatherByFatherCount() : void
      {
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
         var i:int = 0;
         var wall:* = null;
         var wallRect:* = null;
         var selfBitmapData:* = null;
         var m:* = null;
         var wallBitmapData:* = null;
         var angel:Number = NaN;
         var p:* = null;
         this.lastStandingObj = this.standInObj;
         this.standInObj = null;
         this.headInObj = null;
         this.leftInObj = null;
         this.rightInObj = null;
         var wallArray:Array = gc.pWorld.getWallArray();
         for(i = 0; i < wallArray.length; )
         {
            wall = wallArray[i];
            if(this.wallFilterArray.indexOf(wall.wallFilterIdx) == -1)
            {
               if(wall is Wall)
               {
                  if(Wall(wall).isStatic())
                  {
                     wallRect = wall.getBounds(gc.gameSence);
                  }
                  else
                  {
                     wallRect = Wall(wall).getNextFrameBound();
                  }
               }
               else
               {
                  wallRect = wall.getBounds(gc.gameSence);
               }
               if(wallRect.intersects(this.getNextFrameBounds()))
               {
                  if(wall.rotation != 0 && Math.round(wall.rotation) != 90 && !wall.isOutOfThisLine(this) || wall.rotation != 0 && Math.round(wall.rotation) != 90 && wall.isOutOfThisLine(this) && wallRect.intersects(this.getNextFrameXBounds()))
                  {
                     if(!this.selfBitmap)
                     {
                        selfBitmapData = new BitmapData(this.colipse.width,this.colipse.height,true,2236962);
                        selfBitmapData.draw(this.colipse,new Matrix(1,0,0,1,this.colipse.width / 2,this.colipse.height / 2));
                        this.selfBitmap = new Bitmap(selfBitmapData);
                        this.selfBitmap.x = this.x - this.selfBitmap.width / 2 + this.speed.x;
                        this.selfBitmap.y = this.y - this.selfBitmap.height / 2 + this.speed.y;
                     }
                     else
                     {
                        this.selfBitmap.x = this.x - this.selfBitmap.width / 2 + this.speed.x;
                        this.selfBitmap.y = this.y - this.selfBitmap.height / 2 + this.speed.y;
                     }
                     m = wall.transform.matrix;
                     m.tx = wall.width / 2;
                     m.ty = wall.height / 2;
                     if(!this.wallBitmap)
                     {
                        wallBitmapData = new BitmapData(wall.width,wall.height,true,2236962);
                        angel = wall.rotation * 3.141592653589793 / 180;
                        wallBitmapData.draw(wall,m);
                        this.wallBitmap = new Bitmap(wallBitmapData);
                        this.wallBitmap.name = wall.name;
                        this.wallBitmap.x = wall.x - this.wallBitmap.width / 2;
                        this.wallBitmap.y = wall.y - this.wallBitmap.height / 2;
                     }
                     else if(this.wallBitmap.name != wall.name)
                     {
                        this.wallBitmap.bitmapData.fillRect(this.wallBitmap.bitmapData.rect,16777215);
                        this.wallBitmap.bitmapData.draw(wall,m);
                        this.wallBitmap.x = wall.x - this.wallBitmap.width / 2;
                        this.wallBitmap.y = wall.y - this.wallBitmap.height / 2;
                        this.wallBitmap.name = wall.name;
                     }
                     else
                     {
                        this.wallBitmap.x = wall.x - this.wallBitmap.width / 2;
                        this.wallBitmap.y = wall.y - this.wallBitmap.height / 2;
                     }
                     if(this.selfBitmap.bitmapData.hitTest(new Point(this.selfBitmap.x,this.selfBitmap.y),0,this.wallBitmap.bitmapData,new Point(this.wallBitmap.x,this.wallBitmap.y),1))
                     {
                        p = wall.setYByRole(this);
                        if(!this.isLeft && !this.isRight && !this.isAttacking() && !this.isBeAttacking())
                        {
                           if(!this.isWaiting())
                           {
                              this.setAction("wait");
                           }
                        }
                        if(this.speed.y > 0)
                        {
                           this.getDownFloor();
                        }
                        this.speed.x = p.x;
                        this.speed.y = p.y;
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
                     this.nearToWall(wall);
                  }
               }
            }
            i++;
         }
         this.move();
      }
      
      protected function nearToWall(wall:MovieClip) : void
      {
         var wallRect:* = null;
         var curWallRect:Rectangle = wall.getBounds(gc.gameSence);
         if(wall is Wall)
         {
            if(Wall(wall).isStatic())
            {
               wallRect = wall.getBounds(gc.gameSence);
            }
            else
            {
               wallRect = Wall(wall).getNextFrameBound();
            }
         }
         else
         {
            wallRect = wall.getBounds(gc.gameSence);
         }
         var myNextFrame:Rectangle = this.getNextFrameBounds();
         var myCurFrame:Rectangle = this.colipse.getBounds(gc.gameSence);
         var offsetNum:Number = 8;
         if(wall is Wall)
         {
            offsetNum += Math.max(Math.abs(this.speed.y),Math.abs(Wall(wall).speedY));
         }
         if(this.speed.y > 0 && this.getBottom() <= wallRect.y + offsetNum)
         {
            if(!wall.getChildByName("isThroughDownButUpWall"))
            {
               if(wall is ThroughWall)
               {
                  this.standInObj = wall;
                  this.y = wallRect.y - 0.1 - this.colipse.height / 2;
                  this.speed.y = 0;
                  this.getDownFloor();
               }
               else if(myCurFrame.x + myCurFrame.width > wallRect.x && myCurFrame.x < wallRect.x + wallRect.width)
               {
                  this.standInObj = wall;
                  this.y = wallRect.y - 0.1 - this.colipse.height / 2;
                  this.speed.y = 0;
                  this.getDownFloor();
               }
            }
         }
         if(!(wall.getChildByName("isThroughWall") || wall.getChildByName("isThroughUpButDownWall")))
         {
            if(this.speed.y <= 0 && myCurFrame.y > wallRect.y + curWallRect.height)
            {
               this.headInObj = wall;
               this.y = wallRect.y + wallRect.height + 0.1 + this.colipse.height / 2;
               this.speed.y = 0;
            }
            if(this.speed.x <= 0 && (myCurFrame.x >= curWallRect.x + curWallRect.width && myNextFrame.x <= wallRect.x + wallRect.width && myNextFrame.x + myNextFrame.width >= wallRect.x) && this.getBottom() > wallRect.y + 5)
            {
               this.leftInObj = wall;
               this.x = wallRect.x + wallRect.width + 2 + this.colipse.width / 2;
               this.speed.x = 0;
            }
            if(this.speed.x >= 0 && (myCurFrame.x <= curWallRect.x && myNextFrame.x + myNextFrame.width >= wallRect.x && myNextFrame.x <= wallRect.x + wallRect.width) && this.getBottom() > wallRect.y + 5)
            {
               this.rightInObj = wall;
               this.x = wallRect.x - 2 - this.colipse.width / 2;
               this.speed.x = 0;
            }
         }
      }
      
      protected function move() : void
      {
         if(this.isWalkOrRun() || this.isInSky() || this.isBeAttacking() || this.isCanMoveWhenAttack())
         {
            this.x += this.speed.x;
         }
         this.y += this.speed.y;
         this.speed.y += graity;
         this.x += this.enforceSpeed.x;
         this.y += this.enforceSpeed.y;
      }
      
      public function turnLeftPublic() : void
      {
         this.turnLeft();
      }
      
      public function turnRightPublic() : void
      {
         this.turnRight();
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
         if(gc.sid == this.sid && this is BaseHero && !(this is Role2Shadow) && gc.isInRoom())
         {
            if(this.getBBDC().getDirect() == 1)
            {
               gc.sendLorRInfo(BaseHero(this));
            }
         }
         this.bbdc.turnLeft();
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
         if(gc.sid == this.sid && this is BaseHero && !(this is Role2Shadow) && gc.isInRoom())
         {
            if(this.getBBDC().getDirect() == 0)
            {
               gc.sendLorRInfo(BaseHero(this));
            }
         }
         this.bbdc.turnRight();
      }
      
      public function stopMoveL() : void
      {
         this.isLeft = false;
         if(!this.isRight)
         {
            if(!this.isAttacking())
            {
               if(!this.isInSky())
               {
                  if(!this.isWaiting())
                  {
                     this.setAction("wait");
                  }
               }
            }
            if(!this.isCanMoveWhenAttack())
            {
               this.speed.x = 0;
            }
         }
         else
         {
            this.bbdc.turnRight();
         }
      }
      
      public function stopMoveR() : void
      {
         this.isRight = false;
         if(!this.isLeft)
         {
            if(!this.isAttacking())
            {
               if(!this.isInSky())
               {
                  if(!this.isWaiting())
                  {
                     this.setAction("wait");
                  }
               }
            }
            if(!this.isCanMoveWhenAttack())
            {
               this.speed.x = 0;
            }
         }
         else
         {
            this.bbdc.turnLeft();
         }
      }
      
      protected function stopMove() : void
      {
         if(this.isLeft)
         {
            this.stopMoveL();
         }
         else if(this.isRight)
         {
            this.stopMoveR();
         }
         if(!this.isWaiting())
         {
            this.setAction("wait");
         }
      }
      
      protected function addBeAttackEffect(b:BaseObject) : void
      {
      }
      
      protected function shadowEffect() : void
      {
         AUtils.shallowEffect(this);
      }
      
      protected function getBeattackBackSpeed(source:BaseBullet, obj:Object) : Point
      {
         if(!obj)
         {
            return new Point(0,0);
         }
         var point:Point = new Point(obj.attackBackSpeed[0],obj.attackBackSpeed[1]);
         if(source is EnemyMoveBullet)
         {
            if(source.speed.x < 0)
            {
               point.x = -Math.abs(point.x);
            }
            else
            {
               point.x = Math.abs(point.x);
            }
         }
         else if(source is SpecialEffectBullet || source is FollowBaseObjectBullet)
         {
            if(source.getImcName() == "Role2Bullet3")
            {
               if(this.x > source.sourceRole.x)
               {
                  point.x = Math.abs(point.x);
               }
               else
               {
                  point.x = -Math.abs(point.x);
               }
            }
            else if(source.getImcName() == "Monster37Bullet4_2")
            {
               if(this.x > source.sourceRole.x)
               {
                  point.x = -Math.abs(point.x);
               }
               else
               {
                  point.x = Math.abs(point.x);
               }
            }
            else if(BaseBullet(source).getDirect() == -1)
            {
               point.x = -Math.abs(point.x);
            }
            else
            {
               point.x = Math.abs(point.x);
            }
         }
         return point;
      }
      
      public function setAttackBack(p:Point) : void
      {
         if(p.x < 0)
         {
            this.isLeft = true;
            this.isRight = false;
         }
         else
         {
            this.isLeft = false;
            this.isRight = true;
         }
         this.speed.x = p.x;
         this.speed.y = p.y;
      }
      
      public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         return false;
      }
      
      public function getHurtByPig8(hurt:int) : void
      {
      }
      
      protected function jump() : void
      {
         this.speed.y = jumpPower;
      }
      
      protected function getBottom() : Number
      {
         return this.colipse.height / 2 + this.y;
      }
      
      public function isCanMoveByStage() : Boolean
      {
         var thisRect:Rectangle = this.colipse.getBounds(gc.gameSence.parent);
         var thisLeft:Number = thisRect.x + this.speed.x;
         var thisRight:Number = thisRect.x + thisRect.width + this.speed.x;
         return thisLeft > 20 && thisRight < 920 || this.speed.x < 0 && thisRight > 920 || this.speed.x > 0 && thisLeft < 20;
      }
      
      protected function getTop() : Number
      {
         return -this.colipse.height / 2 + this.y;
      }
      
      protected function getLeft() : Number
      {
         return -this.colipse.width / 2 + this.x;
      }
      
      protected function getRight() : Number
      {
         return this.colipse.width / 2 + this.x;
      }
      
      protected function getDownFloor() : void
      {
         if(!this.isAttacking() && !this.isBeAttacking())
         {
            if(this.isLeft || this.isRight)
            {
               this.iswor();
            }
            else if(!this.isWaiting())
            {
               this.setAction("wait");
            }
         }
         this._anti.jumpCount = 0;
      }
      
      protected function getFallDown() : void
      {
         if(this.standInObj && this.standInObj.getChildByName("isThroughWall"))
         {
            this.y += 20;
            this.setAction("jump1");
            this._anti.jumpCount = 1;
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
      
      protected function isCannotMoveXWhenAttack() : Boolean
      {
         return false;
      }
      
      public function getNextFrameBounds() : Rectangle
      {
         var nfb:Rectangle = this.colipse.getBounds(gc.gameSence);
         nfb.offsetPoint(this.speed);
         return nfb;
      }
      
      public function getNextFrameXBounds() : Rectangle
      {
         var nfb:Rectangle = this.colipse.getBounds(gc.gameSence);
         nfb.offset(this.speed.x,0);
         return nfb;
      }
      
      public function setNameTextField(s:String, ttf:TextFormat = null) : void
      {
         if(!ttf)
         {
            ttf = this.nameTextField.getTextFormat();
         }
         this.nameTextField.text = s;
         this.nameTextField.setTextFormat(ttf);
      }
      
      public function releaseMagicWeapon() : void
      {
         this.curMagicWeapon = null;
      }
      
      public function getRealPower(cur:String, crit:Boolean = true) : int
      {
         return 0;
      }
      
      public function setStun() : void
      {
      }
      
      public function setAction(str:String) : void
      {
         this.curAction = str;
         if(str == "dead")
         {
            if(this.bbdc.isStopFrame)
            {
               this.bbdc.continueFrame();
            }
         }
      }
      
      public function isNormalHit() : Boolean
      {
         return true;
      }
      
      public function newAttackId() : void
      {
         this.attackId++;
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
      
      public function isWaiting() : Boolean
      {
         return this.curAction == "wait";
      }
      
      public function isStatic() : Boolean
      {
         return !this.isLeft && !this.isRight;
      }
      
      public function isDead() : Boolean
      {
         return false;
      }
      
      public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         this.lastHitTime = getTimer();
      }
      
      public function setOtherAttack(attackKind:String, direct:uint, point:Point, params:Array = null, initTimer:uint = 0) : void
      {
      }
      
      public function setOtherBuff(action:String, params:Array) : void
      {
      }
      
      public function getRoleId() : uint
      {
         return 0;
      }
      
      public function setStatic() : void
      {
         this.isLeft = false;
         this.isRight = false;
         this.speed.x = 0;
      }
      
      public function setYourFather(count:int) : void
      {
         this._anti.isYourFather = true;
         this.fatherCount = count;
      }
      
      public function isYourFather() : Boolean
      {
         return this._anti.isYourFather == true;
      }
      
      public function setJumpCount(v:uint) : void
      {
         this._anti.jumpCount = v;
      }
      
      public function getJumpCount() : uint
      {
         return this._anti.jumpCount;
      }
      
      public function setLostGraity() : void
      {
         this.graity = 0;
      }
      
      public function getBBDC() : BaseBitmapDataClip
      {
         return this.bbdc;
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
      }
      
      public function iswor() : *
      {
         if(!this.isRunning())
         {
            this.setAction("walk");
         }
         else
         {
            this.setAction("run");
         }
      }
      
      public function get wallFilterArray() : Array
      {
         return _wallFilterArray;
      }
      
      public function set wallFilterArray(value:Array) : void
      {
         _wallFilterArray = value;
      }
      
      public function isCanHurtWhenBeingAttack() : Boolean
      {
         return true;
      }
   }
}
