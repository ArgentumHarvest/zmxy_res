package com.edgarcai.util
{
   import flash.utils.ByteArray;
   
   public final class Utils
   {
       
      
      public function Utils()
      {
         super();
      }
      
      public static function equal(obj1:*, obj2:*) : Boolean
      {
         var bytes1:ByteArray = new ByteArray();
         bytes1.writeObject(obj1);
         bytes1.position = 0;
         var bytes2:ByteArray = new ByteArray();
         bytes2.writeObject(obj2);
         bytes2.position = 0;
         if(bytes1.length == bytes2.length)
         {
            while(bytes1.bytesAvailable)
            {
               if(bytes1.readByte() != bytes2.readByte())
               {
                  return false;
               }
            }
            return true;
         }
         return false;
      }
   }
}
