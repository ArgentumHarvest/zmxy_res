package export.magicWeapon
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import com.greensock.TweenMax;
   import export.bullet.SpecialEffectBullet;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class MagicRing extends BaseMagicWeapon
   {
       
      
      public function MagicRing(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_Ring;
         this.mp = 50;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicRingBmd");
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
         throw new Error("MagicRing--BitmapData Error!");
      }
      
      override public function showSkill() : void
      {
         var bb:SpecialEffectBullet = new SpecialEffectBullet("MagicRingEffect");
         bb.x = this.x;
         bb.y = this.y;
         bb.setDisable();
         bb.setRole(this.sourceRole);
         bb.setAction("wait");
         this.sourceRole.magicBulletArray.push(bb);
         gc.gameSence.addChild(bb);
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
         TweenMax.delayedCall(22,function(_self:MagicRing):*
         {
            _self.setAction("wait");
         },[this]);
      }
   }
}
