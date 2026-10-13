package export.level.StageListener411Children
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Xiannv extends Sprite
   {
       
      
      private var bbdc:BaseBitmapDataClip;
      
      public function Xiannv()
      {
         super();
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("sl41xiannv");
         var body:Object = {
            "name":"body",
            "source":bmdArray
         };
         bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
         bbdc.setOffsetXY(15,0);
         bbdc.setFrameStopCount([[3,3,3,4,3,4]]);
         bbdc.setFrameCount([6]);
         bbdc.getCurPoint().y = 0;
         this.addChild(bbdc);
         var w:MovieClip = AUtils.getNewObj("rankDoorW") as MovieClip;
         w.x = -15;
         w.y = -70;
         this.addChild(w);
      }
      
      public function step() : void
      {
         if(this.bbdc)
         {
            this.bbdc.step();
         }
      }
   }
}
