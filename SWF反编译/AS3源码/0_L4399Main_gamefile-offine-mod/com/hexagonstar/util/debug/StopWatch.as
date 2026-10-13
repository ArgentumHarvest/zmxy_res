package com.hexagonstar.util.debug
{
   import flash.utils.getTimer;
   
   public class StopWatch
   {
       
      
      private var _started:Boolean = false;
      
      private var _startTimeKeys:Array;
      
      private var _stopTimeKeys:Array;
      
      private var _title:String;
      
      public function StopWatch()
      {
         super();
         reset();
      }
      
      public function start(title:String = "") : void
      {
         if(!_started)
         {
            _title = title;
            _started = true;
            _startTimeKeys.push(getTimer());
         }
      }
      
      public function stop() : void
      {
         var stopTime:int = 0;
         if(_started)
         {
            stopTime = getTimer();
            _stopTimeKeys[_startTimeKeys.length - 1] = stopTime;
            _started = false;
         }
      }
      
      public function reset() : void
      {
         _startTimeKeys = [];
         _stopTimeKeys = [];
         _started = false;
      }
      
      public function toString() : String
      {
         var i:int = 0;
         var s1:int = 0;
         var s2:int = 0;
         var s:String = "\n ********************* [STOPWATCH] *********************";
         if(_title != "")
         {
            s += "\n * " + _title;
         }
         i = 0;
         while(i < _startTimeKeys.length)
         {
            s1 = _startTimeKeys[i];
            s2 = _stopTimeKeys[i];
            s += "\n * started [" + format(s1) + "ms] stopped [" + format(s2) + "ms] time [" + format(s2 - s1) + "ms]";
            i++;
         }
         if(i == 0)
         {
            s += "\n * never started.";
         }
         else
         {
            s += "\n * total runnning time: " + timeInSeconds + "s";
         }
         return s + "\n *******************************************************";
      }
      
      public function get started() : Boolean
      {
         return _started;
      }
      
      public function get timeInMilliSeconds() : int
      {
         var i:int = 0;
         if(_started)
         {
            _stopTimeKeys[_startTimeKeys.length - 1] = getTimer();
         }
         var r:int = 0;
         for(i = 0; i < _startTimeKeys.length; )
         {
            r += _stopTimeKeys[i] - _startTimeKeys[i];
            i++;
         }
         return r;
      }
      
      public function get timeInSeconds() : Number
      {
         return timeInMilliSeconds / 1000;
      }
      
      private function format(v:int) : String
      {
         var i:int = 0;
         var s:String = "";
         var l:int = v.toString().length;
         for(i = 0; i < 5 - l; )
         {
            s += "0";
            i++;
         }
         return s + v;
      }
   }
}
