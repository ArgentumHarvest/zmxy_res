package export.level.StageListener223Children
{
   import base.BaseHero;
   import export.ThroughWall;
   
   public class MovingFloorSl223 extends ThroughWall
   {
       
      
      private var direct:String = "";
      
      public var initY:Number = 0;
      
      private var turnToUpCount:uint = 8;
      
      public function MovingFloorSl223(kind:uint)
      {
         super();
         this.speedX = 0;
         this.visible = false;
         this.userDataName = "stagelistener223futai" + kind;
      }
      
      override public function step() : void
      {
         super.step();
         for each(var bh in gc.getPlayerArray())
         {
            if(bh.lastStandingObj == null && bh.standInObj == this)
            {
               this.turnToUpCount = 8;
               this.speedY = 2;
            }
         }
         if(this.turnToUpCount > 0)
         {
            turnToUpCount--;
            if(this.turnToUpCount == 0)
            {
               this.speedY = -4;
            }
         }
         if(this.y < this.initY)
         {
            this.y = this.initY;
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
