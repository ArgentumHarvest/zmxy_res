package export.bigzp
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SpecialTaskMask extends Sprite
   {
       
      
      public var jfbtn:SimpleButton;
      
      private var gc:Config;
      
      public function SpecialTaskMask()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         jfbtn.addEventListener("click",jfClick);
      }
      
      private function removed(e:Event) : void
      {
         jfbtn.removeEventListener("click",jfClick);
      }
      
      private function jfClick(e:MouseEvent) : void
      {
         gc.openUrl("https://my.4399.com/space-376686047-do-thread-id-30814198-tagid-80615.html");
      }
   }
}
