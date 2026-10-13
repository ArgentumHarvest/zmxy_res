package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import base.MonsterAppearPoint;
   import com.superkaka.Tools.CommonEvent;
   import export.StopPoint;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class StageListener253 extends BaseLevelListenering
   {
      
      public static var curType1:int = 0;
      
      public static var curType2:int = 0;
      
      public static var curType3:int = 0;
       
      
      private var mapArr:Array;
      
      private var monsters:Array;
      
      private var boss:BaseMonster;
      
      private const MAX_KILL_NUM:int = 50;
      
      private var transferDoor:MovieClip;
      
      public function StageListener253()
      {
         mapArr = [];
         monsters = [];
         super();
         this.waitForRegisterDataArray = [];
      }
      
      override public function start() : void
      {
         var i:int = 0;
         super.start();
         var monsterTypes:Array = [126,117,119];
         var mArr:Array = gc.pWorld.getMonsterAppearArray();
         for each(var map in mArr)
         {
            map.enemyType = monsterTypes[int(RandomControllor.getIns().getRandom() * monsterTypes.length)];
            map.totalNum = 5;
            map.delay = 1;
            map.addEventListener("MonsterCreated",__monsterCreated);
            mapArr.push(map);
         }
         var ta:Array = gc.pWorld.getTransferDoorArray();
         for(i = 0; i < ta.length; )
         {
            transferDoor = ta[i];
            i++;
         }
      }
      
      protected function __monsterCreated(evt:CommonEvent) : void
      {
         var bm:BaseMonster = evt.data as BaseMonster;
         bm.addEventListener("monsterdestroy",__monsterDestroy);
         monsters.push(bm);
      }
      
      protected function __monsterDestroy(evt:Event) : void
      {
         var mname:* = null;
         var bh:* = null;
         var stopArr:* = null;
         var bm:BaseMonster = evt.currentTarget as BaseMonster;
         if(bm.isDead())
         {
            mname = getQualifiedClassName(bm);
            if(mname == "export.monster::Monster117")
            {
               curType2++;
            }
            else if(mname == "export.monster::Monster119")
            {
               curType3++;
            }
            else if(mname == "export.monster::Monster126")
            {
               curType1++;
            }
            if(curType1 >= 50 && curType2 >= 50 && curType3 >= 50)
            {
               if(!boss)
               {
                  bh = gc.getRandomPlayer();
                  if(bh)
                  {
                     boss = MainGame.getInstance().createMonster(215,bh.x,200);
                     boss.addEventListener("monsterdestroy",__bossDead);
                     stopArr = gc.pWorld.getStopPointArray();
                     for each(var sp in stopArr)
                     {
                        sp.destroy();
                     }
                     gc.pWorld.getStopPointArray().length = 0;
                  }
               }
            }
         }
      }
      
      protected function __bossDead(event:Event) : void
      {
         boss.removeEventListener("monsterdestroy",__bossDead);
         this.showDoor();
      }
      
      private function showDoor() : void
      {
         transferDoor.visible = true;
         var bh:BaseHero = gc.getRandomPlayer();
         if(bh)
         {
            transferDoor.x = bh.x;
         }
      }
      
      override public function keyBoardDownForW(hero:BaseHero) : void
      {
         if(boss && boss.isDead())
         {
            MainGame.getInstance().fbEnter(1);
         }
         else
         {
            MainGame.getInstance().fbEnter(0);
         }
      }
      
      override public function step() : void
      {
         super.step();
         if(!transferDoor.visible)
         {
            if(gc.pWorld.getMonsterAppearArray().length == 0 && gc.pWorld.monsterArray.length == 0)
            {
               this.showDoor();
            }
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(boss)
         {
            boss.removeEventListener("monsterdestroy",__bossDead);
            boss = null;
         }
         for each(var bm in monsters)
         {
            bm.removeEventListener("monsterdestroy",__monsterDestroy);
         }
         monsters = null;
         for each(var map in mapArr)
         {
            map.removeEventListener("MonsterCreated",__monsterCreated);
         }
         mapArr = null;
      }
   }
}
