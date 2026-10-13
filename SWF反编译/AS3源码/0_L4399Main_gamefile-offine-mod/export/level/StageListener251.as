package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import flash.events.Event;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class StageListener251 extends BaseLevelListenering
   {
       
      
      private var tw:TweenMax;
      
      private const MAX:int = 10;
      
      private var current:int = 0;
      
      public function StageListener251()
      {
         super();
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override public function start() : void
      {
         super.start();
         gc.maxMonsterPerScreen = 11;
         this.tw = TweenMax.delayedCall(5,callOne);
      }
      
      private function callOne() : void
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
         this.tw = TweenMax.delayedCall(5,callOne);
      }
      
      protected function __monsterDead(e:Event) : void
      {
         (e.currentTarget as BaseMonster).removeEventListener("monsterdestroy",__monsterDead);
         current--;
      }
      
      override public function destroy() : void
      {
         if(this.tw)
         {
            this.tw.kill();
            this.tw = null;
         }
         super.destroy();
      }
   }
}
