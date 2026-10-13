package export.magicWeapon
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.bullet.SpecialEffectBullet;
   import export.monster.Monster49;
   import export.monster.Monster50;
   import export.monster.Monster51;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class MagicFlute extends BaseMagicWeapon
   {
       
      
      public function MagicFlute(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_HXZ_FLUTE;
         this.mp = 10;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicFluteBmd");
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
         throw new Error("MagicFluteBmd--BitmapData Error!");
      }
      
      override public function showSkill() : void
      {
         if(this.sourceRole)
         {
            var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
            var timeCount:uint = gc.frameClips * 1;
            if(equip)
            {
               timeCount = gc.frameClips * equip.getELevel();
               if(equip.getWX().indexOf("木") != -1)
               {
                  timeCount *= 2;
               }
            }
            for each(bm in gc.pWorld.monsterArray)
            {
               if(!bm.isYourFather() && !bm.isDead() && !(bm is Monster50 || bm is Monster51 || bm is Monster49))
               {
                  bm.addCurAddEffect([{
                     "name":BaseAddEffect.FLUTE_SLEEP,
                     "time":timeCount
                  }]);
               }
            }
            var b:SpecialEffectBullet = new SpecialEffectBullet("MagicFluteEffect");
            b.x = this.x;
            b.y = this.y;
            b.setRole(this.sourceRole);
            b.setDirect(0);
            b.setDisable();
            b.setAction("null");
            gc.gameSence.addChild(b);
            this.sourceRole.magicBulletArray.push(b);
            TweenMax.delayedCall(40,function(_self:MagicFlute):*
            {
               _self.setAction("wait");
            },[this]);
         }
      }
   }
}
