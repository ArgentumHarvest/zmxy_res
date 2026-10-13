package export.level
{
   import base.BaseLevelListenering;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class StageListener491 extends BaseLevelListenering
   {
       
      
      private var m161AppearInterval:uint = 72;
      
      private var m161AppearCount:uint = 3;
      
      public function StageListener491()
      {
         super();
         this.waitForRegisterDataArray = ["Monster160"];
      }
      
      override public function step() : void
      {
         super.step();
         if(this.m161AppearCount > 0)
         {
            if(m161AppearInterval > 0)
            {
               m161AppearInterval--;
               if(m161AppearInterval == 0)
               {
                  this.callM161();
                  m161AppearInterval = 72;
               }
            }
         }
      }
      
      private function callM161() : void
      {
         MainGame.getInstance().createMonster(161,100 + RandomControllor.getIns().getRandom() * 500,300);
         this.m161AppearCount--;
      }
      
      override public function start() : void
      {
         super.start();
         MainGame.getInstance().createMonster(160,600,300);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
