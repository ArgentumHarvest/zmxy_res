package export.bullet
{
   import base.BaseBullet;
   import base.BaseObject;
   import flash.geom.Point;
   
   public class EnemyMoveBullet extends BaseBullet
   {
       
      
      protected var distance:int;
      
      protected var isAddSpeed:Boolean = false;
      
      protected var funcWhenDistanceOver:Function;
      
      protected var addSpeedX:Number = 0;
      
      protected var addSpeedY:Number = 0;
      
      protected var moveTarget:BaseObject;
      
      public var addSpeedValue:Number = 0;
      
      public function EnemyMoveBullet(imgMcName:String)
      {
         super(imgMcName);
      }
      
      override protected function step() : void
      {
         var speexNum:Number = NaN;
         var p:* = null;
         super.step();
         if(this.moveTarget)
         {
            if(!this.moveTarget.isDead() && !this.moveTarget.isReadyToDestroy)
            {
               speexNum = Math.sqrt(this.speed.x * this.speed.x + this.speed.y * this.speed.y);
               p = AUtils.GetNextPointByTwoObj(this,this.moveTarget);
               speexNum += addSpeedValue;
               this.speed.x = p.x * speexNum;
               this.speed.y = p.y * speexNum;
            }
            else
            {
               this.moveTarget = null;
            }
         }
         this.x += this.speed.x;
         this.y += this.speed.y;
         this.speed.x += this.addSpeedX;
         this.speed.y += this.addSpeedY;
         distance -= Math.sqrt(this.speed.x * this.speed.x + this.speed.y * this.speed.y);
         if(distance <= 0)
         {
            if(this.funcWhenDistanceOver != null)
            {
               this.funcWhenDistanceOver(this.x,this.y);
            }
            this.destroy();
         }
      }
      
      public function setMoveTarget(t:BaseObject) : void
      {
         this.moveTarget = t;
      }
      
      public function getMoveTarget() : BaseObject
      {
         return this.moveTarget;
      }
      
      public function setAddSpeed(addx:Number, addy:Number) : void
      {
         this.addSpeedX = addx;
         this.addSpeedY = addy;
      }
      
      public function setDistance(d:int, func:Function = null) : void
      {
         this.distance = d;
         this.funcWhenDistanceOver = func;
      }
      
      public function setSpeed(s:Number, y:Number = 0) : void
      {
         this.speed.x = s;
         this.speed.y = y;
      }
      
      public function getSpeed() : Point
      {
         return this.speed;
      }
      
      override public function setRole(bo:BaseObject) : void
      {
         super.setRole(bo);
      }
   }
}
