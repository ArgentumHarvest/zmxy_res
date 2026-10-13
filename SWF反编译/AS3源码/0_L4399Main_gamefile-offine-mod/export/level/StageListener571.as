package export.level
{
   import base.BaseLevelListenering;
   import my.MainGame;
   
   public class StageListener571 extends BaseLevelListenering
   {
       
      
      public function StageListener571()
      {
         super();
         this.waitForRegisterDataArray = ["Monster155"];
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override public function start() : void
      {
         super.start();
         MainGame.getInstance().createMonster(155,500,200);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
