package export.magicWeapon
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class MagicDikuihualan extends BaseMagicWeapon
   {
       
      
      private var mcEffect:MovieClip;
      
      public function MagicDikuihualan(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_DKHL;
         this.mp = 10;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicDKHLBmd");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],50,50,new Point(0,0));
            bbdc.setOffsetXY(1,-10);
            bbdc.setFrameStopCount([[10],[9999]]);
            bbdc.setFrameCount([1,1]);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.addChild(bbdc);
            return;
         }
         throw new Error("MagicDikuihualan--BitmapData Error!");
      }
      
      override public function showSkill() : void
      {
         if(this.sourceRole)
         {
            var continueTimeCount:uint = gc.frameClips * 10;
            var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
            if(equip)
            {
               if(equip.getWX().indexOf("木") != -1)
               {
                  continueTimeCount *= 2;
               }
               mcEffect = AUtils.getNewObj("MagicDKHLBuff");
               mcEffect.x = this.sourceRole.x;
               mcEffect.y = this.sourceRole.y - 10;
               gc.gameSence.addChild(mcEffect);
               for each(bo in gc.getPlayerAndPetArray())
               {
                  bo.addCurAddEffect([{
                     "name":BaseAddEffect.MAGIC_DKHL,
                     "time":continueTimeCount,
                     "cureHp":equip.getELevel() * 2,
                     "cureMp":equip.getELevel()
                  }]);
               }
            }
            TweenMax.delayedCall(continueTimeCount / gc.frameClips,function(_self:MagicDikuihualan):*
            {
               gc.gameSence.removeChild(_self.mcEffect);
               _self.mcEffect = null;
            },[this]);
            TweenMax.delayedCall(21,function(_self:MagicDikuihualan):*
            {
               _self.setAction("wait");
            },[this]);
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.mcEffect = null;
      }
   }
}
