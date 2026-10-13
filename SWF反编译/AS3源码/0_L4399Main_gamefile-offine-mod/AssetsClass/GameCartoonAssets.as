package AssetsClass
{
   import event.CommonEvent;
   import export.cartoon.GameCartoon;
   
   public class GameCartoonAssets extends BaseAssets
   {
       
      
      public function GameCartoonAssets()
      {
         super(GameCartoon);
         this.loadAssets(["Cartoon.swf"]);
      }
      
      override protected function addContent() : void
      {
         super.addContent();
         GameCartoon(this.content).mygotoandStop(gc.gameinwhere);
         if(gc.gameinwhere == "开场")
         {
            gc.eventManger.dispatchEvent(new CommonEvent("RemoveSelectRoleInterface"));
         }
         else if(gc.gameinwhere == "玲珑宝塔")
         {
            gc.eventManger.dispatchEvent(new CommonEvent("ShowOtherScene"));
         }
      }
      
      override protected function __loadFail(evt:CommonEvent) : void
      {
         if(gc.gameinwhere == "开场")
         {
            gc.eventManger.dispatchEvent(new CommonEvent("ShowOpenAnimationOver"));
         }
         else if(gc.gameinwhere == "玲珑宝塔")
         {
            gc.curStageAndCurLevel.curStage = 8;
            gc.curStageAndCurLevel.curLevel = 1;
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         }
         super.__loadFail(evt);
      }
   }
}
