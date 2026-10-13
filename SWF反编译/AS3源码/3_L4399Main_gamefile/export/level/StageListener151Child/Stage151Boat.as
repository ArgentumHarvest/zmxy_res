package export.level.StageListener151Child
{
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.ThroughWall;
   import export.summon.SummonCowKing;
   import flash.events.Event;
   
   public class Stage151Boat extends ThroughWall
   {
       
      
      private var sourceRole:BaseObject;
      
      private var intervalCount:int = 0;
      
      private var INTERVALCOUNTCONST:int = -1;
      
      private var offsetYValue:uint = 70;
      
      public function Stage151Boat(role:BaseObject, timeCount:int)
      {
         super();
         this.sourceRole = role;
         this.INTERVALCOUNTCONST = timeCount;
         this.width = 130;
         this.height = 20;
         this.visible = false;
         this.setUserDataName("MagicBigBottleData");
         if(this.sourceRole is SummonCowKing)
         {
            offsetYValue = 75;
         }
      }
      
      override public function step() : void
      {
         super.step();
         var offsetX:Number = 0;
         var offsetY:Number = 0;
         if(Math.abs(this.x - this.sourceRole.x) > 30)
         {
            offsetX = this.sourceRole.x - this.x;
         }
         if(Math.abs(this.y - this.sourceRole.y) > 62)
         {
            offsetY = this.sourceRole.y - this.y;
         }
         TweenMax.killChildTweensOf(this);
         if(offsetX != 0)
         {
            if(offsetX > 0)
            {
               AUtils.flipHorizontal(this.userData,1);
            }
            else if(offsetX < 0)
            {
               AUtils.flipHorizontal(this.userData,-1);
            }
            TweenMax.to(this,0.4,{"x":this.x + offsetX});
         }
         if(offsetY != 0)
         {
            TweenMax.to(this,0.1,{"y":this.y + offsetY + offsetYValue});
         }
         if(this.sourceRole.isReadyToDestroy)
         {
            this.destroy();
         }
         else if(this.INTERVALCOUNTCONST >= 0)
         {
            this.intervalCount++;
            if(this.intervalCount >= this.INTERVALCOUNTCONST)
            {
               this.destroy();
               this.intervalCount = 0;
            }
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.dispatchEvent(new Event("destroy"));
      }
   }
}
