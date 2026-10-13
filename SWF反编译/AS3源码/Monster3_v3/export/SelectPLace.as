package export
{
   import config.*;
   import event.*;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.*;
   import flash.text.TextField;
   import flash.utils.*;
   
   public class SelectPLace extends Sprite
   {
       
      
      public var s1_1:MovieClip;
      
      public var s1_2:MovieClip;
      
      public var s1_3:MovieClip;
      
      public var s2_1:MovieClip;
      
      public var s2_2:MovieClip;
      
      public var s2_3:MovieClip;
      
      public var s3_1:MovieClip;
      
      public var s3_2:MovieClip;
      
      public var s3_3:MovieClip;
      
      public var s4_1:MovieClip;
      
      public var showBuySkill:MovieClip;
      
      public var arena:MovieClip;
      
      public var submitbtn:SimpleButton;
      
      public var savebtn:SimpleButton;
      
      public var saveInterval:TextField;
      
      public var s4_2:MovieClip;
      
      public var s4_3:MovieClip;
      
      private var gc:Config;
      
      public function SelectPLace()
      {
         super();
         this.gc = Config.getInstance();
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
         this.init();
      }
      
      private function init() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               this["s" + (_loc1_ + 1) + "_" + (_loc2_ + 1)].buttonMode = true;
               _loc2_++;
            }
            _loc1_++;
         }
         this.showBuySkill.buttonMode = true;
         this.arena.buttonMode = true;
         if(this.gc.player1 && this.gc.player1.protectedObject.lhValue >= 160 || this.gc.player2 && this.gc.player2.protectedObject.lhValue >= 160)
         {
            this.showBuySkill.gotoAndStop(3);
         }
         if(this.gc.playNum == 2)
         {
            this.arena.gotoAndStop(3);
         }
         this.gc.saveTimer = new Timer(1000);
         this.gc.saveTimer.addEventListener(TimerEvent.TIMER,this.__timer);
         if(this.gc.saveIntervelCount != 0)
         {
            this.savebtn.enabled = false;
            this.savebtn.mouseEnabled = false;
            this.gc.saveTimer.start();
         }
         this.gc.logInfoTimer = new Timer(1000);
         this.gc.logInfoTimer.addEventListener(TimerEvent.TIMER,this.__logInfoTimer);
         this.gc.logInfoTimer.start();
      }
      
      private function added(param1:Event) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(!this.gc.isHideDebug || this.gc.isYourFather)
         {
            this.gc.curBigStage = 4;
            this.gc.curBigLevel = 1;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.gc.curBigStage)
         {
            _loc3_ = _loc2_ + 1;
            if(_loc3_ < this.gc.curBigStage)
            {
               _loc3_ = 3;
            }
            else
            {
               _loc3_ = this.gc.curBigLevel;
            }
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               this["s" + (_loc2_ + 1) + "_" + (_loc4_ + 1)].addEventListener(MouseEvent.CLICK,this.onSelected);
               this["s" + (_loc2_ + 1) + "_" + (_loc4_ + 1)].addEventListener(MouseEvent.ROLL_OVER,this.mOver);
               this["s" + (_loc2_ + 1) + "_" + (_loc4_ + 1)].addEventListener(MouseEvent.ROLL_OUT,this.mOut);
               _loc4_++;
            }
            _loc2_++;
         }
         this["s" + this.gc.curBigStage + "_" + this.gc.curBigLevel].gotoAndStop(3);
         this.showBuySkill.addEventListener(MouseEvent.CLICK,this.buySkill);
         this.showBuySkill.addEventListener(MouseEvent.ROLL_OVER,this.mOver);
         this.showBuySkill.addEventListener(MouseEvent.ROLL_OUT,this.mOut);
         if(this.gc.playNum == 2)
         {
            this.arena.addEventListener(MouseEvent.CLICK,this.arenaClick);
            this.arena.addEventListener(MouseEvent.ROLL_OVER,this.mOver);
            this.arena.addEventListener(MouseEvent.ROLL_OUT,this.mOut);
         }
         this.submitbtn.addEventListener(MouseEvent.CLICK,this.submitScore);
         this.savebtn.addEventListener(MouseEvent.CLICK,this.saveGame);
      }
      
      private function removed(param1:Event) : void
      {
         var _loc3_:uint = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = 0;
            while(_loc3_ < 3)
            {
               this["s" + (_loc2_ + 1) + "_" + (_loc3_ + 1)].removeEventListener(MouseEvent.CLICK,this.onSelected);
               this["s" + (_loc2_ + 1) + "_" + (_loc3_ + 1)].removeEventListener(MouseEvent.ROLL_OVER,this.mOver);
               this["s" + (_loc2_ + 1) + "_" + (_loc3_ + 1)].removeEventListener(MouseEvent.ROLL_OUT,this.mOut);
               _loc3_++;
            }
            _loc2_++;
         }
         this.showBuySkill.removeEventListener(MouseEvent.CLICK,this.buySkill);
         this.showBuySkill.removeEventListener(MouseEvent.ROLL_OVER,this.mOver);
         this.showBuySkill.removeEventListener(MouseEvent.ROLL_OUT,this.mOut);
         this.arena.removeEventListener(MouseEvent.CLICK,this.arenaClick);
         this.arena.removeEventListener(MouseEvent.ROLL_OVER,this.mOver);
         this.arena.removeEventListener(MouseEvent.ROLL_OUT,this.mOut);
         this.submitbtn.removeEventListener(MouseEvent.CLICK,this.submitScore);
         this.savebtn.removeEventListener(MouseEvent.CLICK,this.saveGame);
         this.gc.saveTimer.removeEventListener(TimerEvent.TIMER,this.__timer);
         this.gc.saveTimer.stop();
         this.gc.saveTimer = null;
         this.gc.logInfoTimer.removeEventListener(TimerEvent.TIMER,this.__logInfoTimer);
         this.gc.logInfoTimer.stop();
         this.gc.logInfoTimer = null;
      }
      
      private function mOver(param1:MouseEvent) : void
      {
         param1.currentTarget.gotoAndStop(2);
      }
      
      private function mOut(param1:MouseEvent) : void
      {
         if(param1.currentTarget != this["s" + this.gc.curBigStage + "_" + this.gc.curBigLevel])
         {
            param1.currentTarget.gotoAndStop(1);
         }
         else
         {
            param1.currentTarget.gotoAndStop(3);
         }
      }
      
      private function arenaClick(param1:MouseEvent) : *
      {
         this.gc.gameMode = Config.MODE3;
         this.gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
      }
      
      private function onSelected(param1:MouseEvent) : void
      {
         if(this.gc.playNum == 1)
         {
            this.gc.gameMode = Config.MODE1;
         }
         else if(this.gc.playNum == 2)
         {
            this.gc.gameMode = Config.MODE2;
         }
         this.gc.curStage = int(String(param1.currentTarget.name).substr(1,1));
         this.gc.curLevel = int(String(param1.currentTarget.name).substr(3,1));
         this.gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function doAfterChangeIn() : void
      {
         this.visible = true;
      }
      
      private function buySkill(param1:*) : void
      {
         this.gc.eventManger.dispatchEvent(new CommonEvent("showBuySkill",{"state":"maping"}));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function submitScore(param1:*) : void
      {
         var _loc2_:int = 0;
         this.gc.eventManger.dispatchEvent(new CommonEvent("showNightYears"));
      }
      
      private function saveGame(param1:MouseEvent) : void
      {
         if(GMain.serviceHold)
         {
            this.gc.logInfo = GMain.serviceHold.isLog;
            if(this.gc.isHideDebug)
            {
               if(this.gc.saveIntervelCount <= 0)
               {
                  this.gc.memory.setStorage();
                  this.gc.saveIntervelCount = 30;
                  this.gc.saveTimer.start();
               }
            }
         }
      }
      
      private function __logInfoTimer(param1:TimerEvent) : void
      {
         if(GMain.serviceHold)
         {
            this.gc.logInfo = GMain.serviceHold.isLog;
            if(!this.gc.logInfo)
            {
               if(this.parent)
               {
                  this.parent.removeChild(this);
               }
               if(this.gc.hero1)
               {
                  this.gc.hero1.dispose();
                  this.gc.hero1.roleProperies.destory();
               }
               if(this.gc.hero2)
               {
                  this.gc.hero2.dispose();
                  this.gc.hero2.roleProperies.destory();
               }
               this.gc.initData();
               GMain.getInstance().switchSence("GameMenu");
            }
         }
      }
      
      private function __timer(param1:TimerEvent) : void
      {
         if(this.gc.saveIntervelCount > 0)
         {
            --this.gc.saveIntervelCount;
            this.saveInterval.text = "(" + String(this.gc.saveIntervelCount) + ")";
            this.savebtn.enabled = false;
            this.savebtn.mouseEnabled = false;
         }
         else
         {
            this.savebtn.enabled = true;
            this.savebtn.mouseEnabled = true;
            this.saveInterval.text = "";
         }
      }
   }
}
