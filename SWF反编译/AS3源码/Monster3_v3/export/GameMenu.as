package export
{
   import com.hexagonstar.util.debug.*;
   import config.*;
   import event.*;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.*;
   import manager.*;
   
   public class GameMenu extends Sprite
   {
       
      
      public var simpleGame:SimpleButton;
      
      public var doubleGame:SimpleButton;
      
      public var successRoom:SimpleButton;
      
      public var gameShop:SimpleButton;
      
      public var gameHelp:SimpleButton;
      
      public var gameRecommend:SimpleButton;
      
      public var aboutUs:SimpleButton;
      
      public var backbtn:SimpleButton;
      
      public var continueGame:SimpleButton;
      
      public var newGame:SimpleButton;
      
      public var tangseng:SimpleButton;
      
      public var wukong:SimpleButton;
      
      private var isnew:Boolean = true;
      
      private var gc:Config;
      
      private var currentName:String;
      
      var readid:uint = 0;
      
      public function GameMenu()
      {
         super();
         this.gc = Config.getInstance();
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      private function added(param1:Event) : *
      {
         this.simpleGame.addEventListener(MouseEvent.CLICK,this.selectNum);
         this.doubleGame.addEventListener(MouseEvent.CLICK,this.selectNum);
         this.backbtn.addEventListener(MouseEvent.CLICK,this.backClick);
         this.continueGame.addEventListener(MouseEvent.CLICK,this.continueGameGetTime);
         this.newGame.addEventListener(MouseEvent.CLICK,this.newGameGetTime);
         this.gameHelp.addEventListener(MouseEvent.CLICK,this.hellpClick);
         this.aboutUs.addEventListener(MouseEvent.CLICK,this.about);
         this.tangseng.addEventListener(MouseEvent.CLICK,this.tangSeng);
         this.wukong.addEventListener(MouseEvent.CLICK,this.wuKong);
         this.gameShop.addEventListener(MouseEvent.CLICK,this.shoping);
         this.successRoom.addEventListener(MouseEvent.CLICK,this.sroom);
         this.gc.playerName = "";
         SoundManager.play("begin");
      }
      
      private function removed(param1:Event) : *
      {
         this.simpleGame.removeEventListener(MouseEvent.CLICK,this.selectNum);
         this.doubleGame.removeEventListener(MouseEvent.CLICK,this.selectNum);
         this.backbtn.removeEventListener(MouseEvent.CLICK,this.backClick);
         this.continueGame.removeEventListener(MouseEvent.CLICK,this.continueGameGetTime);
         this.newGame.removeEventListener(MouseEvent.CLICK,this.newGameGetTime);
         this.gameHelp.removeEventListener(MouseEvent.CLICK,this.hellpClick);
         this.aboutUs.removeEventListener(MouseEvent.CLICK,this.about);
         this.tangseng.removeEventListener(MouseEvent.CLICK,this.tangSeng);
         this.wukong.removeEventListener(MouseEvent.CLICK,this.wuKong);
         this.gameShop.removeEventListener(MouseEvent.CLICK,this.shoping);
         this.successRoom.removeEventListener(MouseEvent.CLICK,this.sroom);
      }
      
      private function about(param1:MouseEvent) : void
      {
         SoundManager.play("xz");
         this.gc.eventManger.dispatchEvent(new CommonEvent("showAboutUs"));
      }
      
      private function backClick(param1:MouseEvent) : void
      {
         SoundManager.play("xz");
         this.showMenu();
      }
      
      private function newGameGetTime(param1:MouseEvent) : void
      {
         this.gc.getGameTime(this.newGameClick);
      }
      
      private function continueGameGetTime(param1:MouseEvent) : void
      {
         this.gc.getGameTime(this.continueClick);
      }
      
      private function continueClick() : void
      {
         SoundManager.play("xz");
         if(this.gc.playNum == 1)
         {
            this.showTW();
         }
         else if(this.gc.playNum == 2)
         {
            this.continueStart(2);
         }
      }
      
      private function newGameClick() : void
      {
         SoundManager.play("xz");
         this.isnew = true;
         this.doAfterChangeOut();
         this.showMenu();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function continueStart(param1:uint) : void
      {
         this.gc.memory.getStorage(param1);
         this.isnew = false;
         this.doAfterChangeOut();
         this.showMenu();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function tangSeng(param1:MouseEvent) : void
      {
         SoundManager.play("xz");
         this.continueStart(0);
      }
      
      private function wuKong(param1:MouseEvent) : void
      {
         SoundManager.play("xz");
         this.continueStart(1);
      }
      
      private function selectNum(param1:MouseEvent) : *
      {
         this.currentName = param1.currentTarget.name;
         if(this.gc.isHideDebug)
         {
            this.gc.logInfo = GMain.serviceHold.isLog;
            if(this.gc.logInfo == null)
            {
               GMain.serviceHold.showLogPanel();
            }
            else
            {
               this.gc.usernameHash = this.gc.logInfo.name;
               this.doSelectNum();
            }
            if(!this.gc.loginAlert)
            {
               this.gc.loginAlert = AUtils.getNewObj("LoginAlert");
               this.gc.loginAlert.name = "LoginAlert";
               this.gc.loginAlert.x = 470;
               this.gc.loginAlert.y = 295;
               this.addChild(this.gc.loginAlert);
            }
         }
         else
         {
            this.doSelectNum();
         }
      }
      
      public function doSelectNum() : void
      {
         var _loc1_:Boolean = false;
         SoundManager.play("xz");
         Debug.trace("this.currentName:" + this.currentName);
         if(this.currentName == "simpleGame")
         {
            this.gc.playNum = 1;
            this.gc.gameMode = 1;
            if(this.gc.isHideDebug)
            {
               GMain.serviceHold.getData(false,1);
               GMain.serviceHold.getData(false,0);
            }
         }
         else if(this.currentName == "doubleGame")
         {
            this.gc.playNum = 2;
            this.gc.gameMode = 2;
            if(this.gc.isHideDebug)
            {
               GMain.serviceHold.getData(false,2);
            }
         }
         if(!this.gc.isHideDebug)
         {
            _loc1_ = this.gc.memory.judgeSave();
            this.hideMenu(_loc1_);
         }
      }
      
      private function showTW() : void
      {
         if(this.gc.memory.searchSave(1) && this.gc.memory.searchSave(0))
         {
            this.wukong.x = 751.15;
            this.wukong.y = 195;
            this.tangseng.x = 751.15;
            this.tangseng.y = 248.8;
         }
         else if(this.gc.memory.searchSave(1))
         {
            this.wukong.x = 751.15;
            this.wukong.y = 248.8;
         }
         else if(this.gc.memory.searchSave(0))
         {
            this.tangseng.x = 751.15;
            this.tangseng.y = 248.8;
         }
         this.backbtn.x = 800;
         this.continueGame.x = 1110;
         this.newGame.x = 1110;
         this.newGame.y = 314.35;
      }
      
      public function showAndHide() : void
      {
         var _loc1_:Boolean = false;
         Debug.trace("--showAndHide--");
         if(this.gc.playNum == 1)
         {
            ++this.readid;
         }
         else if(this.gc.playNum == 2)
         {
            this.readid = 2;
         }
         if(this.readid >= 2)
         {
            _loc1_ = this.gc.memory.judgeSave();
            this.hideMenu(_loc1_);
         }
      }
      
      private function hideMenu(param1:Boolean) : void
      {
         this.simpleGame.x = 1110;
         this.doubleGame.x = 1110;
         this.successRoom.x = 1110;
         this.gameShop.x = 1110;
         this.gameHelp.x = 1110;
         this.gameRecommend.x = 1110;
         this.aboutUs.x = 1110;
         this.backbtn.x = 800;
         if(param1)
         {
            this.continueGame.x = 800;
            this.newGame.x = 800;
            this.newGame.y = 205.5;
         }
         else
         {
            this.newGame.y = this.continueGame.y;
            this.newGame.x = 800;
         }
      }
      
      private function showMenu() : void
      {
         this.simpleGame.x = 751.15;
         this.doubleGame.x = 751.15;
         this.successRoom.x = 751.15;
         this.gameShop.x = 751.15;
         this.gameHelp.x = 751.15;
         this.gameRecommend.x = 751.15;
         this.aboutUs.x = 751.15;
         this.backbtn.x = 1110;
         this.continueGame.x = 1110;
         this.newGame.x = 1110;
         this.newGame.y = 314.35;
         this.wukong.x = 1110;
         this.wukong.y = 338.05;
         this.tangseng.x = 1110;
         this.tangseng.y = 387.55;
      }
      
      private function hellpClick(param1:*) : void
      {
         SoundManager.play("xz");
         this.gc.eventManger.dispatchEvent(new CommonEvent("GameHelp",{"state":"menu"}));
      }
      
      public function doAfterChangeOut() : void
      {
         if(this.isnew)
         {
            this.gc.eventManger.dispatchEvent(new Event("StartSelectRole"));
         }
         else
         {
            this.gc.eventManger.dispatchEvent(new Event("SelectOver"));
         }
      }
      
      private function shoping(param1:MouseEvent) : void
      {
         this.gc.ts.setTxt("暂未开放，敬请期待");
         this.addChild(this.gc.ts);
      }
      
      private function sroom(param1:MouseEvent) : void
      {
         this.gc.ts.setTxt("暂未开放，敬请期待");
         this.addChild(this.gc.ts);
      }
   }
}
