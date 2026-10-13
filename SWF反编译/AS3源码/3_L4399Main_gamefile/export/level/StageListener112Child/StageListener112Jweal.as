package export.level.StageListener112Child
{
   import base.BaseHero;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.level.StageListener112;
   import flash.display.MovieClip;
   import my.HitTest;
   
   public class StageListener112Jweal extends BaseObject
   {
       
      
      private var _kind:uint = 1;
      
      public var isDestroy:Boolean = false;
      
      public function StageListener112Jweal(kind:uint)
      {
         super();
         this._kind = kind;
         var img:* = AUtils.getImageObj("StageListener112Jweal" + this._kind);
         img.x = -img.width / 2;
         img.y = -img.height / 2;
         this.colipse = new MovieClip();
         this.colipse.addChild(img);
         addChild(this.colipse);
      }
      
      override public function step() : void
      {
         this.checkCanMove();
         this.checkGet();
      }
      
      private function checkGet() : void
      {
         var count:int = 0;
         var rate:int = 0;
         for each(var bh in gc.getPlayerArray())
         {
            if(bh.colipse)
            {
               if(HitTest.complexHitTestObject(bh.colipse,this))
               {
                  if(gc.pWorld.getBaseLevelListener() is StageListener112)
                  {
                     count = 1;
                     if(this._kind == 1)
                     {
                        count = 1;
                     }
                     else
                     {
                        count = 3;
                     }
                     rate = 2;
                     count *= rate;
                     StageListener112(gc.pWorld.getBaseLevelListener()).totalJwealNum = StageListener112(gc.pWorld.getBaseLevelListener()).totalJwealNum + count;
                  }
                  this.destroy();
                  break;
               }
            }
         }
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
