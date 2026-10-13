package localcalista.utils
{
   import flash.utils.ByteArray;
   
   public class LocalBase64
   {
      
      private static const base64chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
       
      
      public function LocalBase64()
      {
         super();
      }
      
      public static function encode(source:String) : String
      {
         var i:int = 0;
         var chr2:int = 0;
         var chr3:int = 0;
         var chr1:int = 0;
         var enc2:int = 0;
         var enc3:int = 0;
         var enc4:int = 0;
         var enc1:int = 0;
         if(!source || source == "")
         {
            return "";
         }
         var size:int = source.length;
         var output:String = "";
         while(i < size)
         {
            chr1 = source.charCodeAt(i++);
            chr2 = source.charCodeAt(i++);
            chr3 = source.charCodeAt(i++);
            enc1 = chr1 >> 2;
            enc2 = (chr1 & 3) << 4 | chr2 >> 4;
            enc3 = (chr2 & 15) << 2 | chr3 >> 6;
            enc4 = chr3 & 63;
            if(isNaN(chr2))
            {
               enc3 = enc4 = 64;
            }
            else if(isNaN(chr3))
            {
               enc4 = 64;
            }
            output += "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".charAt(enc1) + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".charAt(enc2);
            output += "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".charAt(enc3) + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".charAt(enc4);
         }
         return output;
      }
      
      public static function encodeByteArray(data:ByteArray) : String
      {
         var i:* = 0;
         var l:int = 0;
         var dataBuffer:* = null;
         if(!data)
         {
            return "";
         }
         var pos:uint = data.position;
         var output:String = "";
         var outputBuffer:Array = new Array(4);
         data.position = 0;
         while(data.bytesAvailable > 0)
         {
            dataBuffer = [];
            i = int(0);
            while(i < 3 && data.bytesAvailable > 0)
            {
               dataBuffer[i] = data.readUnsignedByte();
               i++;
            }
            outputBuffer[0] = (dataBuffer[0] & 252) >> 2;
            outputBuffer[1] = (dataBuffer[0] & 3) << 4 | dataBuffer[1] >> 4;
            outputBuffer[2] = (dataBuffer[1] & 15) << 2 | dataBuffer[2] >> 6;
            outputBuffer[3] = dataBuffer[2] & 63;
            l = dataBuffer.length;
            for(i = l; i < 3; )
            {
               outputBuffer[i + 1] = 64;
               i++;
            }
            l = outputBuffer.length;
            for(i = int(0); i < l; )
            {
               output += "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".charAt(outputBuffer[i]);
               i++;
            }
         }
         data.position = pos;
         return output;
      }
      
      public static function decode(source:String) : String
      {
         var chr2:int = 0;
         var chr3:int = 0;
         var chr1:int = 0;
         var enc2:int = 0;
         var enc3:int = 0;
         var enc4:int = 0;
         var enc1:int = 0;
         var i:int = 0;
         if(!source || source == "")
         {
            return "";
         }
         var size:int = source.length;
         var output:String = "";
         while(i < size)
         {
            enc1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".indexOf(source.charAt(i++));
            enc2 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".indexOf(source.charAt(i++));
            enc3 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".indexOf(source.charAt(i++));
            enc4 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".indexOf(source.charAt(i++));
            chr1 = enc1 << 2 | enc2 >> 4;
            chr2 = (enc2 & 15) << 4 | enc3 >> 2;
            chr3 = (enc3 & 3) << 6 | enc4;
            output += String.fromCharCode(chr1);
            if(enc3 != 64)
            {
               output += String.fromCharCode(chr2);
            }
            if(enc4 != 64)
            {
               output += String.fromCharCode(chr3);
            }
         }
         return output;
      }
      
      public static function decodeToByteArray(data:String) : ByteArray
      {
         var i:* = 0;
         var j:* = 0;
         var k:* = 0;
         var output:ByteArray = new ByteArray();
         var dataBuffer:Array = new Array(4);
         var outputBuffer:Array = new Array(3);
         var length:uint = data.length;
         i;
         while(i < length)
         {
            j = uint(0);
            while(j < 4 && i + j < length)
            {
               dataBuffer[j] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".indexOf(data.charAt(i + j));
               j++;
            }
            outputBuffer[0] = (dataBuffer[0] << 2) + ((dataBuffer[1] & 48) >> 4);
            outputBuffer[1] = ((dataBuffer[1] & 15) << 4) + ((dataBuffer[2] & 60) >> 2);
            outputBuffer[2] = ((dataBuffer[2] & 3) << 6) + dataBuffer[3];
            for(k = uint(0); k < 3; )
            {
               if(dataBuffer[k + 1] == 64)
               {
                  break;
               }
               output.writeByte(outputBuffer[k]);
               k++;
            }
            i += 4;
         }
         output.position = 0;
         return output;
      }
   }
}
