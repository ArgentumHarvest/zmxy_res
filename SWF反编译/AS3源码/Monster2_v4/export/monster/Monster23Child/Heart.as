package export.monster.Monster23Child
{
   import com.greensock.*;
   import flash.display.MovieClip;
   
   public class Heart extends MovieClip
   {
       
      
      private var heartShowTime:int;
      
      private var heartHideTime:int;
      
      public function Heart()
      {
         super();
         this.alpha = 0;
         this.heartShowTime = 0;
         this.heartHideTime = 24 * int(5 + Math.random() * 5);
      }
      
      public function step() : void
      {
         if(this.heartHideTime > 0)
         {
            --this.heartHideTime;
            if(this.heartHideTime == 0)
            {
               TweenMax.to(this,2,{
                  "alpha":1,
                  "onComplete":function():*
                  {
                     heartShowTime = 24 * int(2 + Math.random() * 4);
                  }
               });
            }
         }
         if(this.heartShowTime > 0)
         {
            --this.heartShowTime;
            if(this.heartShowTime == 0)
            {
               TweenMax.to(this,2,{
                  "alpha":0,
                  "onComplete":function():*
                  {
                     heartHideTime = 24 * int(5 + Math.random() * 7);
                  }
               });
            }
         }
      }
   }
}
