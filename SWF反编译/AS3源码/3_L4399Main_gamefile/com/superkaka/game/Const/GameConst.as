package com.superkaka.game.Const
{
   import flash.display.Stage;
   
   public class GameConst
   {
      
      public static var stage:Stage;
      
      public static var PLAYER_1:uint = 0;
      
      public static var PLAYER_2:uint = 1;
      
      public static var USE_ASSETS_WORKER:Boolean = true;
      
      public static var USE_TOTAL_BITMAPDATA:Boolean = true;
      
      public static var USE_UNION_BITMAPDATA:Boolean = false;
      
      public static var USE_CONFIGURES_WORKER:Boolean = true;
      
      public static var LOG_DATA:Object;
      
      public static var UID:int = 100000 * Math.random() + 100000;
      
      public static var useCrypt:Boolean = false;
      
      public static var useDebug:Boolean = true;
      
      public static var localData:Boolean = true;
      
      public static var localLogin:Boolean = true;
      
      public static var isSingleGame:Boolean = true;
      
      public static var isPreLoading:Boolean = true;
      
      public static var tempSet:Boolean = false;
      
      public static var IP:String = "192.168.54.223";
      
      public static var ASSETS_URL:String = "Assets/";
      
      public static var GATE_IP:String = "192.168.54.223";
      
      public static var GATE_PORT:int = 4097;
      
      public static var PRIVATE_KEY:String = "";
      
      public static var isAutoTest:Boolean = false;
      
      public static var isPressureTest:Boolean = true;
      
      public static var loginKey:String = "";
      
      public static var gateServerId:int = -1;
      
      public static var isRelease:Boolean = true;
      
      public static var fbId:int = -1;
      
      public static var fbKey:String = "";
      
      public static var roomId:int = -1;
      
      public static var roomKey:String = "";
      
      public static var VERSION:String = "V1.20";
      
      public static var IS_CHECK:Boolean = true;
      
      public static var PATH:String = "";
      
      public static var gameTime:Number;
      
      public static var SOURCE_WIDTH:int = 1100;
      
      public static var SOURCE_HEIGHT:int = 640;
      
      public static var CM:int = 1;
      
      public static var TIME:Number;
      
      public static var SERVERID:int = 1;
      
      public static var FLAG:String;
      
      public static var SITE:String = "";
       
      
      public function GameConst()
      {
         super();
      }
      
      public static function get versionNum() : int
      {
         return int(VERSION.slice(1) * 1000);
      }
      
      public static function get resizeWidth() : Number
      {
         var w:Number = stage.stageWidth;
         w = w > 1100 ? 1100 : GameConst.stage.stageWidth;
         return w < 940 ? 940 : w;
      }
      
      public static function get resizeHeight() : Number
      {
         var h:Number = stage.stageHeight;
         h = h > 640 ? 640 : GameConst.stage.stageHeight;
         return h < 590 ? 590 : h;
      }
   }
}
