package export.petSprite
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BasePet;
   import base.BasePetSprite;
   import flash.geom.Point;
   
   public class YinTigerPetSprite extends BasePetSprite
   {
       
      
      public function YinTigerPetSprite(sourceRole:BasePet)
      {
         this.type = 8;
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
            bbdc = new BaseBitmapDataClip([body],54,54,new Point(0,0));
            bbdc.setOffsetXY(1,-10);
            bbdc.setFrameStopCount([[10]]);
            bbdc.setFrameCount([1]);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.addChild(bbdc);
            return;
         }
         throw new Error("PetSprite_" + this.type + "--BitmapData Error!");
      }
   }
}
