package export.level
{
   import base.BaseLevelListenering;
   import event.CommonEvent;
   import export.monster.Monster156;
   import flash.display.MovieClip;
   import my.MainGame;
   
   public class StageListener4710 extends BaseLevelListenering
   {
       
      
      private var m156Array:Array;
      
      private var curLevel:uint = 1;
      
      private var sl47Floor:MovieClip;
      
      public function StageListener4710()
      {
         m156Array = [];
         super();
         waitForRegisterDataArray = ["Monster156"];
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
         var m156:Monster156 = MainGame.getInstance().createMonster(156,500,200) as Monster156;
         m156.setPropertyByLevel(this.curLevel);
         m156.addEventListener(Monster156.Monster156DEAD_EVENT,__m156Dead);
         this.m156Array.push(m156);
      }
      
      private function __m156Dead(evt:CommonEvent) : void
      {
         var m156:Monster156 = evt.target as Monster156;
         m156.removeEventListener(Monster156.Monster156DEAD_EVENT,__m156Dead);
         this.removeFromm156Array(m156);
         gc.setAnalyzeConstellationsLevel(10,this.curLevel);
         this.curLevel++;
         this.sl47Floor.gotoAndStop(this.curLevel);
         this.callMonster();
      }
      
      private function removeFromm156Array(m156:Monster156) : void
      {
         var idx:int = this.m156Array.indexOf(m156);
         if(idx != -1)
         {
            this.m156Array.splice(idx,1);
         }
      }
      
      override public function destroy() : void
      {
         for each(var m156 in this.m156Array)
         {
            m156.removeEventListener(Monster156.Monster156DEAD_EVENT,__m156Dead);
         }
         this.m156Array.length = 0;
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
