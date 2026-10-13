package export.bigzp
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class DollExchange extends MovieClip
   {
       
      
      public var btnClose:SimpleButton;
      
      public function DollExchange()
      {
         super();
         this.addEventListener("addedToStage",__added,false,0,true);
      }
      
      private function __added(evt:Event) : void
      {
         this.btnClose.addEventListener("click",__close);
      }
      
      private function __close(evt:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this.btnClose.removeEventListener("click",__close);
      }
   }
}
