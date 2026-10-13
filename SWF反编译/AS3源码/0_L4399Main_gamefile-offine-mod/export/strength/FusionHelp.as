package export.strength
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   
   public class FusionHelp extends Sprite
   {
       
      
      public var btn_x:SimpleButton;
      
      public function FusionHelp()
      {
         super();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:*) : void
      {
         btn_x.addEventListener("click",close);
      }
      
      private function removed(e:*) : void
      {
         btn_x.removeEventListener("click",close);
      }
      
      private function close(e:*) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
