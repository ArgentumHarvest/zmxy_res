package export.huodong
{
   import config.Config;
   import export.huodong.kabu.KaBuActivites;
   import export.huodong.kabu.ReceiveKaBuPacks;
   import export.huodong.valentineday.ValentinesDay;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class AllHuoDongInterface extends Sprite
   {
       
      
      public var actkabubtn:SimpleButton;
      
      public var reckabubtn:SimpleButton;
      
      public var btn_x:SimpleButton;
      
      public var nybtn:SimpleButton;
      
      private var gc:Config;
      
      public function AllHuoDongInterface()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         actkabubtn.addEventListener("click",actKaBuClick);
         reckabubtn.addEventListener("click",recKaBuClick);
         btn_x.addEventListener("click",backClick);
         nybtn.addEventListener("click",newYearClick);
      }
      
      private function removed(e:Event) : void
      {
         actkabubtn.removeEventListener("click",actKaBuClick);
         reckabubtn.removeEventListener("click",recKaBuClick);
         btn_x.removeEventListener("click",backClick);
         nybtn.removeEventListener("click",newYearClick);
      }
      
      private function actKaBuClick(e:MouseEvent) : void
      {
         var kbact:KaBuActivites = new KaBuActivites();
         this.parent.addChild(kbact);
         this.backClick(null);
      }
      
      private function recKaBuClick(e:MouseEvent) : void
      {
         var kbrec:ReceiveKaBuPacks = new ReceiveKaBuPacks();
         this.parent.addChild(kbrec);
         this.backClick(null);
      }
      
      private function newYearClick(e:MouseEvent) : void
      {
         var valentines:ValentinesDay = new ValentinesDay();
         this.parent.addChild(valentines);
         this.backClick(null);
      }
      
      private function backClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
