package export.magicWeapon
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import com.greensock.TweenMax;
   import export.level.StageListener151Child.Stage151Boat;
   import flash.events.Event;
   import flash.geom.Point;
   import my.MyEquipObj;
   
   public class MagicBigBottle extends BaseMagicWeapon
   {
       
      
      private var bingWall:Stage151Boat;
      
      public function MagicBigBottle(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_BigBottle;
         this.mp = 30;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicBigSwordBmd");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],100,150,new Point(0,0));
            bbdc.setOffsetXY(0,0);
            bbdc.setFrameStopCount([[10],[9999]]);
            bbdc.setFrameCount([1,1]);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.addChild(bbdc);
            return;
         }
         throw new Error("MagicBigSword--BitmapData Error!");
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override public function showSkill() : void
      {
         if(this.bingWall)
         {
            this.bingWall.destroy();
            this.bingWall = null;
         }
         bingWall = new Stage151Boat(this.sourceRole,gc.frameClips * 20);
         bingWall.addEventListener("destroy",__destroy);
         bingWall.x = this.sourceRole.x;
         bingWall.y = this.sourceRole.y - 100;
         gc.pWorld.getWallArray().push(bingWall);
         gc.gameSence.addChild(bingWall);
         var timeCount:Number = 60;
         if(this.sourceRole && this.sourceRole.getPlayer())
         {
            var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
            if(equip && equip.getWX().indexOf("木") != -1)
            {
               timeCount = 40;
            }
         }
         TweenMax.delayedCall(timeCount,function(_self:MagicBigBottle):*
         {
            _self.setAction("wait");
         },[this]);
      }
      
      private function __destroy(evt:Event) : void
      {
         this.bingWall = null;
      }
   }
}
