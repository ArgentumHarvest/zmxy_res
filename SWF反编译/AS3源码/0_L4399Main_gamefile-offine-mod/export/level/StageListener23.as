package export.level
{
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseLevelListenering;
   import export.mapObject.WoodThron;
   import flash.display.MovieClip;
   import my.HitTest;
   import my.MainGame;
   
   public class StageListener23 extends BaseLevelListenering
   {
       
      
      private var woodThronArray:Array;
      
      private var fbEnter:MovieClip;
      
      private var fbCount:uint = 5;
      
      private var fbFatherCount:uint = 0;
      
      public function StageListener23()
      {
         woodThronArray = [];
         super();
         waitForRegisterDataArray = ["Monster15","Monster9","Monster10","Monster19"];
      }
      
      override public function start() : void
      {
         var i:* = 0;
         var obj:* = null;
         super.start();
         var len:uint = gc.gameSence.numChildren;
         for(i = uint(0); i < len; )
         {
            obj = gc.gameSence.getChildAt(i);
            if(obj is MovieClip)
            {
               if(MovieClip(obj).getChildByName("isWoodThron"))
               {
                  woodThronArray.push(obj);
               }
            }
            if(obj.name == "fbEnter")
            {
               this.fbEnter = obj as MovieClip;
            }
            i++;
         }
      }
      
      override public function step() : void
      {
         var colipse:* = null;
         var img:* = null;
         super.step();
         for each(var it in this.woodThronArray)
         {
            it.step();
         }
         if(this.fbEnter.currentFrame == 1)
         {
            if(this.fbFatherCount == 0)
            {
               if(this.fbCount > 0 && this.fbEnter)
               {
                  colipse = this.fbEnter.getChildByName("colipse") as MovieClip;
                  if(colipse)
                  {
                     for each(var bh in gc.getPlayerArray())
                     {
                        for each(var bb in bh.magicBulletArray)
                        {
                           if(HitTest.complexHitTestObject(bb,colipse))
                           {
                              this.fbCount--;
                              img = AUtils.getNewObj("HeroBeHurt");
                              img.x = colipse.x;
                              img.y = colipse.y;
                              this.fbEnter.addChild(img);
                              this.fbFatherCount = gc.frameClips * 1;
                           }
                        }
                     }
                  }
               }
            }
            if(this.fbCount <= 0)
            {
               this.fbEnter.gotoAndPlay(2);
            }
         }
         else if(this.fbEnter.currentFrame == this.fbEnter.totalFrames)
         {
            colipse = this.fbEnter.getChildByName("colipse") as MovieClip;
            if(colipse)
            {
               for each(bh in gc.getPlayerArray())
               {
                  if(bh.colipse.hitTestObject(colipse))
                  {
                     MainGame.getInstance().fbEnter();
                  }
               }
            }
         }
         if(this.fbFatherCount > 0)
         {
            this.fbFatherCount--;
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.woodThronArray = null;
      }
   }
}
