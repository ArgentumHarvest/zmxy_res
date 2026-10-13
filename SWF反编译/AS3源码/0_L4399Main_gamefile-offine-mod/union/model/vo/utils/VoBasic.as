package union.model.vo.utils
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class VoBasic
   {
      
      public static var ClassDescribes:Dictionary = new Dictionary();
       
      
      protected var thisOb:Object;
      
      private var _className:String;
      
      public function VoBasic()
      {
         super();
         _className = getQualifiedClassName(this);
         if(ClassDescribes[_className])
         {
            thisOb = ClassDescribes[_className];
         }
         else
         {
            thisOb = DescribeClass.describe_flash(this);
            ClassDescribes[_className] = thisOb;
         }
      }
      
      public function updateFromObject(o:Object) : void
      {
         for(var name in o)
         {
            if(thisOb.hasOwnProperty(name))
            {
               buildField(name,o[name]);
            }
         }
      }
      
      public function buildFromObject(o:Object) : void
      {
         for(var name in o)
         {
            if(thisOb.hasOwnProperty(name))
            {
               buildField(name,o[name]);
            }
         }
      }
      
      public function buildFormXMLAttr(xml:XML) : void
      {
         for(var name in thisOb)
         {
            try
            {
               this[name] = xml[name];
            }
            catch(err:Error)
            {
            }
         }
      }
      
      public function buildFormXML(xml:XML) : void
      {
         var value:* = null;
         for(var name in thisOb)
         {
            value = xml[name].text();
            buildField(name,value);
         }
      }
      
      protected function buildField(name:String, value:*) : void
      {
         var av:* = null;
         var reg:* = null;
         var tar1:* = null;
         var tob:Boolean = false;
         var i:int = 0;
         var p:* = null;
         var v:* = null;
         var b:* = null;
         if(value == null)
         {
            return;
         }
         if(typeof value != "string")
         {
            if(thisOb[name] != "int")
            {
               av = String(value).split(",");
            }
         }
         if(thisOb[name] == "Array")
         {
            if(value == "")
            {
               this[name] = null;
            }
            else
            {
               this[name] = av;
            }
         }
         else if(thisOb[name] == "int")
         {
            this[name] = int(value);
         }
         else if(thisOb[name] == "Boolean")
         {
            if(value == "true" || Number(value) > 0)
            {
               this[name] = true;
            }
            else
            {
               this[name] = false;
            }
         }
         else if(thisOb[name] != "flash.utils::Dictionary")
         {
            if(String(thisOb[name]).indexOf("__AS3__.vec::Vector.<") != -1)
            {
               reg = /<(.*)>/;
               tar1 = reg.exec(String(thisOb[name]));
               tob = false;
               if(tar1[1] == "int")
               {
                  this[name] = new Vector.<int>();
                  tob = true;
               }
               else if(tar1[1] == "uint")
               {
                  this[name] = new Vector.<uint>();
                  tob = true;
               }
               else if(tar1[1] == "String")
               {
                  this[name] = new Vector.<String>();
                  tob = true;
               }
               else if(tar1[1] == "Number")
               {
                  this[name] = new Vector.<Number>();
                  tob = true;
               }
               else if(tar1[1] == "flash.geom::Point")
               {
                  this[name] = new Vector.<Point>();
                  for(i = 0; i < av.length; )
                  {
                     p = new Point(av[i],av[i + 1]);
                     this[name].push(p);
                     i += 2;
                  }
               }
               if(tob)
               {
                  for each(var item in av)
                  {
                     this[name].push(item);
                  }
               }
            }
            else if(thisOb[name] == "flash.geom::Point")
            {
               if(av)
               {
                  this[name] = new Point(av[0],av[1]);
               }
            }
            else if(thisOb[name] == "flash.geom::Rectangle")
            {
               if(av)
               {
                  this[name] = new Rectangle(Number(av[0]),Number(av[1]),Number(av[2]),Number(av[3]));
               }
            }
            else if(thisOb[name] == "flash.geom::Vector3D")
            {
               if(av.length > 0 && value != "")
               {
                  v = new Vector3D();
                  v.x = av[0];
                  v.y = av[1];
                  v.z = av[2];
                  this[name] = v;
               }
            }
            else if(thisOb[name] == "Object")
            {
               b = new ByteArray();
               b.writeObject(value);
               b.position = 0;
               this[name] = b.readObject();
               b.clear();
            }
            else
            {
               try
               {
                  this[name] = value;
               }
               catch(err:Error)
               {
                  this[name] = null;
               }
            }
         }
      }
      
      public function buildFromCSV(fieldNames:Array, data:Array) : void
      {
         var i:int = 0;
         for(i = 0; i < fieldNames.length; )
         {
            buildField(fieldNames[i],data[i]);
            i++;
         }
      }
      
      public function cloneToObject() : Object
      {
         var resObj:Object = {};
         for(var name in thisOb)
         {
            resObj[name] = this[name];
         }
         return resObj;
      }
      
      public function toString() : String
      {
         var str:String = "{";
         for(var name in thisOb)
         {
            str += "|" + name + ":" + this[name];
         }
         return str + "}";
      }
   }
}
