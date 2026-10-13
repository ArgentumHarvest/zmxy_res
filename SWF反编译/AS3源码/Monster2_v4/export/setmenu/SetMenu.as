package export.setmenu
{
   import config.*;
   import event.*;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.*;
   import manager.*;
   import my.*;
   
   public class SetMenu extends Sprite
   {
       
      
      public var btn_continue:SimpleButton;
      
      public var btn_back_selectmap:SimpleButton;
      
      public var btn_back_menu:SimpleButton;
      
      public var btn_help:SimpleButton;
      
      public var btn_x:SimpleButton;
      
      public var btn_sound_open:SimpleButton;
      
      public var btn_sound_close:SimpleButton;
      
      private var gc:Config;
      
      private var asprite:Sprite;
      
      public function SetMenu()
      {
         super();
         this.gc = Config.getInstance();
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      private function added(param1:*) : void
      {
         this.btn_continue.addEventListener(MouseEvent.CLICK,this.continueClick);
         this.btn_back_selectmap.addEventListener(MouseEvent.CLICK,this.backmapClick);
         this.btn_back_menu.addEventListener(MouseEvent.CLICK,this.backmenuClick);
         this.btn_help.addEventListener(MouseEvent.CLICK,this.helpClick);
         this.btn_x.addEventListener(MouseEvent.CLICK,this.continueClick);
         this.btn_sound_open.addEventListener(MouseEvent.CLICK,this.openSound);
         this.btn_sound_close.addEventListener(MouseEvent.CLICK,this.closeSound);
         this.intoStopGame();
         this.initSound();
      }
      
      private function removed(param1:*) : void
      {
         this.btn_continue.removeEventListener(MouseEvent.CLICK,this.continueClick);
         this.btn_back_selectmap.removeEventListener(MouseEvent.CLICK,this.backmapClick);
         this.btn_back_menu.removeEventListener(MouseEvent.CLICK,this.backmenuClick);
         this.btn_help.removeEventListener(MouseEvent.CLICK,this.helpClick);
         this.btn_x.removeEventListener(MouseEvent.CLICK,this.continueClick);
         this.btn_sound_open.removeEventListener(MouseEvent.CLICK,this.openSound);
         this.btn_sound_close.removeEventListener(MouseEvent.CLICK,this.closeSound);
      }
      
      private function initSound() : void
      {
         if(SoundManager.soundStay)
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
         MainGame.getInstance().stopGame();
      }
      
      private function continueClick(param1:MouseEvent) : void
      {
         MainGame.getInstance().continueGame();
         this.destory();
      }
      
      private function backmapClick(param1:MouseEvent) : void
      {
         GMain.getInstance().switchSence("showStageMap");
         this.continueClick(null);
         MainGame.getInstance().destroyGame();
      }
      
      private function backmenuClick(param1:MouseEvent) : void
      {
         GMain.getInstance().switchSence("GameMenu");
         this.continueClick(null);
         MainGame.getInstance().destroyMode();
      }
      
      private function helpClick(param1:MouseEvent) : void
      {
         this.gc.eventManger.dispatchEvent(new CommonEvent("GameHelp"));
      }
      
      private function openSound(param1:MouseEvent) : void
      {
         this.btn_sound_close.visible = true;
         this.btn_sound_open.visible = false;
         SoundManager.controlSound();
      }
      
      private function closeSound(param1:MouseEvent) : void
      {
         this.btn_sound_close.visible = false;
         this.btn_sound_open.visible = true;
         SoundManager.controlSound();
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
