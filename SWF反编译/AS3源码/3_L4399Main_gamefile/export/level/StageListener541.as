package export.level
{
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import export.monster.Monster176;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class StageListener541 extends BaseLevelListenering
   {
       
      
      private var monsterCountDict:Dictionary;
      
      private var mon9:BaseMonster;
      
      private var mon10:BaseMonster;
      
      private var mon17:BaseMonster;
      
      private var mon18:BaseMonster;
      
      private var mon19:BaseMonster;
      
      private var xiannvLevel:uint = 1;
      
      private var dropDict:Dictionary;
      
      public function StageListener541()
      {
         var fu:int = 0;
         var fuInt:int = 0;
         var i:* = 0;
         var fuYu:int = 0;
         super();
         this.monsterCountDict = new Dictionary();
         if(gc.stage541Type == 0)
         {
            this.waitForRegisterDataArray = ["Monster9","Monster10","Monster17","Monster18","Monster19"];
            this.monsterCountDict[9] = 10;
            this.monsterCountDict[10] = 10;
            this.monsterCountDict[17] = 10;
            this.monsterCountDict[18] = 10;
            this.monsterCountDict[19] = 10;
         }
         else if(gc.stage541Type == 1)
         {
            this.waitForRegisterDataArray = ["Monster176"];
         }
         else if(gc.stage541Type == 2)
         {
            this.waitForRegisterDataArray = ["Monster9","Monster19","Monster10"];
            this.monsterCountDict[9] = gc.stage541Args[0];
            this.monsterCountDict[19] = gc.stage541Args[1];
            this.monsterCountDict[10] = gc.stage541Args[2];
            fu = gc.stage541Args[3];
            trace("-------------------gc.stage541Args:" + gc.stage541Args);
            this.dropDict = new Dictionary();
            if(fu == 0)
            {
               this.dropDict["kly1"] = 3;
            }
            else
            {
               this.dropDict["kly3"] = 0;
               fuInt = fu / 4;
               for(i = uint(0); i < fuInt; )
               {
                  this.dropDict["kly3"]++;
                  i++;
               }
               fuYu = fu % 4;
               if(fuYu == 1)
               {
                  this.dropDict["kly1"] = 6;
               }
               else if(fuYu == 2)
               {
                  this.dropDict["kly2"] = 2;
               }
               else if(fuYu == 3)
               {
                  this.dropDict["kly2"] = 3;
               }
            }
            trace("--kly1:" + this.dropDict["kly1"]);
            trace("--kly2:" + this.dropDict["kly2"]);
            trace("--kly3:" + this.dropDict["kly3"]);
         }
      }
      
      override public function afterFallEquip(equipName:String) : void
      {
         trace("afterFallEquip---:" + equipName);
         if(gc.stage541Type == 2)
         {
            if(this.dropDict[equipName])
            {
               if(this.dropDict[equipName] > 0)
               {
                  this.dropDict[equipName]--;
               }
               if(this.dropDict[equipName] == 0)
               {
                  this.dropDict[equipName] = null;
               }
            }
         }
      }
      
      override public function beforeFallEquip(bm:BaseMonster) : void
      {
         var dropArray:* = null;
         trace("---beforeFallEquip---");
         if(gc.stage541Type == 2)
         {
            dropArray = [];
            for(var key in this.dropDict)
            {
               if(this.dropDict[key] > 0)
               {
                  trace("key:" + key);
                  dropArray.push({
                     "name":key,
                     "bigtype":"dj"
                  });
               }
            }
            bm.setFallList(dropArray);
         }
      }
      
      override public function step() : void
      {
         super.step();
         var isOver:Boolean = true;
         if(gc.stage541Type == 0)
         {
            if(mon9)
            {
               if(mon9.isDead())
               {
                  this.newMonsterByType(9);
               }
            }
            if(mon10)
            {
               if(mon10.isDead())
               {
                  this.newMonsterByType(10);
               }
            }
            if(mon17)
            {
               if(mon17.isDead())
               {
                  this.newMonsterByType(17);
               }
            }
            if(mon18)
            {
               if(mon18.isDead())
               {
                  this.newMonsterByType(18);
               }
            }
            if(mon19)
            {
               if(mon19.isDead())
               {
                  this.newMonsterByType(19);
               }
            }
            for each(var val in this.monsterCountDict)
            {
               if(val > 0)
               {
                  isOver = false;
               }
            }
         }
         else if(gc.stage541Type == 1)
         {
            if(this.xiannvLevel >= 7)
            {
               if(gc.pWorld.monsterArray.length != 0)
               {
                  isOver = false;
               }
            }
            else if(gc.pWorld.monsterArray.length == 0)
            {
               this.xiannvLevel++;
               this.gotoXiannvLevel(this.xiannvLevel);
            }
         }
         else if(gc.stage541Type == 2)
         {
            if(mon9)
            {
               if(mon9.isDead())
               {
                  this.newMonsterByTypeOnShaizi(9);
               }
            }
            if(mon19)
            {
               if(mon19.isDead())
               {
                  this.newMonsterByTypeOnShaizi(19);
               }
            }
            if(mon10)
            {
               if(mon10.isDead())
               {
                  this.newMonsterByTypeOnShaizi(10);
               }
            }
            for each(val in this.monsterCountDict)
            {
               if(val > 0)
               {
                  isOver = false;
               }
            }
         }
         if(isOver)
         {
            if(gc.pWorld.monsterArray.length == 0)
            {
               this.showDoor();
            }
         }
      }
      
      private function showDoor() : void
      {
         var i:int = 0;
         var mc:* = null;
         var ta:Array = gc.pWorld.getTransferDoorArray();
         for(i = 0; i < ta.length; )
         {
            mc = ta[i];
            mc.visible = true;
            i++;
         }
      }
      
      override public function start() : void
      {
         super.start();
         trace("gc.stage541Args：" + gc.stage541Args);
         if(gc.stage541Type == 0)
         {
            this.newMonsterByType(9);
            this.newMonsterByType(10);
            this.newMonsterByType(17);
            this.newMonsterByType(18);
            this.newMonsterByType(19);
         }
         else if(gc.stage541Type == 1)
         {
            this.gotoXiannvLevel(1);
         }
         else if(gc.stage541Type == 2)
         {
            if(gc.stage541Args[0] > 0)
            {
               this.newMonsterByTypeOnShaizi(9);
            }
            if(gc.stage541Args[1] > 0)
            {
               this.newMonsterByTypeOnShaizi(19);
            }
            if(gc.stage541Args[2] > 0)
            {
               this.newMonsterByTypeOnShaizi(10);
            }
         }
      }
      
      private function gotoXiannvLevel(lv:uint) : void
      {
         var i:* = 0;
         var bm:* = null;
         for(i = uint(0); i < lv; )
         {
            bm = MainGame.getInstance().createMonster(176,100 + RandomControllor.getIns().getRandom() * 700,200) as Monster176;
            bm.setLevel(this.xiannvLevel);
            i++;
         }
      }
      
      private function newMonsterByType(type:uint) : void
      {
         var lv:int = 0;
         if(monsterCountDict[type] > 0)
         {
            monsterCountDict[type]--;
            this["mon" + type] = MainGame.getInstance().createMonster(type,100 + RandomControllor.getIns().getRandom() * 700,200);
            lv = 10 - monsterCountDict[type];
            (this["mon" + type] as BaseMonster).setLevel(lv);
         }
         else
         {
            this["mon" + type] = null;
         }
      }
      
      private function newMonsterByTypeOnShaizi(type:uint) : void
      {
         var lv:int = 0;
         if(monsterCountDict[type] > 0)
         {
            monsterCountDict[type]--;
            this["mon" + type] = MainGame.getInstance().createMonster(type,100 + RandomControllor.getIns().getRandom() * 700,200);
            lv = 1;
            if(type == 9)
            {
               lv = gc.stage541Args[0] - monsterCountDict[type];
               (this["mon" + type] as BaseMonster).setLevel(lv);
            }
            else if(type == 19)
            {
               lv = gc.stage541Args[1] - monsterCountDict[type];
               (this["mon" + type] as BaseMonster).setLevel(lv);
            }
            else if(type == 10)
            {
               lv = gc.stage541Args[2] - monsterCountDict[type];
               (this["mon" + type] as BaseMonster).setLevel(lv);
            }
            (this["mon" + type] as BaseMonster).setProbability(0.5);
         }
         else
         {
            this["mon" + type] = null;
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(this.mon9)
         {
            this.mon9.destroy();
         }
         if(this.mon10)
         {
            this.mon10.destroy();
         }
         if(this.mon17)
         {
            this.mon17.destroy();
         }
         if(this.mon18)
         {
            this.mon18.destroy();
         }
         if(this.mon19)
         {
            this.mon19.destroy();
         }
         this.mon9 = null;
         this.mon10 = null;
         this.mon17 = null;
         this.mon18 = null;
         this.mon19 = null;
         this.dropDict = null;
         this.monsterCountDict = null;
      }
   }
}
