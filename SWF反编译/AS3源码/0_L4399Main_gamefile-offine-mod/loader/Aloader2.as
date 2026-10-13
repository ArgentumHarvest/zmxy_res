package loader
{
   import flash.utils.ByteArray;
   import localcalista.utils.LocalBase64;
   import localctrl4399.LocalObjectToXML;
   import localctrl4399.LocalXMLToObject;
   
   public class Aloader2
   {
      
      static var instance:Aloader2;
       
      
      private var encryptString:String = "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";
      
      private var _objToXml:LocalObjectToXML;
      
      private var _xmlToObj:LocalXMLToObject;
      
      public function Aloader2()
      {
         super();
         if(!instance)
         {
            instance = this;
         }
      }
      
      public static function getInstance() : Aloader2
      {
         return instance;
      }
      
      public function encryptXml(myXML:XML) : void
      {
         var contentStr:String = encXml(myXML);
         var byte:ByteArray = new ByteArray();
         byte.writeObject(contentStr);
         byte.compress();
         contentStr = LocalBase64.encodeByteArray(byte);
      }
      
      private function encXml(data:Object) : String
      {
         var str:* = null;
         if(_objToXml == null)
         {
            _objToXml = new LocalObjectToXML();
         }
         return _objToXml.objectToString(data);
      }
      
      public function decryptXml() : XML
      {
         if(this.encryptString == "")
         {
            return null;
         }
         var contentStr:String = String(this.encryptString);
         var byte:ByteArray = LocalBase64.decodeToByteArray(contentStr);
         byte.uncompress();
         contentStr = byte.readObject() as String;
         byte = null;
         return decXml(contentStr) as XML;
      }
      
      private function decXml(str:String) : Object
      {
         var xml:* = null;
         var bol:Boolean = false;
         var obj:* = null;
         var tmpAry:* = null;
         if(_xmlToObj == null)
         {
            _xmlToObj = new LocalXMLToObject();
         }
         var arr:Array = _xmlToObj.strToObj(str as String);
         var result:* = "";
         if(arr[0] == "String")
         {
            str = arr[1];
            result = str;
         }
         else if(arr[0] == "XML")
         {
            xml = arr[1];
            result = xml;
         }
         else if(arr[0] == "Boolean")
         {
            bol = arr[1];
            result = bol;
         }
         else if(arr[0] == "Object")
         {
            obj = arr[1];
            result = obj;
         }
         else if(arr[0] == "Array")
         {
            tmpAry = arr[1];
            result = tmpAry;
         }
         return result;
      }
   }
}
