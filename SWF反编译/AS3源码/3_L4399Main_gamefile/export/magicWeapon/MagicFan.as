package export.magicWeapon
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import com.greensock.TweenMax;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class MagicFan extends BaseMagicWeapon
   {
       
      
      private var bullet:EnemyMoveBullet;
      
      public function MagicFan(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_HZL_FAN;
         this.mp = 10;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicFanBmd");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],60,60,new Point(0,0));
            bbdc.setOffsetXY(1,-10);
            bbdc.setFrameStopCount([[10],[9999]]);
            bbdc.setFrameCount([1,1]);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.addChild(bbdc);
            return;
         }
         throw new Error("MagicFan--BitmapData Error!");
      }
      
      override public function showSkill() : void
      {
         if(this.sourceRole)
         {
            var timeCount:uint = gc.frameClips * 20;
            this.showEffect();
            TweenMax.delayedCall(timeCount / gc.frameClips + 1,function(_self:MagicFan):*
            {
               _self.setAction("wait");
            },[this]);
         }
      }
      
      private function showEffect() : void
      {
         var equip:* = null;
         if(!this.bullet)
         {
            this.bullet = new EnemyMoveBullet("MagicFanEffect");
            this.bullet.x = this.x;
            this.bullet.y = this.y + 20;
            this.bullet.setDistance(9999);
            this.bullet.setRole(this.sourceRole);
            this.bullet.setDirect(0);
            this.bullet.setAction("hzlFan");
            gc.gameSence.addChild(this.bullet);
            this.sourceRole.magicBulletArray.push(this.bullet);
            this.bullet.setFuncWhenHit(newWind);
            this.bullet.setDestroyWhenLastFrame(false);
            equip = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
            if(equip)
            {
               this.bullet.setDestroyInCount(gc.frameClips * (equip.getELevel() + 2));
            }
            else
            {
               this.bullet.setDestroyInCount(gc.frameClips * 1);
            }
            this.bullet.setFuncWhenDestroy(windDestroy);
            this.bullet.setFuncWhenEnterFrame(windEnter);
         }
      }
      
      private function windEnter(bb:BaseBullet) : void
      {
         if(this.bullet)
         {
            if(AUtils.GetDisBetweenTwoObj(this.bullet,this.sourceRole) >= 100)
            {
               if(this.bullet.x > this.sourceRole.x)
               {
                  this.bullet.setSpeed(-10,0);
               }
               else
               {
                  this.bullet.setSpeed(10,0);
               }
            }
            else
            {
               this.bullet.setSpeed(0,0);
            }
         }
      }
      
      private function windDestroy(bb:BaseBullet) : void
      {
         this.bullet = null;
      }
      
      private function newWind(bb:BaseBullet) : void
      {
         var b:* = null;
         if(this.bullet)
         {
            b = new SpecialEffectBullet("MagicFanEffect");
            b.x = this.bullet.x;
            b.y = this.bullet.y;
            b.setRole(this.sourceRole);
            b.setDirect(0);
            b.setDestroyWhenLastFrame(false);
            b.setDestroyInCount(gc.frameClips * 3);
            b.setAction("hzlFan");
            gc.gameSence.addChild(b);
            this.sourceRole.magicBulletArray.push(b);
         }
      }
      
      override public function destroy() : void
      {
         if(this.bullet)
         {
            this.bullet = null;
         }
         super.destroy();
      }
   }
}
