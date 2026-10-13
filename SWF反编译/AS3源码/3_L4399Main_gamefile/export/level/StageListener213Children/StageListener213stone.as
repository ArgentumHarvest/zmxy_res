package export.level.StageListener213Children
{
   import base.BaseBullet;
   import base.BaseHero;
   import com.greensock.TweenMax;
   import config.Config;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import my.HitTest;
   import my.MainGame;
   
   public class StageListener213stone extends Sprite
   {
       
      
      public var state:uint = 0;
      
      private var life:uint = 5;
      
      private var fatherCount:uint = 0;
      
      private var gc:Config;
      
      public function StageListener213stone()
      {
         super();
         gc = Config.getInstance();
         this.init();
      }
      
      private function init() : void
      {
         this.graphics.beginFill(16711680,0);
         this.graphics.drawRect(0,0,60,120);
         this.graphics.endFill();
      }
      
      private function show() : void
      {
         TweenMax.delayedCall(1.5,function():*
         {
            if(MainGame.getInstance())
            {
               MainGame.getInstance().fbEnter();
            }
         });
      }
      
      public function step() : void
      {
         var playerArray:* = null;
         var img:* = null;
         if(this.fatherCount > 0)
         {
            this.fatherCount--;
         }
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
                        if(this.life > 0)
                        {
                           if(this.fatherCount == 0)
                           {
                              this.fatherCount = 12;
                              this.life--;
                              img = AUtils.getNewObj("HeroBeHurt");
                              img.x = 47;
                              img.y = 85;
                              this.addChild(img);
                              if(this.life == 0)
                              {
                                 this.state = 1;
                                 this.show();
                                 break;
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
