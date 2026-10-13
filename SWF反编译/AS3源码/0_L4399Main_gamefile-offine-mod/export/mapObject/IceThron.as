package export.mapObject
{
   import base.BaseHero;
   import config.Config;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import my.HitTest;
   
   public class IceThron extends MovieClip
   {
       
      
      private var attackId:uint = 0;
      
      private var gc:Config;
      
      private var intervalCount:uint = 0;
      
      public var isIceThron:MovieClip;
      
      public function IceThron()
      {
         super();
         gc = Config.getInstance();
      }
      
      public function step() : void
      {
         var flag:Boolean = false;
         if(this.intervalCount == 0)
         {
            this.newAttackId();
            this.intervalCount = gc.frameClips * 2;
         }
         if(this.intervalCount >= 0)
         {
            this.intervalCount--;
         }
         if(this.y < 100)
         {
            flag = false;
            if(this.currentFrame == 1)
            {
               if(gc.hero1)
               {
                  if(Math.abs(this.x - gc.hero1.x) <= 200)
                  {
                     flag = true;
                  }
               }
               if(!flag)
               {
                  if(gc.hero2)
                  {
                     if(Math.abs(this.x - gc.hero2.x) <= 200)
                     {
                        flag = true;
                     }
                  }
               }
               if(flag)
               {
                  this.gotoAndPlay(2);
               }
            }
            if(!flag)
            {
               if(this.currentFrame == this.totalFrames)
               {
                  this.gotoAndStop(1);
               }
            }
         }
         else
         {
            this.gotoAndStop(1);
         }
         for each(var bh in gc.getPlayerArray())
         {
            if(bh.beAttackIdArray.indexOf(this.getAttackId()) == -1)
            {
               if(!bh.isYourFather())
               {
                  if(HitTest.complexHitTestObject(this,bh.colipse))
                  {
                     bh.reduceHp(30,true);
                     if(bh.getBBDC().getDirect() == 0)
                     {
                        bh.setAttackBack(new Point(10,0));
                     }
                     else
                     {
                        bh.setAttackBack(new Point(-10,0));
                     }
                     bh.beAttackIdArray.push(this.getAttackId());
                     bh.beAttackDoing();
                  }
               }
            }
         }
      }
      
      private function getAttackId() : String
      {
         return this.name + this.attackId;
      }
      
      private function newAttackId() : void
      {
         this.attackId++;
      }
   }
}
