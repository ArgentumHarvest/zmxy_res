package export.level
{
   import base.BaseLevelListenering;
   import event.CommonEvent;
   import export.monster.Monster144;
   import flash.display.MovieClip;
   import my.MainGame;
   
   public class StageListener473 extends BaseLevelListenering
   {
       
      
      private var m144Array:Array;
      
      private var curLevel:uint = 1;
      
      private var sl47Floor:MovieClip;
      
      public function StageListener473()
      {
         m144Array = [];
         super();
         waitForRegisterDataArray = ["Monster144","Monster145"];
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
         var m144:Monster144 = MainGame.getInstance().createMonster(144,500,200) as Monster144;
         m144.setPropertyByLevel(this.curLevel);
         m144.addEventListener(Monster144.Monster144DEAD_EVENT,__m144Dead);
         this.m144Array.push(m144);
      }
      
      private function __m144Dead(evt:CommonEvent) : void
      {
         var m144:Monster144 = evt.target as Monster144;
         m144.removeEventListener(Monster144.Monster144DEAD_EVENT,__m144Dead);
         this.removeFromm144Array(m144);
         gc.setAnalyzeConstellationsLevel(3,this.curLevel);
         this.curLevel++;
         this.sl47Floor.gotoAndStop(this.curLevel);
         this.callMonster();
      }
      
      private function removeFromm144Array(m144:Monster144) : void
      {
         var idx:int = this.m144Array.indexOf(m144);
         if(idx != -1)
         {
            this.m144Array.splice(idx,1);
         }
      }
      
      override public function destroy() : void
      {
         for each(var m144 in this.m144Array)
         {
            m144.removeEventListener(Monster144.Monster144DEAD_EVENT,__m144Dead);
         }
         this.m144Array.length = 0;
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
