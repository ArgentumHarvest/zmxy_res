package com.superkaka.mvc.Control
{
   import com.superkaka.Tools.AUtils;
   import com.superkaka.game.Const.ProtocolDict;
   import com.superkaka.mvc.Base.BaseControl;
   import com.superkaka.mvc.ControlFactory;
   import flash.utils.ByteArray;
   
   public class RMessageControl extends BaseControl
   {
       
      
      public function RMessageControl()
      {
         super();
      }
      
      public function analysicsMessage(prePath:String, data:ByteArray, codeName:String, cb:Function = null) : void
      {
         var key:int = 0;
         var len:int = 0;
         var i:* = 0;
         var encodeType:int = data.readByte();
         var crypt:int = data.readByte();
         var compressd:int = data.readByte();
         if(encodeType == 1)
         {
            key = ProtocolDict.getIns().getDecodeKey(codeName);
            len = data.length;
            for(i = uint(0); i < len; )
            {
               data[i] ^= key;
               i++;
            }
         }
         if(crypt == 1)
         {
         }
         var pathLen:int = data.readShort();
         var path:String = data.readUTFBytes(pathLen);
         var body:ByteArray = new ByteArray();
         body.endian = "littleEndian";
         body.writeBytes(data,data.position);
         body.position = 0;
         if(body.length > 0)
         {
            trace("---收到数据---len:" + body.length);
         }
         if(compressd == 1)
         {
            body.uncompress("zlib");
         }
         var pathArr:Array = path.split(".");
         var fileName:String = pathArr.shift();
         var funcName:String = pathArr.shift();
         if(fileName == "MvcReceive")
         {
            if(cb)
            {
               cb(fileName,funcName,body);
            }
            return;
         }
         var cls:Class = AUtils.getClass(prePath + fileName);
         var control:BaseControl = ControlFactory.getIns().getControl(cls);
         control[funcName](body);
      }
   }
}
