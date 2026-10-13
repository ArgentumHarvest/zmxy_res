package export.level
{
   import base.BaseLevelListenering;
   import event.CommonEvent;
   import export.monster.Monster151;
   import flash.display.MovieClip;
   import my.MainGame;
   
   public class StageListener478 extends BaseLevelListenering
   {
       
      
      private var m151Array:Array;
      
      private var curLevel:uint = 1;
      
      private var sl47Floor:MovieClip;
      
      public function StageListener478()
      {
         m151Array = [];
         super();
         waitForRegisterDataArray = ["Monster151"];
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
         var m151:Monster151 = MainGame.getInstance().createMonster(151,500,200) as Monster151;
         m151.setPropertyByLevel(this.curLevel);
         m151.addEventListener(Monster151.Monster151DEAD_EVENT,__m151Dead);
         this.m151Array.push(m151);
      }
      
      private function __m151Dead(evt:CommonEvent) : void
      {
         var m151:Monster151 = evt.target as Monster151;
         m151.removeEventListener(Monster151.Monster151DEAD_EVENT,__m151Dead);
         this.removeFromm151Array(m151);
         gc.setAnalyzeConstellationsLevel(8,this.curLevel);
         this.curLevel++;
         this.sl47Floor.gotoAndStop(this.curLevel);
         this.callMonster();
      }
      
      private function removeFromm151Array(m151:Monster151) : void
      {
         var idx:int = this.m151Array.indexOf(m151);
         if(idx != -1)
         {
            this.m151Array.splice(idx,1);
         }
      }
      
      override public function destroy() : void
      {
         for each(var m151 in this.m151Array)
         {
            m151.removeEventListener(Monster151.Monster151DEAD_EVENT,__m151Dead);
         }
         this.m151Array.length = 0;
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
