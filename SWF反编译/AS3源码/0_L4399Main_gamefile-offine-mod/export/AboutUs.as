package export
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   
   public class AboutUs extends Sprite
   {
       
      
      public var btnback:SimpleButton;
      
      public function AboutUs()
      {
         super();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:*) : void
      {
         btnback.addEventListener("click",back);
      }
      
      private function removed(e:*) : void
      {
         btnback.removeEventListener("click",back);
      }
      
      private function back(e:*) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
