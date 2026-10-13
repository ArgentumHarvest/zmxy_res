package export
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class SingleShaiZi extends MovieClip
   {
       
      
      public var speedVec:Point;
      
      public var speedVal:Number = 20;
      
      public var targetPoint:Point;
      
      public var targetPointArray:Array;
      
      public var stopPoint:Point;
      
      public var targetValue:uint = 1;
      
      public var power:int = 5;
      
      public var isOver:Boolean = false;
      
      public function SingleShaiZi()
      {
         speedVec = new Point(0,0);
         targetPointArray = [];
         stopPoint = new Point(50,50);
         super();
      }
      
      public function step() : void
      {
         if(this.isOver)
         {
            return;
         }
         this.x += this.speedVec.x * this.speedVal;
         this.y += this.speedVec.y * this.speedVal;
         if(this.targetPoint == null)
         {
            this.setTargetPoint(this.getRandomTargetPoint());
         }
         else if(AUtils.GetDisBetweenTwoObj(this,this.targetPoint) <= 21)
         {
            this.x = this.targetPoint.x;
            this.y = this.targetPoint.y;
            this.changeTargetPoint();
         }
      }
      
      public function setTargetPoint(p:Point) : void
      {
         this.targetPoint = p;
         this.speedVec = AUtils.GetNextPointByTwoObj(this,this.targetPoint);
      }
      
      private function getRandomTargetPoint() : Point
      {
         var randPointIdx:uint = RandomControllor.getIns().getRandom() * targetPointArray.length;
         return targetPointArray[randPointIdx] as Point;
      }
      
      private function changeTargetPoint() : void
      {
         var tp:* = null;
         this.speedVec.x = 0;
         this.speedVec.y = 0;
         if(this.power > 0)
         {
            tp = this.getRandomTargetPoint();
            while(tp == this.targetPoint)
            {
               tp = this.getRandomTargetPoint();
            }
            this.setTargetPoint(tp);
            this.power--;
         }
         else if(this.power == 0)
         {
            this.setTargetPoint(this.stopPoint);
            this.power--;
         }
         else
         {
            this.setFinalValue();
         }
      }
      
      private function setFinalValue() : void
      {
         this.gotoAndStop(1);
         var mc:MovieClip = this.getChildAt(0) as MovieClip;
         mc.gotoAndStop(this.targetValue);
         this.isOver = true;
      }
   }
}
