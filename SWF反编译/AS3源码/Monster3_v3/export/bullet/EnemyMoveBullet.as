package export.bullet
{
   import base.BaseBullet;
   import base.BaseObject;
   
   public class EnemyMoveBullet extends BaseBullet
   {
       
      
      private var distance:int;
      
      private var isAddSpeed:Boolean = false;
      
      public function EnemyMoveBullet(param1:String)
      {
         super(param1);
      }
      
      override protected function step() : void
      {
         if(this.isDisabled)
         {
            return;
         }
         super.step();
         this.x += this.speed;
         if(this.speed < 7 && this.isAddSpeed)
         {
            if(this.speed > 0)
            {
               this.speed += 0.4;
            }
            else
            {
               this.speed -= 0.4;
            }
         }
         this.distance -= Math.abs(this.speed);
         if(this.distance <= 0)
         {
            this.destroy();
         }
      }
      
      public function setAddSpeed() : void
      {
         this.isAddSpeed = true;
      }
      
      public function setDistance(param1:int) : void
      {
         this.distance = param1;
      }
      
      public function setSpeed(param1:Number) : void
      {
         this.speed = param1;
         if(this.direct == 1)
         {
            this.speed = -this.speed;
         }
      }
      
      public function getSpeed() : int
      {
         return this.speed;
      }
      
      override public function setRole(param1:BaseObject) : void
      {
         super.setRole(param1);
      }
   }
}
