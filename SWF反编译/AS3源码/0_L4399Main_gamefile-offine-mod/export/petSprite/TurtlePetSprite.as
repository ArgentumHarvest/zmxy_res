package export.petSprite
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BasePet;
   import base.BasePetSprite;
   import flash.geom.Point;
   
   public class TurtlePetSprite extends BasePetSprite
   {
       
      
      public function TurtlePetSprite(sourceRole:BasePet)
      {
         this.type = 3;
         super(sourceRole);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("PetSprite_" + this.type);
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],39,37,new Point(0,0));
            bbdc.setOffsetXY(1,-10);
            bbdc.setFrameStopCount([[10]]);
            bbdc.setFrameCount([1]);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.addChild(bbdc);
            return;
         }
         throw new Error("MagicLeaf--BitmapData Error!");
      }
   }
}
