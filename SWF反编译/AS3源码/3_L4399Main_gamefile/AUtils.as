package
{
   import base.BaseObject;
   import com.greensock.TweenMax;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import flash.utils.clearInterval;
   import flash.utils.getDefinitionByName;
   import flash.utils.setInterval;
   import mvc.controllor.RandomControllor;
   
   public class AUtils
   {
      
      private static var evemonth:Array = [31,29,31,30,31,30,31,31,30,31,30,31];
       
      
      public function AUtils()
      {
         super();
      }
      
      public static function getClass(name:*) : *
      {
         return getDefinitionByName(name) as Class;
      }
      
      public static function getNewObj(name:*) : *
      {
         var cls:Class = getDefinitionByName(name) as Class;
         return new cls();
      }
      
      public static function getImageObj(name:*) : *
      {
         var cls:Class = getDefinitionByName(name) as Class;
         var temp:* = new cls();
         return new Bitmap(temp);
      }
      
      public static function getImageSprite(name:*) : *
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
      
      public static function changeNumber(num:Number, snum:uint) : *
      {
         var str:String = num + "";
         return Number(str.substr(0,snum + 2));
      }
      
      public static function numberAdd(num1:Number, num2:Number, snum:uint) : *
      {
         var str:String = Math.floor(num1 * 100 + num2 * 100) / 100 + "";
         return Number(str.substr(0,snum + 2));
      }
      
      public static function enCurHas(v:*) : int
      {
         return v * 100 + 201;
      }
      
      public static function deCurHas(v:int) : int
      {
         return v - 201;
      }
      
      public static function enCodeString(str:String) : Array
      {
         var i:* = 0;
         var slen:uint = str.length;
         var arr:Array = [];
         for(i = uint(0); i < slen; )
         {
            arr.push(str.charAt(i));
            i++;
         }
         return arr;
      }
      
      public static function getDeCodeString(arr:Array) : String
      {
         var i:* = 0;
         var alen:uint = arr.length;
         var str:String = "";
         for(i = uint(0); i < alen; )
         {
            str += arr[i];
            i++;
         }
         return str;
      }
      
      public static function getDayBetweenDate(_day1:String, _day2:String) : int
      {
         var date3:* = null;
         var date4:* = null;
         var dayAry1:Array = _day1.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]);
         var day1:uint = int(dayAry1[2]);
         var dayAry2:Array = _day2.split("-");
         var year2:uint = int(dayAry2[0]);
         var month2:uint = int(dayAry2[1]);
         var day2:uint = int(dayAry2[2]);
         var date1:Date = new Date(year1,month1,day1);
         var date2:Date = new Date(year2,month2,day2);
         var diff:int = (date2.getTime() - date1.getTime()) / 1000;
         if(diff < 0)
         {
            date3 = new Date(year1,month1 - 1,day1);
            date4 = new Date(year2,month2 - 1,day2);
            diff = (date4.getTime() - date3.getTime()) / 1000;
            return diff / 3600 / 24;
         }
         return diff / 3600 / 24;
      }
      
      public static function getDayBetweenTwoDate(_day1:String, _day2:String) : int
      {
         var dayAry1:Array = _day1.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
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
      
      public static function numberSub(num1:Number, num2:Number, snum:uint) : *
      {
         var str:String = Math.floor(num1 * 100 - num2 * 100) / 100 + "";
         var title:String = str.charAt(0);
         if(title == "-")
         {
            return Number(str.substr(0,snum + 4));
         }
         return Number(str.substr(0,snum + 3));
      }
      
      public static function stopAllChildren(mc:DisplayObjectContainer) : void
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
      
      public static function testIntersects(obj1:*, obj2:*, parent:DisplayObjectContainer) : Boolean
      {
         return obj1.getBounds(parent).intersects(obj2.getBounds(parent));
      }
      
      public static function startAllChildren(mc:DisplayObjectContainer) : void
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
      
      public static function nextAllChildren(mc:DisplayObjectContainer) : void
      {
         var i:int = 0;
         var m:* = null;
         for(i = 0; i < mc.numChildren; )
         {
            if(mc.getChildAt(i) is MovieClip)
            {
               m = mc.getChildAt(i) as MovieClip;
               if(m.currentFrame == m.totalFrames)
               {
                  m.gotoAndStop(1);
               }
               else
               {
                  m.nextFrame();
               }
               nextAllChildren(m);
            }
            i++;
         }
      }
      
      public static function center(obj:DisplayObject, stage:Stage) : *
      {
         obj.x = (stage.stageWidth - obj.width) / 2;
         obj.y = (stage.stageHeight - obj.height) / 2;
      }
      
      public static function clone(source:Object) : Object
      {
         var r:ByteArray = new ByteArray();
         r.writeObject(source);
         r.position = 0;
         return r.readObject();
      }
      
      public static function shallowEffect(displayObj:DisplayObject) : void
      {
         displayObj = displayObj;
         var b:BitmapData = new BitmapData(displayObj.width,displayObj.height,true,16777215);
         b.draw(displayObj,new Matrix(displayObj.transform.matrix.a,0,0,1,displayObj.width / 2,displayObj.height / 2));
         var bm:Bitmap = new Bitmap(b);
         bm.x = displayObj.x - displayObj.width / 2;
         bm.y = displayObj.y - displayObj.height / 2;
         if(displayObj is BaseObject)
         {
            if(BaseObject(displayObj).isStatic())
            {
               bm.x += (RandomControllor.getIns().getRandom() - 0.5) * 5;
            }
         }
         if(displayObj.parent)
         {
            var idx:int = displayObj.parent.getChildIndex(displayObj);
            displayObj.parent.addChildAt(bm,idx);
            TweenMax.to(bm,1,{
               "alpha":0,
               "onCompleteParams":[bm],
               "onComplete":function(b:Bitmap):*
               {
                  if(b && b.parent && b.parent.contains(b))
                  {
                     b.bitmapData.dispose();
                     b.bitmapData = null;
                     b.parent.removeChild(b);
                  }
               }
            });
         }
         else
         {
            bm.bitmapData.dispose();
            bm.bitmapData = null;
         }
      }
      
      public static function flipHorizontal(dsp:DisplayObject, a:int) : void
      {
         var matrix:Matrix = dsp.transform.matrix;
         var tempa:* = matrix.a;
         matrix.a = a == 1 ? Math.abs(tempa) : -Math.abs(tempa);
         dsp.transform.matrix = matrix;
      }
      
      public static function GlowEffect() : GlowFilter
      {
         return new GlowFilter(16777215,1,15,15,1.5,2,false,false);
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
      
      public static function GetDisBetweenTwoObj(obj1:*, obj2:*) : Number
      {
         if(!obj1 || !obj2)
         {
            return 0;
         }
         var offsetX:Number = obj2.x - obj1.x;
         var offsetY:Number = obj2.y - obj1.y;
         return Math.sqrt(offsetX * offsetX + offsetY * offsetY);
      }
      
      public static function GetDisBetweenTwoPoint(obj1:Point, obj2:Point) : Number
      {
         if(!obj1 || !obj2)
         {
            return 0;
         }
         var offsetX:Number = obj2.x - obj1.x;
         var offsetY:Number = obj2.y - obj1.y;
         return Math.sqrt(offsetX * offsetX + offsetY * offsetY);
      }
      
      public static function checkLoadOK(dis:*, fun:Function) : void
      {
         dis = dis;
         fun = fun;
         var si:int = setInterval(function():*
         {
            var j:int = 0;
            var totalNum:int = dis.numChildren;
            var flag:Boolean = true;
            for(j = 0; j < totalNum; )
            {
               if(!dis.getChildAt(j))
               {
                  flag = false;
                  break;
               }
               j++;
            }
            if(flag)
            {
               clearInterval(si);
               fun.call();
            }
         },100);
      }
      
      public static function getRandomValue() : int
      {
         return Math.ceil((0.5 - RandomControllor.getIns().getRandom()) * (30 + RandomControllor.getIns().getRandom() * 5000000));
      }
      
      public static function encryptValue(data:*) : *
      {
         return undefined;
      }
   }
}
