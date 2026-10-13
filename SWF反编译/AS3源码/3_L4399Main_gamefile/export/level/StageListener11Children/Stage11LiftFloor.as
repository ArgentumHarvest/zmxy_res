package export.level.StageListener11Children
{
   import export.ThroughWall;
   
   public class Stage11LiftFloor extends ThroughWall
   {
       
      
      public function Stage11LiftFloor()
      {
         this.speedY = -4;
         super();
         this.width = 237;
         this.userDataName = "stage11lift";
         this.visible = false;
      }
      
      override public function step() : void
      {
         super.step();
         if(this.y < -1900)
         {
            this.destroy();
         }
      }
   }
}
