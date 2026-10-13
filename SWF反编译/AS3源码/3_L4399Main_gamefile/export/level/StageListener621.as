package export.level
{
   import base.BaseLevelListenering;
   
   public class StageListener621 extends BaseLevelListenering
   {
       
      
      public function StageListener621()
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
         this.sendLoadingComplete();
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
