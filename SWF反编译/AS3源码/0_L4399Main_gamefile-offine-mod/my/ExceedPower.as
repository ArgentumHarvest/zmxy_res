package my
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   
   public class ExceedPower extends Sprite
   {
       
      
      private var w:Number;
      
      private var h:Number;
      
      private var lineColor:uint;
      
      private var fillColor:uint;
      
      private var maxPower:int;
      
      private var currentFillColor:int;
      
      public function ExceedPower(w:Number, h:Number, maxPower:int = 0, lineColor:uint = 16711680, fillColor:uint = 65280)
      {
         super();
         this.w = w;
         this.h = h;
         this.lineColor = lineColor;
         this.fillColor = fillColor;
         this.maxPower = maxPower;
         this.alpha = 0;
      }
      
      public function step(currentPower:int) : void
      {
         this.graphics.clear();
         var powerRate:Number = currentPower / this.maxPower;
         powerRate = Math.min(powerRate,1);
         this.graphics.lineStyle(1,lineColor);
         this.graphics.drawRect(0,0,w,h);
         if(powerRate > 0)
         {
            this.graphics.lineStyle(0,fillColor,0);
            if(powerRate == 1)
            {
               if(currentFillColor != 1122867)
               {
                  this.currentFillColor = 1122867;
               }
               else
               {
                  this.currentFillColor = 11189196;
               }
               this.graphics.beginFill(this.currentFillColor);
            }
            else
            {
               this.graphics.beginFill(this.fillColor);
            }
            this.graphics.drawRect(1,1,(w - 2) * powerRate,h - 2);
         }
         this.graphics.endFill();
         if(powerRate > 0 && this.alpha == 0)
         {
            TweenMax.to(this,0.5,{"alpha":1});
         }
         if(powerRate == 0 && this.alpha == 1)
         {
            TweenMax.to(this,0.5,{"alpha":0});
         }
      }
      
      public function setMaxPower(v:uint) : void
      {
         this.maxPower = v;
      }
      
      public function clear() : void
      {
         this.graphics.clear();
      }
   }
}
