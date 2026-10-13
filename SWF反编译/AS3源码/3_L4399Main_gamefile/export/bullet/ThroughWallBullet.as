package export.bullet
{
   import base.BaseHero;
   import com.greensock.TweenMax;
   import export.ThroughWall;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class ThroughWallBullet extends ThroughWall
   {
       
      
      private var isStop:Boolean = false;
      
      private var moveDirect:int = 1;
      
      private var totalCount:int;
      
      private var stopCount:int;
      
      private var swordEffect:SpecialEffectBullet;
      
      private var stopCounts:uint;
      
      public function ThroughWallBullet(speedX:int)
      {
         super();
         this.speedX = speedX;
         if(this.speedX > 0)
         {
            moveDirect = 1;
         }
         else if(this.speedX < 0)
         {
            moveDirect = 2;
         }
         else
         {
            moveDirect = 3;
         }
         this.isThroughWall = new MovieClip();
         this.isThroughWall.name = "isThroughWall";
         this.addChild(this.isThroughWall);
         this.visible = false;
         stopCounts = gc.frameClips * 6;
      }
      
      override public function step() : void
      {
         if(this.userData)
         {
            if(this.speedX > 0)
            {
               if(this.userData.transform.matrix.a < 0)
               {
                  AUtils.flipHorizontal(this.userData,1);
               }
            }
            else if(this.speedX < 0)
            {
               if(this.userData.transform.matrix.a > 0)
               {
                  AUtils.flipHorizontal(this.userData,-1);
               }
            }
         }
         if(!this.isStop)
         {
            if(this.userData)
            {
               this.userData.visible = false;
            }
            var heroArray:Array = gc.getPlayerArray();
            for(var i:int = 0; i < heroArray.length; )
            {
               var bh:BaseHero = heroArray[i] as BaseHero;
               if(bh.standInObj == this)
               {
                  this.isStop = true;
                  var temp:* = this;
                  this.moveDirect = 3;
                  bh.speed.x = 0;
                  TweenMax.to(temp,0.5,{
                     "y":temp.y + 10,
                     "onComplete":function():*
                     {
                        TweenMax.to(temp,0.5,{"y":temp.y - 4});
                     }
                  });
                  break;
               }
               i++;
            }
            if(moveDirect == 1)
            {
               this.speedX -= 0.5;
            }
            else if(moveDirect == 2)
            {
               this.speedX += 0.5;
            }
            else if(moveDirect == 3)
            {
               this.speedX = 0;
            }
         }
         else
         {
            if(this.swordEffect)
            {
               this.swordEffect.destroy();
               this.swordEffect = null;
            }
            if(this.userData)
            {
               this.userData.visible = true;
            }
            this.stopCount++;
            this.speedX = 0;
         }
         super.step();
         this.totalCount++;
         if(this.isStop)
         {
            if(this.stopCount >= this.stopCounts)
            {
               this.dispatchEvent(new Event("destroy"));
               this.destroy();
            }
         }
         else if(this.totalCount >= gc.frameClips * 8)
         {
            this.dispatchEvent(new Event("destroy"));
            this.destroy();
         }
      }
      
      public function setStopDoubleCount() : void
      {
         this.stopCounts = gc.frameClips * 12;
      }
      
      public function setSwordEffect(s:SpecialEffectBullet) : void
      {
         this.swordEffect = s;
      }
      
      public function getSwordEffect() : SpecialEffectBullet
      {
         return this.swordEffect;
      }
      
      override public function destroy() : void
      {
         if(this.swordEffect)
         {
            this.swordEffect.destroy();
            this.swordEffect = null;
         }
         super.destroy();
      }
   }
}
