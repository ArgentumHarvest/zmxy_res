package export.magicWeapon
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import com.greensock.TweenMax;
   import export.bullet.EnemyMoveBullet;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class MagicFootball extends BaseMagicWeapon
   {
       
      
      protected var b:EnemyMoveBullet;
      
      public function MagicFootball(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_FOOTBALL;
         this.mp = 10;
         this.offsetX = -45;
         this.shakeYMax = -35;
         this.shakeYMin = -45;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicFootballBmd");
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
         throw new Error("MagicFootballB--BitmapData Error!");
      }
      
      override public function showSkill() : void
      {
         var interval:int = 10;
         var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
         if(equip)
         {
            if(equip.getWX().indexOf("木") != -1)
            {
               b = new EnemyMoveBullet("Football2");
               if(this.sourceRole.getBBDC().getDirect() == 0)
               {
                  b.x = this.sourceRole.x - 55;
                  b.setSpeed(-12,0);
               }
               else
               {
                  b.x = this.sourceRole.x + 55;
                  b.setSpeed(12,0);
               }
               b.setDistance(9999);
               b.setFuncWhenEnterFrame(function(bb:BaseBullet):*
               {
                  var p:Point = gc.gameSence.localToGlobal(new Point(bb.x,bb.y));
                  if(p.x > 930)
                  {
                     bb.x -= bb.x - 930;
                  }
                  else if(p.x < 10)
                  {
                     bb.x -= p.x;
                  }
               });
               b.y = this.sourceRole.y + 25;
               b.setFuncWhenHit(function(bb:EnemyMoveBullet):*
               {
                  bb.setSpeed(0,0);
               });
               b.setRole(this.sourceRole);
               b.setDirect(0);
               b.setAction("football1");
               var parentIdx:int = gc.gameSence.getChildIndex(this.sourceRole);
               if(parentIdx != -1)
               {
                  gc.gameSence.addChildAt(b,parentIdx);
               }
               this.sourceRole.magicBulletArray.push(b);
            }
            else
            {
               b = new EnemyMoveBullet("Football1");
               if(this.sourceRole.getBBDC().getDirect() == 0)
               {
                  b.x = this.sourceRole.x - 55;
                  b.setSpeed(-9,0);
               }
               else
               {
                  b.x = this.sourceRole.x + 55;
                  b.setSpeed(9,0);
               }
               b.setDestroyWhenLastFrame(false);
               b.setFuncWhenEnterFrame(function(bb:BaseBullet):*
               {
                  var p:Point = gc.gameSence.localToGlobal(new Point(bb.x,bb.y));
                  trace("p:" + p);
                  if(p.x > 930)
                  {
                     bb.x -= bb.x - 930;
                  }
                  else if(p.x < 10)
                  {
                     bb.x -= p.x;
                  }
               });
               b.setDestroyInCount(gc.frameClips * 2);
               b.setDistance(9999);
               b.setFuncWhenHit(function(bb:EnemyMoveBullet):*
               {
                  bb.setSpeed(0,0);
               });
               b.y = this.sourceRole.y + 40;
               b.setRole(this.sourceRole);
               b.setDirect(0);
               b.setAction("football2");
               parentIdx = gc.gameSence.getChildIndex(this.sourceRole);
               if(parentIdx != -1)
               {
                  gc.gameSence.addChildAt(b,parentIdx);
               }
               this.sourceRole.magicBulletArray.push(b);
            }
         }
         TweenMax.delayedCall(interval,function(_self:MagicFootball):*
         {
            _self.setAction("wait");
         },[this]);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.b = null;
      }
   }
}
