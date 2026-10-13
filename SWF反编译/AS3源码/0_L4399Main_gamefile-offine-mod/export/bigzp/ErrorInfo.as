package export.bigzp
{
   import config.Config;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ErrorInfo extends Sprite
   {
       
      
      public var jumpmc:MovieClip;
      
      public var btn_back:SimpleButton;
      
      private var gc:Config;
      
      public function ErrorInfo()
      {
         super();
         gc = Config.getInstance();
         jumpmc.buttonMode = true;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         btn_back.addEventListener("click",xClick);
         jumpmc.addEventListener("click",jumpClick);
      }
      
      private function removed(e:Event) : void
      {
         btn_back.addEventListener("click",xClick);
         jumpmc.addEventListener("click",jumpClick);
      }
      
      private function jumpClick(e:MouseEvent) : void
      {
         gc.openUrl("https://www.4399.com");
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
