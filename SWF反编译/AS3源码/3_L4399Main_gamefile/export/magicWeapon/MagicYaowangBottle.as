package export.magicWeapon
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import com.greensock.TweenMax;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class MagicYaowangBottle extends BaseMagicWeapon
   {
       
      
      public function MagicYaowangBottle(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_YW_BOTTLE;
         this.mp = 100;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicYWBottleBmd");
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
         throw new Error("MagicYaowangBottle--BitmapData Error!");
      }
      
      override public function showSkill() : void
      {
         if(this.sourceRole)
         {
            var timeCount:uint = 20;
            var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
            var cureHp:uint = 0;
            if(equip)
            {
               cureHp = equip.getELevel() * 100 + (this.sourceRole.roleProperies.getSHHP() - this.sourceRole.roleProperies.getHHP()) * 0.15;
            }
            if(equip && equip.getWX().indexOf("木") != -1)
            {
               timeCount = 10;
            }
            this.sourceRole.cureHp(cureHp);
            TweenMax.delayedCall(timeCount + 1,function(_self:MagicYaowangBottle):*
            {
               _self.setAction("wait");
            },[this]);
         }
      }
   }
}
