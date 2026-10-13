package export.magicWeapon
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import com.greensock.TweenMax;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class MagicLianhua extends BaseMagicWeapon
   {
       
      
      public function MagicLianhua(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_LH;
         this.mp = 10;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicLhBmd");
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
         throw new Error("MagicLhBmd--BitmapData Error!");
      }
      
      override public function showSkill() : void
      {
         if(this.sourceRole)
         {
            if(this.sourceRole.getPlayer().findCurrentPet(true))
            {
               if(this.sourceRole.getPlayer().findCurrentPet(true).getHp() <= 0)
               {
                  var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
                  if(equip)
                  {
                     var per:Number = equip.getELevel() * 5;
                     if(equip.getWX().indexOf("木") != -1)
                     {
                        per += 25;
                     }
                     per /= 100;
                     this.sourceRole.getPlayer().findCurrentPet(true).reSetPetStateByPercent(per);
                     this.sourceRole.changePet();
                     gc.ts.setTxt("宠物已复活");
                     gc.stage.addChild(gc.ts);
                  }
               }
            }
            TweenMax.delayedCall(300,function(_self:MagicLianhua):*
            {
               _self.setAction("wait");
            },[this]);
         }
      }
   }
}
