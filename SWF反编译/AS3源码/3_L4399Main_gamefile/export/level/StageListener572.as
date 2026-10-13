package export.level
{
   import base.BaseLevelListenering;
   import my.MainGame;
   
   public class StageListener572 extends BaseLevelListenering
   {
       
      
      public function StageListener572()
      {
         super();
         this.waitForRegisterDataArray = ["Monster190"];
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override public function start() : void
      {
         super.start();
         if(gc.isHideDebug)
         {
            MainGame.getInstance().doSaveGame();
         }
         MainGame.getInstance().createMonster(190,500,200);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
