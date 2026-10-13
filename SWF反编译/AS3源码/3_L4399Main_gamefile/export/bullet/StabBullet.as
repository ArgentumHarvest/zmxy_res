package export.bullet
{
   import base.BaseBullet;
   import com.greensock.TweenMax;
   import flash.geom.Point;
   
   public class StabBullet extends BaseBullet
   {
       
      
      public var speedValue:int = 1;
      
      private var addSpeedValue:int = 0;
      
      private var count:int = 0;
      
      private var isRush:Boolean = false;
      
      private var target:Point;
      
      private var source:Point;
      
      private var targetVectorMo:Point;
      
      private var targetRotation:int;
      
      private var turnTime:Number;
      
      public function StabBullet(name:String, t:Point, turnTime:Number, s:Point = null)
      {
         targetVectorMo = new Point(0,1);
         super(name);
         this.target = t;
         this.source = s;
         this.turnTime = turnTime;
         this.setRotation();
      }
      
      private function setRotation() : void
      {
         this.speed = new Point();
         this.alpha = 0;
         if(target)
         {
            if(this.source)
            {
               targetVectorMo = AUtils.GetNextPointByTwoObj(this.source,target);
            }
            else
            {
               targetVectorMo = AUtils.GetNextPointByTwoObj(this,target);
            }
            if(targetVectorMo.y != 0)
            {
               var k:Number = -targetVectorMo.x / targetVectorMo.y;
               targetRotation = Math.atan(k) * 180 / 3.141592653589793;
               if(targetVectorMo.x < 0 && targetVectorMo.y > 0 || targetVectorMo.x > 0 && targetVectorMo.y > 0)
               {
                  targetRotation += 180;
               }
            }
            else if(targetVectorMo.x > this.x)
            {
               targetRotation = 90;
            }
            else
            {
               targetRotation = -90;
            }
         }
         else
         {
            targetRotation = 180;
         }
         TweenMax.to(this,this.turnTime,{
            "alpha":1,
            "rotation":targetRotation,
            "onCompleteParams":[this],
            "onComplete":function(sb:StabBullet):*
            {
               sb.rush();
            }
         });
      }
      
      override protected function step() : void
      {
         super.step();
         if(this.isRush)
         {
            if(target)
            {
               this.x += targetVectorMo.x * (this.speedValue + this.addSpeedValue);
               this.y += targetVectorMo.y * (this.speedValue + this.addSpeedValue);
            }
            else
            {
               this.speed.x = 0;
               this.speed.y += 0.5;
               this.x += this.speed.x;
               this.y += this.speed.y;
            }
            addSpeedValue += count * 0.05;
            count++;
         }
         if(count > gc.frameClips * 10 || this.y > 1000 || this.y < -2500)
         {
            this.destroy();
         }
      }
      
      public function rush() : void
      {
         this.isRush = true;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
