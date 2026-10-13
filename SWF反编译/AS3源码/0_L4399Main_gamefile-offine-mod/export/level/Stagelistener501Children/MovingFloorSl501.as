package export.level.Stagelistener501Children
{
   import base.BaseHero;
   import export.ThroughWall;
   
   public class MovingFloorSl501 extends ThroughWall
   {
      
      public static var DIRECT_LEFT:String = "left";
      
      public static var DIRECT_RIGHT:String = "right";
       
      
      private var direct:String = "";
      
      public function MovingFloorSl501()
      {
         super();
         this.speedX = 3;
         this.visible = false;
         this.userDataName = "stage501Boat";
      }
      
      override public function step() : void
      {
         super.step();
         if(this.x + this.speedX > 760)
         {
            this.moveLeft();
            this.setHeroSpeed();
         }
         else if(this.x + this.speedX < 200)
         {
            this.moveRight();
            this.setHeroSpeed();
         }
         if(this.x < -this.width / 2)
         {
            this.destroy();
         }
      }
      
      public function setStatic() : void
      {
         this.speedX = 0;
         this.speedY = 0;
      }
      
      public function setDirect(str:String) : void
      {
         this.direct = str;
         if(this.direct == DIRECT_LEFT)
         {
            this.moveLeft();
         }
         else
         {
            this.moveRight();
         }
      }
      
      private function setHeroSpeed() : void
      {
         for each(var bh in gc.getPlayerArray())
         {
            if(bh.standInObj)
            {
               if(bh.standInObj == this)
               {
                  bh.speed.x = 0;
               }
            }
         }
      }
      
      protected function moveRight() : void
      {
         if(this.speedX < 0)
         {
            this.speedX *= -1;
         }
      }
      
      protected function moveLeft() : void
      {
         if(this.speedX > 0)
         {
            this.speedX *= -1;
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
