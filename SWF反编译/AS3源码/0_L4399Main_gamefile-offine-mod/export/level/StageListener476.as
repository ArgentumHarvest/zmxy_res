package export.level
{
   import base.BaseLevelListenering;
   import event.CommonEvent;
   import export.monster.Monster149;
   import flash.display.MovieClip;
   import my.MainGame;
   
   public class StageListener476 extends BaseLevelListenering
   {
       
      
      private var m149Array:Array;
      
      private var curLevel:uint = 1;
      
      private var sl47Floor:MovieClip;
      
      public function StageListener476()
      {
         m149Array = [];
         super();
         waitForRegisterDataArray = ["Monster149"];
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
         var m149:Monster149 = MainGame.getInstance().createMonster(149,500,200) as Monster149;
         m149.setPropertyByLevel(this.curLevel);
         m149.addEventListener(Monster149.Monster149DEAD_EVENT,__m149Dead);
         this.m149Array.push(m149);
      }
      
      private function __m149Dead(evt:CommonEvent) : void
      {
         var m149:Monster149 = evt.target as Monster149;
         m149.removeEventListener(Monster149.Monster149DEAD_EVENT,__m149Dead);
         this.removeFromm149Array(m149);
         gc.setAnalyzeConstellationsLevel(6,this.curLevel);
         this.curLevel++;
         this.sl47Floor.gotoAndStop(this.curLevel);
         this.callMonster();
      }
      
      private function removeFromm149Array(m149:Monster149) : void
      {
         var idx:int = this.m149Array.indexOf(m149);
         if(idx != -1)
         {
            this.m149Array.splice(idx,1);
         }
      }
      
      override public function destroy() : void
      {
         for each(var m149 in this.m149Array)
         {
            m149.removeEventListener(Monster149.Monster149DEAD_EVENT,__m149Dead);
         }
         this.m149Array.length = 0;
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
