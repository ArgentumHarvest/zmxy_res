package my
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class BitmapDataTransfer
   {
      
      static var picWidth:Number = 450;
      
      static var picHeight:Number = 450;
      
      static var endColor:uint = 16744576;
      
      static var startColor:uint = 32896;
      
      static var middleColor:uint = 8421504;
      
      static var myBitmapData:BitmapData = new BitmapData(picWidth,picHeight);
       
      
      public function BitmapDataTransfer()
      {
         super();
      }
      
      public static function drawMapBitmap(param1:BitmapData, param2:int) : BitmapData
      {
         var _loc3_:ByteArray = null;
         var _loc4_:ByteArray = null;
         if(param2 > 0)
         {
            _loc3_ = param1.getPixels(new Rectangle(0,0,940 - param2,590));
            _loc4_ = param1.getPixels(new Rectangle(940 - param2,0,param2,590));
         }
         else
         {
            _loc3_ = param1.getPixels(new Rectangle(0,0,-param2,590));
            _loc4_ = param1.getPixels(new Rectangle(-param2,0,940 + param2,590));
         }
         _loc3_.position = 0;
         _loc4_.position = 0;
         if(param2 > 0)
         {
            param1.setPixels(new Rectangle(0,0,param2,590),_loc4_);
            param1.setPixels(new Rectangle(param2,0,940 - param2,590),_loc3_);
         }
         else
         {
            param1.setPixels(new Rectangle(0,0,940 + param2,590),_loc4_);
            param1.setPixels(new Rectangle(940 + param2,0,-param2,590),_loc3_);
         }
         return param1;
      }
   }
}
