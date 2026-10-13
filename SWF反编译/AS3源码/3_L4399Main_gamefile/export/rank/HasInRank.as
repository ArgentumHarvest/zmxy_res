package export.rank
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class HasInRank extends Sprite
   {
       
      
      public var ranktxt:TextField;
      
      public var fvaluetxt:TextField;
      
      public var gxtxt:TextField;
      
      public var zgtxt:TextField;
      
      public var curfvaluetxt:TextField;
      
      public var btnSubmit:SimpleButton;
      
      public var cttxt:TextField;
      
      private var gc:Config;
      
      public function HasInRank()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         btnSubmit.addEventListener("click",submitClick);
         this.setShow();
      }
      
      private function removed(e:Event) : void
      {
         btnSubmit.removeEventListener("click",submitClick);
      }
      
      public function setShow() : void
      {
         if(gc.ownRankUser)
         {
            ranktxt.text = gc.ownRankUser.getRank() + "";
            fvaluetxt.text = gc.ownRankUser.getScore() - gc.ownRankUser.getGongXun() + "";
            curfvaluetxt.text = RankPropertyCount.getFightingForceByPlayerNum(gc.getUsersArray()).toString();
            cttxt.text = gc.dataObject.challengeRankTimes + "";
            gxtxt.text = gc.ownRankUser.getGongXun() + "";
            zgtxt.text = gc.ownRankUser.getScore() + "";
         }
         else
         {
            ranktxt.text = "";
            fvaluetxt.text = "";
            curfvaluetxt.text = "";
            cttxt.text = "";
            gxtxt.text = "";
            zgtxt.text = "";
         }
      }
      
      private function submitClick(evt:MouseEvent) : void
      {
         if(this.parent)
         {
            RankTopInterface(this.parent).submitScore();
         }
      }
   }
}
