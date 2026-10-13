package base
{
   import com.greensock.TweenMax;
   import config.Config;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class BasePetSprite extends Sprite
   {
      
      public static const PHOENIX_PET_SPRITE:uint = 0;
      
      public static const TIGRESS_PET_SPRITE:uint = 1;
      
      public static const NIAN_PET_SPRITE:uint = 2;
      
      public static const TURTLE_PET_SPRITE:uint = 3;
      
      public static const DRAGON_PET_SPRITE:uint = 4;
      
      public static const MOUSE_PET_SPRITE:uint = 5;
      
      public static const NEAT_PET_SPRITE:uint = 6;
      
      public static const FIRE_HORSE_PET_SPRITE:uint = 7;
      
      public static const YIN_TIGER_PET_SPRITE:uint = 8;
       
      
      protected var sourceRole:BasePet;
      
      protected var bbdc:BaseBitmapDataClip;
      
      public var type:uint;
      
      public var curAction:String;
      
      private var shakeDirect:uint = 0;
      
      protected var count:uint = 0;
      
      protected var gc:Config;
      
      public function BasePetSprite(sourceRole:BasePet)
      {
         super();
         gc = Config.getInstance();
         this.sourceRole = sourceRole;
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
         var _loc3_:* = str;
         if("wait" === _loc3_)
         {
            if(curPoint.y != 0)
            {
               this.bbdc.setFramePointX(0);
               this.bbdc.setFramePointY(0);
            }
            this.bbdc.setState(str);
         }
      }
      
      protected function scriptFrameOverFunc(row:int) : void
      {
         var state:String = this.bbdc.getState();
         var _loc3_:* = state;
         if("wait" === _loc3_)
         {
            this.bbdc.setFramePointX(0);
         }
      }
      
      public function getBBDC() : BaseBitmapDataClip
      {
         return this.bbdc;
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
            targetPoint.x = this.sourceRole.x + 45;
            this.bbdc.turnLeft();
         }
         else
         {
            targetPoint.x = this.sourceRole.x - 45;
            this.bbdc.turnRight();
         }
         if(this.shakeDirect == 0)
         {
            targetPoint.y = this.sourceRole.y - this.sourceRole.height / 5;
            this.shakeDirect = 1;
         }
         else
         {
            targetPoint.y = this.sourceRole.y - (this.sourceRole.height / 5 + 10);
            this.shakeDirect = 0;
         }
         TweenMax.to(this,1,{
            "x":targetPoint.x,
            "y":targetPoint.y
         });
      }
      
      public function destroy() : void
      {
         this.sourceRole = null;
         this.bbdc = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
