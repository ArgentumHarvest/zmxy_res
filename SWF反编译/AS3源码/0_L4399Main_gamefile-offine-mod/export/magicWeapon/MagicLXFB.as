package export.magicWeapon
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import com.greensock.TweenMax;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class MagicLXFB extends BaseMagicWeapon
   {
       
      
      public function MagicLXFB(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_LXFB;
         this.mp = 10;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicLXFBBmd");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],61,50,new Point(0,0));
            bbdc.setOffsetXY(1,-10);
            bbdc.setFrameStopCount([[10],[9999]]);
            bbdc.setFrameCount([1,1]);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.addChild(bbdc);
            return;
         }
         throw new Error("MagicLXFBBmd--BitmapData Error!");
      }
      
      override public function showSkill() : void
      {
         if(this.sourceRole)
         {
            var timeCount:uint = gc.frameClips * 10;
            var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
            if(equip && equip.getWX().indexOf("木") != -1)
            {
               timeCount *= 2;
            }
            this.sourceRole.addCurAddEffect([{
               "name":BaseAddEffect.XLFB_BUFF,
               "time":timeCount
            }]);
            TweenMax.delayedCall(21,function(_self:MagicLXFB):*
            {
               _self.setAction("wait");
            },[this]);
         }
      }
   }
}
