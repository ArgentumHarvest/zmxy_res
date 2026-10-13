package export.rank
{
   import config.Config;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class NotInRank extends Sprite
   {
       
      
      public var curfvaluetxt:TextField;
      
      private var gc:Config;
      
      public function NotInRank()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         this.setShow();
      }
      
      private function removed(e:Event) : void
      {
      }
      
      public function setShow() : void
      {
         curfvaluetxt.text = RankPropertyCount.getFightingForceByPlayerNum(gc.getUsersArray()).toString();
      }
   }
}
