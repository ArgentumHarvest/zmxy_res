package export.level.StageListener222Children
{
   import export.ThroughWall;
   import mvc.controllor.RandomControllor;
   
   public class MovingFloorSl222 extends ThroughWall
   {
      
      public static var DIRECT_LEFT:String = "left";
      
      public static var DIRECT_RIGHT:String = "right";
       
      
      private var direct:String = "";
      
      public function MovingFloorSl222()
      {
         super();
         this.speedX = (RandomControllor.getIns().getRandom() - 0.5) * 10;
         if(this.speedX > 0)
         {
            if(this.speedX < 2)
            {
               this.speedX = 2;
            }
         }
         else if(this.speedX > -2)
         {
            this.speedX = -2;
         }
         this.visible = false;
         this.userDataName = "stage222futai";
      }
      
      override public function step() : void
      {
         super.step();
         if(this.x < -this.width / 2)
         {
            this.destroy();
         }
      }
      
      public function randomInit() : void
      {
         if(RandomControllor.getIns().getRandom() < 0.75)
         {
            this.width = 245;
            this.userDataName = "stage222futai245";
         }
         else
         {
            this.width = 110;
         }
         if(RandomControllor.getIns().getRandom() < 0.5)
         {
            this.setDirect(DIRECT_RIGHT);
            this.x = -this.width / 2;
         }
         else
         {
            this.setDirect(DIRECT_LEFT);
            this.x = 1100 + this.width / 2;
         }
         this.y = 150 + RandomControllor.getIns().getRandom() * 400;
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
