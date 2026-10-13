package export.level
{
   import base.BaseLevelListenering;
   import export.mapObject.FireThron;
   import flash.display.MovieClip;
   
   public class StageListener22 extends BaseLevelListenering
   {
       
      
      private var fireThronArray:Array;
      
      public function StageListener22()
      {
         fireThronArray = [];
         super();
         waitForRegisterDataArray = ["Monster16","Monster9","Monster10","Monster19"];
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
               if(MovieClip(obj).getChildByName("isFireThron"))
               {
                  fireThronArray.push(obj);
               }
            }
            i++;
         }
      }
      
      override public function step() : void
      {
         super.step();
         for each(var it in this.fireThronArray)
         {
            it.step();
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.fireThronArray = [];
      }
   }
}
