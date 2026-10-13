package export.mapObject
{
   import base.BaseHero;
   import com.greensock.TweenMax;
   import config.Config;
   import export.level.StageListener101;
   import flash.display.MovieClip;
   import my.HitTest;
   
   public class TransferWind extends MovieClip
   {
       
      
      private var targetLevel:uint;
      
      private var direct:uint = 0;
      
      private var fiexedHeroArray:Array;
      
      private var continuedCount:uint = 192;
      
      private var gc:Config;
      
      public function TransferWind(curLevel:uint, direct:uint)
      {
         fiexedHeroArray = [];
         super();
         gc = Config.getInstance();
         if(curLevel == 1)
         {
            if(direct == 0)
            {
               this.targetLevel = 3;
            }
            else
            {
               this.targetLevel = 4;
            }
         }
         else if(curLevel == 2)
         {
            if(direct == 0)
            {
               this.targetLevel = 4;
            }
            else
            {
               this.targetLevel = 5;
            }
         }
         else if(curLevel == 3)
         {
            if(direct == 0)
            {
               this.targetLevel = 1;
            }
            else
            {
               this.targetLevel = 5;
            }
         }
         else if(curLevel == 4)
         {
            if(direct == 0)
            {
               this.targetLevel = 1;
            }
            else
            {
               this.targetLevel = 2;
            }
         }
         else if(curLevel == 5)
         {
            if(direct == 0)
            {
               this.targetLevel = 2;
            }
            else
            {
               this.targetLevel = 3;
            }
         }
         else
         {
            this.targetLevel = 1;
         }
         this.direct = direct;
      }
      
      public function step() : void
      {
         if(this.direct == 0)
         {
            this.x -= 10;
         }
         else
         {
            this.x += 10;
         }
         for each(var bh in gc.getPlayerArray())
         {
            if(this.fiexedHeroArray.indexOf(bh) == -1)
            {
               if(HitTest.complexHitTestObject(bh,this))
               {
                  gc.vControllor.setStopStep();
                  TweenMax.killAll(true,true,true);
                  bh.setLostKeyboard();
                  bh.setLostGraity();
                  bh.setAction("hurt");
                  bh.getBBDC().show();
                  bh.getBBDC().stopFrame();
                  bh.x = this.x;
                  bh.y = this.y;
                  this.fiexedHeroArray.push(bh);
               }
            }
            else
            {
               bh.x = this.x;
               bh.y = this.y;
            }
         }
         if(this.continuedCount > 0)
         {
            this.continuedCount--;
            if(this.continuedCount == 0)
            {
               if(this.fiexedHeroArray.length > 0)
               {
                  if(gc.pWorld.getBaseLevelListener() is StageListener101)
                  {
                     (gc.pWorld.getBaseLevelListener() as StageListener101).gotoLevel(this.targetLevel);
                  }
               }
               else
               {
                  this.destroy();
               }
            }
         }
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
