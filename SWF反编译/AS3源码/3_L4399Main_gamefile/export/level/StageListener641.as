package export.level
{
   import base.BaseLevelListenering;
   import my.MainGame;
   
   public class StageListener641 extends BaseLevelListenering
   {
       
      
      public function StageListener641()
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
         MainGame.getInstance().createMonster(gc.monsterIdforStage641,500,300);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
