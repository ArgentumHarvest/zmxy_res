package export.level
{
   import base.BaseLevelListenering;
   import event.CommonEvent;
   import export.monster.Monster162;
   import flash.display.MovieClip;
   import my.MainGame;
   
   public class StageListener4714 extends BaseLevelListenering
   {
       
      
      private var m162Array:Array;
      
      private var curLevel:uint = 1;
      
      private var sl47Floor:MovieClip;
      
      public function StageListener4714()
      {
         m162Array = [];
         super();
         waitForRegisterDataArray = ["Monster162"];
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
         var m162:Monster162 = MainGame.getInstance().createMonster(162,500,200) as Monster162;
         m162.setPropertyByLevel(this.curLevel);
         m162.addEventListener(Monster162.Monster162DEAD_EVENT,__m162Dead);
         this.m162Array.push(m162);
      }
      
      private function __m162Dead(evt:CommonEvent) : void
      {
         var m162:Monster162 = evt.target as Monster162;
         m162.removeEventListener(Monster162.Monster162DEAD_EVENT,__m162Dead);
         this.removeFromm162Array(m162);
         gc.setAnalyzeConstellationsLevel(14,this.curLevel);
         this.curLevel++;
         this.sl47Floor.gotoAndStop(this.curLevel);
         this.callMonster();
      }
      
      private function removeFromm162Array(m162:Monster162) : void
      {
         var idx:int = this.m162Array.indexOf(m162);
         if(idx != -1)
         {
            this.m162Array.splice(idx,1);
         }
      }
      
      override public function destroy() : void
      {
         for each(var m162 in this.m162Array)
         {
            m162.removeEventListener(Monster162.Monster162DEAD_EVENT,__m162Dead);
         }
         this.m162Array.length = 0;
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
