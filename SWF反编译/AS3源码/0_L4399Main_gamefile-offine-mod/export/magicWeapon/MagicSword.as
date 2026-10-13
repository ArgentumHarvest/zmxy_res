package export.magicWeapon
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import export.bullet.SpecialEffectBullet;
   import export.bullet.ThroughWallBullet;
   import flash.events.Event;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class MagicSword extends BaseMagicWeapon
   {
       
      
      private var swordEffect:BaseBullet;
      
      public function MagicSword(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_Sword;
         this.mp = 30;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicSwordBmd");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],120,120,new Point(0,0));
            bbdc.setOffsetXY(0,0);
            bbdc.setFrameStopCount([[10],[9999]]);
            bbdc.setFrameCount([1,1]);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.addChild(bbdc);
            return;
         }
         throw new Error("MagicSword--BitmapData Error!");
      }
      
      override public function showSkill() : void
      {
         var bb:* = null;
         trace("---showSkill---sword");
         var speed:int = this.sourceRole.getBBDC().getDirect() == 0 ? -18 : 18;
         var tBullet:ThroughWallBullet = new ThroughWallBullet(speed);
         var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
         if(equip.getWX().indexOf("木") != -1)
         {
            tBullet.setStopDoubleCount();
         }
         tBullet.addEventListener("destroy",__bulletDestroy,false,0,true);
         tBullet.setUserDataName("MagicUmbrellaHit1");
         tBullet.x = this.sourceRole.x;
         tBullet.y = this.sourceRole.y;
         gc.pWorld.getWallArray().push(tBullet);
         gc.gameSence.addChild(tBullet);
         if(!this.swordEffect)
         {
            bb = new SpecialEffectBullet("SwordEffect");
            bb.setRole(this.sourceRole);
            bb.setDestroyWhenLastFrame(false);
            bb.setDestroyWhenMaxHitCountLessThenZero(false);
            bb.setAction("fabao-sword");
            bb.setFollowObj(tBullet);
            this.sourceRole.magicBulletArray.push(bb);
            gc.gameSence.addChild(bb);
            this.swordEffect = bb;
         }
      }
      
      private function __bulletDestroy(evt:Event) : void
      {
         trace("---__bulletDestroy---");
         this.setAction("wait");
         if(this.swordEffect)
         {
            this.swordEffect.destroy();
            this.swordEffect = null;
         }
      }
   }
}
