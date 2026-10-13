package export.level.Stagelistener611Children
{
   import com.greensock.TweenMax;
   import export.ThroughWall;
   import mvc.controllor.RandomControllor;
   
   public class MovingFloorSl611 extends ThroughWall
   {
      
      public static var DIRECT_LEFT:String = "left";
      
      public static var DIRECT_RIGHT:String = "right";
       
      
      private var direct:String = "";
      
      private var type:int = 1;
      
      private var _tw:TweenMax;
      
      private var continueTime:int;
      
      public function MovingFloorSl611()
      {
         super();
         this.continueTime = (4 + RandomControllor.getIns().getRandom() * 4) * gc.frameClips;
         this.speedX = 4 + (RandomControllor.getIns().getRandom() - 0.5) * 3;
         this.visible = false;
         type = 1 + int(RandomControllor.getIns().getRandom() * 3);
         if(type == 1)
         {
            this.width = 250;
         }
         else
         {
            this.width = 180;
         }
         this.setDirect(DIRECT_RIGHT);
         this.userDataName = "sl611futai" + type;
      }
      
      private function complete() : void
      {
         this.destroy();
      }
      
      override public function step() : void
      {
         super.step();
         if(this.userData)
         {
            this.userData.alpha = this.alpha;
         }
         if(this.continueTime > 0)
         {
            this.continueTime--;
            if(this.continueTime == 0)
            {
               this._tw = TweenMax.to(this,1.5,{
                  "alpha":0,
                  "onComplete":complete
               });
            }
         }
         if(this.x > 1400)
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
         if(this._tw)
         {
            this._tw.kill();
            this._tw = null;
         }
         super.destroy();
      }
   }
}
