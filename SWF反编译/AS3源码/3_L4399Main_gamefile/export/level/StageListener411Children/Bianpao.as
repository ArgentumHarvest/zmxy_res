package export.level.StageListener411Children
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class Bianpao extends Sprite
   {
       
      
      private var isStart:Boolean = false;
      
      private var resArray:Array;
      
      private var nums:uint = 1;
      
      public function Bianpao()
      {
         resArray = [];
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
         var i:* = 0;
         var mc:* = null;
         for(i = uint(0); i < nums; )
         {
            mc = AUtils.getNewObj("xinchun_bianpao") as MovieClip;
            this.resArray.push(mc);
            this.addChild(mc);
            i++;
         }
         for each(var mcc in this.resArray)
         {
            mcc.x = 0;
            mcc.y = 0;
            mcc.gotoAndPlay(1);
         }
      }
      
      private function stop() : void
      {
         for each(var mcc in this.resArray)
         {
            mcc.stop();
         }
         this.isStart = false;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function destroy() : void
      {
         for each(var mcc in this.resArray)
         {
            if(mcc.parent)
            {
               mcc.parent.removeChild(mcc);
            }
         }
         this.resArray.length = 0;
         this.stop();
      }
   }
}
