package export.setmenu
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import manager.MusicManager;
   import my.MainGame;
   
   public class SetMenu extends Sprite
   {
       
      
      public var btn_continue:SimpleButton;
      
      public var btn_back_selectmap:SimpleButton;
      
      public var btn_back_menu:SimpleButton;
      
      public var btn_help:SimpleButton;
      
      public var btn_x:SimpleButton;
      
      public var btn_sound_open:SimpleButton;
      
      public var btn_sound_close:SimpleButton;
      
      public var btn_huazhi:SimpleButton;
      
      public var huazhi:MovieClip;
      
      public var secretTxt:TextField;
      
      private var gc:Config;
      
      private var mm:MusicManager;
      
      private var asprite:Sprite;
      
      public function SetMenu()
      {
         super();
         gc = Config.getInstance();
         mm = MusicManager.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:*) : void
      {
         trace("setmenu---added");
         btn_continue.addEventListener("click",continueClick);
         btn_back_selectmap.addEventListener("click",backmapClick);
         btn_back_menu.addEventListener("click",backmenuClick);
         btn_help.addEventListener("click",helpClick);
         btn_x.addEventListener("click",continueClick);
         btn_sound_open.addEventListener("click",openSound);
         btn_sound_close.addEventListener("click",closeSound);
         btn_huazhi.addEventListener("click",huazhiChange);
         this.initSound();
         if(gc.stage.quality == "HIGH")
         {
            this.huazhi.gotoAndStop(1);
         }
         else if(gc.stage.quality == "MEDIUM")
         {
            this.huazhi.gotoAndStop(2);
         }
         else if(gc.stage.quality == "LOW")
         {
            this.huazhi.gotoAndStop(3);
         }
      }
      
      private function removed(e:*) : void
      {
         btn_continue.removeEventListener("click",continueClick);
         btn_back_selectmap.removeEventListener("click",backmapClick);
         btn_back_menu.removeEventListener("click",backmenuClick);
         btn_help.removeEventListener("click",helpClick);
         btn_x.removeEventListener("click",continueClick);
         btn_sound_open.removeEventListener("click",openSound);
         btn_sound_close.removeEventListener("click",closeSound);
         btn_huazhi.removeEventListener("click",huazhiChange);
         if(gc.isSingleGame())
         {
            MainGame.getInstance().continueGame();
         }
      }
      
      private function initSound() : void
      {
         if(mm.soundStay)
         {
            this.btn_sound_close.visible = true;
            this.btn_sound_open.visible = false;
         }
         else
         {
            this.btn_sound_close.visible = false;
            this.btn_sound_open.visible = true;
         }
      }
      
      private function intoStopGame() : void
      {
         gc.pausepre = getTimer();
         MainGame.getInstance().stopGame();
      }
      
      private function continueClick(e:MouseEvent) : void
      {
         gc.pauseaft = getTimer();
         var inputStr:String = this.secretTxt.text;
         gc.eventManger.dispatchEvent(new CommonEvent("closeSettingViewCmd",{"secret":inputStr}));
         this.destory();
      }
      
      private function backmapClick(e:MouseEvent) : void
      {
         this.continueClick(null);
         MainGame.getInstance().destroyGame();
         gc.closeScoket();
         if(gc.dataObject.whichlastworld == 1)
         {
            GMain.getInstance().switchSence("showNewStageMap");
         }
         else if(gc.dataObject.whichlastworld == 2)
         {
            GMain.getInstance().switchSence("showThirdStageMap");
         }
         else
         {
            GMain.getInstance().switchSence("showStageMap");
         }
         if(gc.isHideDebug)
         {
            if(gc.curStageAndCurLevel.curStage == 11)
            {
               doSaveGame();
            }
         }
      }
      
      private function doSaveGame() : void
      {
         gc.memory.setStorage(gc.luanqibazaojiami.saveId);
      }
      
      private function backmenuClick(e:MouseEvent) : void
      {
         this.continueClick(null);
         MainGame.getInstance().destroyMode();
         gc.closeScoket();
         GMain.getInstance().switchSence("GameMenu");
      }
      
      private function helpClick(e:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("GameHelp"));
      }
      
      private function openSound(e:MouseEvent) : void
      {
         this.btn_sound_close.visible = true;
         this.btn_sound_open.visible = false;
         mm.controlSound();
      }
      
      private function huazhiChange(e:MouseEvent) : void
      {
         if(this.huazhi.currentFrame == 1)
         {
            gc.stage.quality = "medium";
            this.huazhi.gotoAndStop(2);
         }
         else if(this.huazhi.currentFrame == 2)
         {
            gc.stage.quality = "low";
            this.huazhi.gotoAndStop(3);
         }
         else
         {
            gc.stage.quality = "high";
            this.huazhi.gotoAndStop(1);
         }
      }
      
      private function closeSound(e:MouseEvent) : void
      {
         this.btn_sound_close.visible = false;
         this.btn_sound_open.visible = true;
         mm.controlSound();
      }
      
      private function destory() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
