package export.cartoon
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import my.MainGame;
   
   public class GameCartoon extends MovieClip
   {
       
      
      private var gc:Config;
      
      private var hasadd:Boolean = false;
      
      private var inWhere:String;
      
      public var bgmc:MovieClip;
      
      public function GameCartoon()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      public function mygotoandStop(frame:String) : void
      {
         this.inWhere = frame;
         this.gotoAndStop(inWhere);
      }
      
      private function added(e:*) : void
      {
         trace("GameCartoon---added");
         if(!hasadd)
         {
            gc.opening = true;
            hasadd = true;
            this.addEventListener("click",nextPage);
         }
      }
      
      private function removed(e:*) : void
      {
         this.removeEventListener("click",nextPage);
      }
      
      private function nextPage(e:MouseEvent) : void
      {
         if(inWhere == "开场")
         {
            if(this.currentFrame == 2)
            {
               this.skipOpening();
            }
            else
            {
               this.nextFrame();
            }
         }
         else if(inWhere == "玲珑宝塔")
         {
            if(this.currentFrame == 4)
            {
               gc.curStageAndCurLevel.curStage = 8;
               gc.curStageAndCurLevel.curLevel = 1;
               gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
               this.destory();
            }
            else
            {
               this.nextFrame();
            }
         }
      }
      
      public function gotoStageMap() : void
      {
         if(this.parent)
         {
            MainGame.getInstance().levelClear();
            GMain.getInstance().switchSence("showStageMap");
            this.parent.removeChild(this);
         }
      }
      
      private function skipOpening() : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("ShowOpenAnimationOver"));
         this.destory();
      }
      
      public function destory() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
