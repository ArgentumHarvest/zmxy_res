package export.magicWeapon
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import event.CommonEvent;
   import export.bullet.SpecialEffectBullet;
   import export.bullet.ThroughWallBullet;
   import flash.events.Event;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class MagicLDBSword extends BaseMagicWeapon
   {
       
      
      private var swordEffectArray:Array;
      
      private var swordId:uint = 1;
      
      public function MagicLDBSword(bo:BaseHero)
      {
         swordEffectArray = [];
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_LDBSword;
         this.mp = 100;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicLDBSwordBmd");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],51,75,new Point(0,0));
            bbdc.setOffsetXY(0,0);
            bbdc.setFrameStopCount([[10],[9999],[9999],[9999]]);
            bbdc.setFrameCount([1,1,1,1]);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.addChild(bbdc);
            return;
         }
         throw new Error("MagicSword--BitmapData Error!");
      }
      
      override public function setAction(str:String) : void
      {
         this.curAction = str;
         var curPoint:Point = this.bbdc.getCurPoint();
         switch(str)
         {
            case "wait":
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
         }
      }
      
      override protected function scriptFrameOverFunc(row:int) : void
      {
         var state:String = this.bbdc.getState();
         switch(state)
         {
            case "wait":
               this.bbdc.setFramePointX(0);
               break;
            case "hit1":
               this.setAction("wait");
               break;
            case "hit2":
               this.setAction("wait");
               break;
            case "hit3":
               this.setAction("wait");
         }
      }
      
      override public function useSkill() : void
      {
         if(this.sourceRole)
         {
            if(this.sourceRole.roleProperies.getMMP() >= mp)
            {
               this.showSkill();
               this.sourceRole.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.sourceRole.roleProperies.getMMP() - mp]));
            }
         }
      }
      
      override public function showSkill() : void
      {
         var tb:* = null;
         if(this.swordEffectArray.length == 2)
         {
            tb = this.swordEffectArray.shift();
            this.destroyTb(tb);
         }
         else if(this.swordEffectArray.length == 0)
         {
            swordId = 1;
         }
         this.createSword();
         this.setMWDisplay();
         if(swordId == 1)
         {
            swordId = 2;
         }
         else
         {
            swordId = 1;
         }
      }
      
      private function createSword() : void
      {
         var speed:int = this.sourceRole.getBBDC().getDirect() == 0 ? -18 : 18;
         var tBullet:ThroughWallBullet = new ThroughWallBullet(speed);
         var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
         if(equip)
         {
            if(equip.getWX().indexOf("木") != -1)
            {
               tBullet.setStopDoubleCount();
            }
         }
         tBullet.addEventListener("destroy",__bulletDestroy,false,0,true);
         tBullet.setUserDataName("MagicLDBSword" + swordId);
         tBullet.name = swordId + "";
         tBullet.x = this.sourceRole.x;
         tBullet.y = this.sourceRole.y;
         tBullet.width = 80;
         gc.pWorld.getWallArray().push(tBullet);
         gc.gameSence.addChild(tBullet);
         var bb:SpecialEffectBullet = new SpecialEffectBullet("SwordEffect");
         bb.setRole(this.sourceRole);
         bb.setDestroyWhenLastFrame(false);
         bb.setDestroyWhenMaxHitCountLessThenZero(false);
         bb.setAction("fabao-sword");
         bb.setFollowObj(tBullet);
         this.sourceRole.magicBulletArray.push(bb);
         gc.gameSence.addChild(bb);
         this.swordEffectArray.push(tBullet);
      }
      
      override public function isUsing() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3";
      }
      
      private function __bulletDestroy(evt:Event) : void
      {
         var i:* = 0;
         var tb:* = null;
         var len:uint = this.swordEffectArray.length;
         for(i = uint(0); i < len; )
         {
            tb = this.swordEffectArray[i] as ThroughWallBullet;
            if(tb == evt.currentTarget)
            {
               this.destroyTb(tb);
               this.swordEffectArray.splice(i,1);
               break;
            }
            i++;
         }
         this.setMWDisplay();
      }
      
      private function setMWDisplay() : void
      {
         var tb:* = null;
         if(this.swordEffectArray.length == 0)
         {
            this.setAction("wait");
         }
         else if(this.swordEffectArray.length == 2)
         {
            this.setAction("hit3");
         }
         else if(this.swordEffectArray.length == 1)
         {
            tb = this.swordEffectArray[0] as ThroughWallBullet;
            if(tb.name == "1")
            {
               this.setAction("hit1");
            }
            else
            {
               this.setAction("hit2");
            }
         }
      }
      
      private function destroyTb(tb:ThroughWallBullet) : void
      {
         tb.removeEventListener("destroy",__bulletDestroy);
         tb.destroy();
      }
      
      override public function destroy() : void
      {
         var i:* = 0;
         var tb:* = null;
         var len:uint = this.swordEffectArray.length;
         for(i = uint(0); i < len; )
         {
            tb = this.swordEffectArray[i] as ThroughWallBullet;
            this.destroyTb(tb);
            i++;
         }
         this.swordEffectArray.length = 0;
         this.swordEffectArray = null;
         super.destroy();
      }
   }
}
