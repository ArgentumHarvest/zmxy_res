package export.lose
{
   import config.*;
   import event.*;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.*;
   
   public class GameFail extends Sprite
   {
       
      
      public var rePlayButton:SimpleButton;
      
      public var backTochooseButton:SimpleButton;
      
      private var gc:Config;
      
      public function GameFail()
      {
         super();
         this.gc = Config.getInstance();
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      private function added(param1:*) : void
      {
         this.rePlayButton.addEventListener(MouseEvent.CLICK,this.rePlay);
         this.backTochooseButton.addEventListener(MouseEvent.CLICK,this.backToMap);
      }
      
      private function removed(param1:*) : void
      {
         this.rePlayButton.removeEventListener(MouseEvent.CLICK,this.rePlay);
         this.backTochooseButton.removeEventListener(MouseEvent.CLICK,this.backToMap);
      }
      
      private function rePlay(param1:*) : void
      {
         this.gc.eventManger.dispatchEvent(new CommonEvent("ReStart"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function backToMap(param1:*) : void
      {
         GMain.getInstance().switchSence("showStageMap");
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
