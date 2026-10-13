package export.lose
{
   import config.Config;
   import event.CommonEvent;
   import export.rank.RankPropertyCount;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   
   public class GameFail extends Sprite
   {
       
      
      public var rePlayButton:SimpleButton;
      
      public var backTochooseButton:SimpleButton;
      
      private var gc:Config;
      
      public function GameFail()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:*) : void
      {
         this.rePlayButton.visible = true;
         rePlayButton.addEventListener("click",rePlay);
         backTochooseButton.addEventListener("click",backToMap);
         if(gc.curStageAndCurLevel.curStage >= 5)
         {
            this.rePlayButton.visible = false;
         }
         if(gc.curStageAndCurLevel.curStage >= 20 && gc.curStageAndCurLevel.curStage < 40)
         {
            this.rePlayButton.visible = true;
         }
         if(gc.isInWeiPk())
         {
            RankPropertyCount.submitRankScore(gc);
         }
      }
      
      private function removed(e:*) : void
      {
         rePlayButton.removeEventListener("click",rePlay);
         backTochooseButton.removeEventListener("click",backToMap);
      }
      
      private function rePlay(e:*) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("ReStart"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function backToMap(e:*) : void
      {
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
         if(gc.isInWeiPk())
         {
            gc.curStageAndCurLevel.curStage = 41;
            gc.curStageAndCurLevel.curLevel = 1;
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
