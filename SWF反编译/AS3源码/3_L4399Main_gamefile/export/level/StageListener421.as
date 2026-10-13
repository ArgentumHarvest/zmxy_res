package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.fallbox.CopperBox;
   import export.fallbox.SilverBox;
   import export.level.StageListener411Children.VictorySprite;
   import export.monster.Monster121;
   import export.monster.Monster122;
   import export.monster.Monster123;
   import export.monster.Monster124;
   import export.rank.RankPropertyCount;
   import export.rank.RankUser;
   import flash.events.Event;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   import user.User;
   
   public class StageListener421 extends BaseLevelListenering
   {
       
      
      private var isVictory:Boolean = false;
      
      private var winGongxun:int = 0;
      
      private var isStart:Boolean = false;
      
      private var silverBox:SilverBox;
      
      private var copperBox:CopperBox;
      
      public function StageListener421()
      {
         super();
         waitForRegisterDataArray = [];
      }
      
      override public function step() : void
      {
         var isAllDead:Boolean = false;
         super.step();
         if(this.isStart)
         {
            if(!this.isVictory)
            {
               isAllDead = true;
               for each(var bm in gc.pWorld.monsterArray)
               {
                  if(!bm.isDead())
                  {
                     isAllDead = false;
                  }
               }
               if(isAllDead)
               {
                  if(!gc.rankhaslimit)
                  {
                     silverBox = new SilverBox();
                     silverBox.addEventListener("showAward",__showSilverAward);
                     gc.gameSence.addChild(silverBox);
                  }
                  else
                  {
                     copperBox = new CopperBox();
                     copperBox.addEventListener("showAward",__showCopperAward);
                     gc.gameSence.addChild(copperBox);
                  }
                  this.isVictory = true;
               }
            }
         }
         if(silverBox)
         {
            silverBox.step();
         }
         if(copperBox)
         {
            copperBox.step();
         }
      }
      
      private function __showSilverAward(evt:Event) : void
      {
         var ernGongxun:int = this.winGongxun;
         if(!gc.rankhaslimit)
         {
            gc.dataObject.gongxun += ernGongxun;
            RankPropertyCount.submitRankScore(gc);
         }
         else
         {
            ernGongxun = 0;
         }
         var rd:uint = Math.round(RandomControllor.getIns().getRandom());
         if(rd == 0)
         {
            gc.dataObject.mysteriousshoptimes++;
         }
         else
         {
            if(gc.player1.roleid > 0)
            {
               gc.player1.dataObject.strenthtimes++;
            }
            if(gc.player2.roleid > 0)
            {
               gc.player2.dataObject.strenthtimes++;
            }
         }
         var vs:VictorySprite = new VictorySprite(gc.rankUsers.getUserName(),ernGongxun,rd);
         vs.setTxt(gc.rankUsers.getUserName(),ernGongxun,rd);
         GMain.getInstance().getMainSence().addChild(vs);
         if(MainGame.getInstance())
         {
            MainGame.getInstance().doSaveGame();
         }
      }
      
      private function __showCopperAward(evt:Event) : void
      {
         evt = evt;
         var _anti:Antiwear = new Antiwear(new binaryEncrypt());
         _anti.ershi = 20;
         _anti.bashi = 80;
         var value:int = _anti.ershi + RandomControllor.getIns().getRandom() * _anti.bashi;
         var userArray:Array = gc.getUsersArray();
         var playerArray:Array = gc.getPlayerArray();
         if(RandomControllor.getIns().getRandom() < 0.5)
         {
            for each(u in userArray)
            {
               u.setLhValue(u.getLhValue() + value);
            }
            gc.ts.setTxt("获得 " + value + "点灵魂");
         }
         else
         {
            for each(bh in playerArray)
            {
               bh.roleProperies.dispatchEvent(new CommonEvent("SetExper",[bh.roleProperies.getExper() + value]));
            }
            gc.ts.setTxt("获得 " + value + "点经验");
         }
         gc.stage.addChild(gc.ts);
         TweenMax.delayedCall(3,function():*
         {
            if(MainGame.getInstance())
            {
               MainGame.getInstance().destroyGame();
            }
            GMain.getInstance().switchSence("showStageMap");
            gc.curStageAndCurLevel.curStage = 41;
            gc.curStageAndCurLevel.curLevel = 1;
            gc.eventManger.dispatchEvent(new CommonEvent("selectStageOver"));
         });
         if(MainGame.getInstance())
         {
            MainGame.getInstance().doSaveGame();
         }
      }
      
      override public function start() : void
      {
         var rankUsersArray:* = null;
         super.start();
         if(gc.rankUsers)
         {
            rankUsersArray = gc.rankUsers.getRankUserArray();
            for each(var ru in rankUsersArray)
            {
               this.createMonsterByRankUser(ru);
            }
            this.winGongxun = gc.rankUsers.getWinGongxun();
         }
         this.isStart = true;
      }
      
      private function openTheBox() : void
      {
      }
      
      private function createMonsterByRankUser(ru:RankUser) : void
      {
         var m121:* = null;
         var minIdx:int = 0;
         var m122:* = null;
         minIdx = 0;
         var m123:* = null;
         minIdx = 0;
         var m124:* = null;
         minIdx = 0;
         var bmFightingScoreXishu:Number = 0.1;
         var playerFightingXishu:Number = 0.1;
         var playersFightingScore:int = RankPropertyCount.getFightingForceByPlayerNum(gc.getUsersArray()) + gc.dataObject.gongxun;
         var myFightingScore:int = ru.getScore();
         bmFightingScoreXishu = RankPropertyCount.getFightingScoreDiffCoefficientByFightingScorediff(playersFightingScore - myFightingScore);
         playerFightingXishu = RankPropertyCount.getFightingScoreDiffCoefficientByFightingScorediff(myFightingScore - playersFightingScore);
         for each(var bh in gc.getPlayerArray())
         {
            bh.playerFightingScore = playerFightingXishu;
         }
         if(ru.getRoleId() == 1)
         {
            m121 = new Monster121(ru);
            m121.x = 700;
            m121.y = 200;
            gc.pWorld.monsterArray.push(m121);
            minIdx = gc.getMinIdxInHeroAndPet();
            gc.gameSence.addChildAt(m121,minIdx);
            m121.fightingScoreDiff = bmFightingScoreXishu;
         }
         else if(ru.getRoleId() == 2)
         {
            m122 = new Monster122(ru);
            m122.x = 700;
            m122.y = 200;
            gc.pWorld.monsterArray.push(m122);
            minIdx = gc.getMinIdxInHeroAndPet();
            gc.gameSence.addChildAt(m122,minIdx);
            m122.fightingScoreDiff = bmFightingScoreXishu;
         }
         else if(ru.getRoleId() == 3)
         {
            m123 = new Monster123(ru);
            m123.x = 700;
            m123.y = 200;
            gc.pWorld.monsterArray.push(m123);
            minIdx = gc.getMinIdxInHeroAndPet();
            gc.gameSence.addChildAt(m123,minIdx);
            m123.fightingScoreDiff = bmFightingScoreXishu;
         }
         else if(ru.getRoleId() == 4)
         {
            m124 = new Monster124(ru);
            m124.x = 700;
            m124.y = 200;
            gc.pWorld.monsterArray.push(m124);
            minIdx = gc.getMinIdxInHeroAndPet();
            gc.gameSence.addChildAt(m124,minIdx);
            m124.fightingScoreDiff = bmFightingScoreXishu;
         }
      }
      
      override public function destroy() : void
      {
         if(silverBox)
         {
            silverBox.removeEventListener("showAward",__showSilverAward);
         }
         if(copperBox)
         {
            copperBox.removeEventListener("showAward",__showCopperAward);
         }
         super.destroy();
      }
   }
}
