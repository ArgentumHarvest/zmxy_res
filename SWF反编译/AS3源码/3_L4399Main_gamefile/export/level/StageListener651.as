package export.level
{
   import base.BaseLevelListenering;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import my.MainGame;
   
   public class StageListener651 extends BaseLevelListenering
   {
       
      
      private var si:int;
      
      public function StageListener651()
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
         MainGame.getInstance().createMonster(226,500,300);
         si = setInterval(function():*
         {
            MainGame.getInstance().createMonster(66,200 + Math.random() * 600,200 + Math.random() * 150);
         },8000);
      }
      
      override public function destroy() : void
      {
         clearInterval(si);
         super.destroy();
      }
   }
}
