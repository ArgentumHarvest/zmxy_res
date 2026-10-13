package export.level
{
   import base.BaseLevelListenering;
   import export.level.Stagelistener511Children.StageListener511Qiqiu;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class StageListener511 extends BaseLevelListenering
   {
       
      
      private var qiqiuArray:Array;
      
      public function StageListener511()
      {
         qiqiuArray = [];
         super();
         this.waitForRegisterDataArray = ["Monster167"];
      }
      
      override public function step() : void
      {
         super.step();
         for each(var qq in this.qiqiuArray)
         {
            qq.step();
         }
      }
      
      override public function start() : void
      {
         super.start();
         MainGame.getInstance().createMonster(167,500,200);
      }
      
      public function showQiqiu() : void
      {
         var i:* = 0;
         var qqNum:uint = 1 + Math.floor(RandomControllor.getIns().getRandom() * 4);
         for(i = uint(0); i < qqNum; )
         {
            this.newQiqiu();
            i++;
         }
      }
      
      private function newQiqiu() : void
      {
         var qq:StageListener511Qiqiu = new StageListener511Qiqiu();
         qq.x = 50 + RandomControllor.getIns().getRandom() * 850;
         qq.y = 400;
         gc.gameSence.addChild(qq);
         this.qiqiuArray.push(qq);
      }
      
      override public function destroy() : void
      {
         for each(var qq in this.qiqiuArray)
         {
            qq.destroy();
         }
         this.qiqiuArray.length = 0;
         this.qiqiuArray = null;
         super.destroy();
      }
   }
}
