package export
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class Help extends MovieClip
   {
       
      
      public var btnback:SimpleButton;
      
      public var actionHelp:SimpleButton;
      
      public var achivePet:SimpleButton;
      
      public function Help()
      {
         super();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:*) : void
      {
         this.gotoAndStop(1);
         btnback.addEventListener("click",backClick);
         actionHelp.addEventListener("click",actionHelpClick);
         achivePet.addEventListener("click",achivePetClick);
      }
      
      private function removed(e:*) : void
      {
         btnback.removeEventListener("click",backClick);
         actionHelp.removeEventListener("click",actionHelpClick);
         achivePet.removeEventListener("click",achivePetClick);
      }
      
      private function backClick(e:*) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function actionHelpClick(e:MouseEvent) : void
      {
         this.gotoAndStop(1);
      }
      
      private function achivePetClick(e:MouseEvent) : void
      {
         this.gotoAndStop(2);
      }
   }
}
