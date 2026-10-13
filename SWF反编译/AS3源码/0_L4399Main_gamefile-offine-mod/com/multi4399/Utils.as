package com.multi4399
{
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   
   public class Utils
   {
       
      
      public function Utils()
      {
         super();
      }
      
      public static function byte4_to_ints(bytes:ByteArray) : Array
      {
         var i:int = 0;
         bytes.position = 0;
         var array:Array = [];
         var len:int = bytes.length / 4;
         bytes.endian = "littleEndian";
         for(i = 0; i < len; )
         {
            array.push(bytes.readUnsignedInt());
            i++;
         }
         return array;
      }
      
      public static function ints_to_byte4(array:Array) : ByteArray
      {
         var i:int = 0;
         var bytes:ByteArray = new ByteArray();
         var len:int = array.length;
         bytes.endian = "littleEndian";
         for(i = 0; i < len; )
         {
            bytes.writeUnsignedInt(array[i]);
            i++;
         }
         bytes.position = 0;
         return bytes;
      }
      
      public static function byte2_to_ints(bytes:ByteArray) : Array
      {
         var i:int = 0;
         bytes.position = 0;
         var array:Array = [];
         var len:int = bytes.length / 2;
         bytes.endian = "littleEndian";
         for(i = 0; i < len; )
         {
            array.push(bytes.readUnsignedShort());
            i++;
         }
         return array;
      }
      
      public static function ints_to_byte2(array:Array) : ByteArray
      {
         var i:int = 0;
         var bytes:ByteArray = new ByteArray();
         var len:int = array.length;
         bytes.endian = "littleEndian";
         for(i = 0; i < len; )
         {
            bytes.writeShort(array[i]);
            i++;
         }
         bytes.position = 0;
         return bytes;
      }
      
      public function var2bin(variable:*, endian:String = "bigEndian") : ByteArray
      {
         var type:String = getQualifiedClassName(variable);
         var bin:ByteArray = new ByteArray();
         bin.endian = endian;
         switch(type)
         {
            case "int":
               bin.writeInt(variable);
               break;
            case "Number":
               bin.writeDouble(variable);
               break;
            case "String":
               bin.writeUTFBytes(variable);
               break;
            case "Array":
               bin.writeUTFBytes(variable.toString());
               break;
            case "flash.utils::ByteArray":
               bin = variable;
         }
         return bin;
      }
   }
}
