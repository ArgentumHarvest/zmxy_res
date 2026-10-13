package com.edgarcai.encrypt
{
   import flash.utils.ByteArray;
   import mvc.controllor.RandomControllor;
   
   public class binaryEncrypt implements IEncrypt
   {
       
      
      private var _ran:Number;
      
      private var _max:Number = 655360;
      
      public function binaryEncrypt()
      {
         _ran = RandomControllor.getIns().getRandom() * 10000;
         super();
      }
      
      protected function encodeCommand(v:Number) : Number
      {
         var v1:Number = v ^ _ran;
         return v1 >> _max;
      }
      
      protected function decodeCommand(v:Number) : Number
      {
         var v1:Number = v << _max;
         return Number(v1 ^ _ran);
      }
      
      public function encode(data:*) : *
      {
         var bytes:ByteArray = new ByteArray();
         bytes.writeObject(data);
         bytes.position = 0;
         var rBytes:ByteArray = new ByteArray();
         while(bytes.bytesAvailable)
         {
            rBytes.writeInt(encodeCommand(bytes.readByte()));
         }
         return rBytes;
      }
      
      public function decode(data:*) : *
      {
         var bytes:* = null;
         var rBytes:* = null;
         if(data is ByteArray)
         {
            bytes = data as ByteArray;
            bytes.position = 0;
            rBytes = new ByteArray();
            while(bytes.bytesAvailable)
            {
               rBytes.writeByte(decodeCommand(bytes.readInt()));
            }
            rBytes.position = 0;
            return rBytes.readObject();
         }
         throw new Error("数据类型不正确");
      }
   }
}
