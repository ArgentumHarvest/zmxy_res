package export.level
{
   import base.BaseLevelListenering;
   import event.CommonEvent;
   import export.monster.Monster142;
   import flash.display.MovieClip;
   import my.MainGame;
   
   public class StageListener472 extends BaseLevelListenering
   {
       
      
      private var m142Array:Array;
      
      private var curLevel:uint = 1;
      
      private var sl47Floor:MovieClip;
      
      public function StageListener472()
      {
         m142Array = [];
         super();
         waitForRegisterDataArray = [];
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
         this.callMonster();
      }
      
      private function callMonster() : void
      {
         var m142:Monster142 = MainGame.getInstance().createMonster(142,500,200) as Monster142;
         m142.setPropertyByLevel(this.curLevel);
         m142.addEventListener(Monster142.MONSTER142DEAD_EVENT,__m142Dead);
         this.m142Array.push(m142);
      }
      
      private function __m142Dead(evt:CommonEvent) : void
      {
         var m142:Monster142 = evt.target as Monster142;
         m142.removeEventListener(Monster142.MONSTER142DEAD_EVENT,__m142Dead);
         this.removeFromM142Array(m142);
         gc.setAnalyzeConstellationsLevel(2,this.curLevel);
         this.curLevel++;
         this.sl47Floor.gotoAndStop(this.curLevel);
         this.callMonster();
      }
      
      private function removeFromM142Array(m142:Monster142) : void
      {
         var idx:int = this.m142Array.indexOf(m142);
         if(idx != -1)
         {
            this.m142Array.splice(idx,1);
         }
      }
      
      override public function destroy() : void
      {
         for each(var m142 in this.m142Array)
         {
            m142.removeEventListener(Monster142.MONSTER142DEAD_EVENT,__m142Dead);
         }
         this.m142Array.length = 0;
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
