package export.level
{
   import base.BaseLevelListenering;
   import com.greensock.TweenMax;
   import my.MainGame;
   
   public class StageListener45 extends BaseLevelListenering
   {
       
      
      public function StageListener45()
      {
         super();
         waitForRegisterDataArray = ["Monster192"];
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
            MainGame.getInstance().createMonster(192,800,300);
         });
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
