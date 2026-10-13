package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import export.RoleInfo;
   import export.level.Stagelistener611Children.MovingFloorSl611;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextFormat;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   import user.User;
   
   public class StageListener611 extends BaseLevelListenering
   {
       
      
      private var mfArr:Array;
      
      private var interval:int;
      
      private var curInterval:int;
      
      private var intervalChange:int;
      
      private var curIntervalChange:int;
      
      private var callMonsterInterval:int;
      
      private var curCallMonsterInterval:int;
      
      private var monsters:Array;
      
      private const MAX_MONSTER_NUM:int = 6;
      
      private var score:int = 0;
      
      private var scoreInterval:int = 0;
      
      private const MAX_SCORE:int = 10;
      
      private var curScore:int = 0;
      
      private var timeMc:MovieClip;
      
      public function StageListener611()
      {
         mfArr = [];
         monsters = [];
         super();
         this.interval = gc.frameClips * 1;
         this.curInterval = this.interval;
         this.intervalChange = gc.frameClips * 3.3;
         this.curIntervalChange = this.intervalChange;
         this.callMonsterInterval = gc.frameClips * 3;
         this.curCallMonsterInterval = this.callMonsterInterval;
         this.scoreInterval = gc.frameClips * 10;
         this.waitForRegisterDataArray = [];
      }
      
      override public function step() : void
      {
         var randY:Number = NaN;
         var bh:* = null;
         var bm:* = null;
         super.step();
         if(this.curInterval > 0)
         {
            this.curInterval--;
            if(this.curInterval == 0)
            {
               randY = 300 + (RandomControllor.getIns().getRandom() - 0.5) * 200;
               this.createFutai(50,randY);
               this.curInterval = this.interval;
            }
         }
         if(this.curIntervalChange > 0)
         {
            this.curIntervalChange--;
            if(this.curIntervalChange == 0)
            {
               this.interval += gc.frameClips / 2;
               this.curIntervalChange = intervalChange;
            }
         }
         if(this.curCallMonsterInterval > 0)
         {
            this.curCallMonsterInterval--;
            if(this.curCallMonsterInterval == 0)
            {
               if(this.monsters.length < 6)
               {
                  bh = gc.getRandomPlayer();
                  if(bh)
                  {
                     bm = MainGame.getInstance().createMonster(214,bh.x + (RandomControllor.getIns().getRandom() - 0.5) * 600,250 + (RandomControllor.getIns().getRandom() - 0.5) * 400);
                     bm.addEventListener("monsterdestroy",__monsterDestroy);
                     this.monsters.push(bm);
                  }
               }
               this.curCallMonsterInterval = this.callMonsterInterval;
            }
         }
         this.score++;
         if(this.timeMc)
         {
            this.timeMc.timeTf.text = int(this.score / gc.frameClips);
            this.timeMc.timeTf.width = this.timeMc.timeTf.textWidth + 5;
            this.timeMc.timeTf.height = this.timeMc.timeTf.textHeight + 5;
         }
         if(this.score % this.scoreInterval == 0)
         {
            if(this.curScore < 10)
            {
               gc.dataObject.worldtransfromTimes++;
               gc.ts.setTxt("获得 昆仑山世界传送次数X1");
               gc.stage.addChild(gc.ts);
               this.curScore++;
            }
         }
      }
      
      protected function __monsterDestroy(evt:Event) : void
      {
         var bm:BaseMonster = evt.currentTarget as BaseMonster;
         bm.removeEventListener("monsterdestroy",__monsterDestroy);
         var idx:int = this.monsters.indexOf(bm);
         if(idx != -1)
         {
            this.monsters.splice(idx,1);
         }
      }
      
      private function createFutai(xx:Number, yy:Number) : void
      {
         var mf:MovingFloorSl611 = new MovingFloorSl611();
         mf.x = xx;
         mf.y = yy;
         gc.pWorld.getWallArray().push(mf);
         gc.gameSence.addChild(mf);
      }
      
      override public function start() : void
      {
         var ri:* = null;
         super.start();
         var players:Array = gc.getUsersArray();
         for each(var user in players)
         {
            ri = gc.gameInfo.getRoleInfoByPlayer(user);
            ri.setSkillEnabled(false);
         }
         this.timeMc = AUtils.getNewObj("sl611Time") as MovieClip;
         this.timeMc.timeTf.x += 40;
         this.timeMc.timeTf.y += 3;
         this.timeMc.x = 480 - this.timeMc.width / 2;
         this.timeMc.y = 80;
         gc.gameInfo.addChild(this.timeMc);
         var ttf:TextFormat = new TextFormat();
         ttf.color = 0;
         this.timeMc.timeTf.defaultTextFormat = ttf;
         this.createFutai(50,500);
      }
      
      override public function destroy() : void
      {
         for each(var mf in mfArr)
         {
            mf.destroy();
         }
         mfArr = null;
         for each(var bm in this.monsters)
         {
            bm.removeEventListener("monsterdestroy",__monsterDestroy);
         }
         this.monsters = null;
         super.destroy();
      }
   }
}
