package base
{
   import com.greensock.TweenMax;
   import config.Config;
   import event.CommonEvent;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class BaseMagicWeapon extends Sprite
   {
      
      public static var BMW_Bottle:uint = 1;
      
      public static var BMW_Leaf:uint = 2;
      
      public static var BMW_Ring:uint = 3;
      
      public static var BMW_Sword:uint = 4;
      
      public static var BMW_Umbrella:uint = 5;
      
      public static var BMW_YuJinPing:uint = 6;
      
      public static var BMW_BigBottle:uint = 7;
      
      public static var BMW_Turtle:uint = 8;
      
      public static var BMW_CowKing:uint = 9;
      
      public static var BMW_TurnRoundKing:uint = 10;
      
      public static var BMW_RedBottle:uint = 11;
      
      public static var BMW_LDBSword:uint = 12;
      
      public static var BMW_YW_BOTTLE:uint = 13;
      
      public static var BMW_HXZ_FLUTE:uint = 14;
      
      public static var BMW_HZL_FAN:uint = 15;
      
      public static var BMW_BALLOON:uint = 16;
      
      public static var BMW_SHENXING:uint = 17;
      
      public static var BMW_DKHL:uint = 18;
      
      public static var BMW_YYB:uint = 19;
      
      public static var BMW_LH:uint = 20;
      
      public static var BMW_BG:uint = 21;
      
      public static var BMW_LXFB:uint = 22;
      
      public static var BMW_FOOTBALL:uint = 23;
      
      public static var BMW_SXFB:uint = 24;
      
      public static var BMW_YXFB:uint = 25;
       
      
      protected var sourceRole:BaseHero;
      
      protected var bbdc:BaseBitmapDataClip;
      
      public var fillName:String = "";
      
      public var bmwId:uint;
      
      private var positionFixCount:int = 12;
      
      protected var count:uint = 0;
      
      protected var mp:uint = 10;
      
      public var curAction:String;
      
      private var shakeDirect:uint = 0;
      
      protected var offsetX:Number = 55;
      
      protected var shakeYMax:Number = 25;
      
      protected var shakeYMin:Number = 15;
      
      protected var gc:Config;
      
      public function BaseMagicWeapon(bo:BaseHero)
      {
         super();
         gc = Config.getInstance();
         this.sourceRole = bo;
         this.initBBDC();
         this.setAction("wait");
         this.count = gc.frameClips / 2;
      }
      
      protected function initBBDC() : void
      {
      }
      
      public function setAction(str:String) : void
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
            case "hit":
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
         }
      }
      
      protected function scriptFrameOverFunc(row:int) : void
      {
         var state:String = this.bbdc.getState();
         switch(state)
         {
            case "wait":
               this.bbdc.setFramePointX(0);
               break;
            case "hit":
               this.setAction("wait");
         }
      }
      
      public function useSkill() : void
      {
         if(this.curAction == "hit")
         {
            return;
         }
         if(this.sourceRole)
         {
            if(this.sourceRole.roleProperies.getMMP() >= mp)
            {
               this.setAction("hit");
               this.showSkill();
               this.sourceRole.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.sourceRole.roleProperies.getMMP() - mp]));
            }
         }
      }
      
      public function showSkill() : void
      {
      }
      
      public function setOtherUseSkill(action:String) : void
      {
         var _loc2_:* = action;
         if("hit" === _loc2_)
         {
            this.showSkill();
         }
      }
      
      public function step() : void
      {
         if(this.bbdc)
         {
            this.bbdc.step();
         }
         if(this.count > 0)
         {
            this.count--;
            if(this.count == 0)
            {
               this.setPosition();
               this.count = gc.frameClips / 2;
            }
         }
      }
      
      protected function setPosition() : void
      {
         var targetPoint:Point = new Point();
         if(this.sourceRole.getBBDC().getDirect() == 0)
         {
            targetPoint.x = this.sourceRole.x + offsetX;
            this.bbdc.turnLeft();
         }
         else
         {
            targetPoint.x = this.sourceRole.x - offsetX;
            this.bbdc.turnRight();
         }
         if(this.shakeDirect == 0)
         {
            targetPoint.y = this.sourceRole.y - shakeYMin;
            this.shakeDirect = 1;
         }
         else
         {
            targetPoint.y = this.sourceRole.y - shakeYMax;
            this.shakeDirect = 0;
         }
         TweenMax.to(this,0.5,{
            "x":targetPoint.x,
            "y":targetPoint.y
         });
      }
      
      public function getSourceHero() : BaseHero
      {
         return sourceRole;
      }
      
      public function isUsing() : Boolean
      {
         return this.curAction == "hit";
      }
      
      public function getBBDC() : BaseBitmapDataClip
      {
         return this.bbdc;
      }
      
      public function destroy() : void
      {
         if(this.sourceRole)
         {
            this.sourceRole.releaseMagicWeapon();
         }
         this.sourceRole = null;
         if(this.bbdc)
         {
            this.bbdc.destroy();
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
