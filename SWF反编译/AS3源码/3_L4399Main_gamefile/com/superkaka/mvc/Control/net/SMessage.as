package com.superkaka.mvc.Control.net
{
   import com.superkaka.game.Base.BaseVO;
   import com.superkaka.game.Const.ProtocolDict;
   import flash.utils.ByteArray;
   
   public class SMessage extends BaseVO
   {
       
      
      protected var _path:String = "";
      
      protected var _encodeType:int = 1;
      
      protected var _crypt:int = 1;
      
      protected var _compressd:int = 0;
      
      protected var head:ByteArray;
      
      protected var body:ByteArray;
      
      public function SMessage(path:String, encodeType:int = 1, crypt:int = 1, compressd:int = 0)
      {
         head = new ByteArray();
         body = new ByteArray();
         super();
         this._compressd = compressd;
         this._encodeType = encodeType;
         this._crypt = crypt;
         this._path = path;
         head.endian = "littleEndian";
         body.endian = "littleEndian";
         this.writeHead();
         this.writeBody();
      }
      
      protected function writeHead() : void
      {
         if(this._path != "")
         {
            head.writeUTF(this._path);
         }
         else
         {
            head.writeShort(0);
         }
      }
      
      protected function writeBody() : void
      {
      }
      
      public function writeBodyData(jStr:String) : void
      {
         body.writeUTF(jStr);
      }
      
      protected function writeJsonBody(jObj:Object) : void
      {
      }
      
      public function bodyJson() : String
      {
         var baCopy:* = null;
         if(this._compressd)
         {
            baCopy = new ByteArray();
            baCopy.endian = "littleEndian";
            baCopy.writeBytes(body);
            baCopy.uncompress("zlib");
         }
         baCopy.position = 0;
         return baCopy.readUTFBytes(baCopy.length);
      }
      
      public function headJson() : String
      {
         head.position = 0;
         return head.readUTF();
      }
      
      public function getData(codeName:String) : ByteArray
      {
         var crypt:int = 0;
         var headLen:int = 0;
         var m:int = 0;
         var bodyLen:int = 0;
         var n:int = 0;
         var len:* = 0;
         var key:int = 0;
         var i:* = 0;
         var ba:ByteArray = new ByteArray();
         ba.endian = "littleEndian";
         if(this._compressd == 1)
         {
            body.compress("zlib");
         }
         var packLen:int = head.length + body.length + 3;
         if(this._crypt == 1)
         {
            packLen += 4;
         }
         ba.writeInt(packLen);
         ba.writeByte(this._encodeType);
         ba.writeByte(this._crypt);
         ba.writeByte(this._compressd);
         if(this._crypt == 1)
         {
            crypt = head[0];
            headLen = head.length;
            for(m = 0; m < headLen; )
            {
               crypt += head[m];
               m++;
            }
            bodyLen = body.length;
            for(n = 0; n < bodyLen; )
            {
               crypt += body[n];
               n++;
            }
            ba.writeInt(crypt);
         }
         ba.writeBytes(head);
         ba.writeBytes(body);
         if(this._encodeType == 1)
         {
            len = uint(ba.length);
            key = ProtocolDict.getIns().getEncodeKey(codeName);
            for(i = uint(7); i < len; )
            {
               ba[i] ^= key;
               i++;
            }
         }
         return ba;
      }
      
      public function destroy() : void
      {
         this.head.length = 0;
         this.head.clear();
         this.body.length = 0;
         this.body.clear();
         this.head = null;
         this.body = null;
      }
      
      public function get path() : String
      {
         return _path;
      }
   }
}
