package export.pet
{
   import export.bullet.EnemyMoveBullet;
   
   public class PetMouse4Bullet3 extends EnemyMoveBullet
   {
       
      
      private var isBack:Boolean = false;
      
      public function PetMouse4Bullet3(imgMcName:String)
      {
         super(imgMcName);
      }
      
      override public function step2() : void
      {
         super.step2();
         if(!isBack)
         {
            if(this.speed.x == 0)
            {
               this.setMoveTarget(this.sourceRole);
               this.setAddSpeed(0,0);
               this.addSpeedValue = 1;
               isBack = true;
            }
         }
         else if(AUtils.GetDisBetweenTwoObj(this,this.sourceRole) <= 30)
         {
            this.destroy();
         }
      }
   }
}
