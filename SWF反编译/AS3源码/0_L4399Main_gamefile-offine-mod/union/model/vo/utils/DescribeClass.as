package union.model.vo.utils
{
   import flash.utils.describeType;
   
   public class DescribeClass
   {
       
      
      public function DescribeClass()
      {
         super();
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
         var type:* = null;
         var xml:XML = describeType(o);
         var xmlist:XMLList = xml.variable;
         o = {};
         for(i = 0; i < xmlist.length(); )
         {
            na = xmlist[i].attribute("name");
            type = xmlist[i].attribute("type");
            o[na] = type;
            i++;
         }
         return o;
      }
   }
}
