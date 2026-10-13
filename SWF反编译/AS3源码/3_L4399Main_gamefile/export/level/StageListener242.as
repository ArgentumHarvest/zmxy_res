package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class StageListener242 extends BaseLevelListenering
   {
       
      
      private var ti;
      
      private const MAX:int = 10;
      
      private var current:int = 0;
      
      private var isCallBoss:Boolean = false;
      
      public function StageListener242()
      {
         super();
      }
      
      override public function step() : void
      {
         var bh:* = null;
         super.step();
         if(!this.isCallBoss)
         {
            bh = gc.getRandomPlayer();
            if(bh && bh.x >= 1500)
            {
               MainGame.getInstance().createMonster(207,bh.x + (RandomControllor.getIns().getRandom() - 0.5) * 600,250 + (RandomControllor.getIns().getRandom() - 0.5) * 400);
               this.isCallBoss = true;
            }
         }
      }
      
      override public function start() : void
      {
         super.start();
         this.ti = setInterval(function():*
         {
            var bh:* = null;
            var bm:* = null;
            if(current < 10)
            {
               bh = gc.getRandomPlayer();
               if(bh)
               {
                  bm = MainGame.getInstance().createMonster(206,bh.x + (RandomControllor.getIns().getRandom() - 0.5) * 600,250 + (RandomControllor.getIns().getRandom() - 0.5) * 400);
                  bm.addEventListener("monsterdestroy",__monsterDead);
               }
               current++;
            }
         },1000);
      }
      
      protected function __monsterDead(e:Event) : void
      {
         (e.currentTarget as BaseMonster).removeEventListener("monsterdestroy",__monsterDead);
         current--;
      }
      
      override public function destroy() : void
      {
         clearInterval(this.ti);
         super.destroy();
      }
   }
}
