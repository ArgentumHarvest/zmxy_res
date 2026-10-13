package export.level
{
   import base.BaseLevelListenering;
   import export.mapObject.IceThron;
   import flash.display.MovieClip;
   
   public class StageListener21 extends BaseLevelListenering
   {
       
      
      private var iceThronArray:Array;
      
      public function StageListener21()
      {
         iceThronArray = [];
         super();
         waitForRegisterDataArray = ["Monster6","Monster9","Monster10","Monster19"];
      }
      
      override public function start() : void
      {
         var i:* = 0;
         var obj:* = null;
         super.start();
         var len:uint = gc.gameSence.numChildren;
         for(i = uint(0); i < len; )
         {
            obj = gc.gameSence.getChildAt(i);
            if(obj is MovieClip)
            {
               if(MovieClip(obj).getChildByName("isIceThron"))
               {
                  iceThronArray.push(obj);
               }
            }
            i++;
         }
      }
      
      override public function step() : void
      {
         super.step();
         for each(var it in this.iceThronArray)
         {
            it.step();
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.iceThronArray = [];
      }
   }
}
