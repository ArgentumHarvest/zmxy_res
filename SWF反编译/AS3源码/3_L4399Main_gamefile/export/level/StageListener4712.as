package export.level
{
   import base.BaseLevelListenering;
   import event.CommonEvent;
   import export.monster.Monster158;
   import flash.display.MovieClip;
   import my.MainGame;
   
   public class StageListener4712 extends BaseLevelListenering
   {
       
      
      private var m158Array:Array;
      
      private var curLevel:uint = 1;
      
      private var sl47Floor:MovieClip;
      
      public function StageListener4712()
      {
         m158Array = [];
         super();
         waitForRegisterDataArray = ["Monster158"];
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
         var m158:Monster158 = MainGame.getInstance().createMonster(158,500,200) as Monster158;
         m158.setPropertyByLevel(this.curLevel);
         m158.addEventListener(Monster158.Monster158DEAD_EVENT,__m158Dead);
         this.m158Array.push(m158);
      }
      
      private function __m158Dead(evt:CommonEvent) : void
      {
         var m158:Monster158 = evt.target as Monster158;
         m158.removeEventListener(Monster158.Monster158DEAD_EVENT,__m158Dead);
         this.removeFromm158Array(m158);
         gc.setAnalyzeConstellationsLevel(12,this.curLevel);
         this.curLevel++;
         this.sl47Floor.gotoAndStop(this.curLevel);
         this.callMonster();
      }
      
      private function removeFromm158Array(m158:Monster158) : void
      {
         var idx:int = this.m158Array.indexOf(m158);
         if(idx != -1)
         {
            this.m158Array.splice(idx,1);
         }
      }
      
      override public function destroy() : void
      {
         for each(var m158 in this.m158Array)
         {
            m158.removeEventListener(Monster158.Monster158DEAD_EVENT,__m158Dead);
         }
         this.m158Array.length = 0;
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
