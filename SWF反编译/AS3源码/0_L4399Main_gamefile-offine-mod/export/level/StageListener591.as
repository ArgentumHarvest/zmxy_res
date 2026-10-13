package export.level
{
   import base.BaseLevelListenering;
   import my.MainGame;
   
   public class StageListener591 extends BaseLevelListenering
   {
       
      
      public function StageListener591()
      {
         super();
         this.waitForRegisterDataArray = [];
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override public function start() : void
      {
         super.start();
         MainGame.getInstance().createMonster(204,500,200);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
