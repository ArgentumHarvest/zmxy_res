package export.level
{
   import base.BaseLevelListenering;
   import com.greensock.TweenMax;
   import my.MainGame;
   
   public class StageListener43 extends BaseLevelListenering
   {
       
      
      public function StageListener43()
      {
         super();
         waitForRegisterDataArray = ["Monster33"];
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override public function start() : void
      {
         super.start();
         TweenMax.delayedCall(3,function():*
         {
            MainGame.getInstance().createMonster(33,800,300);
         });
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
