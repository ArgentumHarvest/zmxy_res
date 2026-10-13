package export.level.StageListener471Children
{
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.bullet.SpecialEffectBullet;
   
   public class Monster140SpecialBullet extends SpecialEffectBullet
   {
       
      
      private var target:BaseObject;
      
      private var moveToTargetInterval:uint = 48;
      
      private var moveToTargetIntervalCount:uint = 0;
      
      public function Monster140SpecialBullet(imgMcName:String)
      {
         super(imgMcName);
      }
      
      override public function step2() : void
      {
         super.step2();
         if(this.target)
         {
            if(this.moveToTargetIntervalCount > 0)
            {
               this.moveToTargetIntervalCount--;
            }
            if(this.moveToTargetIntervalCount == 0)
            {
               this.moveToTarget();
               this.selectNextTarget();
               this.moveToTargetIntervalCount = this.moveToTargetInterval;
            }
         }
         else
         {
            this.selectNextTarget();
         }
      }
      
      private function moveToTarget() : void
      {
         var disX:Number = NaN;
         if(this.target)
         {
            disX = Math.abs(this.x - this.target.x);
            TweenMax.to(this,2.1 * (disX / 1000),{"x":this.target.x});
         }
      }
      
      private function selectNextTarget() : void
      {
         var target:BaseObject = gc.getRandomPlayer();
         if(target)
         {
            this.target = target;
         }
      }
      
      override public function destroy() : void
      {
         this.target = null;
         super.destroy();
      }
   }
}
