package export.monster.Monster186Children
{
   import base.BaseHero;
   import export.bullet.EnemyMoveBullet;
   
   public class Monster186Bullet3 extends EnemyMoveBullet
   {
       
      
      public var taraget:BaseHero;
      
      private var isStartMove:Boolean = false;
      
      private var index:int = 0;
      
      public function Monster186Bullet3(imgMcName:String)
      {
         super(imgMcName);
      }
      
      override public function step2() : void
      {
         super.step2();
         if(this.destroyInCount == gc.frameClips * 4)
         {
            this.isStartMove = true;
         }
         if(taraget)
         {
            if(taraget.isDead())
            {
               taraget = gc.getRandomPlayer();
            }
            if(this.isStartMove)
            {
               if(this.destroyInCount % 12 == 0)
               {
                  if(this.taraget.x > this.x)
                  {
                     this.setSpeed(5 + index,0);
                  }
                  else
                  {
                     this.setSpeed(-(5 + index),0);
                  }
               }
            }
         }
         else
         {
            this.destroy();
         }
      }
      
      override public function setDestroyInCount(d:int) : void
      {
         super.setDestroyInCount(d);
         this.index = d / gc.frameClips / 3;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.taraget = null;
      }
   }
}
