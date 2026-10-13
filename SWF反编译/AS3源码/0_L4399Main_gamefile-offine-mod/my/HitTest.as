package my
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class HitTest
   {
       
      
      public function HitTest()
      {
         super();
      }
      
      public static function complexHitTestObject(target1:DisplayObject, target2:DisplayObject, accurracy:Number = 1) : Boolean
      {
         return complexIntersectionRectangle(target1,target2,accurracy).width != 0;
      }
      
      public static function intersectionRectangle(target1:DisplayObject, target2:DisplayObject) : Rectangle
      {
         if(!target1.root || !target2.root || !target1.hitTestObject(target2))
         {
            return new Rectangle();
         }
         var bounds1:Rectangle = target1.getBounds(target1.root);
         var bounds2:Rectangle = target2.getBounds(target2.root);
         var intersection:Rectangle = new Rectangle();
         intersection.x = Math.max(bounds1.x,bounds2.x);
         intersection.y = Math.max(bounds1.y,bounds2.y);
         intersection.width = Math.min(bounds1.x + bounds1.width - intersection.x,bounds2.x + bounds2.width - intersection.x);
         intersection.height = Math.min(bounds1.y + bounds1.height - intersection.y,bounds2.y + bounds2.height - intersection.y);
         return intersection;
      }
      
      public static function complexIntersectionRectangle(target1:DisplayObject, target2:DisplayObject, accurracy:Number = 1) : Rectangle
      {
         if(accurracy <= 0)
         {
            throw new Error("ArgumentError: Error #5001: Invalid value for accurracy",5001);
         }
         if(!target1.hitTestObject(target2))
         {
            return new Rectangle();
         }
         var hitRectangle:Rectangle = intersectionRectangle(target1,target2);
         if(hitRectangle.width * accurracy < 1 || hitRectangle.height * accurracy < 1)
         {
            return new Rectangle();
         }
         var bitmapData:BitmapData = new BitmapData(hitRectangle.width * accurracy,hitRectangle.height * accurracy,false,0);
         bitmapData.draw(target1,HitTest.getDrawMatrix(target1,hitRectangle,accurracy),new ColorTransform(1,1,1,1,255,-255,-255,255));
         bitmapData.draw(target2,HitTest.getDrawMatrix(target2,hitRectangle,accurracy),new ColorTransform(1,1,1,1,255,255,255,255),"difference");
         var intersection:Rectangle = bitmapData.getColorBoundsRect(4294967295,4278255615);
         bitmapData.dispose();
         if(accurracy != 1)
         {
            intersection.x /= accurracy;
            intersection.y /= accurracy;
            intersection.width /= accurracy;
            intersection.height /= accurracy;
         }
         intersection.x += hitRectangle.x;
         intersection.y += hitRectangle.y;
         return intersection;
      }
      
      protected static function getDrawMatrix(target:DisplayObject, hitRectangle:Rectangle, accurracy:Number) : Matrix
      {
         var localToGlobal:* = null;
         var matrix:* = null;
         var rootConcatenatedMatrix:Matrix = target.root.transform.concatenatedMatrix;
         localToGlobal = target.localToGlobal(new Point());
         matrix = target.transform.concatenatedMatrix;
         matrix.tx = localToGlobal.x - hitRectangle.x;
         matrix.ty = localToGlobal.y - hitRectangle.y;
         matrix.a /= rootConcatenatedMatrix.a;
         matrix.d /= rootConcatenatedMatrix.d;
         if(accurracy != 1)
         {
            matrix.scale(accurracy,accurracy);
         }
         return matrix;
      }
      
      public static function hittttttest(obj1:MovieClip, obj2:MovieClip) : Boolean
      {
         var bd1:BitmapData = new BitmapData(obj1.width,obj1.height,true,16777215);
         var bd2:BitmapData = new BitmapData(obj2.width,obj2.height,true,16777215);
         bd1.draw(obj1,new Matrix(obj1.transform.matrix.a,0,0,1,obj1.width / 2,obj1.height / 2));
         bd2.draw(obj2,new Matrix(obj2.transform.matrix.a,0,0,1,obj2.width / 2,obj2.height / 2));
         var p1:Point = new Point(obj1.x - obj1.width / 2,obj1.y - obj1.height / 2);
         var p2:Point = new Point(obj2.x - obj2.width / 2,obj2.y - obj2.height / 2);
         if(bd1.hitTest(new Point(p1.x,p1.y),100,bd2,new Point(p2.x,p2.y),100))
         {
            bd1.dispose();
            bd2.dispose();
            return true;
         }
         bd1.dispose();
         bd2.dispose();
         return false;
      }
   }
}
