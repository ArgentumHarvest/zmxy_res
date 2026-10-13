package com.hexagonstar.util.debug
{
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.StatusEvent;
   import flash.net.LocalConnection;
   import flash.net.SharedObject;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.system.System;
   import flash.utils.ByteArray;
   import flash.utils.describeType;
   
   public final class Debug
   {
      
      public static const LEVEL_DEBUG:int = 0;
      
      public static const LEVEL_INFO:int = 1;
      
      public static const LEVEL_WARN:int = 2;
      
      public static const LEVEL_ERROR:int = 3;
      
      public static const LEVEL_FATAL:int = 4;
      
      private static var _filterLevel:int = 0;
      
      private static var _isConnected:Boolean = false;
      
      private static var _isPollingFPS:Boolean = false;
      
      private static var _isEnabled:Boolean = true;
      
      private static var _stage:Stage;
      
      private static var _connection:LocalConnection;
      
      private static var _fpsMeter:FPSMeter;
      
      private static var _stopWatch:StopWatch;
       
      
      public function Debug()
      {
         super();
      }
      
      public static function trace(... args) : void
      {
         var l:int = args[1] is int ? args[1] : 1;
         if(l >= _filterLevel && l < 7)
         {
            send("onData",args[0],l,0);
         }
      }
      
      public static function traceObj(obj:Object, depth:int = 64, level:int = 1) : void
      {
         if(level >= _filterLevel && level < 7)
         {
            send("onData",obj,level,depth);
         }
      }
      
      public static function inspect(obj:Object) : void
      {
         send("onInspect",obj,1,-1);
      }
      
      public static function hexDump(obj:Object) : void
      {
         send("onHexDump",obj,0,0);
      }
      
      public static function forceGC() : void
      {
         try
         {
         }
         catch(e1:Error)
         {
            try
            {
               new LocalConnection().connect("forceGC");
               new LocalConnection().connect("forceGC");
            }
            catch(e2:Error)
            {
            }
         }
      }
      
      public static function clear() : void
      {
         Debug.trace("[%CLR%]",5);
      }
      
      public static function delimiter() : void
      {
         Debug.trace("[%DLT%]",5);
      }
      
      public static function pause() : void
      {
         Debug.trace("[%PSE%]",5);
      }
      
      public static function time() : void
      {
         Debug.trace("[%TME%]",5);
      }
      
      public static function createCategory(id:int, name:String = "", textColor:uint = 0, bgColor:uint = 16776960) : void
      {
         send("onCategory",[id,name,textColor,bgColor],0,0);
      }
      
      public static function monitor(stage:Stage, pollInterval:int = 500) : void
      {
         if(_isPollingFPS)
         {
            Debug.stop();
         }
         if(_isEnabled && !_fpsMeter)
         {
            _isPollingFPS = true;
            _stage = stage;
            sendCapabilities();
            _fpsMeter = new FPSMeter(_stage,pollInterval);
            _fpsMeter.addEventListener("fpsUpdate",onFPSUpdate);
            _fpsMeter.start();
         }
      }
      
      public static function mark(color:uint = 16711935) : void
      {
         send("onMarker",color,1,-1);
      }
      
      public static function stop() : void
      {
         if(_fpsMeter)
         {
            _isPollingFPS = false;
            _fpsMeter.stop();
            _fpsMeter.removeEventListener("fpsUpdate",onFPSUpdate);
            _fpsMeter = null;
            _stage = null;
         }
      }
      
      public static function timerStart(title:String = "") : void
      {
         if(_isEnabled)
         {
            if(!_stopWatch)
            {
               _stopWatch = new StopWatch();
            }
            _stopWatch.start(title);
         }
      }
      
      public static function timerStop() : void
      {
         if(_stopWatch)
         {
            _stopWatch.stop();
         }
      }
      
      public static function timerReset() : void
      {
         if(_stopWatch)
         {
            _stopWatch.reset();
         }
      }
      
      public static function timerInMilliSeconds() : void
      {
         if(_stopWatch)
         {
            Debug.trace(_stopWatch.timeInMilliSeconds + "ms");
         }
      }
      
      public static function timerInSeconds() : void
      {
         if(_stopWatch)
         {
            Debug.trace(_stopWatch.timeInSeconds + "s");
         }
      }
      
      public static function timerToString() : void
      {
         if(_stopWatch)
         {
            Debug.trace(_stopWatch.toString());
         }
      }
      
      public static function timerStopToString(reset:Boolean = false) : void
      {
         if(_stopWatch)
         {
            _stopWatch.stop();
            Debug.trace(_stopWatch.toString());
            if(reset)
            {
               _stopWatch.reset();
            }
         }
      }
      
      public static function get filterLevel() : int
      {
         return _filterLevel;
      }
      
      public static function set filterLevel(v:int) : void
      {
         if(v >= 0 && v < 5)
         {
            _filterLevel = v;
         }
      }
      
      public static function get enabled() : Boolean
      {
         return _isEnabled;
      }
      
      public static function set enabled(v:Boolean) : void
      {
         _isEnabled = v;
      }
      
      private static function onFPSUpdate(e:Event) : void
      {
         send("onFPS",_fpsMeter.fps + "," + _stage.frameRate + "," + _fpsMeter.frt + "," + System.totalMemory);
      }
      
      private static function onStatus(e:StatusEvent) : void
      {
      }
      
      private static function send(m:String, d:*, l:int = 1, r:int = 0) : void
      {
         var s:Number = NaN;
         var byteArray:* = null;
         if(_isEnabled)
         {
            if(!_isConnected)
            {
               _isConnected = true;
               _connection = new LocalConnection();
               _connection.addEventListener("status",onStatus);
            }
            s = 0;
            if(typeof d == "string")
            {
               s = String(d).length;
            }
            else if(typeof d == "object")
            {
               byteArray = new ByteArray();
               byteArray.writeObject(d);
               s = byteArray.length;
               byteArray = null;
            }
            if(s > 39000)
            {
               storeDataLSO(m,d);
               m = "onLargeData";
               d = null;
            }
            _connection.send("_alcon_lc",m,d,l,r,"");
         }
      }
      
      private static function sendCapabilities() : void
      {
         var n:* = null;
         var xml:XML = describeType(Capabilities);
         var a:Array = [];
         for each(var node in xml.*)
         {
            n = node.@name.toString();
            if(n.length > 0 && n != "_internal" && n != "prototype")
            {
               a.push({
                  "p":n,
                  "v":Capabilities[n].toString()
               });
            }
         }
         a.sortOn(["p"],1);
         send("onCap",a);
      }
      
      private static function storeDataLSO(m:String, d:*) : void
      {
         var flushResult:* = null;
         var sharedObject:SharedObject = SharedObject.getLocal("alcon","/");
         sharedObject.data["alconMethod"] = m;
         sharedObject.data["alconData"] = d;
         try
         {
            flushResult = sharedObject.flush();
            if(flushResult == "flushed")
            {
               return;
            }
         }
         catch(e:Error)
         {
            Security.showSettings("localStorage");
         }
      }
   }
}
