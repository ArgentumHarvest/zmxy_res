package export
{
   import config.Config;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   
   public class FloorBg extends MovieClip
   {
       
      
      private var gc:Config;
      
      public function FloorBg()
      {
         super();
         gc = Config.getInstance();
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(this.getChildByName("floorBitmap"))
         {
            (this.getChildByName("floorBitmap") as Bitmap).bitmapData.dispose();
            (this.getChildByName("floorBitmap") as Bitmap).bitmapData = null;
         }
         gc.bg1 = null;
      }
   }
}
