package export.level
{
   import base.BaseLevelListenering;
   import com.greensock.TweenMax;
   import my.MainGame;
   
   public class StageListener171 extends BaseLevelListenering
   {
       
      
      public function StageListener171()
      {
         super();
         waitForRegisterDataArray = ["Monster102","Monster103","Monster104","Monster105"];
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
            MainGame.getInstance().createMonster(102,600,370);
         });
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
