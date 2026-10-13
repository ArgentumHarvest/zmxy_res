package export.level
{
   import base.BaseLevelListenering;
   import event.CommonEvent;
   import export.monster.Monster147;
   import flash.display.MovieClip;
   import my.MainGame;
   
   public class StageListener475 extends BaseLevelListenering
   {
       
      
      private var m147Array:Array;
      
      private var curLevel:uint = 1;
      
      private var sl47Floor:MovieClip;
      
      public function StageListener475()
      {
         m147Array = [];
         super();
         waitForRegisterDataArray = ["Monster147"];
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
         this.callMonster147();
      }
      
      private function callMonster147() : void
      {
         var m147:Monster147 = MainGame.getInstance().createMonster(147,500,200) as Monster147;
         m147.setPropertyByLevel(this.curLevel);
         m147.addEventListener(Monster147.Monster147DEAD_EVENT,__m147Dead);
         this.m147Array.push(m147);
      }
      
      private function __m147Dead(evt:CommonEvent) : void
      {
         var m147:Monster147 = evt.target as Monster147;
         m147.removeEventListener(Monster147.Monster147DEAD_EVENT,__m147Dead);
         this.removeFromm147Array(m147);
         gc.setAnalyzeConstellationsLevel(5,this.curLevel);
         this.curLevel++;
         this.sl47Floor.gotoAndStop(this.curLevel);
         this.callMonster147();
      }
      
      private function removeFromm147Array(m147:Monster147) : void
      {
         var idx:int = this.m147Array.indexOf(m147);
         if(idx != -1)
         {
            this.m147Array.splice(idx,1);
         }
      }
      
      override public function destroy() : void
      {
         for each(var m147 in this.m147Array)
         {
            m147.removeEventListener(Monster147.Monster147DEAD_EVENT,__m147Dead);
         }
         this.m147Array.length = 0;
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
