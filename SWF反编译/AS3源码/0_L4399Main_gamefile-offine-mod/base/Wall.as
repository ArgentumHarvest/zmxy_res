package base
{
   import config.Config;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Wall extends MovieClip
   {
       
      
      [Inspectable(defaultValue="0")]
      public var speedX:Number = 0;
      
      [Inspectable(defaultValue="0")]
      public var speedY:Number = 0;
      
      [Inspectable(defaultValue="0")]
      public var moveTime:int = 0;
      
      [Inspectable(defaultValue="")]
      public var userDataName:String = "";
      
      protected var equationX:Number;
      
      protected var constX:Number;
      
      protected var equationX2:Number;
      
      protected var sourceRotation:int;
      
      protected var minX:Number;
      
      protected var maxX:Number;
      
      public var isReadyToDestroy:Boolean = false;
      
      protected var gc:Config;
      
      protected var userData:MovieClip;
      
      private var _wallFilterIdx:int = -1;
      
      public function Wall()
      {
         super();
         gc = Config.getInstance();
         this.sourceRotation = Math.round(this.rotation);
         this.rotation = 0;
         var sourceHeight:Number = this.height;
         var sourceWidth:Number = this.width;
         this.rotation = this.sourceRotation;
         if(this.rotation != 90)
         {
            equationX = Math.tan(this.rotation * 3.141592653589793 / 180);
         }
         else
         {
            equationX = 1;
         }
         equationX2 = -1 / equationX;
         var xxxx:Number = sourceHeight / 2 / Math.cos(Math.abs(this.rotation * 3.141592653589793 / 180));
         constX = -equationX * this.x + this.y - xxxx;
         if(this.rotation < 0)
         {
            this.maxX = (this.y - this.height / 2 - constX) / equationX;
            this.minX = this.x - this.width / 2;
         }
         else
         {
            this.maxX = this.x + this.width / 2;
            this.minX = (this.y - this.height / 2 - constX) / equationX;
         }
         this.addEventListener("addedToStage",__added);
      }
      
      public function setYByRole(mc:*) : Point
      {
         var nextX:Number = NaN;
         var nextY:Number = NaN;
         var returnPoint:Point = new Point();
         var lineY:Number = equationX * mc.x + this.constX;
         if(lineY > mc.y)
         {
            mc.standInObj = this;
         }
         if(!mc.isWalkOrRun() && !mc.isBeAttacking() && !mc.isCanMoveWhenAttack())
         {
            return returnPoint;
         }
         var colipseRect:Rectangle = mc.getNextFrameXBounds();
         var offsetX:Number = Math.abs(Math.cos(this.rotation * 3.141592653589793 / 180) * mc.speed.x);
         var offsetY:Number = Math.tan(this.rotation * 3.141592653589793 / 180) * offsetX;
         if(!this.isOutOfThisLine(mc) || this.isOutOfThisLine(mc) && this.getBounds(gc.gameSence).intersects(mc.getNextFrameXBounds()))
         {
            if(mc.speed.x >= 0)
            {
               if(this.rotation < 0)
               {
                  offsetY = -Math.abs(offsetY);
               }
               else
               {
                  offsetY = Math.abs(offsetY);
               }
            }
            else
            {
               offsetX = -offsetX;
               if(this.rotation < 0)
               {
                  offsetY = Math.abs(offsetY);
               }
               else
               {
                  offsetY = -Math.abs(offsetY);
               }
            }
            if(mc is BaseHero)
            {
               if(mc.isCanMoveByStage())
               {
                  returnPoint.x = offsetX;
                  returnPoint.y = offsetY;
               }
            }
            else
            {
               returnPoint.x = offsetX;
               returnPoint.y = offsetY;
            }
         }
         return returnPoint;
      }
      
      public function isOutOfThisLine(mc:*) : Boolean
      {
         var colipseRect:Rectangle = mc.getNextFrameBounds();
         if(this.rotation < 0)
         {
            return !(colipseRect.x + colipseRect.width >= this.minX && colipseRect.x + colipseRect.width <= this.maxX);
         }
         return !(colipseRect.x >= this.minX && colipseRect.x <= this.maxX);
      }
      
      protected function __added(evt:Event) : void
      {
         this.removeEventListener("addedToStage",__added);
      }
      
      public function step() : void
      {
         var idx:* = 0;
         if(!this.userData)
         {
            if(this.userDataName != "")
            {
               this.userData = AUtils.getNewObj(userDataName) as MovieClip;
               this.userData.x = this.x;
               this.userData.y = this.y;
               idx = uint(gc.gameSence.getChildIndex(this));
               if(idx != -1)
               {
                  gc.gameSence.addChildAt(this.userData,idx);
               }
            }
         }
         else
         {
            this.userData.x = this.x;
            this.userData.y = this.y;
         }
         if(!this.isStatic())
         {
            this.x += this.speedX;
            this.y += this.speedY;
         }
      }
      
      public function setUserDataName(name:String) : void
      {
         this.userDataName = name;
      }
      
      public function getUserDataName() : String
      {
         return this.userDataName;
      }
      
      public function getUserData() : MovieClip
      {
         return this.userData;
      }
      
      public function destroy() : void
      {
         this.isReadyToDestroy = true;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(this.userData)
         {
            if(gc.gameSence.contains(this.userData))
            {
               gc.gameSence.removeChild(this.userData);
            }
            this.userData = null;
         }
         var idx:int = gc.pWorld.getWallArray().indexOf(this);
         if(idx != -1)
         {
            gc.pWorld.getWallArray().splice(idx,1);
         }
      }
      
      public function getMirrorVector() : Point
      {
         if(Math.round(this.rotation) != 90)
         {
            return new Point(1,this.equationX);
         }
         return new Point(0,this.equationX);
      }
      
      public function isRoundWall() : Boolean
      {
         return false;
      }
      
      public function getNextFrameBound() : Rectangle
      {
         var returnRect:Rectangle = this.getBounds(gc.gameSence);
         if(!this.isStatic())
         {
            returnRect.offsetPoint(new Point(this.speedX,this.speedY));
         }
         return returnRect;
      }
      
      public function isStatic() : Boolean
      {
         return this.speedX == 0 && this.speedY == 0;
      }
      
      public function get wallFilterIdx() : int
      {
         return _wallFilterIdx;
      }
      
      public function set wallFilterIdx(value:int) : void
      {
         _wallFilterIdx = value;
      }
   }
}
