package export.level.StageListener131Children
{
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.level.StageListener131;
   import flash.display.MovieClip;
   import my.HitTest;
   
   public class StageListener131Jweal extends BaseObject
   {
      
      public static var RED:uint = 0;
      
      public static var ORINGE:uint = 1;
      
      public static var YELLOW:uint = 2;
      
      public static var GREEN:uint = 3;
      
      public static var CYAN:uint = 4;
      
      public static var BLUE:uint = 5;
      
      public static var VIOLET:uint = 6;
       
      
      private var _kind:uint = 0;
      
      public var isDestroy:Boolean = false;
      
      public function StageListener131Jweal(kind:uint)
      {
         super();
         this._kind = kind;
         var img:* = AUtils.getImageObj("fall_flower_" + this._kind);
         img.x = -img.width / 2;
         img.y = -img.height / 2 + 13;
         this.colipse = new MovieClip();
         this.colipse.addChild(img);
         addChild(this.colipse);
      }
      
      override public function step() : void
      {
         this.checkCanMove();
      }
      
      public function checkGet(xiannv:Stage131FollowHero) : void
      {
         if(HitTest.complexHitTestObject(xiannv.colipse,this))
         {
            xiannv.setFlowerTarget(this);
         }
      }
      
      public function beGet() : void
      {
         if(gc.pWorld.getBaseLevelListener() is StageListener131)
         {
            StageListener131(gc.pWorld.getBaseLevelListener()).getFlowerByType(this._kind);
         }
         this.destroy();
      }
      
      public function destroy() : void
      {
         this.isDestroy = true;
         TweenMax.to(this,0.8,{
            "y":this.y - 100,
            "alpha":0,
            "onComplete":this.remove
         });
      }
      
      private function remove() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function get kind() : uint
      {
         return _kind;
      }
      
      public function set kind(value:uint) : void
      {
         _kind = value;
      }
   }
}
