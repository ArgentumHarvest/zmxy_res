package export.magicWeapon
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import flash.geom.Point;
   
   public class MagicBalloon extends BaseMagicWeapon
   {
       
      
      private var fbfillName:String;
      
      public function MagicBalloon(bo:BaseHero, fillName:String)
      {
         this.fbfillName = fillName;
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_BALLOON;
         this.mp = 0;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName(this.fbfillName + "Bmd");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],60,107,new Point(0,0));
            bbdc.setOffsetXY(1,-10);
            bbdc.setFrameStopCount([[10],[9999]]);
            bbdc.setFrameCount([1,1]);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.addChild(bbdc);
            return;
         }
         throw new Error("MagicBalloon--BitmapData Error!");
      }
      
      override public function useSkill() : void
      {
      }
   }
}
