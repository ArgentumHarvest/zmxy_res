package com.superkaka.Tools
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class AUtils
   {
       
      
      public function AUtils()
      {
         super();
      }
      
      public static function getClass(name:*) : Class
      {
         return getDefinitionByName(name) as Class;
      }
      
      public static function getNewObj(name:*) : Object
      {
         var cls:Class = getDefinitionByName(name) as Class;
         return new cls();
      }
      
      public static function getImageObj(name:*) : Bitmap
      {
         var cls:Class = getDefinitionByName(name) as Class;
         var temp:* = new cls();
         return new Bitmap(temp);
      }
      
      public static function getImageSprite(name:*) : Sprite
      {
         var cls:Class = getDefinitionByName(name) as Class;
         var temp:* = new cls();
         var bm:Bitmap = new Bitmap(temp);
         var sprite:Sprite = new Sprite();
         sprite.addChild(bm);
         return sprite;
      }
      
      public static function stringToByteArray(str:String) : ByteArray
      {
         var ba:ByteArray = new ByteArray();
         ba.endian = "littleEndian";
         ba.writeUTFBytes(str);
         ba.position = 0;
         return ba;
      }
      
      public static function getDisBetweenTwoObject(obj1:*, obj2:*) : Number
      {
         var xOffset:Number = obj1.x - obj2.x;
         var yOffset:Number = obj1.y - obj2.y;
         return Number(Math.sqrt(xOffset * xOffset + yOffset * yOffset));
      }
      
      public static function getDisBetweenTwoEntity(obj1:DisplayObject, obj2:DisplayObject) : Number
      {
         var xOffset:Number = obj1.x - obj2.x;
         var yOffset:Number = obj1.y - obj2.y;
         return Number(Math.sqrt(xOffset * xOffset + yOffset * yOffset));
      }
      
      public static function getDayBetweenDate(_day1:String, _day2:String) : int
      {
         var dayAry1:Array = _day1.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]);
         var day1:uint = int(dayAry1[2]);
         var dayAry2:Array = _day2.split("-");
         var year2:uint = int(dayAry2[0]);
         var month2:uint = int(dayAry2[1]) - 1;
         var day2:uint = int(dayAry2[2]);
         var date1:Date = new Date(year1,month1,day1);
         var date2:Date = new Date(year2,month2,day2);
         var diff:int = (date2.getTime() - date1.getTime()) / 1000;
         return diff / 3600 / 24;
      }
      
      public static function stopAllChildren(mc:MovieClip) : void
      {
         var i:int = 0;
         var m:* = null;
         for(i = 0; i < mc.numChildren; )
         {
            if(mc.getChildAt(i) && mc.getChildAt(i) is MovieClip)
            {
               m = mc.getChildAt(i) as MovieClip;
               if(m)
               {
                  m.stop();
                  stopAllChildren(m);
               }
            }
            i++;
         }
      }
      
      public static function startAllChildren(mc:MovieClip) : void
      {
         var i:int = 0;
         var m:* = null;
         for(i = 0; i < mc.numChildren; )
         {
            if(mc.getChildAt(i) is MovieClip)
            {
               m = mc.getChildAt(i) as MovieClip;
               m.play();
               startAllChildren(m);
            }
            i++;
         }
      }
      
      public static function clone(source:Object) : Object
      {
         var r:ByteArray = new ByteArray();
         r.writeObject(source);
         r.position = 0;
         return r.readObject();
      }
      
      public static function showFunctionTime(func:Function, label:String) : void
      {
         label = !!label ? label : "time";
         var t1:int = getTimer();
         func();
         var t2:int = getTimer();
         trace(label + ":" + (t2 - t1));
      }
      
      public static function getLabelByLeftTime(leftTime:int) : String
      {
         var hours:int = leftTime / 3600000;
         var mins:int = leftTime % 3600000 / 60000;
         var sec:int = leftTime % 60000 / 1000;
         return hours + ":" + mins + ":" + sec;
      }
      
      public static function getDateForm1(date:Date) : String
      {
         var year:String = date.getFullYear() + "";
         var month:String = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1 + "";
         var day:String = date.getDate() < 10 ? "0" + date.getDate() : date.getDate() + "";
         var hour:String = date.getHours() < 10 ? "0" + date.getHours() : date.getHours() + "";
         var min:String = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes() + "";
         var sec:String = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds() + "";
         return year + "." + month + "." + day + "  " + hour + ":" + min + ":" + sec;
      }
      
      public static function GetNextPointByTwoObj(obj1:*, obj2:*) : Point
      {
         if(!obj1 || !obj2)
         {
            return new Point(0,0);
         }
         var offsetX:Number = obj2.x - obj1.x;
         var offsetY:Number = obj2.y - obj1.y;
         if(offsetX == 0 && offsetY == 0)
         {
            return new Point(0,0);
         }
         var dis:Number = Math.sqrt(offsetX * offsetX + offsetY * offsetY);
         return new Point(offsetX / dis,offsetY / dis);
      }
   }
}
