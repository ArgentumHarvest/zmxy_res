package my
{
   import flash.display.Stage;
   import flash.display.StageQuality;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.getTimer;
   
   public class FPS
   {
       
      
      public var lastTime:uint;
      
      public var framesPassed:uint = 0;
      
      public var resetAfter:uint = 15;
      
      public var fps:Number;
      
      public var display:TextField;
      
      public var changeQuality:Boolean = false;
      
      public var traceFPS:Boolean = false;
      
      public var lowFPS:Number = 20;
      
      public var highFPS:Number = 30;
      
      public var precision:uint = 2;
      
      public var stage:Stage;
      
      public function FPS()
      {
         super();
      }
      
      public static function offsetQuality(param1:Stage, param2:int) : void
      {
         var _loc3_:Array = [StageQuality.LOW,StageQuality.MEDIUM,StageQuality.HIGH,StageQuality.BEST];
         var _loc4_:int;
         if((_loc4_ = _loc3_.indexOf(param1.quality.toLowerCase()) + param2) >= _loc3_.length)
         {
            _loc4_ = _loc3_.length - 1;
         }
         else if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         param1.quality = _loc3_[_loc4_];
      }
      
      public function startCalc() : void
      {
         this.lastTime = getTimer();
         this.framesPassed = 0;
      }
      
      public function stopCalc() : void
      {
         this.stage.removeEventListener(Event.ENTER_FRAME,this.update);
      }
      
      public function update() : void
      {
         var _loc1_:uint = 0;
         ++this.framesPassed;
         if(this.framesPassed == this.resetAfter)
         {
            _loc1_ = getTimer();
            this.fps = 1000 * this.framesPassed / (_loc1_ - this.lastTime);
            this.lastTime = _loc1_;
            this.framesPassed = 0;
            if(this.display)
            {
               this.display.text = this.fps.toFixed(this.precision) + " fps";
            }
         }
      }
   }
}
