package export.magicWeapon
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import base.BaseSummon;
   import com.greensock.TweenMax;
   import export.bullet.SpecialEffectBullet;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class MagicTurnRoundKing extends BaseMagicWeapon
   {
       
      
      public function MagicTurnRoundKing(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_TurnRoundKing;
         this.mp = 10;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicTurnRoundKingBMD");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],80,80,new Point(0,0));
            bbdc.setOffsetXY(1,-10);
            bbdc.setFrameStopCount([[10],[9999]]);
            bbdc.setFrameCount([1,1]);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.addChild(bbdc);
            return;
         }
         throw new Error("MagicTurnRoundKingBMD--BitmapData Error!");
      }
      
      override public function showSkill() : void
      {
         var bb:SpecialEffectBullet = new SpecialEffectBullet("MagicTurnRoundKingEffectNew");
         bb.x = this.x;
         bb.y = this.y;
         bb.setDisable();
         bb.setRole(this.sourceRole);
         bb.setAction("wait");
         this.sourceRole.magicBulletArray.push(bb);
         gc.gameSence.addChild(bb);
         var cd:uint = 70;
         var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
         if(equip)
         {
            if(equip.getWX().indexOf("木") != -1)
            {
               cd = 50;
            }
            if(this.sourceRole)
            {
               this.sourceRole.callSummonByType(BaseSummon.SUMMON_TURNROUNDKING,equip.getELevel());
            }
         }
         TweenMax.delayedCall(cd,function(_self:MagicTurnRoundKing):*
         {
            _self.setAction("wait");
         },[this]);
      }
   }
}
