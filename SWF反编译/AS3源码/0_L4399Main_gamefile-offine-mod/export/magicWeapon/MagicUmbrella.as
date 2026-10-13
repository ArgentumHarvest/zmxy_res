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
   
   public class MagicUmbrella extends BaseMagicWeapon
   {
       
      
      public function MagicUmbrella(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_Umbrella;
         this.mp = 40;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicUmbrellaBmd");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],100,100,new Point(0,0));
            bbdc.setOffsetXY(1,-10);
            bbdc.setFrameStopCount([[10],[9999]]);
            bbdc.setFrameCount([1,1]);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.addChild(bbdc);
            return;
         }
         throw new Error("MagicUmbrella--BitmapData Error!");
      }
      
      override public function showSkill() : void
      {
         if(this.sourceRole.getPlayer())
         {
            var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
            var defendValue:uint = 0;
            if(equip)
            {
               defendValue = this.sourceRole.roleProperies.getDefense() * equip.getELevel();
               if(equip.getWX().indexOf("木") != -1)
               {
                  defendValue *= 2;
               }
               this.sourceRole.addCurAddEffect([{
                  "name":BaseAddEffect.MAGIC_UMBRELLA_DEFEND,
                  "time":gc.frameClips * 10,
                  "defendValue":defendValue
               }]);
            }
         }
         TweenMax.delayedCall(20,function(_self:MagicUmbrella):*
         {
            _self.setAction("wait");
         },[this]);
      }
   }
}
