package export.rank
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ApplyRank extends Sprite
   {
       
      
      public var applybtn:SimpleButton;
      
      private var gc:Config;
      
      public function ApplyRank()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         applybtn.addEventListener("click",applyClick);
      }
      
      private function removed(e:Event) : void
      {
         applybtn.removeEventListener("click",applyClick);
      }
      
      private function applyClick(e:MouseEvent) : void
      {
         if(gc.getAverageLevel() < 30)
         {
            gc.ts.setTxt("等级不足30级,不能提交战斗力");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(this.parent)
         {
            RankTopInterface(this.parent).submitScore();
            this.parent.removeChild(this);
         }
      }
   }
}
