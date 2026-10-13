package base
{
   import com.greensock.TweenMax;
   import config.Config;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class BaseAura extends MovieClip
   {
       
      
      private var startCount:int = 20;
      
      private var count:int = 0;
      
      protected var sourceMonster:BaseMonster;
      
      protected var sourceHero:BaseHero;
      
      protected var speed:int;
      
      protected var power:int;
      
      private var correntState:int = 1;
      
      protected var gc:Config;
      
      public function BaseAura(param1:BaseMonster, param2:BaseHero)
      {
         super();
         this.gc = Config.getInstance();
         this.sourceMonster = param1;
         this.sourceHero = param2;
         this.speed = 4 + Math.random() * 2;
         this.addEventListener(Event.ADDED_TO_STAGE,this.__added);
      }
      
      private function __added(param1:Event) : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.__added);
         this.addEventListener(Event.ENTER_FRAME,this.__enterFrame);
      }
      
      private function __enterFrame(param1:Event) : void
      {
         var _loc2_:Point = null;
         if(this.correntState == 1)
         {
            if(this.startCount > 0)
            {
               --this.startCount;
            }
            else
            {
               this.startUp();
            }
         }
         else if(this.correntState == 2)
         {
            _loc2_ = AUtils.GetNextPointByTwoObj(this,this.sourceHero);
            this.x += _loc2_.x * this.speed;
            this.y += _loc2_.y * this.speed;
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
         ++this.count;
         if(this.count > 2400)
         {
            this.destroy();
         }
      }
      
      public function setPower(param1:int) : void
      {
         this.power = param1;
      }
      
      public function getPower() : int
      {
         return this.power;
      }
      
      protected function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(this.hasEventListener(Event.ENTER_FRAME))
         {
            this.removeEventListener(Event.ENTER_FRAME,this.__enterFrame);
         }
         delete global[this];
      }
      
      private function startUp() : void
      {
         var upValue:Number = 50 - Math.random() * 20;
         TweenMax.to(this,1,{
            "y":this.y - upValue,
            "onComplete":function():*
            {
               startMove();
            }
         });
         this.removeEventListener(Event.ENTER_FRAME,this.__enterFrame);
      }
      
      private function startMove() : void
      {
         this.correntState = 2;
         this.addEventListener(Event.ENTER_FRAME,this.__enterFrame);
      }
   }
}
