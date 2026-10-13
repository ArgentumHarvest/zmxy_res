package export.level
{
   import base.BaseLevelListenering;
   import event.CommonEvent;
   import export.monster.Monster159;
   import flash.display.MovieClip;
   import my.MainGame;
   
   public class StageListener4713 extends BaseLevelListenering
   {
       
      
      private var m159Array:Array;
      
      private var curLevel:uint = 1;
      
      private var sl47Floor:MovieClip;
      
      public function StageListener4713()
      {
         m159Array = [];
         super();
         waitForRegisterDataArray = ["Monster159"];
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override public function start() : void
      {
         super.start();
         this.sl47Floor = AUtils.getNewObj("sl47Floor") as MovieClip;
         this.sl47Floor.gotoAndStop(1);
         this.sl47Floor.x = 450;
         this.sl47Floor.y = 90;
         gc.gameInfo.addChild(this.sl47Floor);
         this.callMonster159();
      }
      
      private function callMonster159() : void
      {
         var m159:Monster159 = MainGame.getInstance().createMonster(159,500,200) as Monster159;
         m159.setPropertyByLevel(this.curLevel);
         m159.addEventListener(Monster159.Monster159DEAD_EVENT,__m159Dead);
         this.m159Array.push(m159);
      }
      
      private function __m159Dead(evt:CommonEvent) : void
      {
         var m159:Monster159 = evt.target as Monster159;
         m159.removeEventListener(Monster159.Monster159DEAD_EVENT,__m159Dead);
         this.removeFromm159Array(m159);
         gc.setAnalyzeConstellationsLevel(13,this.curLevel);
         this.curLevel++;
         this.sl47Floor.gotoAndStop(this.curLevel);
         this.callMonster159();
      }
      
      private function removeFromm159Array(m159:Monster159) : void
      {
         var idx:int = this.m159Array.indexOf(m159);
         if(idx != -1)
         {
            this.m159Array.splice(idx,1);
         }
      }
      
      override public function destroy() : void
      {
         for each(var m159 in this.m159Array)
         {
            m159.removeEventListener(Monster159.Monster159DEAD_EVENT,__m159Dead);
         }
         this.m159Array.length = 0;
         if(this.sl47Floor)
         {
            if(this.sl47Floor.parent)
            {
               this.sl47Floor.parent.removeChild(this.sl47Floor);
            }
            this.sl47Floor = null;
         }
         super.destroy();
      }
   }
}
