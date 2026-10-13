package export.level.StageListener113Child
{
   import base.BaseAddEffect;
   import base.BaseHero;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import my.HitTest;
   
   public class StageListener113Flowers extends BaseObject
   {
       
      
      protected var _kind:uint = 1;
      
      protected var _direct:uint = 1;
      
      public var isDestroy:Boolean = false;
      
      public function StageListener113Flowers(kind:uint)
      {
         super();
         this._kind = kind;
         var img:* = AUtils.getImageObj("StageListener113Flower_" + this._kind);
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
         if(this.x <= 0)
         {
            this.isDestroy = true;
            this.remove();
         }
      }
      
      private function checkGet() : void
      {
         for each(var bh in gc.getPlayerArray())
         {
            if(bh.colipse)
            {
               if(HitTest.complexHitTestObject(bh.colipse,this))
               {
                  if(this._kind == 1 || this._kind == 3)
                  {
                     bh.addCurAddEffect([{
                        "name":BaseAddEffect.PETHORSE_ICE,
                        "time":gc.frameClips * 4
                     }]);
                  }
                  else
                  {
                     bh.addCurAddEffect([{
                        "name":BaseAddEffect.ATTACKUP,
                        "time":gc.frameClips * 5,
                        "addValue":300
                     }]);
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
      
      public function get direct() : uint
      {
         return _direct;
      }
      
      public function set direct(value:uint) : void
      {
         _direct = value;
         if(_direct == 2)
         {
            this.graity = 0;
            this.isFly;
         }
      }
   }
}
