package base
{
   import com.greensock.TweenMax;
   import config.Config;
   import export.hero.Role1;
   import export.level.StageListener131;
   import export.monster.Monster121;
   import export.monster.Monster124;
   import export.monster.Monster32;
   import export.monster.Monster34;
   import export.monster.MonsterRole4Hit5;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.HitTest;
   
   public class BaseBullet extends Sprite
   {
      
      public static var DESIDE_BY_FRAMES_LEFT:uint = 0;
       
      
      protected var imgMc:MovieClip;
      
      public var sourceRole:BaseObject;
      
      public var sourceRoleAttackInfoObject:Object;
      
      private var _hurt:int;
      
      public var finallHurt:int = 0;
      
      public var isCrit:Boolean = false;
      
      public var hitObject:BaseObject;
      
      public var isCanBeAttack:Boolean = false;
      
      public var isDisabled:Boolean = false;
      
      public var isReadyToDestroy:Boolean = false;
      
      public var initTimer:uint;
      
      public var isBingo:Boolean = false;
      
      protected var isAdd:Boolean = false;
      
      private var lastStopGameState:Boolean = false;
      
      protected var direct:int = -1;
      
      public var speed:Point;
      
      public var curAction:String;
      
      protected var gc:Config;
      
      protected var attackId:int;
      
      protected var maxAttackCount:int;
      
      protected var imcName:String;
      
      private var attackInterval:int;
      
      private var attackIntervalCount:int = 0;
      
      protected var funcWhenHitWall:Function = null;
      
      protected var funcWhenHit:Function = null;
      
      protected var funcWhenInCount:Function = null;
      
      protected var funcWhenEnterFrame:Function = null;
      
      protected var funcWhenDestroy:Function = null;
      
      protected var followDisplayObject:DisplayObject;
      
      protected var destroyInCount:int = -1;
      
      protected var isHurtCanCutDownEffect:Boolean = false;
      
      protected var isDestroyWhenLastFrame:Boolean = true;
      
      protected var isDestroyWhenMaxHitCountLessThenZero:Boolean = true;
      
      protected var hurtAdd:Number = 0;
      
      public var isStopInLastFrame:Boolean = false;
      
      public function BaseBullet(imgMcName:String)
      {
         super();
         this.imcName = imgMcName;
         this.imgMc = AUtils.getNewObj(imgMcName);
         this.addChild(this.imgMc);
         gc = Config.getInstance();
         this.speed = new Point();
      }
      
      protected function __added(evt:Event) : void
      {
      }
      
      public function step2() : void
      {
         if(!gc.isStopGame)
         {
            this.step();
         }
         if(this.funcWhenEnterFrame != null)
         {
            this.funcWhenEnterFrame(this);
         }
         if(this.imgMc && this.isDestroyWhenLastFrame)
         {
            if(this.imgMc.currentFrame == this.imgMc.totalFrames)
            {
               this.imgMc.stop();
               this.destroy();
            }
         }
         if(this.imgMc && this.isStopInLastFrame)
         {
            if(this.imgMc.currentFrame == this.imgMc.totalFrames)
            {
               this.imgMc.stop();
            }
         }
         if(this.sourceRole)
         {
            if(this.isHurtCanCutDownEffect)
            {
               if(this.sourceRole.curAction == "hurt")
               {
                  this.destroy();
               }
            }
         }
      }
      
      protected function step() : void
      {
         this.hitObject = null;
         if(this.destroyInCount > 0)
         {
            this.destroyInCount--;
            if(this.destroyInCount == 0)
            {
               this.destroy();
            }
         }
         if(this.followDisplayObject is BaseObject)
         {
            if((this.followDisplayObject as BaseObject).isDead() || (this.followDisplayObject as BaseObject).isReadyToDestroy)
            {
               this.followDisplayObject = null;
            }
         }
         if(this.followDisplayObject)
         {
            this.x = this.followDisplayObject.x;
            this.y = this.followDisplayObject.y;
         }
         if(this.isDisabled)
         {
            return;
         }
         this.checkAttack();
         this.checkHitWall();
         if(this.imcName)
         {
            if(this.imcName == "Role4Bullet12")
            {
               if(this.sourceRole)
               {
                  if(this.hitTestObject(this.sourceRole.colipse))
                  {
                     this.destroy();
                  }
               }
            }
         }
      }
      
      public function setDestroyWhenLastFrame(b:Boolean) : void
      {
         this.isDestroyWhenLastFrame = b;
      }
      
      public function setHurtCanCutDownEffect(b:Boolean) : void
      {
         this.isHurtCanCutDownEffect = b;
      }
      
      public function setDestroyWhenMaxHitCountLessThenZero(b:Boolean) : void
      {
         this.isDestroyWhenMaxHitCountLessThenZero = b;
      }
      
      public function setCanBeAttack() : void
      {
         this.isCanBeAttack = true;
      }
      
      public function setFuncWhenHitWall(f:Function) : void
      {
         this.funcWhenHitWall = f;
      }
      
      public function setFuncWhenDestroy(f:Function) : void
      {
         this.funcWhenDestroy = f;
      }
      
      public function setFuncWhenEnterFrame(f:Function) : void
      {
         this.funcWhenEnterFrame = f;
      }
      
      public function setFollowDisplayObj(obj:DisplayObject) : void
      {
         this.followDisplayObject = obj;
      }
      
      public function getFollowDisplayObject() : DisplayObject
      {
         return this.followDisplayObject;
      }
      
      public function setFuncWhenHit(f:Function) : void
      {
         this.funcWhenHit = f;
      }
      
      public function setFuncWhenInCount(f:Function, interval:Number, delay:Number) : void
      {
         this.funcWhenInCount = f;
         this.doFuncWhenInCount(interval,delay);
      }
      
      private function doFuncWhenInCount(interval:Number, delay:Number) : void
      {
         TweenMax.delayedCall(delay,delayCall1,[interval]);
      }
      
      public function delayCall1(_interval:Number) : void
      {
         this.funcWhenInCount();
         TweenMax.delayedCall(_interval,delayCall2,[_interval]);
      }
      
      public function delayCall2(_interval:Number) : void
      {
         this.doFuncWhenInCount(_interval,0);
      }
      
      public function setBingoRate(rate:Number) : void
      {
         if(RandomControllor.getIns().getRandom() < rate)
         {
            this.isBingo = true;
         }
      }
      
      private function checkHitWall() : void
      {
         var i:int = 0;
         var wall:* = null;
         if(this.funcWhenHitWall != null)
         {
            for(i = 0; i < gc.pWorld.getWallArray().length; )
            {
               wall = gc.pWorld.getWallArray()[i] as Wall;
               if(wall.width >= 800)
               {
                  if(HitTest.complexHitTestObject(this,wall))
                  {
                     this.funcWhenHitWall(this);
                     this.destroy();
                     break;
                  }
               }
               i++;
            }
         }
      }
      
      public function checkAttack() : void
      {
         var oppositeArray:* = null;
         var j:int = 0;
         var o:* = null;
         if(!this.sourceRole)
         {
            return;
         }
         if(gc.isInRoom())
         {
            if(gc.isInPk())
            {
               if(this.sourceRole is BaseHero)
               {
                  if(BaseHero(this.sourceRole).getPlayer())
                  {
                     oppositeArray = gc.pWorld.getOtherHeroArray();
                     oppositeArray = oppositeArray.concat(gc.pWorld.likeMonsterArray);
                  }
                  else
                  {
                     oppositeArray = [];
                  }
               }
            }
            else if(gc.isInFuben())
            {
               if(this.sourceRole is BaseHero)
               {
                  if(BaseHero(this.sourceRole).getPlayer())
                  {
                     oppositeArray = gc.pWorld.monsterArray;
                     oppositeArray = oppositeArray.concat(gc.pWorld.likeMonsterArray);
                  }
                  else
                  {
                     oppositeArray = [];
                  }
               }
               else if(this.sourceRole is BaseMonster)
               {
                  oppositeArray = gc.getPlayerArray();
               }
            }
         }
         else if(this.sourceRole is BaseHero || this.sourceRole is BasePet || this.sourceRole is BaseSummon)
         {
            oppositeArray = gc.pWorld.monsterArray.concat(gc.pWorld.likeMonsterArray);
         }
         else
         {
            if(this.sourceRole is Monster32 || this.sourceRole is Monster124)
            {
               oppositeArray = gc.getPlayerArray().concat(gc.pWorld.likeMonsterArray);
            }
            else
            {
               oppositeArray = gc.getPlayerArray();
            }
            for each(var bh in gc.getPlayerArray())
            {
               if(bh.getSummon())
               {
                  oppositeArray.push(bh.getSummon());
               }
            }
            oppositeArray = oppositeArray.concat(gc.pWorld.getBaseLevelListener().getSummons());
            if(gc.pWorld.getBaseLevelListener() is StageListener131)
            {
               oppositeArray = oppositeArray.concat(StageListener131(gc.pWorld.getBaseLevelListener()).getFollowHero());
            }
         }
         if(this.attackIntervalCount == this.attackInterval)
         {
            this.newAttackId();
            this.attackIntervalCount = 0;
         }
         if(this.attackIntervalCount >= 0)
         {
            this.attackIntervalCount++;
         }
         for(j = 0; j < oppositeArray.length; j++)
         {
            o = oppositeArray[j];
            if(o)
            {
               if(o is MonsterRole4Hit5)
               {
                  if(MonsterRole4Hit5(o).getSourceRole() != this.sourceRole)
                  {
                     continue;
                  }
               }
               if(o.beAttackIdArray.indexOf(this.getAttackId()) == -1)
               {
                  if(o.beMagicAttack(this,this.sourceRole))
                  {
                     this.hitObject = o;
                     if(this.getImcName() == "Role1Bullet13")
                     {
                        if(this.sourceRole is Role1)
                        {
                           if(Role1(this.sourceRole).sid == gc.sid || gc.isSingleGame())
                           {
                              if(RandomControllor.getIns().getRandom() <= 0.18)
                              {
                                 Role1(this.sourceRole).createShallow();
                              }
                           }
                        }
                        else if(this.sourceRole is Monster34)
                        {
                           if(RandomControllor.getIns().getRandom() <= 0.18)
                           {
                              Monster34(this.sourceRole).createShallow();
                           }
                        }
                        else if(this.sourceRole is Monster121)
                        {
                           if(RandomControllor.getIns().getRandom() <= 0.18)
                           {
                              Monster121(this.sourceRole).createShallow();
                           }
                        }
                     }
                     if(this.funcWhenHit != null)
                     {
                        this.funcWhenHit(this);
                     }
                     o.beAttackIdArray.push(this.getAttackId());
                     this.maxAttackCount--;
                  }
               }
               if(this.getImcName() != "Monster126Bullet2_2" && this.getImcName() != "Monster135Bullet3")
               {
                  if(this.maxAttackCount > 0)
                  {
                     if(o is BaseHero)
                     {
                        if(BaseHero(o).getPet())
                        {
                           if(BaseHero(o).getPet().beAttackIdArray.indexOf(this.getAttackId()) == -1)
                           {
                              if(BaseHero(o).getPet().beMagicAttack(this,this.sourceRole))
                              {
                                 this.hitObject = BaseHero(o).getPet();
                                 if(this.funcWhenHit != null)
                                 {
                                    this.funcWhenHit(this);
                                 }
                                 BaseHero(o).getPet().beAttackIdArray.push(this.getAttackId());
                                 this.maxAttackCount--;
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         if(this.isDestroyWhenMaxHitCountLessThenZero)
         {
            if(this.maxAttackCount <= 0)
            {
               this.destroy();
            }
         }
      }
      
      public function setScale(xx:Number, yy:Number) : void
      {
         var m:Matrix = this.transform.matrix;
         m.a = m.a > 0 ? Math.abs(m.a) * xx : -Math.abs(m.a) * xx;
         m.d *= yy;
         this.transform.matrix = m;
      }
      
      public function setDisable() : void
      {
         this.isDisabled = true;
      }
      
      public function setUnDisable() : void
      {
         this.isDisabled = false;
         this.refreshSourceRoleAttackInfoObject();
      }
      
      public function destroy() : void
      {
         if(this.funcWhenDestroy != null)
         {
            this.funcWhenDestroy(this);
            this.funcWhenDestroy = null;
         }
         if(this.funcWhenHitWall != null)
         {
            this.funcWhenHitWall = null;
         }
         if(this.funcWhenHit != null)
         {
            this.funcWhenHit = null;
         }
         if(this.funcWhenInCount != null)
         {
            this.funcWhenInCount = null;
         }
         if(this.funcWhenEnterFrame != null)
         {
            this.funcWhenEnterFrame = null;
         }
         this.followDisplayObject = null;
         AUtils.stopAllChildren(this);
         TweenMax.killDelayedCallsTo(this.delayCall1);
         TweenMax.killDelayedCallsTo(this.delayCall2);
         this.isReadyToDestroy = true;
         if(this.imgMc)
         {
            this.imgMc.stop();
         }
         this.imgMc = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(this.sourceRole)
         {
            this.sourceRole = null;
         }
         this.sourceRoleAttackInfoObject = null;
      }
      
      public function setRole(bo:BaseObject) : void
      {
         this.sourceRole = bo;
         this.attackId = bo.getNumAttackId();
      }
      
      public function refreshSourceRoleAttackInfoObject() : void
      {
         var baseHurt:int = 0;
         if(!this.isDisabled)
         {
            this.sourceRoleAttackInfoObject = this.sourceRole.attackBackInfoDict[this.curAction];
            this._hurt = this.sourceRole.getRealPower(this.curAction);
            baseHurt = 0;
            if(this.sourceRole is BaseHero || this.sourceRole is BasePet)
            {
               baseHurt = this.sourceRole.getRealPower(this.curAction,false);
               if(this._hurt / baseHurt >= 1.9)
               {
                  this.isCrit = true;
               }
            }
            else if(this.sourceRole is BaseMonster)
            {
               baseHurt = (this.sourceRole as BaseMonster).getRealPower(this.curAction,false);
               if(this._hurt / baseHurt >= 1.9)
               {
                  this.isCrit = true;
               }
            }
         }
      }
      
      public function setHurtAdd(hurtAdd:Number) : void
      {
         this.hurtAdd = hurtAdd;
      }
      
      public function setDirect(d:int) : void
      {
         this.direct = d == 0 ? -1 : 1;
         AUtils.flipHorizontal(this,-this.direct);
      }
      
      public function getDirect() : int
      {
         return this.direct;
      }
      
      public function setAction(a:String) : void
      {
         this.curAction = a;
         var obj:Object = this.sourceRole.attackBackInfoDict[this.curAction];
         if(obj)
         {
            this.maxAttackCount = obj.hitMaxCount;
            this.attackInterval = obj.attackInterval;
         }
         this.refreshSourceRoleAttackInfoObject();
      }
      
      public function stopPlay() : void
      {
         if(this.imgMc)
         {
            this.imgMc.stop();
         }
      }
      
      public function continuePlay() : void
      {
         if(this.imgMc)
         {
            this.imgMc.play();
         }
      }
      
      public function getStickMCArray() : Array
      {
         var i:int = 0;
         var s:* = null;
         var returnArray:Array = [];
         var maxChild:int = this.imgMc.numChildren;
         for(i = 0; i < maxChild; )
         {
            s = this.imgMc.getChildByName("stick" + i) as MovieClip;
            if(s)
            {
               returnArray.push(s);
            }
            i++;
         }
         return returnArray;
      }
      
      public function setDestroyInCount(d:int) : void
      {
         this.destroyInCount = d;
      }
      
      public function setMaxAttackCount(m:uint) : void
      {
         this.maxAttackCount = m;
      }
      
      public function reduceMaxAttackCount() : void
      {
         this.maxAttackCount--;
      }
      
      public function getFrameLeft() : uint
      {
         if(this.imgMc)
         {
            return this.imgMc.totalFrames - this.imgMc.currentFrame;
         }
         return 0;
      }
      
      public function setImcName(n:String) : void
      {
         this.imcName = n;
      }
      
      public function getImcName() : String
      {
         return this.imcName;
      }
      
      public function getImgMc() : MovieClip
      {
         return this.imgMc;
      }
      
      public function newAttackId() : void
      {
         this.attackId++;
      }
      
      public function getAttackId() : String
      {
         return this.name + this.attackId;
      }
      
      public function get hurt() : int
      {
         return _hurt * (1 + this.hurtAdd);
      }
   }
}
