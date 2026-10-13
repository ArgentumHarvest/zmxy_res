package localctrl4399
{
   import flash.utils.ByteArray;
   
   public class LocalXMLToObject
   {
       
      
      private const NULL_TYPY:String = "undefined";
      
      private const BOOBLEAN_TYPE:String = "Boolean";
      
      private const ARRAY_TYPE:String = "Array";
      
      private const STRING_TYPE:String = "String";
      
      private const OBJECT_TYPE:String = "Object";
      
      private const NUMBER_TYPE:String = "Number";
      
      private const XML_TYPE:String = "XML";
      
      public function LocalXMLToObject()
      {
         super();
      }
      
      public function strToObj(str:String) : Array
      {
         var obj:* = null;
         var arr:* = null;
         var bol:Boolean = false;
         var xml:* = null;
         var i:int = 0;
         var len:int = 0;
         var xmlList:* = null;
         var type:* = null;
         var tmpStr:* = null;
         try
         {
            xml = new XML(str);
         }
         catch(error:Error)
         {
            tmpStr = str;
            tmpStr = urlencodeGBK(tmpStr);
            try
            {
               xml = new XML(tmpStr);
            }
            catch(error:Error)
            {
               return ["String",str];
            }
         }
         if(xml.children() == null || xml.children() == undefined)
         {
            return ["String",str];
         }
         if(xml.@game4399 != "true")
         {
            return ["XML",xml];
         }
         if(xml.@type == "Object")
         {
            xmlList = xml.children()[0];
            obj = xmlToObj(xmlList);
            type = "Object";
            return [type,obj];
         }
         if(xml.@type == "Boolean")
         {
            type = "Boolean";
            xmlList = xml.children()[0];
            bol = xmlToBooblean(xmlList);
            return [type,bol];
         }
         if(xml.@type == "Array")
         {
            type = "Array";
            xmlList = xml.children()[0];
            arr = xmlToArray(xmlList);
            return [type,arr];
         }
         return null;
      }
      
      private function xmlToObj(xml:XML) : Object
      {
         var obj:* = null;
         var i:int = 0;
         var len:int = 0;
         var xmlList:* = null;
         var tmpXml:* = null;
         var name:* = null;
         var type:* = null;
         var val:* = null;
         obj = {};
         xmlList = xml.children();
         len = xmlList.length();
         for(i = 0; i < len; )
         {
            tmpXml = xmlList[i];
            type = tmpXml.@type;
            name = tmpXml.@name;
            switch(type)
            {
               case "Array":
                  val = xmlToArray(tmpXml) as Array;
                  break;
               case "Boolean":
                  val = xmlToBooblean(tmpXml) as Boolean;
                  break;
               case "String":
                  val = xmlToString(tmpXml) as String;
                  break;
               case "Number":
                  val = xmlToNumber(tmpXml) as Number;
                  break;
               case "Object":
                  val = xmlToObj(tmpXml);
            }
            obj[name] = val;
            i++;
         }
         return obj;
      }
      
      private function xmlToArray(xml:XML) : Array
      {
         var arr:* = null;
         var i:int = 0;
         var len:int = 0;
         var val:* = null;
         var tmpXml:* = null;
         var childXml:* = null;
         var type:* = null;
         var name:* = null;
         arr = [];
         tmpXml = xml.children();
         len = tmpXml.length();
         for(i = 0; i < len; )
         {
            childXml = tmpXml[i];
            type = childXml.@type;
            name = childXml.@name;
            switch(type)
            {
               case "Array":
                  val = xmlToArray(childXml) as Array;
                  break;
               case "Boolean":
                  val = xmlToBooblean(childXml) as Boolean;
                  break;
               case "String":
                  val = xmlToString(childXml) as String;
                  break;
               case "Number":
                  val = xmlToNumber(childXml) as Number;
                  break;
               case "Object":
                  val = xmlToObj(childXml);
                  break;
               case "undefined":
                  val = null;
            }
            arr.push(val);
            i++;
         }
         return arr;
      }
      
      private function xmlToNumber(xml:XML) : Number
      {
         var num:Number = NaN;
         return Number(Number(xml[0]));
      }
      
      private function xmlToBooblean(xml:XML) : Boolean
      {
         var bol:Boolean = false;
         if(xml[0] == "false")
         {
            bol = false;
         }
         else if(xml[0] == "true")
         {
            bol = true;
         }
         return bol;
      }
      
      private function xmlToString(xml:XML) : String
      {
         var str:* = null;
         return String(xml[0]);
      }
      
      private function urlencodeGBK(str:String) : String
      {
         var result:String = "";
         var byte:ByteArray = new ByteArray();
         byte.writeMultiByte(str,"gbk");
         byte.position = 0;
         return byte.readUTFBytes(byte.length - 1);
      }
   }
}
