package export.level
{
   import base.BaseLevelListenering;
   import my.MainGame;
   
   public class StageListener581 extends BaseLevelListenering
   {
       
      
      public function StageListener581()
      {
         super();
         this.waitForRegisterDataArray = ["Monster191"];
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override public function start() : void
      {
         super.start();
         MainGame.getInstance().createMonster(191,500,200);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
