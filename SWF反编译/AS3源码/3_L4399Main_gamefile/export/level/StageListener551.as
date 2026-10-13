package export.level
{
   import base.BaseLevelListenering;
   import flash.display.Bitmap;
   import flash.net.URLLoader;
   import my.MainGame;
   
   public class StageListener551 extends BaseLevelListenering
   {
       
      
      private var _monId:int = 177;
      
      private var urlLoader:URLLoader;
      
      public function StageListener551()
      {
         super();
         this.waitForRegisterDataArray = ["Monster177","Monster178","Monster179"];
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override public function start() : void
      {
         var bm:* = null;
         bm = null;
         gc.isBeatBeidou = true;
         if(gc.qixingMonsterId == 178)
         {
            gc.gameSence.getBgSprite().removeChildAt(0);
            bm = AUtils.getImageObj("bg551_2") as Bitmap;
            gc.gameSence.getBgSprite().addChild(bm);
         }
         else if(gc.qixingMonsterId == 179)
         {
            gc.gameSence.getBgSprite().removeChildAt(0);
            bm = AUtils.getImageObj("bg551_3") as Bitmap;
            gc.gameSence.getBgSprite().addChild(bm);
         }
         super.start();
         MainGame.getInstance().createMonster(gc.qixingMonsterId,500,200);
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
