package export.level.StageListener223Children
{
   import export.bullet.EnemyMoveBullet;
   
   public class Monster139TantantanBullet extends EnemyMoveBullet
   {
       
      
      public var hitTimes:int = 3;
      
      private var cccc:int = 5;
      
      public function Monster139TantantanBullet(imgMcName:String)
      {
         super(imgMcName);
      }
      
      override public function step2() : void
      {
         super.step2();
         if(this.hitTimes == 0)
         {
            this.destroy();
         }
         if(cccc > 0)
         {
            cccc--;
            if(cccc == 0)
            {
               AUtils.shallowEffect(this);
               cccc = 5;
            }
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
