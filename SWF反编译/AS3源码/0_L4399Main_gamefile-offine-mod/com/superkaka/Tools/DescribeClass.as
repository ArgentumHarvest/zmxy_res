package com.superkaka.Tools
{
   import flash.utils.describeType;
   
   public class DescribeClass
   {
       
      
      public function DescribeClass()
      {
         super();
      }
      
      public static function getObjectString(obj:*, indent:String = "") : String
      {
         var str:String = "";
         if(obj is Array)
         {
            str += "\n";
            indent += "|__";
            for(var i in obj)
            {
               str = str + indent + i + "=>" + getObjectString(obj[i],indent);
            }
         }
         else if(obj is Number)
         {
            str = str + obj + " (n)\n";
         }
         else if(obj is String)
         {
            str = str + obj + " (s)\n";
         }
         else if(obj is Boolean)
         {
            str = str + obj + " (b)\n";
         }
         else if(obj is Object)
         {
            str += "\n";
            indent += "|__";
            for(var o in obj)
            {
               str = str + indent + o + "=>" + getObjectString(obj[o],indent);
            }
         }
         else
         {
            str = str + obj + " (e)\n";
         }
         return str;
      }
      
      public static function describe(o:*) : Object
      {
         var i:int = 0;
         var na:* = null;
         var xml:XML = describeType(o);
         var xmlist:XMLList = xml.accessor;
         o = {};
         for(i = 0; i < xmlist.length(); )
         {
            na = xmlist[i].attribute("name");
            o[na] = null;
            i++;
         }
         return o;
      }
      
      public static function describe_flash(o:*) : Object
      {
         var i:int = 0;
         var na:* = null;
         var xml:XML = describeType(o);
         var xmlist:XMLList = xml.variable;
         o = {};
         for(i = 0; i < xmlist.length(); )
         {
            na = xmlist[i].attribute("name");
            o[na] = null;
            i++;
         }
         return o;
      }
   }
}
