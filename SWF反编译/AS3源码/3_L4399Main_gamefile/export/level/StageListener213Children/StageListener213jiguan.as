package export.level.StageListener213Children
{
   import base.BaseBullet;
   import base.BaseHero;
   import config.Config;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import my.HitTest;
   
   public class StageListener213jiguan extends Sprite
   {
       
      
      public var state:uint = 0;
      
      private var gc:Config;
      
      public function StageListener213jiguan()
      {
         super();
         gc = Config.getInstance();
         this.init();
      }
      
      private function init() : void
      {
         this.graphics.beginFill(16711680,0);
         this.graphics.drawRect(0,0,134,270);
         this.graphics.endFill();
      }
      
      private function show() : void
      {
         var bm:Bitmap = AUtils.getImageObj("sl213Light") as Bitmap;
         this.addChild(bm);
      }
      
      public function step() : void
      {
         var playerArray:* = null;
         var img:* = null;
         if(state == 0)
         {
            playerArray = gc.getPlayerArray();
            for each(var bh in playerArray)
            {
               for each(var bb in bh.magicBulletArray)
               {
                  if(!bb.isDisabled)
                  {
                     if(HitTest.complexHitTestObject(this,bb))
                     {
                        this.state = 1;
                        this.show();
                        img = AUtils.getNewObj("HeroBeHurt");
                        img.x = 67;
                        img.y = 135;
                        this.addChild(img);
                     }
                  }
               }
            }
         }
      }
   }
}
