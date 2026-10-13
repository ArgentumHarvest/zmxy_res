package export.level
{
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import export.level.Stagelistener631Children.MoonCake;
   import flash.display.MovieClip;
   import flash.events.Event;
   import my.MainGame;
   import my.SingleSavedBuff;
   
   public class StageListener631 extends BaseLevelListenering
   {
       
      
      private var mooncake:MoonCake;
      
      private var daojishi:MovieClip;
      
      private var totalTime:int = 4800;
      
      private var destroyDelayTime:int = 144;
      
      private var monsterAppearInterval:int = 240;
      
      private var curMonsterAppearInterval:int = 72;
      
      private var monArr:Array;
      
      public function StageListener631()
      {
         monArr = [194,195,196,197,198];
         super();
         this.waitForRegisterDataArray = ["Monster9","Monster10","Monster17","Monster18","Monster19"];
      }
      
      override public function step() : void
      {
         var i:int = 0;
         var idx:int = 0;
         var kind:int = 0;
         var bm:* = null;
         super.step();
         if(this.totalTime > 0)
         {
            this.totalTime--;
            this.updateTime();
            if(this.totalTime == 0)
            {
               this.showResult();
            }
            else
            {
               if(this.curMonsterAppearInterval > 0)
               {
                  this.curMonsterAppearInterval--;
                  if(this.curMonsterAppearInterval == 0)
                  {
                     for(i = 0; i < 10; )
                     {
                        idx = int(Math.random() * monArr.length);
                        kind = this.monArr[idx];
                        if(gc.pWorld.monsterArray.length < 12)
                        {
                           bm = MainGame.getInstance().createMonster(kind,100 + Math.random() * 700,150 + Math.random() * 150);
                           bm.setProbability(0.1);
                           bm.addCurAddEffect([{
                              "name":"father",
                              "time":gc.frameClips * 1,
                              "interval":1000,
                              "isForever":1
                           }]);
                           bm.forceTarget = this.mooncake;
                           bm.addEventListener("monsterdestroy",__destroy);
                        }
                        i++;
                     }
                     this.curMonsterAppearInterval = monsterAppearInterval;
                  }
               }
               if(this.mooncake)
               {
                  this.mooncake.step();
               }
            }
         }
         else if(this.destroyDelayTime > 0)
         {
            this.destroyDelayTime--;
            if(this.destroyDelayTime == 0)
            {
               this.doDestroy();
            }
         }
         if(this.daojishi)
         {
            if(this.mooncake)
            {
               this.daojishi.scoreTf.text = this.mooncake.hp + "";
            }
         }
      }
      
      private function doDestroy() : void
      {
         if(gc.dataObject.whichlastworld == 1)
         {
            GMain.getInstance().switchSence("showNewStageMap");
         }
         else if(gc.dataObject.whichlastworld == 2)
         {
            GMain.getInstance().switchSence("showThirdStageMap");
         }
         else
         {
            GMain.getInstance().switchSence("showStageMap");
         }
         MainGame.getInstance().destroyGameAndSaveGame();
      }
      
      private function showResult() : void
      {
         var addValue:int = this.mooncake.hp;
         if(addValue < 1)
         {
            addValue = 1;
         }
         gc.savedBuff.addBuff(SingleSavedBuff.BUFF_MID_BUFF,addValue,gc.frameClips * 60 * 60);
         gc.ts.setTxt("恭喜你获得 中秋节buff 增加攻击力：" + addValue,5);
         gc.stage.addChild(gc.ts);
         for each(var bm in gc.pWorld.monsterArray)
         {
            if(!bm.isDead())
            {
               bm.reduceHp(bm.getSHp());
            }
         }
      }
      
      protected function __destroy(evt:Event) : void
      {
         (evt.currentTarget as BaseMonster).removeEventListener("monsterdestroy",__destroy);
         if(this.mooncake)
         {
            this.mooncake.hp += 2;
         }
      }
      
      override public function start() : void
      {
         this.mooncake = new MoonCake();
         this.mooncake.x = 290;
         this.mooncake.y = 390;
         gc.gameSence.addChild(this.mooncake);
         super.start();
         this.daojishi = AUtils.getNewObj("sl631Time") as MovieClip;
         this.daojishi.x = 480 - this.daojishi.width / 2;
         this.daojishi.y = 80;
         gc.gameInfo.addChild(this.daojishi);
      }
      
      private function updateTime() : void
      {
         if(this.daojishi)
         {
            this.daojishi.timeTf.text = int(this.totalTime / gc.frameClips);
         }
      }
      
      override public function destroy() : void
      {
         if(this.mooncake)
         {
            this.mooncake.destroy();
            this.mooncake = null;
         }
         if(this.daojishi)
         {
            this.daojishi = null;
         }
         super.destroy();
      }
   }
}
