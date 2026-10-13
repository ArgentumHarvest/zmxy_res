package export.mapObject
{
   import base.BaseHero;
   import config.Config;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.HitTest;
   
   public class FireThron extends MovieClip
   {
       
      
      public var isFireThron:MovieClip;
      
      private var attackId:uint = 0;
      
      private var gc:Config;
      
      private var intervalCount:uint = 0;
      
      public function FireThron()
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
         if(this.currentFrame == 1)
         {
            flag = false;
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
         if(this.currentFrame >= 2 && this.currentFrame <= 19)
         {
            for each(var bh in gc.getPlayerArray())
            {
               if(bh.beAttackIdArray.indexOf(this.getAttackId()) == -1)
               {
                  if(!bh.isYourFather())
                  {
                     if(HitTest.complexHitTestObject(this,bh.colipse))
                     {
                        bh.reduceHp(45 + (RandomControllor.getIns().getRandom() - 0.5) * 10,true);
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
