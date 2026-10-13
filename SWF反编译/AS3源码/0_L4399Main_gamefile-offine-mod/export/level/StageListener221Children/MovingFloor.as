package export.level.StageListener221Children
{
   import base.BaseHero;
   import export.ThroughWall;
   import export.level.StageListener221;
   import manager.MusicManager;
   import mvc.controllor.RandomControllor;
   
   public class MovingFloor extends ThroughWall
   {
      
      public static var DIRECT_LEFT:String = "left";
      
      public static var DIRECT_RIGHT:String = "right";
       
      
      private var direct:String = "";
      
      private var kind:uint = 1;
      
      private var mm:MusicManager;
      
      public function MovingFloor(kind:uint)
      {
         super();
         mm = MusicManager.getInstance();
         this.kind = kind;
         this.speedX = (RandomControllor.getIns().getRandom() - 0.5) * 12;
         if(this.speedX > 0)
         {
            if(this.speedX < 3)
            {
               this.speedX = 3;
            }
         }
         else if(this.speedX > -3)
         {
            this.speedX = -3;
         }
         this.visible = false;
         this.userDataName = "stage131Futai" + this.kind;
      }
      
      override public function step() : void
      {
         super.step();
         if(this.x < -this.width / 2)
         {
            this.destroy();
         }
         for each(var bh in gc.getPlayerArray())
         {
            if(bh.lastStandingObj == null && bh.standInObj == this)
            {
               mm.play("stage221mmmm" + this.kind);
               if(gc.pWorld.getBaseLevelListener() is StageListener221)
               {
                  (gc.pWorld.getBaseLevelListener() as StageListener221).addMusic(this.kind);
               }
            }
         }
      }
      
      public function randomInit() : void
      {
         this.width = 110;
         if(RandomControllor.getIns().getRandom() < 0.5)
         {
            this.setDirect(DIRECT_RIGHT);
            this.x = -this.width / 2;
         }
         else
         {
            this.setDirect(DIRECT_LEFT);
            this.x = 1200 + this.width / 2;
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
