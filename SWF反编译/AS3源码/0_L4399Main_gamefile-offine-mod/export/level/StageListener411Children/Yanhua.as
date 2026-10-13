package export.level.StageListener411Children
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class Yanhua extends Sprite
   {
       
      
      private var isStart:Boolean = false;
      
      private var res:MovieClip;
      
      public function Yanhua()
      {
         super();
      }
      
      public function step() : void
      {
         if(this.isStart)
         {
            if(this.numChildren == 0)
            {
               this.stop();
            }
         }
      }
      
      public function start() : void
      {
         if(!this.isStart)
         {
            this.isStart = true;
            this.init();
         }
      }
      
      public function isStarting() : Boolean
      {
         return this.isStart;
      }
      
      private function init() : void
      {
         if(!this.res)
         {
            this.res = AUtils.getNewObj("xinchun_yanhua") as MovieClip;
         }
         this.addChild(this.res);
         this.res.gotoAndPlay(1);
      }
      
      private function stop() : void
      {
         if(this.res)
         {
            this.res.stop();
         }
         this.isStart = false;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function destroy() : void
      {
         this.stop();
      }
   }
}
