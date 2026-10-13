package config
{
   import PhysicsWorlds.PhysicsWorld;
   import base.BaseHero;
   import event.AEventDispatcher;
   import export.FloorBg;
   import export.GameInfo;
   import export.GameSence;
   import export.Infomation;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.net.LocalConnection;
   import flash.utils.Timer;
   import my.AllEquipment;
   import my.KeyBoardControl;
   import my.ViewControllor;
   import storage.MemoryClass;
   import user.User;
   
   public class Config
   {
      
      static var instance:Config;
      
      public static var MODE1:int = 1;
      
      public static var MODE2:int = 2;
      
      public static var MODE3:int = 3;
       
      
      public var memory:MemoryClass;
      
      public var opening:Boolean = false;
      
      public var eventManger:AEventDispatcher;
      
      public var playNum:uint;
      
      public var hero1:BaseHero;
      
      public var hero2:BaseHero;
      
      public var player1:User;
      
      public var player2:User;
      
      public var gameSence:GameSence;
      
      public var gameInfo:GameInfo;
      
      public var pWorld:PhysicsWorld;
      
      public var bg1:FloorBg;
      
      public var bg2:MovieClip;
      
      public var stage:Stage;
      
      public var isStopGame:Boolean = false;
      
      public var vControllor:ViewControllor;
      
      public var keyboardControl:KeyBoardControl;
      
      public var allEquip:AllEquipment;
      
      public var otherList:Array;
      
      public var isHideDebug:Boolean = false;
      
      public var curBigStage:uint = 1;
      
      public var curBigLevel:uint = 1;
      
      public var lc:LocalConnection;
      
      public var playerName:String;
      
      public var logInfo:Object;
      
      public var isFirstLogin:Boolean = true;
      
      public var loginAlert:MovieClip;
      
      public var lastSubmitScore:int;
      
      public var usernameHash:String = "";
      
      public var huodong61Flag:Boolean = false;
      
      public var ts:Infomation;
      
      public var num1:int = 1;
      
      public var num2:int = 2;
      
      public var num5:int = 3;
      
      public var num7:int = 7;
      
      public var num3:int = 3;
      
      public var num6:int = 6;
      
      public var num4:int = 4;
      
      public var num8:int = 8;
      
      public var num9:int = 9;
      
      public var num0:int = 0;
      
      public var curLevel:uint = 1;
      
      public var curStage:uint = 4;
      
      public var isLevelClear:Boolean = false;
      
      public var maxMonsterPerScreen:int = 8;
      
      public var gameMode:int;
      
      public var saveIntervelCount:int;
      
      public var saveTimer:Timer;
      
      public var logInfoTimer:Timer;
      
      public function Config()
      {
         this.eventManger = new AEventDispatcher();
         this.allEquip = new AllEquipment();
         this.otherList = new Array();
         this.ts = new Infomation();
         super();
         if(!instance)
         {
            instance = this;
            this.initData();
         }
      }
      
      public static function getInstance() : Config
      {
         return instance;
      }
      
      public function initData() : void
      {
         this.hero1 = null;
         this.hero2 = null;
         this.player1 = new User();
         this.player1.controlPlayer = 0;
         this.player2 = new User();
         this.player2.controlPlayer = 1;
         this.curBigLevel = 1;
         this.curBigStage = 1;
         this.memory = new MemoryClass();
      }
      
      public function destroyGame() : void
      {
         this.otherList = [];
         this.isLevelClear = false;
      }
      
      public function isFb() : Boolean
      {
         return this.curStage == 9 && this.curLevel == 1;
      }
      
      public function isFb1() : Boolean
      {
         return this.curStage == 9 && this.curLevel == 1;
      }
      
      public function getPlayerArray() : Array
      {
         var _loc1_:Array = [];
         if(this.hero1)
         {
            _loc1_.push(this.hero1);
         }
         if(this.hero2)
         {
            _loc1_.push(this.hero2);
         }
         return _loc1_;
      }
   }
}
