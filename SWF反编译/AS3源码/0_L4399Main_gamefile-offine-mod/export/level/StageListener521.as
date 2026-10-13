package export.level
{
   import base.BaseLevelListenering;
   import com.greensock.TweenMax;
   import my.MainGame;
   
   public class StageListener521 extends BaseLevelListenering
   {
       
      
      private var tw:TweenMax;
      
      public function StageListener521()
      {
         super();
         this.waitForRegisterDataArray = ["Monster170"];
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override public function start() : void
      {
         super.start();
         tw = TweenMax.delayedCall(1,function():*
         {
            MainGame.getInstance().createMonster(170,500,200);
         });
      }
      
      override public function destroy() : void
      {
         if(this.tw)
         {
            this.tw.kill();
            this.tw = null;
         }
         super.destroy();
      }
   }
}
