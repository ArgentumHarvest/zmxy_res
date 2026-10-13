package export.level
{
   import base.BaseLevelListenering;
   import event.CommonEvent;
   import export.monster.Monster150;
   import flash.display.MovieClip;
   import my.MainGame;
   
   public class StageListener477 extends BaseLevelListenering
   {
       
      
      private var m150Array:Array;
      
      private var curLevel:uint = 1;
      
      private var sl47Floor:MovieClip;
      
      public function StageListener477()
      {
         m150Array = [];
         super();
         waitForRegisterDataArray = ["Monster150"];
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
         var m150:Monster150 = MainGame.getInstance().createMonster(150,500,200) as Monster150;
         m150.setPropertyByLevel(this.curLevel);
         m150.addEventListener(Monster150.Monster150DEAD_EVENT,__m150Dead);
         this.m150Array.push(m150);
      }
      
      private function __m150Dead(evt:CommonEvent) : void
      {
         var m150:Monster150 = evt.target as Monster150;
         m150.removeEventListener(Monster150.Monster150DEAD_EVENT,__m150Dead);
         this.removeFromm150Array(m150);
         gc.setAnalyzeConstellationsLevel(7,this.curLevel);
         this.curLevel++;
         this.sl47Floor.gotoAndStop(this.curLevel);
         this.callMonster();
      }
      
      private function removeFromm150Array(m150:Monster150) : void
      {
         var idx:int = this.m150Array.indexOf(m150);
         if(idx != -1)
         {
            this.m150Array.splice(idx,1);
         }
      }
      
      override public function destroy() : void
      {
         for each(var m150 in this.m150Array)
         {
            m150.removeEventListener(Monster150.Monster150DEAD_EVENT,__m150Dead);
         }
         this.m150Array.length = 0;
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
