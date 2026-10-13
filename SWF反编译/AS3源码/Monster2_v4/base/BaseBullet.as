package base
{
   import com.greensock.*;
   import config.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.Matrix;
   
   public class BaseBullet extends Sprite
   {
       
      
      protected var imgMc:MovieClip;
      
      public var sourceRole:BaseObject;
      
      public var isCanBeAttack:Boolean = false;
      
      public var isDisabled:Boolean = false;
      
      private var lastStopGameState:Boolean = false;
      
      protected var direct:int = -1;
      
      public var speed:Number;
      
      public var curAction:String;
      
      protected var gc:Config;
      
      protected var attackId:int;
      
      protected var maxAttackCount:int;
      
      private var attackInterval:int;
      
      private var attackIntervalCount:int = 0;
      
      public function BaseBullet(param1:String)
      {
         super();
         this.imgMc = AUtils.getNewObj(param1);
         this.addChild(this.imgMc);
         this.gc = Config.getInstance();
         this.addEventListener(Event.ADDED_TO_STAGE,this.__added,true,0,false);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.__removed,true,0,false);
      }
      
      private function __added(param1:Event) : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.__bulletEnterFreame);
      }
      
      private function __removed(param1:Event) : void
      {
      }
      
      private function __bulletEnterFreame(param1:Event) : void
      {
         if(!this.gc.isStopGame)
         {
            this.step();
         }
         if(this.lastStopGameState != this.gc.isStopGame)
         {
            if(!this.lastStopGameState)
            {
               AUtils.stopAllChildren(this);
            }
            else
            {
               AUtils.startAllChildren(this);
            }
         }
         this.lastStopGameState = this.gc.isStopGame;
      }
      
      protected function step() : void
      {
         if(this.isDisabled)
         {
            return;
         }
         this.checkAttack();
      }
      
      public function setCanBeAttack() : void
      {
         this.isCanBeAttack = true;
      }
      
      public function checkAttack() : void
      {
         var oppositeArray:Array = null;
         var c:int = 0;
         var o:BaseObject = null;
         var k:int = 0;
         var bb:BaseBullet = null;
         var t:* = undefined;
         var obj:Object = null;
         var m:int = 0;
         var opp:BaseObject = null;
         var stickArray:Array = this.getStickMCArray();
         if(this.sourceRole is BaseHero)
         {
            oppositeArray = this.gc.pWorld.monsterArray;
         }
         else
         {
            oppositeArray = this.gc.getPlayerArray();
         }
         if(this.gc.gameMode == 3)
         {
            c = 0;
            while(c < this.gc.getPlayerArray().length)
            {
               if(this.gc.getPlayerArray()[c] != this.sourceRole)
               {
                  oppositeArray = [this.gc.getPlayerArray()[c]];
               }
               c++;
            }
         }
         if(this.attackIntervalCount == this.attackInterval)
         {
            this.newAttackId();
            this.attackIntervalCount = 0;
         }
         var j:int = 0;
         while(j < oppositeArray.length)
         {
            o = oppositeArray[j];
            k = 0;
            while(k < o.magicBulletArray.length)
            {
               bb = o.magicBulletArray[k] as BaseBullet;
               if(bb.isCanBeAttack)
               {
                  if(this.hitTestObject(bb))
                  {
                     t = bb;
                     bb.setDisable();
                     TweenMax.to(t,1,{
                        "alpha":0,
                        "onComplete":function():*
                        {
                           t.destroy();
                        }
                     });
                  }
               }
               k++;
            }
            if(o.isCanBeHurt())
            {
               if(o.beAttackIdArray.indexOf(this.getAttackId()) == -1)
               {
                  if(o.beMagicAttack(this,this.sourceRole))
                  {
                     obj = this.sourceRole.attackBackInfoDict[this.curAction];
                     if(obj)
                     {
                        if(obj.attackRange)
                        {
                           m = 0;
                           while(m < oppositeArray.length)
                           {
                              opp = oppositeArray[m];
                              if(opp != o)
                              {
                                 if(AUtils.GetDisBetweenTwoObj(o,opp) <= int(obj.attackRange))
                                 {
                                    opp.beMagicAttack(this,this.sourceRole,true);
                                 }
                              }
                              m++;
                           }
                        }
                     }
                     o.beAttackIdArray.push(this.getAttackId());
                     if(this.attackIntervalCount == 0)
                     {
                        this.attackIntervalCount = 1;
                     }
                     --this.maxAttackCount;
                     if(this.maxAttackCount <= 0)
                     {
                        this.destroy();
                        break;
                     }
                  }
               }
            }
            j++;
         }
         if(this.attackIntervalCount > 0)
         {
            ++this.attackIntervalCount;
         }
      }
      
      public function setScale(param1:Number, param2:Number) : void
      {
         var _loc3_:Matrix = this.transform.matrix;
         _loc3_.a = _loc3_.a > 0 ? Number(Math.abs(_loc3_.a) * param1) : Number(-Math.abs(_loc3_.a) * param1);
         _loc3_.d *= param2;
         this.transform.matrix = _loc3_;
      }
      
      public function setDisable() : void
      {
         this.isDisabled = true;
      }
      
      public function destroy() : void
      {
         var _loc1_:int = 0;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(this.sourceRole)
         {
            _loc1_ = this.sourceRole.magicBulletArray.indexOf(this);
            if(_loc1_ != -1)
            {
               this.sourceRole.magicBulletArray.splice(_loc1_,1);
            }
         }
         this.removeEventListener(Event.ENTER_FRAME,this.__bulletEnterFreame);
         delete global[this];
      }
      
      public function setRole(param1:BaseObject) : void
      {
         this.sourceRole = param1;
         this.attackId = param1.getNumAttackId();
         this.direct = this.sourceRole.transform.matrix.a;
         AUtils.flipHorizontal(this,this.direct);
      }
      
      public function setAction(param1:String) : void
      {
         this.curAction = param1;
         var _loc2_:Object = this.sourceRole.attackBackInfoDict[this.curAction];
         if(_loc2_)
         {
            this.maxAttackCount = _loc2_.hitMaxCount;
            this.attackInterval = _loc2_.attackInterval;
         }
      }
      
      public function stopPlay() : void
      {
         this.imgMc.stop();
      }
      
      public function continuePlay() : void
      {
         this.imgMc.play();
      }
      
      public function getStickMCArray() : Array
      {
         var _loc4_:MovieClip = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = this.imgMc.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(_loc4_ = this.imgMc.getChildByName("stick" + _loc3_) as MovieClip)
            {
               _loc1_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function newAttackId() : void
      {
         ++this.attackId;
      }
      
      public function getAttackId() : String
      {
         return this.name + this.attackId;
      }
   }
}
