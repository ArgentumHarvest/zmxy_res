package base
{
   import com.greensock.TweenMax;
   import config.Config;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class BaseAura extends MovieClip
   {
       
      
      public var isReadyToDestroy:Boolean = false;
      
      protected var startCount:int = 20;
      
      protected var count:int = 0;
      
      protected var sourceMonster:BaseMonster;
      
      protected var sourceHero:BaseHero;
      
      protected var speed:int;
      
      protected var power:int;
      
      protected var correntState:int = 1;
      
      protected var gc:Config;
      
      public function BaseAura(sm:BaseMonster, sh:BaseHero)
      {
         super();
         gc = Config.getInstance();
         this.sourceMonster = sm;
         this.sourceHero = sh;
         this.speed = 4 + RandomControllor.getIns().getRandom() * 2;
      }
      
      public function step() : void
      {
         var p:* = null;
         if(this.correntState == 3)
         {
            return;
         }
         if(this.correntState == 1)
         {
            if(this.startCount > 0)
            {
               this.startCount--;
            }
            else
            {
               this.startUp();
            }
         }
         else if(this.correntState == 2)
         {
            p = AUtils.GetNextPointByTwoObj(this,this.sourceHero);
            this.x += p.x * this.speed;
            this.y += p.y * this.speed;
            this.speed += 2;
            if(this.speed > 20)
            {
               this.speed = 20;
            }
            if(AUtils.GetDisBetweenTwoObj(this,this.sourceHero) <= 10)
            {
               this.destroy();
            }
         }
         count++;
         if(count > gc.frameClips * 15)
         {
            this.destroy();
         }
      }
      
      public function setPower(p:int) : void
      {
         this.power = p;
      }
      
      public function getPower() : int
      {
         return this.power;
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this.isReadyToDestroy = true;
         this.sourceMonster = null;
         this.sourceHero = null;
      }
      
      protected function startUp() : void
      {
         var upValue:Number = 50 - RandomControllor.getIns().getRandom() * 20;
         TweenMax.to(this,1,{
            "y":this.y - upValue,
            "onCompleteParams":[this],
            "onComplete":function(ba:BaseAura):*
            {
               ba.startMove();
            }
         });
         this.correntState = 3;
      }
      
      protected function startMove() : void
      {
         this.correntState = 2;
      }
   }
}
