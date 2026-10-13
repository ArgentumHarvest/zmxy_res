package com.superkaka.game.Base
{
   import com.superkaka.Tools.DescribeClass;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class BaseVO extends EventDispatcher
   {
       
      
      public function BaseVO()
      {
         super();
      }
      
      public function buildFromObject(o:Object) : void
      {
         var flag:Boolean = false;
         for(var name in o)
         {
            if(this.hasOwnProperty(name))
            {
               flag = this[name] is BaseVO;
               if(flag)
               {
                  (this[name] as BaseVO).buildFromObject(o[name]);
               }
               else if(!(this[name] is Dictionary))
               {
                  this[name] = o[name];
               }
            }
         }
      }
      
      public function buildFormXMLAttr(xml:XML) : void
      {
         for each(var name in this)
         {
            try
            {
               this[name] = xml[name];
            }
            catch(err:Error)
            {
               trace("err : " + err);
            }
         }
      }
      
      public function buildFormXML(xml:XML) : void
      {
         var thisOb:Object = DescribeClass.describe_flash(this);
         for(var name in thisOb)
         {
            try
            {
               this[name] = xml[name].text();
               if(typeof this[name] == "boolean")
               {
                  if(xml[name].text() == "true" || Number(xml[name].text()) > 0)
                  {
                     this[name] = true;
                  }
                  else
                  {
                     this[name] = false;
                  }
               }
            }
            catch(err:Error)
            {
               continue;
            }
         }
      }
      
      public function cloneToObject() : BaseVO
      {
         var cl:Class = getDefinitionByName(getQualifiedClassName(this)) as Class;
         var thisOb:Object = DescribeClass.describe(this);
         var resObj:* = new cl();
         for(var name in thisOb)
         {
            resObj[name] = this[name];
         }
         return resObj;
      }
      
      override public function toString() : String
      {
         var thisOb:Object = DescribeClass.describe_flash(this);
         var str:String = "{";
         var name:* = "";
         for(name in thisOb)
         {
            str += "|" + name + ":" + this[name];
         }
         thisOb = DescribeClass.describe(this);
         for(name in thisOb)
         {
            str += "|" + name + ":" + this[name];
         }
         return str + "}";
      }
   }
}
