package
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Circ;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.ConvolutionFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import flash.utils.clearInterval;
   import flash.utils.getDefinitionByName;
   import flash.utils.setInterval;
   import my.BitmapDataTransfer;
   
   public class AUtils
   {
       
      
      public function AUtils()
      {
         super();
      }
      
      public static function getClass(param1:*) : *
      {
         return getDefinitionByName(param1) as Class;
      }
      
      public static function getNewObj(param1:*) : *
      {
         var _loc2_:Class = getDefinitionByName(param1) as Class;
         return new _loc2_();
      }
      
      public static function getImageObj(param1:*) : *
      {
         var _loc2_:Class = getDefinitionByName(param1) as Class;
         var _loc3_:* = new _loc2_();
         return new Bitmap(_loc3_);
      }
      
      public static function stopAllChildren(param1:DisplayObjectContainer) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.numChildren)
         {
            if(param1.getChildAt(_loc2_) is MovieClip)
            {
               _loc3_ = param1.getChildAt(_loc2_) as MovieClip;
               if(_loc3_.name != "levelupmc")
               {
                  _loc3_.stop();
                  stopAllChildren(_loc3_);
               }
            }
            _loc2_++;
         }
      }
      
      public static function testIntersects(param1:*, param2:*, param3:DisplayObjectContainer) : Boolean
      {
         return param1.getBounds(param3).intersects(param2.getBounds(param3));
      }
      
      public static function startAllChildren(param1:DisplayObjectContainer) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.numChildren)
         {
            if(param1.getChildAt(_loc2_) is MovieClip)
            {
               _loc3_ = param1.getChildAt(_loc2_) as MovieClip;
               if(_loc3_.name != "levelupmc")
               {
                  _loc3_.play();
                  startAllChildren(_loc3_);
               }
            }
            _loc2_++;
         }
      }
      
      public static function center(param1:DisplayObject, param2:Stage) : *
      {
         param1.x = (param2.stageWidth - param1.width) / 2;
         param1.y = (param2.stageHeight - param1.height) / 2;
      }
      
      public static function clone(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function flipHorizontal(param1:DisplayObject, param2:int) : void
      {
         var _loc3_:Matrix = param1.transform.matrix;
         var _loc4_:* = _loc3_.a;
         _loc3_.a = param2 == 1 ? Number(Math.abs(_loc4_)) : Number(-Math.abs(_loc4_));
         param1.transform.matrix = _loc3_;
      }
      
      public static function changeMapEffect3(param1:*, param2:Stage) : void
      {
         var spd:int = 0;
         var time:int = 0;
         var bd1:BitmapData = null;
         var b:Bitmap = null;
         var si:int = 0;
         var d:* = param1;
         var s:Stage = param2;
         spd = 1;
         time = 2000;
         bd1 = new BitmapData(940,590,true,16777215);
         bd1.draw(d,new Matrix(1,0,0,1,0,0));
         b = new Bitmap(bd1,"auto",true);
         GMain.getInstance().getMainSence().addChild(b);
         si = setInterval(function():*
         {
            b.bitmapData = BitmapDataTransfer.drawMapBitmap(bd1,spd);
            if(time >= 1000)
            {
               ++spd;
            }
            else
            {
               --spd;
            }
            time -= 10;
            if(time <= 0)
            {
               clearInterval(si);
            }
         },10);
      }
      
      public static function changeMapEffect4(param1:*, param2:String, param3:Stage) : void
      {
         var bitmap11:Bitmap = null;
         var bitmap12:Bitmap = null;
         var bitmap13:Bitmap = null;
         var bitmap14:Bitmap = null;
         var bitmap15:Bitmap = null;
         var bitmap21:Bitmap = null;
         var bitmap22:Bitmap = null;
         var bitmap23:Bitmap = null;
         var bitmap24:Bitmap = null;
         var bitmap25:Bitmap = null;
         var d1:* = param1;
         var str:String = param2;
         var s:Stage = param3;
         var bd11:BitmapData = new BitmapData(940,590 / 5,true,16777215);
         var bd12:BitmapData = bd11.clone();
         var bd13:BitmapData = bd11.clone();
         var bd14:BitmapData = bd11.clone();
         var bd15:BitmapData = bd11.clone();
         var bd21:BitmapData = bd11.clone();
         var bd22:BitmapData = bd11.clone();
         var bd23:BitmapData = bd11.clone();
         var bd24:BitmapData = bd11.clone();
         var bd25:BitmapData = bd11.clone();
         bd11.draw(d1,new Matrix(1,0,0,1,0,0));
         bd12.draw(d1,new Matrix(1,0,0,1,0,-590 / 5));
         bd13.draw(d1,new Matrix(1,0,0,1,0,-590 * 2 / 5));
         bd14.draw(d1,new Matrix(1,0,0,1,0,-590 * 3 / 5));
         bd15.draw(d1,new Matrix(1,0,0,1,0,-590 * 4 / 5));
         var d2:* = AUtils.getNewObj(str);
         bd21.draw(d2,new Matrix(1,0,0,1,0,0));
         bd22.draw(d2,new Matrix(1,0,0,1,0,-590 / 5));
         bd23.draw(d2,new Matrix(1,0,0,1,0,-590 * 2 / 5));
         bd24.draw(d2,new Matrix(1,0,0,1,0,-590 * 3 / 5));
         bd25.draw(d2,new Matrix(1,0,0,1,0,-590 * 4 / 5));
         bitmap11 = new Bitmap(bd11);
         bitmap12 = new Bitmap(bd12);
         bitmap13 = new Bitmap(bd13);
         bitmap14 = new Bitmap(bd14);
         bitmap15 = new Bitmap(bd15);
         bitmap21 = new Bitmap(bd21);
         bitmap22 = new Bitmap(bd22);
         bitmap23 = new Bitmap(bd23);
         bitmap24 = new Bitmap(bd24);
         bitmap25 = new Bitmap(bd25);
         bitmap11.y = 0;
         bitmap12.y = 590 / 5;
         bitmap13.y = 590 * 2 / 5;
         bitmap14.y = 590 * 3 / 5;
         bitmap15.y = 590 * 4 / 5;
         bitmap21.x = -s.stageWidth;
         bitmap21.y = 0;
         bitmap22.x = s.stageWidth;
         bitmap22.y = 590 / 5;
         bitmap23.x = -s.stageWidth;
         bitmap23.y = 590 * 2 / 5;
         bitmap24.x = s.stageWidth;
         bitmap24.y = 590 * 3 / 5;
         bitmap25.x = -s.stageWidth;
         bitmap25.y = 590 * 4 / 5;
         GMain.getInstance().getMainSence().addChild(bitmap11);
         GMain.getInstance().getMainSence().addChild(bitmap12);
         GMain.getInstance().getMainSence().addChild(bitmap13);
         GMain.getInstance().getMainSence().addChild(bitmap14);
         GMain.getInstance().getMainSence().addChild(bitmap15);
         GMain.getInstance().getMainSence().addChild(bitmap21);
         GMain.getInstance().getMainSence().addChild(bitmap22);
         GMain.getInstance().getMainSence().addChild(bitmap23);
         GMain.getInstance().getMainSence().addChild(bitmap24);
         GMain.getInstance().getMainSence().addChild(bitmap25);
         TweenMax.to(bitmap11,1.5,{
            "x":s.stageWidth,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap11.parent.removeChild(bitmap11);
            }
         });
         TweenMax.to(bitmap12,1.5,{
            "x":-s.stageWidth,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap12.parent.removeChild(bitmap12);
            }
         });
         TweenMax.to(bitmap13,1.5,{
            "x":s.stageWidth,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap13.parent.removeChild(bitmap13);
            }
         });
         TweenMax.to(bitmap14,1.5,{
            "x":-s.stageWidth,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap14.parent.removeChild(bitmap14);
            }
         });
         TweenMax.to(bitmap15,1.5,{
            "x":s.stageWidth,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap15.parent.removeChild(bitmap15);
            }
         });
         TweenMax.to(bitmap21,1.5,{
            "x":0,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap21.parent.removeChild(bitmap21);
            }
         });
         TweenMax.to(bitmap22,1.5,{
            "x":0,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap22.parent.removeChild(bitmap22);
            }
         });
         TweenMax.to(bitmap23,1.5,{
            "x":0,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap23.parent.removeChild(bitmap23);
            }
         });
         TweenMax.to(bitmap24,1.5,{
            "x":0,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap24.parent.removeChild(bitmap24);
            }
         });
         TweenMax.to(bitmap25,1.5,{
            "x":0,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               d1.doAfterChangeOut();
               bitmap25.parent.removeChild(bitmap25);
            }
         });
      }
      
      public static function changeMapEffect5(param1:*, param2:String, param3:Stage) : void
      {
         var bitmap11:Bitmap = null;
         var bitmap12:Bitmap = null;
         var bitmap13:Bitmap = null;
         var bitmap14:Bitmap = null;
         var bitmap21:Bitmap = null;
         var bitmap22:Bitmap = null;
         var bitmap23:Bitmap = null;
         var bitmap24:Bitmap = null;
         var d1:* = param1;
         var str:String = param2;
         var s:Stage = param3;
         var bd11:BitmapData = new BitmapData(940 / 4,590,true,16777215);
         var bd12:BitmapData = bd11.clone();
         var bd13:BitmapData = bd11.clone();
         var bd14:BitmapData = bd11.clone();
         var bd21:BitmapData = bd11.clone();
         var bd22:BitmapData = bd11.clone();
         var bd23:BitmapData = bd11.clone();
         var bd24:BitmapData = bd11.clone();
         bd11.draw(d1,new Matrix(1,0,0,1,0,0));
         bd12.draw(d1,new Matrix(1,0,0,1,-940 / 4,0));
         bd13.draw(d1,new Matrix(1,0,0,1,-940 / 2,0));
         bd14.draw(d1,new Matrix(1,0,0,1,-940 * 3 / 4,0));
         var d2:* = AUtils.getNewObj(str);
         bd21.draw(d2,new Matrix(1,0,0,1,0,0));
         bd22.draw(d2,new Matrix(1,0,0,1,-940 / 4,0));
         bd23.draw(d2,new Matrix(1,0,0,1,-940 / 2,0));
         bd24.draw(d2,new Matrix(1,0,0,1,-940 * 3 / 4,0));
         bitmap11 = new Bitmap(bd11);
         bitmap12 = new Bitmap(bd12);
         bitmap13 = new Bitmap(bd13);
         bitmap14 = new Bitmap(bd14);
         bitmap21 = new Bitmap(bd21);
         bitmap22 = new Bitmap(bd22);
         bitmap23 = new Bitmap(bd23);
         bitmap24 = new Bitmap(bd24);
         bitmap11.x = 0;
         bitmap12.x = 940 / 4;
         bitmap13.x = 940 / 2;
         bitmap14.x = 940 * 3 / 4;
         bitmap21.x = 0;
         bitmap21.y = -s.stageHeight;
         bitmap22.x = 940 / 4;
         bitmap22.y = s.stageHeight;
         bitmap23.x = 940 / 2;
         bitmap23.y = -s.stageHeight;
         bitmap24.x = 940 * 3 / 4;
         bitmap24.y = s.stageHeight;
         GMain.getInstance().getMainSence().addChild(bitmap11);
         GMain.getInstance().getMainSence().addChild(bitmap12);
         GMain.getInstance().getMainSence().addChild(bitmap13);
         GMain.getInstance().getMainSence().addChild(bitmap14);
         GMain.getInstance().getMainSence().addChild(bitmap21);
         GMain.getInstance().getMainSence().addChild(bitmap22);
         GMain.getInstance().getMainSence().addChild(bitmap23);
         GMain.getInstance().getMainSence().addChild(bitmap24);
         TweenMax.to(bitmap11,1.5,{
            "y":s.stageHeight,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap11.parent.removeChild(bitmap11);
            }
         });
         TweenMax.to(bitmap12,1.5,{
            "y":-s.stageHeight,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap12.parent.removeChild(bitmap12);
            }
         });
         TweenMax.to(bitmap13,1.5,{
            "y":s.stageHeight,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap13.parent.removeChild(bitmap13);
            }
         });
         TweenMax.to(bitmap14,1.5,{
            "y":-s.stageHeight,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap14.parent.removeChild(bitmap14);
            }
         });
         TweenMax.to(bitmap21,1.5,{
            "y":0,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap21.parent.removeChild(bitmap21);
            }
         });
         TweenMax.to(bitmap22,1.5,{
            "y":0,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap22.parent.removeChild(bitmap22);
            }
         });
         TweenMax.to(bitmap23,1.5,{
            "y":0,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               bitmap23.parent.removeChild(bitmap23);
            }
         });
         TweenMax.to(bitmap24,1.5,{
            "y":0,
            "ease":Circ.easeInOut,
            "onComplete":function():*
            {
               d1.doAfterChangeOut();
               bitmap24.parent.removeChild(bitmap24);
            }
         });
      }
      
      public static function ConvolutionEffect() : ConvolutionFilter
      {
         var _loc1_:Array = new Array();
         _loc1_ = _loc1_.concat([-2,-1,0]);
         _loc1_ = _loc1_.concat([-1,1,1]);
         _loc1_ = _loc1_.concat([0,1,2]);
         var _loc2_:ConvolutionFilter = new ConvolutionFilter();
         _loc2_.matrixX = 3;
         _loc2_.matrixY = 3;
         _loc2_.matrix = _loc1_;
         _loc2_.divisor = 1;
         return _loc2_;
      }
      
      public static function GlowEffect() : GlowFilter
      {
         return new GlowFilter(16777215,1,15,15,1.5,BitmapFilterQuality.MEDIUM,false,false);
      }
      
      public static function GetNextPointByTwoObj(param1:*, param2:*) : Point
      {
         var _loc3_:Number = param2.x - param1.x;
         var _loc4_:Number = param2.y - param1.y;
         var _loc5_:Number = Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
         return new Point(_loc3_ / _loc5_,_loc4_ / _loc5_);
      }
      
      public static function GetDisBetweenTwoObj(param1:MovieClip, param2:MovieClip) : Number
      {
         var _loc3_:Number = param2.x - param1.x;
         var _loc4_:Number = param2.y - param1.y;
         return Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
      }
      
      public static function checkLoadOK(param1:*, param2:Function) : void
      {
         var si:int = 0;
         var dis:* = param1;
         var fun:Function = param2;
         si = setInterval(function():*
         {
            var _loc1_:* = dis.numChildren;
            var _loc2_:* = true;
            var _loc3_:* = 0;
            while(_loc3_ < _loc1_)
            {
               if(!dis.getChildAt(_loc3_))
               {
                  _loc2_ = false;
                  break;
               }
               _loc3_++;
            }
            if(_loc2_)
            {
               clearInterval(si);
               fun.call();
            }
         },100);
      }
   }
}
