package export
{
   import config.Config;
   import event.CommonEvent;
   import export.huodong.miaomiaoBase.CadpaActivity;
   import export.saveInterface.SaveInter;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.system.Capabilities;
   import manager.MusicManager;
   
   public class GameMenu extends Sprite
   {
       
      
      public var simpleGame:SimpleButton;
      
      public var doubleGame:SimpleButton;
      
      public var gameHelp:SimpleButton;
      
      public var aboutUs:SimpleButton;
      
      public var backbtn:SimpleButton;
      
      public var continueGame:SimpleButton;
      
      public var newGame:SimpleButton;
      
      public var btn_forum:SimpleButton;
      
      public var btnquit:SimpleButton;
      
      public var btnCadpa:SimpleButton;
      
      public var btnGoBack:SimpleButton;
      
      private var gc:Config;
      
      private var mm:MusicManager;
      
      public function GameMenu()
      {
         super();
         gc = Config.getInstance();
         mm = MusicManager.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : *
      {
         var filter:* = null;
         trace("GameMenu--added");
         gc.isinthegame = true;
         simpleGame.addEventListener("click",selectNum);
         simpleGame.visible = false;
         doubleGame.addEventListener("click",selectNum);
         doubleGame.visible = false;
         backbtn.addEventListener("click",backClick);
         backbtn.visible = false;
         continueGame.addEventListener("click",continueClick);
         newGame.addEventListener("click",newGameClick);
         gameHelp.addEventListener("click",hellpClick);
         aboutUs.addEventListener("click",about);
         btnquit.addEventListener("click",quit);
         btn_forum.addEventListener("click",forumClick);
         btnGoBack.addEventListener("click",goBack);
         btnCadpa.addEventListener("click",cadpaClick);
         if(gc.lc)
         {
            gc.playerName = gc.lc.domain;
         }
         mm.play("begin");
         gc.eventManger.addEventListener("RemoveGameMenu",_removeSelf);
         this.tabChildren = false;
         this.tabEnabled = false;
         var bg:Bitmap = AUtils.getImageObj("GameBG");
         this.addChildAt(bg,0);
         if(gc.isBlack)
         {
            filter = new ColorMatrixFilter([0.3,0.6,0,0,0,0.3,0.6,0,0,0,0.3,0.6,0,0,0,0,0,0,1,0]);
            this.filters = [filter];
         }
         this.btnGoBack.visible = gc.isAirGame;
      }
      
      private function __clickToQunzu(evt:MouseEvent) : void
      {
      }
      
      private function __loadComplete(evt:Event) : void
      {
      }
      
      private function removed(e:Event) : *
      {
         gc.eventManger.removeEventListener("RemoveGameMenu",_removeSelf);
         simpleGame.removeEventListener("click",selectNum);
         doubleGame.removeEventListener("click",selectNum);
         backbtn.removeEventListener("click",backClick);
         continueGame.removeEventListener("click",continueClick);
         newGame.removeEventListener("click",newGameClick);
         gameHelp.removeEventListener("click",hellpClick);
         aboutUs.removeEventListener("click",about);
         btnquit.removeEventListener("click",quit);
         btn_forum.removeEventListener("click",forumClick);
         btnCadpa.removeEventListener("click",cadpaClick);
         btnGoBack.removeEventListener("click",goBack);
      }
      
      private function about(e:MouseEvent) : void
      {
         mm.play("SD_xz");
         gc.eventManger.dispatchEvent(new CommonEvent("showAboutUs"));
      }
      
      private function backClick(e:MouseEvent) : void
      {
         mm.play("SD_xz");
         this.showMenu();
      }
      
      private function continueClick(e:MouseEvent) : void
      {
         mm.play("SD_xz");
         if(!this.checkVersion())
         {
            return;
         }
         gc.isnew = false;
         if(gc.isHideDebug)
         {
            if(GMain.serviceHold)
            {
               gc.logInfo = GMain.serviceHold.isLog;
            }
            if(gc.logInfo == null)
            {
               GMain.serviceHold.showLogPanel();
               if(!gc.loginAlert)
               {
                  gc.loginAlert = AUtils.getNewObj("LoginAlertInterface");
                  gc.loginAlert.name = "LoginAlert";
                  this.addChild(gc.loginAlert);
               }
            }
            else
            {
               if(!gc.saveInter)
               {
                  gc.saveInter = AUtils.getNewObj("export.saveInterface.SaveInter") as SaveInter;
               }
               gc.saveInter.state = "read";
               this.addChild(gc.saveInter);
            }
         }
      }
      
      private function newGameClick(e:MouseEvent) : void
      {
         e = e;
         mm.play("SD_xz");
         if(gc.isVersionWrong)
         {
            gc.ts.setTxt("该游戏不是最新版");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(!this.checkVersion())
         {
            return;
         }
         gc.newGameClick();
         gc.isnew = true;
         if(!gc.loginAlert)
         {
            gc.loginAlert = AUtils.getNewObj("LoginAlertInterface");
            gc.loginAlert.name = "LoginAlert";
            this.addChild(gc.loginAlert);
         }
         var self:GameMenu = this;
         gc.requestData(function():*
         {
            if(gc.isHideDebug && GMain.serviceHold)
            {
               gc.logInfo = GMain.serviceHold.isLog;
               if(gc.logInfo == null)
               {
                  GMain.serviceHold.showLogPanel();
               }
               else
               {
                  self.showSelectNum();
                  self.isremoveLoginAlert();
               }
            }
            else
            {
               self.showSelectNum();
               self.isremoveLoginAlert();
            }
         });
      }
      
      public function showSelectNum() : void
      {
         if(gc.isnew)
         {
            this.simpleGame.visible = true;
            this.simpleGame.x = 751.15;
            this.doubleGame.visible = true;
            this.doubleGame.x = 751.15;
            this.backbtn.visible = true;
            this.backbtn.x = 800;
            this.newGame.x = 1110;
            this.newGame.visible = false;
            this.continueGame.x = 1110;
            this.continueGame.visible = false;
            this.gameHelp.x = 1110;
            this.gameHelp.visible = false;
            this.aboutUs.x = 1110;
            this.aboutUs.visible = false;
            this.btnquit.x = 1110;
            this.btnquit.visible = false;
         }
      }
      
      private function selectNum(e:MouseEvent) : *
      {
         var selectMode:String = e.currentTarget.name;
         if(selectMode == "simpleGame")
         {
            gc.playNum = 1;
         }
         else
         {
            gc.playNum = 2;
         }
         mm.play("SD_xz");
         this.showMenu();
         this.doAfterChangeOut();
      }
      
      public function showAndHide() : void
      {
         trace("GameMenu---showAndHide");
         gc.memory.getStorage();
         this.doAfterChangeOut();
      }
      
      private function hideMenu(bl:Boolean) : void
      {
         this.simpleGame.x = 1110;
         this.simpleGame.visible = false;
         this.doubleGame.x = 1110;
         this.doubleGame.visible = false;
         this.gameHelp.x = 1110;
         this.gameHelp.visible = false;
         this.aboutUs.x = 1110;
         this.aboutUs.visible = false;
         this.btnquit.x = 1110;
         this.btnquit.visible = false;
         this.backbtn.visible = true;
         this.backbtn.x = 800;
         if(bl)
         {
            this.continueGame.visible = true;
            this.continueGame.x = 800;
            this.newGame.visible = true;
            this.newGame.x = 800;
            this.newGame.y = 205.5;
         }
         else
         {
            this.newGame.visible = true;
            this.newGame.y = this.continueGame.y;
            this.newGame.x = 800;
         }
      }
      
      public function showMenu() : void
      {
         this.simpleGame.x = 1110;
         this.simpleGame.visible = false;
         this.doubleGame.x = 1110;
         this.doubleGame.visible = false;
         this.backbtn.x = 1110;
         this.backbtn.visible = false;
         this.gameHelp.visible = true;
         this.gameHelp.x = 751.15;
         this.gameHelp.y = 237.25;
         this.aboutUs.visible = true;
         this.aboutUs.x = 751.15;
         this.aboutUs.y = 290.15;
         this.continueGame.visible = true;
         this.continueGame.x = 751.15;
         this.continueGame.y = 189.55;
         this.newGame.visible = true;
         this.newGame.x = 751.15;
         this.newGame.y = 142.2;
         this.btnquit.visible = true;
         this.btnquit.x = 751.15;
         this.btnquit.y = 337.1;
         this.btn_forum.visible = true;
         this.btn_forum.x = 751.15;
         this.btn_forum.y = 383.4;
      }
      
      private function hellpClick(e:*) : void
      {
         mm.play("SD_xz");
         gc.eventManger.dispatchEvent(new CommonEvent("GameHelp",{"state":"menu"}));
      }
      
      public function getSevenData() : void
      {
         if(GMain.serviceHold)
         {
            GMain.serviceHold.getData(false,7);
         }
      }
      
      public function getSaveData() : void
      {
         if(!gc.isnew)
         {
            if(!gc.saveInter)
            {
               gc.saveInter = AUtils.getNewObj("export.saveInterface.SaveInter") as SaveInter;
            }
            gc.saveInter.state = "read";
            this.addChild(gc.saveInter);
         }
         else
         {
            this.showSelectNum();
         }
      }
      
      public function isremoveLoginAlert() : void
      {
         if(gc.isnew)
         {
            if(gc.loginAlert && gc.loginAlert.parent)
            {
               gc.loginAlert.parent.removeChild(gc.loginAlert);
               gc.loginAlert = null;
            }
         }
      }
      
      private function quit(e:MouseEvent) : void
      {
         gc.doWhenQuitLogin();
         if(GMain.serviceHold)
         {
            GMain.serviceHold.userLogOut();
         }
      }
      
      private function forumClick(e:MouseEvent) : void
      {
         gc.openUrl("https://my.4399.com/space-mtag-tagid-80615.html");
      }
      
      private function cadpaClick(e:MouseEvent) : void
      {
         var zzty:CadpaActivity = new CadpaActivity();
         if(this.parent)
         {
            this.parent.addChild(zzty);
         }
      }
      
      private function goBack(e:MouseEvent) : void
      {
         gc.goBack();
      }
      
      public function doAfterChangeOut() : void
      {
         this.__goToGame(null);
      }
      
      protected function __goToGame(evt:CommonEvent) : void
      {
         if(gc.isnew)
         {
            gc.eventManger.dispatchEvent(new Event("StartSelectRole"));
         }
         else
         {
            gc.eventManger.dispatchEvent(new Event("SelectOver"));
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
         }
      }
      
      private function checkVersion() : Boolean
      {
         var ver:* = null;
         var mainVer:* = null;
         var verArr:Array = Capabilities.version.split(" ");
         if(verArr.length > 1)
         {
            ver = verArr[1];
            mainVer = ver.split(",")[0];
            if(int(mainVer) < 11)
            {
               gc.ts.setTxt("您的flash播放器版本太低，请更新flash播放器！",9999);
               gc.stage.addChild(gc.ts);
               return false;
            }
         }
         return true;
      }
      
      protected function _removeSelf(e:CommonEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
