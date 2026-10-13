package export.level
{
   import base.BaseLevelListenering;
   import com.greensock.TweenMax;
   import my.MainGame;
   
   public class StageListener173 extends BaseLevelListenering
   {
       
      
      public function StageListener173()
      {
         super();
         waitForRegisterDataArray = ["Monster115"];
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override public function start() : void
      {
         super.start();
         MainGame.getInstance().doSaveGame();
         TweenMax.delayedCall(2,function():*
         {
            MainGame.getInstance().createMonster(115,600,200);
         });
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
