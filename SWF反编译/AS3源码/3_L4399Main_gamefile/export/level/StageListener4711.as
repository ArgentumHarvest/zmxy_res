package export.level
{
   import base.BaseLevelListenering;
   import event.CommonEvent;
   import export.monster.Monster157;
   import flash.display.MovieClip;
   import my.MainGame;
   
   public class StageListener4711 extends BaseLevelListenering
   {
       
      
      private var m157Array:Array;
      
      private var curLevel:uint = 1;
      
      private var sl47Floor:MovieClip;
      
      public function StageListener4711()
      {
         m157Array = [];
         super();
         waitForRegisterDataArray = ["Monster157"];
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
         var m157:Monster157 = MainGame.getInstance().createMonster(157,500,200) as Monster157;
         m157.setPropertyByLevel(this.curLevel);
         m157.addEventListener(Monster157.Monster157DEAD_EVENT,__m157Dead);
         this.m157Array.push(m157);
      }
      
      private function __m157Dead(evt:CommonEvent) : void
      {
         var m157:Monster157 = evt.target as Monster157;
         m157.removeEventListener(Monster157.Monster157DEAD_EVENT,__m157Dead);
         this.removeFromm157Array(m157);
         gc.setAnalyzeConstellationsLevel(11,this.curLevel);
         this.curLevel++;
         this.sl47Floor.gotoAndStop(this.curLevel);
         this.callMonster();
      }
      
      private function removeFromm157Array(m157:Monster157) : void
      {
         var idx:int = this.m157Array.indexOf(m157);
         if(idx != -1)
         {
            this.m157Array.splice(idx,1);
         }
      }
      
      override public function destroy() : void
      {
         for each(var m157 in this.m157Array)
         {
            m157.removeEventListener(Monster157.Monster157DEAD_EVENT,__m157Dead);
         }
         this.m157Array.length = 0;
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
