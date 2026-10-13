package export.level
{
   import base.BaseLevelListenering;
   import event.CommonEvent;
   import export.monster.Monster140;
   import flash.display.MovieClip;
   import my.MainGame;
   
   public class StageListener471 extends BaseLevelListenering
   {
       
      
      private var m140Array:Array;
      
      private var curLevel:uint = 1;
      
      private var sl47Floor:MovieClip;
      
      public function StageListener471()
      {
         m140Array = [];
         super();
         waitForRegisterDataArray = ["Monster140","Monster141"];
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
         var m140:Monster140 = MainGame.getInstance().createMonster(140,500,200) as Monster140;
         m140.setPropertyByLevel(this.curLevel);
         m140.addEventListener(Monster140.MONSTER140DEAD_EVENT,__m140Dead);
         this.m140Array.push(m140);
      }
      
      private function __m140Dead(evt:CommonEvent) : void
      {
         var m140:Monster140 = evt.target as Monster140;
         m140.removeEventListener(Monster140.MONSTER140DEAD_EVENT,__m140Dead);
         this.removeFromM140Array(m140);
         gc.setAnalyzeConstellationsLevel(1,this.curLevel);
         this.curLevel++;
         this.sl47Floor.gotoAndStop(this.curLevel);
         this.callMonster();
      }
      
      private function removeFromM140Array(m140:Monster140) : void
      {
         var idx:int = this.m140Array.indexOf(m140);
         if(idx != -1)
         {
            this.m140Array.splice(idx,1);
         }
      }
      
      override public function destroy() : void
      {
         for each(var m140 in this.m140Array)
         {
            m140.removeEventListener(Monster140.MONSTER140DEAD_EVENT,__m140Dead);
         }
         this.m140Array.length = 0;
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
