package export.level
{
   import base.BaseLevelListenering;
   import my.MainGame;
   
   public class StageListener561 extends BaseLevelListenering
   {
       
      
      public function StageListener561()
      {
         super();
         this.waitForRegisterDataArray = ["Monster182","Monster184","Monster185"];
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override public function start() : void
      {
         super.start();
         MainGame.getInstance().createMonster(gc.guoqingMonsterId,500,200);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
