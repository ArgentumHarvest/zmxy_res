package export.muti
{
   import com.greensock.TweenMax;
   import config.Config;
   import flash.display.Bitmap;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import my.MainGame;
   
   public class NodeInfo
   {
       
      
      public var PK_OR_FB:uint = 0;
      
      private var _GameMode:uint;
      
      private var _MaxVisitors:uint;
      
      private var _ltdVisitors:uint;
      
      private var _roomName:String;
      
      private var _mpInfo:uint;
      
      private var _averLevel:uint;
      
      private var _singleIdPlayerNum:uint;
      
      public var isStart:Boolean = false;
      
      public var isOver:Boolean = false;
      
      private var timeCount:uint;
      
      private var showResultTimer:Timer;
      
      private var resultBm:Bitmap;
      
      public var isMonsterAppeared:Boolean = false;
      
      private var gc:Config;
      
      public var totalGetBytesLen:uint = 0;
      
      public var startTime:uint = 0;
      
      private var resultContinue:int = 96;
      
      public function NodeInfo()
      {
         showResultTimer = new Timer(1000);
         super();
      }
      
      public function start() : void
      {
         trace("-----start====");
         gc = Config.getInstance();
         timeCount = 0;
         this.isStart = true;
         this.isOver = false;
         if(gc.isInPk())
         {
            gc.obbsiteArray = gc.pWorld.getOtherHeroArray();
         }
         else if(gc.isInFuben())
         {
            if(gc.isRoomOnwer)
            {
               this.isMonsterAppeared = true;
               if(this.mpInfo == 2001)
               {
                  MainGame.getInstance().createMonster(2001,500,300,-1,1);
               }
               else if(this.mpInfo == 2002)
               {
                  MainGame.getInstance().createMonster(2002,500,300,-1,1);
               }
               else if(this.mpInfo == 2003)
               {
                  MainGame.getInstance().createMonster(2003,500,300,-1,1);
               }
            }
            gc.obbsiteArray = gc.pWorld.monsterArray;
         }
         this.totalGetBytesLen = 0;
         this.startTime = getTimer();
      }
      
      public function step() : void
      {
         if(!this.isStart || this.isOver)
         {
            return;
         }
         this.timeCount++;
         if(this._GameMode == ArenaSprite.ARENASPRITE_MODE_1V1)
         {
            if(gc.obbsiteArray.length == 0)
            {
               this.victory();
            }
            else if(gc.pWorld.heroArray.length == 0)
            {
               this.lose();
            }
         }
         else if(this._GameMode == ArenaSprite.ARENASPRITE_MODE_HUNZHAN)
         {
            if(gc.obbsiteArray.length == 0)
            {
               this.victory();
            }
            else if(gc.pWorld.heroArray.length == 0)
            {
            }
            if(gc.pWorld.heroArray.length == 0 && gc.obbsiteArray.length <= 1)
            {
               this.lose();
            }
         }
         else if(this.isMonsterAppeared && gc.pWorld.monsterArray.length == 0)
         {
            if(resultContinue > 0)
            {
               resultContinue--;
               if(resultContinue == 0)
               {
                  this.victory();
               }
            }
         }
         else if(gc.pWorld.heroArray.length == 0 && gc.pWorld.getOtherHeroArray().length == 0)
         {
            this.lose();
         }
      }
      
      private function victory() : void
      {
         trace("------胜利-------");
         this.isStart = false;
         this.isOver = true;
         this.isMonsterAppeared = false;
         this.resultBm = AUtils.getImageObj("pkVictor") as Bitmap;
         this.resultBm.x = 300;
         this.resultBm.y = 200;
         gc.gameInfo.addChild(this.resultBm);
         if(!showResultTimer.hasEventListener("timer"))
         {
            showResultTimer.addEventListener("timer",__timer);
         }
         showResultTimer.start();
      }
      
      private function lose() : void
      {
         trace("------失败-------");
         this.isStart = false;
         this.isOver = true;
         this.isMonsterAppeared = false;
         this.resultBm = AUtils.getImageObj("pkLose") as Bitmap;
         this.resultBm.x = 300;
         this.resultBm.y = 200;
         gc.gameInfo.addChild(this.resultBm);
         if(!showResultTimer.hasEventListener("timer"))
         {
            showResultTimer.addEventListener("timer",__timer);
         }
         showResultTimer.start();
      }
      
      private function __timer(evt:TimerEvent) : void
      {
         if(showResultTimer.currentCount == 6)
         {
            this.removeResult();
         }
         else if(showResultTimer.currentCount == 7)
         {
            this.doWhenQuitRoom();
         }
      }
      
      private function removeResult() : void
      {
         if(this.resultBm && gc.gameInfo.contains(this.resultBm))
         {
            gc.gameInfo.removeChild(this.resultBm);
         }
      }
      
      public function isStartIng() : Boolean
      {
         return this.isStart;
      }
      
      public function initWhenJoinRoom() : void
      {
         this.isStart = false;
         this.isOver = false;
         this.isMonsterAppeared = false;
         showResultTimer.stop();
         showResultTimer.reset();
         if(showResultTimer.hasEventListener("timer"))
         {
            showResultTimer.removeEventListener("timer",__timer);
         }
         timeCount = 0;
      }
      
      private function doWhenQuitRoom() : void
      {
         trace("=========doWhenQuitRoom======");
         TweenMax.killAll();
         gc.quitRoom();
         showResultTimer.stop();
         showResultTimer.reset();
         if(showResultTimer.hasEventListener("timer"))
         {
            showResultTimer.removeEventListener("timer",__timer);
         }
         this.initWhenJoinRoom();
      }
      
      public function get ltdVisitors() : uint
      {
         return _ltdVisitors;
      }
      
      public function set ltdVisitors(value:uint) : void
      {
         _ltdVisitors = value;
      }
      
      public function get singleIdPlayerNum() : uint
      {
         return _singleIdPlayerNum;
      }
      
      public function set singleIdPlayerNum(value:uint) : void
      {
         _singleIdPlayerNum = value;
      }
      
      public function get averLevel() : uint
      {
         return _averLevel;
      }
      
      public function set averLevel(value:uint) : void
      {
         _averLevel = value;
      }
      
      public function get mpInfo() : uint
      {
         return _mpInfo;
      }
      
      public function set mpInfo(value:uint) : void
      {
         _mpInfo = value;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function set roomName(value:String) : void
      {
         _roomName = value;
      }
      
      public function get MaxVisitors() : uint
      {
         return _MaxVisitors;
      }
      
      public function set MaxVisitors(value:uint) : void
      {
         _MaxVisitors = value;
      }
      
      public function get GameMode() : uint
      {
         return _GameMode;
      }
      
      public function set GameMode(value:uint) : void
      {
         _GameMode = value;
      }
   }
}
