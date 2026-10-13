package my
{
   import flash.display.Stage;
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
      
      public static function offsetQuality(s:Stage, amount:int) : void
      {
         var qualities:Array = ["low","medium","high","best"];
         var newQ:int = qualities.indexOf(s.quality.toLowerCase()) + amount;
         if(newQ >= qualities.length)
         {
            newQ = qualities.length - 1;
         }
         else if(newQ < 0)
         {
            newQ = 0;
         }
         s.quality = qualities[newQ];
      }
      
      public function startCalc() : void
      {
         lastTime = getTimer();
         framesPassed = 0;
      }
      
      public function stopCalc() : void
      {
         stage.removeEventListener("enterFrame",update);
      }
      
      public function update() : void
      {
         var t2:* = 0;
         framesPassed++;
         if(framesPassed == resetAfter)
         {
            t2 = uint(getTimer());
            fps = 1000 * framesPassed / (t2 - lastTime);
            lastTime = t2;
            framesPassed = 0;
            if(display)
            {
               display.text = fps.toFixed(precision) + " fps";
            }
         }
      }
   }
}
