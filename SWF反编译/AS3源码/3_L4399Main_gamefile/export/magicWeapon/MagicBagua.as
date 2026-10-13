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
   import export.monster.Monster48;
   import export.monster.Monster50;
   import export.monster.Monster51;
   import export.monster.Monster52;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class MagicBagua extends BaseMagicWeapon
   {
       
      
      public function MagicBagua(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_BG;
         this.mp = 10;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicBaguaBmd");
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
         throw new Error("MagicBagua--BitmapData Error!");
      }
      
      override public function useSkill() : void
      {
         var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
         if(equip)
         {
            if(equip.getELevel() >= 6)
            {
               super.useSkill();
            }
         }
      }
      
      override public function showSkill() : void
      {
         var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
         if(equip)
         {
            if(equip.getELevel() >= 6)
            {
               var b:SpecialEffectBullet = new SpecialEffectBullet("baguaEffect");
               b.x = this.sourceRole.x;
               b.y = this.sourceRole.y + 40;
               b.setRole(this.sourceRole);
               b.setDirect(0);
               b.setDisable();
               b.setAction("hit1");
               var parentIdx:int = gc.gameSence.getChildIndex(this.sourceRole);
               if(parentIdx != -1)
               {
                  gc.gameSence.addChildAt(b,parentIdx);
               }
               this.sourceRole.magicBulletArray.push(b);
               var time:int = gc.frameClips * (equip.getELevel() / 2);
               if(equip.getWX().indexOf("木") != -1)
               {
                  time *= 2;
               }
               var mons:Array = gc.pWorld.monsterArray;
               for each(mon in mons)
               {
                  if(!(mon is Monster52) && !(mon is Monster50) && !(mon is Monster51) && !(mon is Monster48) && !mon.isYourFather() && !mon.isDead())
                  {
                     mon.addCurAddEffect([{
                        "name":BaseAddEffect.STUN,
                        "time":time
                     }]);
                  }
               }
               TweenMax.delayedCall(20,function(_self:MagicBagua):*
               {
                  _self.setAction("wait");
               },[this]);
            }
         }
      }
   }
}
