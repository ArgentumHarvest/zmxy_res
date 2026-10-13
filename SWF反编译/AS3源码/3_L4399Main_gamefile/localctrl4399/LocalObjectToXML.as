package localctrl4399
{
   public class LocalObjectToXML
   {
       
      
      private var _xml:XML;
      
      private const NULL_TYPY:String = "undefined";
      
      private const BOOBLEAN_TYPE:String = "Boolean";
      
      private const ARRAY_TYPE:String = "Array";
      
      private const STRING_TYPE:String = "String";
      
      private const OBJECT_TYPE:String = "Object";
      
      private const NUMBER_TYPE:String = "Number";
      
      private const XML_TYPE:String = "XML";
      
      public function LocalObjectToXML()
      {
         super();
      }
      
      public function objectToString(obj:Object) : String
      {
         var xml:* = null;
         var type:* = null;
         var str:* = null;
         if(!obj)
         {
            return null;
         }
         if(obj is Boolean)
         {
            type = "Boolean";
            xml = bolToXml(obj as Boolean,null);
         }
         else
         {
            if(obj is XML)
            {
               xml = obj as XML;
               xml.ignoreComments = true;
               return xml.toString();
            }
            if(obj is Array)
            {
               type = "Array";
               xml = arrToXml(obj as Array,null);
            }
            else
            {
               if(obj is String)
               {
                  type = "String";
                  return obj as String;
               }
               if(obj is Number || obj is int || obj is uint)
               {
                  type = "Number";
                  return String(obj);
               }
               if(obj is Object)
               {
                  type = "Object";
                  xml = objToXml(obj);
               }
            }
         }
         init(type);
         _xml.appendChild(xml);
         _xml.ignoreWhitespace = true;
         return _xml.toString();
      }
      
      public function objToXml(obj:Object, name:String = null) : XML
      {
         var xml:* = null;
         var val:* = null;
         var tmpXml:* = null;
         xml = <s></s>;
         xml.@type = "Object";
         xml.@name = name;
         for(name in obj)
         {
            val = obj[name];
            if(val is Boolean)
            {
               tmpXml = bolToXml(val as Boolean,name);
               xml.appendChild(tmpXml);
            }
            else if(val is String)
            {
               tmpXml = stringToXml(val as String,name);
               xml.appendChild(tmpXml);
            }
            else if(val is int || val is uint || val is Number)
            {
               tmpXml = numToXml(val as Number,name);
               xml.appendChild(tmpXml);
            }
            else if(val is Array)
            {
               tmpXml = arrToXml(val as Array,name);
               xml.appendChild(tmpXml);
            }
            else if(val is Object)
            {
               tmpXml = objToXml(val,name);
               xml.appendChild(tmpXml);
            }
            else if(!val)
            {
               tmpXml = nullToxml(null,name);
               xml.appendChild(tmpXml);
            }
         }
         return xml;
      }
      
      private function nullToxml(str:String, name:String) : XML
      {
         var xml:* = null;
         xml = <s></s>;
         xml.@type = "undefined";
         xml.@name = name;
         return xml;
      }
      
      private function stringToXml(str:String, name:String) : XML
      {
         var xml:* = null;
         xml = new XML("<s>" + str + "</s>");
         xml.@type = "String";
         xml.@name = name;
         return xml;
      }
      
      private function numToXml(num:Number, name:String) : XML
      {
         var xml:* = null;
         xml = new XML("<s>" + String(num) + "</s>");
         xml.@type = "Number";
         xml.@name = name;
         return xml;
      }
      
      private function arrToXml(arr:Array, name:String) : XML
      {
         var i:int = 0;
         var len:int = 0;
         var xml:* = null;
         var val:* = null;
         var tmpXml:* = null;
         len = arr.length;
         xml = <s></s>;
         xml.@type = "Array";
         xml.@name = name;
         for(i = 0; i < len; )
         {
            val = arr[i];
            if(val is Boolean)
            {
               tmpXml = bolToXml(val as Boolean,null);
               xml.appendChild(tmpXml);
            }
            else if(val is String)
            {
               tmpXml = stringToXml(val as String,null);
               xml.appendChild(tmpXml);
            }
            else if(val is int || val is uint || val is Number)
            {
               tmpXml = numToXml(val as Number,null);
               xml.appendChild(tmpXml);
            }
            else if(val is Array)
            {
               tmpXml = arrToXml(val as Array,null);
               xml.appendChild(tmpXml);
            }
            else if(val is Object)
            {
               tmpXml = objToXml(val,null);
               xml.appendChild(tmpXml);
            }
            i++;
         }
         return xml;
      }
      
      private function bolToXml(bol:Boolean, name:String) : XML
      {
         var xml:* = null;
         if(bol)
         {
            xml = <s>true</s>;
         }
         else
         {
            xml = <s>false</s>;
         }
         xml.@type = "Boolean";
         xml.@name = name;
         return xml;
      }
      
      private function init(type:String) : void
      {
         _xml = <saveXml></saveXml>;
         _xml.@type = type;
         _xml.@game4399 = true;
      }
   }
}
