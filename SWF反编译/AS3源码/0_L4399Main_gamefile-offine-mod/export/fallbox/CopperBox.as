package export.fallbox
{
   import base.BaseHero;
   import com.greensock.TweenMax;
   import config.Config;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class CopperBox extends MovieClip
   {
       
      
      private var speed:uint = 6;
      
      private var count:uint = 0;
      
      private var isOpen:Boolean = false;
      
      private var gc:Config;
      
      public function CopperBox()
      {
         super();
         gc = Config.getInstance();
         this.x = 470;
         this.y = 0;
         this.gotoAndStop(1);
      }
      
      public function step() : void
      {
         var playerArray:* = null;
         if(this.y + speed < 480)
         {
            this.y += speed;
            count++;
            if(count % 12 == 0)
            {
               count = 0;
               speed += 5;
            }
         }
         else
         {
            this.y = 480;
            if(!this.isOpen)
            {
               playerArray = gc.getPlayerArray();
               for each(var bh in playerArray)
               {
                  if(AUtils.GetDisBetweenTwoObj(this,bh) <= 75)
                  {
                     this.gotoAndStop(2);
                     TweenMax.delayedCall(2,getAward);
                     this.isOpen = true;
                     break;
                  }
               }
            }
         }
      }
      
      public function getAward() : void
      {
         this.dispatchEvent(new Event("showAward"));
      }
   }
}
