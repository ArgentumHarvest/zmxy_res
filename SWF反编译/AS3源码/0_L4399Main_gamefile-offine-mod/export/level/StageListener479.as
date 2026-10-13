package export.level
{
   import base.BaseLevelListenering;
   import event.CommonEvent;
   import export.monster.Monster152;
   import flash.display.MovieClip;
   import my.MainGame;
   
   public class StageListener479 extends BaseLevelListenering
   {
       
      
      private var m152Array:Array;
      
      private var curLevel:uint = 1;
      
      private var sl47Floor:MovieClip;
      
      public function StageListener479()
      {
         m152Array = [];
         super();
         waitForRegisterDataArray = ["Monster152"];
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
         var m152:Monster152 = MainGame.getInstance().createMonster(152,500,200) as Monster152;
         m152.setPropertyByLevel(this.curLevel);
         m152.addEventListener(Monster152.Monster152DEAD_EVENT,__m152Dead);
         this.m152Array.push(m152);
      }
      
      private function __m152Dead(evt:CommonEvent) : void
      {
         var m152:Monster152 = evt.target as Monster152;
         m152.removeEventListener(Monster152.Monster152DEAD_EVENT,__m152Dead);
         this.removeFromm152Array(m152);
         gc.setAnalyzeConstellationsLevel(9,this.curLevel);
         this.curLevel++;
         this.sl47Floor.gotoAndStop(this.curLevel);
         this.callMonster();
      }
      
      private function removeFromm152Array(m152:Monster152) : void
      {
         var idx:int = this.m152Array.indexOf(m152);
         if(idx != -1)
         {
            this.m152Array.splice(idx,1);
         }
      }
      
      override public function destroy() : void
      {
         for each(var m152 in this.m152Array)
         {
            m152.removeEventListener(Monster152.Monster152DEAD_EVENT,__m152Dead);
         }
         this.m152Array.length = 0;
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
