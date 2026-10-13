package export.magicWeapon
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import com.greensock.TweenMax;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class MagicShenxing extends BaseMagicWeapon
   {
       
      
      public function MagicShenxing(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_SHENXING;
         this.mp = 10;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicShenxingBmd");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],50,80,new Point(0,0));
            bbdc.setOffsetXY(1,-10);
            bbdc.setFrameStopCount([[10],[9999]]);
            bbdc.setFrameCount([1,1]);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.addChild(bbdc);
            return;
         }
         throw new Error("MagicShenxingBmd--BitmapData Error!");
      }
      
      override public function showSkill() : void
      {
         if(this.sourceRole)
         {
            var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
            var timeCount:uint = 1;
            if(equip)
            {
               timeCount = equip.getELevel();
               if(equip.getWX().indexOf("木") != -1)
               {
                  timeCount += 5;
               }
            }
            this.sourceRole.fabaoJiasu();
            TweenMax.delayedCall(timeCount,function(_self:MagicShenxing):*
            {
               _self.sourceRole.resetFabaoJiasu();
            },[this]);
            TweenMax.delayedCall(21,function(_self:MagicShenxing):*
            {
               _self.setAction("wait");
            },[this]);
         }
      }
   }
}
