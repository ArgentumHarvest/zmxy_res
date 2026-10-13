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
      
      public function ExceedPower(param1:Number, param2:Number, param3:int = 0, param4:uint = 16711680, param5:uint = 65280)
      {
         super();
         this.w = param1;
         this.h = param2;
         this.lineColor = param4;
         this.fillColor = param5;
         this.maxPower = param3;
         this.alpha = 0;
      }
      
      public function step(param1:int, param2:int = 1) : void
      {
         this.graphics.clear();
         var _loc3_:Number = param1 / this.maxPower;
         _loc3_ = Math.min(_loc3_,1);
         this.graphics.lineStyle(1,this.lineColor);
         this.graphics.drawRect(0,0,this.w,this.h);
         if(_loc3_ > 0)
         {
            this.graphics.lineStyle(0,this.fillColor,0);
            if(_loc3_ == 1)
            {
               if(this.currentFillColor != 1122867)
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
            if(param2 == 1)
            {
               this.graphics.drawRect(1,1,(this.w - 2) * _loc3_,this.h - 2);
            }
            else
            {
               this.graphics.drawRect(this.w - 1 - (this.w - 2) * _loc3_,1,(this.w - 2) * _loc3_,this.h - 2);
            }
         }
         this.graphics.endFill();
         if(_loc3_ > 0 && this.alpha == 0)
         {
            TweenMax.to(this,0.5,{"alpha":1});
         }
         if(_loc3_ == 0 && this.alpha == 1)
         {
            TweenMax.to(this,0.5,{"alpha":0});
         }
      }
   }
}
