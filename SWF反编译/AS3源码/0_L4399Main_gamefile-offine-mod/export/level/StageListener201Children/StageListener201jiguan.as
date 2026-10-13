package export.level.StageListener201Children
{
   import base.BaseBullet;
   import base.BaseHero;
   import config.Config;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import my.HitTest;
   
   public class StageListener201jiguan extends Sprite
   {
       
      
      public var state:uint = 0;
      
      private var gc:Config;
      
      public function StageListener201jiguan()
      {
         super();
         gc = Config.getInstance();
         this.init();
      }
      
      private function init() : void
      {
         this.graphics.beginFill(16711680,0);
         this.graphics.drawRect(0,0,55,55);
         this.graphics.endFill();
      }
      
      private function show() : void
      {
         var bm:Bitmap = AUtils.getImageObj("stage201jiguan") as Bitmap;
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
                        img.x = 30;
                        img.y = 30;
                        this.addChild(img);
                     }
                  }
               }
            }
         }
      }
   }
}
