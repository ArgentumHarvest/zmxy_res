package export.level
{
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseLevelListenering;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import my.HitTest;
   import my.MainGame;
   
   public class StageListener31 extends BaseLevelListenering
   {
       
      
      private var lightArray:Array;
      
      private var fbEnter:MovieClip;
      
      private var fbFatherCount:uint = 0;
      
      private var lightStateArray:Array;
      
      public function StageListener31()
      {
         lightArray = [];
         lightStateArray = [];
         super();
         waitForRegisterDataArray = ["Monster11","Monster12","Monster13","Monster21"];
      }
      
      override public function step() : void
      {
         super.step();
         this.lightStateArray.length = 0;
         for each(mc in this.lightArray)
         {
            if(this.fbFatherCount == 0)
            {
               for each(bh in gc.getPlayerArray())
               {
                  for each(bb in bh.magicBulletArray)
                  {
                     if(HitTest.complexHitTestObject(bb,mc))
                     {
                        var img:MovieClip = AUtils.getNewObj("HeroBeHurt");
                        img.x = mc.width / 2;
                        img.y = mc.height / 2;
                        mc.addChild(img);
                        if(mc.currentFrame == 1)
                        {
                           mc.gotoAndStop(2);
                        }
                        else
                        {
                           mc.gotoAndStop(1);
                        }
                        this.fbFatherCount = gc.frameClips * 1;
                     }
                  }
               }
            }
            this.lightStateArray.push(mc.currentFrame);
         }
         if(this.fbFatherCount > 0)
         {
            this.fbFatherCount--;
         }
         if(this.fbEnter.currentFrame == 1)
         {
            if(this.lightStateArray.join(",") == "1,2,1,2,1,2")
            {
               this.fbEnter.gotoAndPlay(2);
               var m:uint = 0;
               for each(bo in gc.getPlayerAndPetArray())
               {
                  TweenMax.to(bo,2,{
                     "y":800,
                     "x":2890,
                     "onComplete":function(_m:uint):*
                     {
                        if(_m == 0)
                        {
                           MainGame.getInstance().fbEnter();
                        }
                     },
                     "onCompleteParams":[m]
                  });
                  m++;
               }
            }
         }
      }
      
      public function fbEnter_hero() : void
      {
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
               if(MovieClip(obj).name == "light0")
               {
                  lightArray.push(obj);
               }
               else if(MovieClip(obj).name == "light1")
               {
                  lightArray.push(obj);
               }
               else if(MovieClip(obj).name == "light2")
               {
                  lightArray.push(obj);
               }
               else if(MovieClip(obj).name == "light3")
               {
                  lightArray.push(obj);
               }
               else if(MovieClip(obj).name == "light4")
               {
                  lightArray.push(obj);
               }
               else if(MovieClip(obj).name == "light5")
               {
                  lightArray.push(obj);
               }
               else if(MovieClip(obj).name == "fbEnter")
               {
                  this.fbEnter = obj as MovieClip;
               }
            }
            i++;
         }
         trace("this.fbEnter:" + this.fbEnter);
      }
      
      override public function init() : void
      {
         super.init();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.lightArray.length = 0;
      }
   }
}
