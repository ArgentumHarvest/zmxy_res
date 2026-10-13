package com.hexagonstar.util.debug
{
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class FPSMeter extends EventDispatcher
   {
      
      public static const FPS_UPDATE:String = "fpsUpdate";
       
      
      private var _stage:Stage;
      
      private var _timer:Timer;
      
      private var _pollInterval:int;
      
      private var _fps:int;
      
      private var _frt:int;
      
      private var _ms:int;
      
      private var _isRunning:Boolean;
      
      private var _delay:int;
      
      private var _delayMax:int = 10;
      
      private var _prev:int;
      
      public function FPSMeter(stage:Stage, pollInterval:int = 500)
      {
         super();
         _stage = stage;
         _pollInterval = pollInterval;
         reset();
      }
      
      public function start() : void
      {
         if(!_isRunning)
         {
            _isRunning = true;
            _timer = new Timer(_pollInterval,0);
            _timer.addEventListener("timer",onTimer);
            _stage.addEventListener("enterFrame",onEnterFrame);
            _timer.start();
         }
      }
      
      public function stop() : void
      {
         if(_isRunning)
         {
            _timer.stop();
            _timer.removeEventListener("timer",onTimer);
            _stage.removeEventListener("enterFrame",onEnterFrame);
            _timer = null;
            reset();
         }
      }
      
      public function reset() : void
      {
         _fps = 0;
         _frt = 0;
         _ms = 0;
         _delay = 0;
         _prev = 0;
         _isRunning = false;
      }
      
      public function get fps() : int
      {
         return _fps;
      }
      
      public function get frt() : int
      {
         return _frt;
      }
      
      private function onTimer(event:TimerEvent) : void
      {
         dispatchEvent(new Event("fpsUpdate"));
      }
      
      private function onEnterFrame(event:Event) : void
      {
         var t:Number = getTimer();
         _delay++;
         if(_delay >= _delayMax)
         {
            _delay = 0;
            _fps = int(1000 * _delayMax / (t - _prev));
            _prev = t;
         }
         _frt = t - _ms;
         _ms = t;
      }
   }
}
