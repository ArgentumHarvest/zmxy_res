package export.level.StageListener461Children
{
   import base.BaseHero;
   import export.bullet.SpecialEffectBullet;
   
   public class Stage461Bullet extends SpecialEffectBullet
   {
       
      
      private var _targetRotation:Number;
      
      public function Stage461Bullet(imgMcName:String)
      {
         _targetRotation = 45 + Math.random() * 45;
         super(imgMcName);
      }
      
      override public function step2() : void
      {
         super.step2();
         shootAngle();
      }
      
      protected function shootAngle() : void
      {
         calculateAngle();
         this.x += -14 * Math.cos(_targetRotation * 3.141592653589793 / 180);
         this.y += -14 * Math.sin(_targetRotation * 3.141592653589793 / 180);
      }
      
      protected function calculateAngle() : void
      {
         var delta:Number = NaN;
         var targetAngle:Number = getBetweenAngle;
         if(_targetRotation != targetAngle)
         {
            delta = targetAngle - _targetRotation;
            if(delta > 180)
            {
               delta -= 360;
            }
            if(delta < -180)
            {
               delta += 360;
            }
            if(delta > 0)
            {
               _targetRotation += 2;
            }
            else
            {
               _targetRotation -= 2;
            }
            if(Math.abs(delta) < 2)
            {
               _targetRotation = targetAngle;
            }
            this.rotation = _targetRotation;
         }
      }
      
      private function get getBetweenAngle() : Number
      {
         var target:BaseHero = gc.getRandomPlayer();
         var angle:Number = 0;
         if(target)
         {
            angle = Math.atan2(this.y - target.y,this.x - target.x) * 180 / 3.141592653589793;
         }
         return angle;
      }
   }
}
