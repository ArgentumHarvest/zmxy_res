package export.level.stagelistener531Children
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import mvc.controllor.RandomControllor;
   
   public class Stagelistener531Sun extends Bitmap
   {
       
      
      public function Stagelistener531Sun()
      {
         var type:String = "stage531Sun" + (1 + Math.ceil(RandomControllor.getIns().getRandom() * 2));
         super(AUtils.getNewObj(type) as BitmapData);
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
