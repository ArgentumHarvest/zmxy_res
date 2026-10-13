package com.multi4399
{
   import flash.utils.ByteArray;
   
   public class RequestPacket extends ByteArray
   {
       
      
      private var _size1:ByteArray;
      
      private var _size2:ByteArray;
      
      private var _size4:ByteArray;
      
      private var _size8:ByteArray;
      
      private var _sizeM:ByteArray;
      
      public const HEADER_SIZE:uint = 20;
      
      public const MAX_SIZE:uint = 1024;
      
      public function RequestPacket(endian:String = "littleEndian")
      {
         _size1 = new ByteArray();
         _size2 = new ByteArray();
         _size4 = new ByteArray();
         _size8 = new ByteArray();
         _sizeM = new ByteArray();
         super();
         this.endian = _size1.endian = _size2.endian = _size4.endian = _size8.endian = _sizeM.endian = endian;
         reset();
         this[0] = 89;
         this[1] = 77;
         this[2] = 80;
         this[3] = 0;
         this[4] = 65;
         this[5] = 0;
      }
      
      public function reset() : void
      {
         this.length = 20;
         this.position = 20;
         _size1.length = _size2.length = _size4.length = _size8.length = _sizeM.length = 0;
         _size1.position = _size2.position = _size4.position = _size8.position = _sizeM.position = 0;
      }
      
      public function addInstruction(opcode:uint, ... oprands) : void
      {
         var i:int = 0;
         var oprand:* = 0;
         var value:* = undefined;
         var len:int = oprands.length;
         var tmp1:int = 0;
         var tmp2:int = 0;
         if(len > 14)
         {
            throw new Error("不能超过7个操作数");
         }
         this.writeShort(opcode);
         for(i = 0; i < len; )
         {
            oprand = uint(oprands[i]);
            value = oprands[i + 1];
            this.writeByte(oprand);
            switch(oprand)
            {
               case 0:
                  _size1.writeByte(value);
                  break;
               case 1:
                  _size2.writeShort(value);
                  break;
               case 2:
                  _size4.writeUnsignedInt(value);
                  break;
               case 3:
                  _size8.writeDouble(value);
                  break;
               case 4:
                  _sizeM.writeShort(value.length);
                  _sizeM.writeBytes(value);
                  break;
               case 12:
                  _sizeM.writeShort(1);
                  _sizeM.writeByte(value);
                  break;
               case 20:
                  _sizeM.writeShort(2);
                  _sizeM.writeShort(value);
                  break;
               case 28:
                  _sizeM.writeShort(4);
                  _sizeM.writeInt(value);
                  break;
               case 36:
                  _sizeM.writeShort(8);
                  _sizeM.writeDouble(value);
                  break;
               case 244:
                  _sizeM.position += 2;
                  tmp1 = _sizeM.position;
                  _sizeM.writeUTFBytes(value);
                  tmp2 = _sizeM.position - tmp1;
                  _sizeM.position = tmp1 - 2;
                  _sizeM.writeShort(tmp2);
                  _sizeM.position += tmp2;
                  break;
               case 228:
                  value = value.toXMLString();
                  _sizeM.position += 2;
                  tmp1 = _sizeM.position;
                  _sizeM.writeUTFBytes(value);
                  tmp2 = _sizeM.position - tmp1;
                  _sizeM.position = tmp1 - 2;
                  _sizeM.writeShort(tmp2);
                  _sizeM.position += tmp2;
                  break;
               default:
                  throw new Error("不支持的变量类型");
            }
            i += 2;
         }
      }
      
      public function pack(mark:uint) : void
      {
         var offset:int = 0;
         this.writeShort(0);
         offset = !!_size1.length ? this.length - 20 : 0;
         offset && this.writeBytes(_size1);
         this[10] = offset & 255;
         this[11] = (offset & 65280) >> 8;
         offset = !!_size2.length ? this.length - 20 : 0;
         offset && this.writeBytes(_size2);
         this[12] = offset & 255;
         this[13] = (offset & 65280) >> 8;
         offset = !!_size4.length ? this.length - 20 : 0;
         offset && this.writeBytes(_size4);
         this[14] = offset & 255;
         this[15] = (offset & 65280) >> 8;
         offset = !!_size8.length ? this.length - 20 : 0;
         offset && this.writeBytes(_size8);
         this[16] = offset & 255;
         this[17] = (offset & 65280) >> 8;
         offset = !!_sizeM.length ? this.length - 20 : 0;
         offset && this.writeBytes(_sizeM);
         this[18] = offset & 255;
         this[19] = (offset & 65280) >> 8;
         offset = this.length;
         this[6] = offset & 255;
         this[7] = (offset & 65280) >> 8;
         this[8] = mark & 255;
         this[9] = (mark & 65280) >> 8;
         if(this.length > 1024)
         {
            throw new Error("发送的数据包长度越过最大值:1024个字节,请分开发送!");
         }
      }
   }
}
