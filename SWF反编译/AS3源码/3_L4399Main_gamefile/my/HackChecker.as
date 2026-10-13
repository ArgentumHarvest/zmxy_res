package my
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public final class HackChecker
   {
      
      public static const checkInterval:int = 1000;
      
      private static var blur:int = 20;
      
      private static var timer:Timer;
      
      private static var prevDate:Number;
      
      private static var prevTime:int;
      
      public static var hackHandler:Function = defaultHackHandler;
       
      
      public function HackChecker()
      {
         super();
      }
      
      public static function enabledCheckSpeedUp(interval:int = 1000, blur:int = 20) : void
      {
         HackChecker.blur = blur;
         timer = new Timer(interval);
         timer.addEventListener("timer",timeHandler);
         timer.start();
      }
      
      private static function timeHandler(event:TimerEvent) : void
      {
         var nextTime:int = getTimer();
         var newDate:Number = new Date().time;
         var interval:int = nextTime - prevTime;
         if(!isNaN(prevDate) && Math.abs(interval - (newDate - prevDate)) > blur)
         {
            hackHandler();
         }
         prevDate = newDate;
         prevTime = nextTime;
      }
      
      public static function defaultHackHandler() : void
      {
         throw new Error("请不要使用作弊工具!");
      }
   }
}
