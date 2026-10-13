package export.level.StageListener171Children
{
   import base.BaseHero;
   import com.greensock.TweenMax;
   import config.Config;
   import flash.display.Sprite;
   import flash.events.Event;
   import mvc.controllor.RandomControllor;
   
   public class Monster104Hand extends Sprite
   {
      
      public static var LEFT_HAND:uint = 0;
      
      public static var RIGHT_HAND:uint = 1;
       
      
      private var _type:uint = 0;
      
      private var minX:Number = 50;
      
      private var maxX:Number = 340;
      
      private var minY:Number = 0;
      
      private var maxY:Number = 0;
      
      private var target:BaseHero;
      
      private var moveDirect:uint = 0;
      
      private var attackInterval:uint = 96;
      
      private var attackIntervalCount:uint = 0;
      
      private var randomWalkCheckDirectCount:uint = 0;
      
      private var randomWalkCheckDirectInterval:uint = 36;
      
      private var isAttacking:Boolean = false;
      
      private var gc:Config;
      
      public function Monster104Hand(type:uint)
      {
         super();
         gc = Config.getInstance();
         this._type = type;
         var bm:Sprite = AUtils.getNewObj("Monster104Zhuazi") as Sprite;
         if(this._type == RIGHT_HAND)
         {
            this.minX = 540;
            this.maxX = 890;
            AUtils.flipHorizontal(bm,-1);
         }
         this.addChild(bm);
         this.addEventListener("addedToStage",__added,false,0,true);
         this.addEventListener("removedFromStage",__removed,false,0,true);
      }
      
      private function __added(evt:Event) : void
      {
         this.minY = this.y;
         this.maxY = this.minY + 100;
      }
      
      private function __removed(evt:Event) : void
      {
      }
      
      public function step() : void
      {
         var rand:Number = NaN;
         if(!this.target)
         {
            for each(var bh in gc.getPlayerArray())
            {
               if(bh.x > this.minX && bh.x < this.maxX)
               {
                  this.target = bh;
                  break;
               }
            }
         }
         else if(this.target.x < this.minX || this.target.x > this.maxX)
         {
            this.target = null;
            this.stopMove();
         }
         if(!this.isAttacking)
         {
            if(this.target)
            {
               if(this.x > this.target.x)
               {
                  this.moveLeft();
               }
               else if(this.x < this.target.x)
               {
                  this.moveRight();
               }
               if(this.attackIntervalCount < this.attackInterval)
               {
                  this.attackIntervalCount++;
                  if(this.attackIntervalCount == this.attackInterval)
                  {
                     this.attack();
                     this.attackIntervalCount = 0;
                  }
               }
            }
            else if(this.randomWalkCheckDirectCount < this.randomWalkCheckDirectInterval)
            {
               this.randomWalkCheckDirectCount++;
               if(this.randomWalkCheckDirectCount == this.randomWalkCheckDirectInterval)
               {
                  rand = RandomControllor.getIns().getRandom();
                  if(rand < 0.3)
                  {
                     this.moveLeft();
                  }
                  else if(rand < 0.6)
                  {
                     this.moveDirect = 1;
                  }
                  else
                  {
                     this.moveRight();
                  }
                  this.randomWalkCheckDirectCount = 0;
               }
            }
            this.moveByDirect();
         }
         else
         {
            this.stopMove();
         }
      }
      
      private function moveByDirect() : void
      {
         if(this.moveDirect == 0)
         {
            if(this.x > this.minX)
            {
               this.x -= 2;
            }
         }
         else if(this.moveDirect == 1)
         {
            if(this.x < this.maxX)
            {
               this.x += 2;
            }
         }
      }
      
      private function stopMove() : void
      {
         this.moveDirect = 2;
      }
      
      private function moveRight() : void
      {
         this.moveDirect = 1;
      }
      
      private function moveLeft() : void
      {
         this.moveDirect = 0;
      }
      
      private function attack() : void
      {
         this.dispatchEvent(new Event("attack"));
         TweenMax.to(this,1.5,{
            "y":this.maxY,
            "onComplete":function(_self:Monster104Hand):*
            {
               _self = _self;
               TweenMax.to(this,0.5,{"onUpdate":function():*
               {
                  gc.vControllor.shake(15);
               }});
               _self.attackOver();
            },
            "onCompleteParams":[this]
         });
         this.isAttacking = true;
      }
      
      private function attackOver() : void
      {
         TweenMax.to(this,1.5,{
            "y":this.minY,
            "onComplete":function(_self:Monster104Hand):*
            {
               _self.isAttacking = false;
            },
            "onCompleteParams":[this]
         });
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
