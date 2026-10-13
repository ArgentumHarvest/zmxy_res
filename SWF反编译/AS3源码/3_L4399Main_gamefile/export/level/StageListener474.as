package export.level
{
   import base.BaseLevelListenering;
   import event.CommonEvent;
   import export.monster.Monster146;
   import flash.display.MovieClip;
   import my.MainGame;
   
   public class StageListener474 extends BaseLevelListenering
   {
       
      
      private var m146Array:Array;
      
      private var curLevel:uint = 1;
      
      private var sl47Floor:MovieClip;
      
      public function StageListener474()
      {
         m146Array = [];
         super();
         waitForRegisterDataArray = ["Monster146"];
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
         var m146:Monster146 = MainGame.getInstance().createMonster(146,500,200) as Monster146;
         m146.setPropertyByLevel(this.curLevel);
         m146.addEventListener(Monster146.Monster146DEAD_EVENT,__m146Dead);
         this.m146Array.push(m146);
      }
      
      private function __m146Dead(evt:CommonEvent) : void
      {
         var m146:Monster146 = evt.target as Monster146;
         m146.removeEventListener(Monster146.Monster146DEAD_EVENT,__m146Dead);
         this.removeFromm146Array(m146);
         gc.setAnalyzeConstellationsLevel(4,this.curLevel);
         this.curLevel++;
         this.sl47Floor.gotoAndStop(this.curLevel);
         this.callMonster();
      }
      
      private function removeFromm146Array(m146:Monster146) : void
      {
         var idx:int = this.m146Array.indexOf(m146);
         if(idx != -1)
         {
            this.m146Array.splice(idx,1);
         }
      }
      
      override public function destroy() : void
      {
         for each(var m146 in this.m146Array)
         {
            m146.removeEventListener(Monster146.Monster146DEAD_EVENT,__m146Dead);
         }
         this.m146Array.length = 0;
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
