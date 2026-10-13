package export.magicWeapon
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import com.greensock.TweenMax;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class MagicYyb extends BaseMagicWeapon
   {
       
      
      public function MagicYyb(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_YYB;
         this.mp = 10;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicYYBBmd");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],60,70,new Point(0,0));
            bbdc.setOffsetXY(1,-10);
            bbdc.setFrameStopCount([[10],[9999]]);
            bbdc.setFrameCount([1,1]);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.addChild(bbdc);
            return;
         }
         throw new Error("MagicYYBBmd--BitmapData Error!");
      }
      
      override public function showSkill() : void
      {
         if(this.sourceRole)
         {
            if(this.sourceRole.getPet())
            {
               var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
               if(equip.getWX().indexOf("木") != -1)
               {
                  this.sourceRole.getPet().turnToGxp(20);
               }
               else
               {
                  this.sourceRole.getPet().turnToGxp(10);
               }
            }
            TweenMax.delayedCall(22,function(_self:MagicYyb):*
            {
               _self.setAction("wait");
            },[this]);
         }
      }
   }
}
