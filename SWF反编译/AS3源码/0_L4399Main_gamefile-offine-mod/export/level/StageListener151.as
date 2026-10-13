package export.level
{
   import base.BaseLevelListenering;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.level.StageListener151Child.Stage151Boat;
   import export.level.StageListener151Child.Stage151BossTime;
   import export.level.StageListener151Child.Stage151Info;
   import flash.display.Bitmap;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class StageListener151 extends BaseLevelListenering
   {
       
      
      private var monsterAppearInterval:uint = 0;
      
      private var MONSTER66APPEARCOUNTCONST:uint = 0;
      
      private var totalMonsters:uint = 50;
      
      private var bgPart1:Bitmap;
      
      private var bgPart2:Bitmap;
      
      private var _stage151BossTime:Stage151BossTime;
      
      public function StageListener151()
      {
         super();
         waitForRegisterDataArray = ["Monster66","Monster67","Monster68"];
         this.MONSTER66APPEARCOUNTCONST = gc.frameClips * 2;
      }
      
      override public function step() : void
      {
         super.step();
         if(this.totalMonsters > 0)
         {
            if(gc.pWorld.monsterArray.length < gc.maxMonsterPerScreen)
            {
               if(this.monsterAppearInterval < this.MONSTER66APPEARCOUNTCONST)
               {
                  this.monsterAppearInterval++;
                  if(this.monsterAppearInterval == this.MONSTER66APPEARCOUNTCONST)
                  {
                     MainGame.getInstance().createMonster(66,800,250 + (RandomControllor.getIns().getRandom() - 0.5) * 400);
                     this.monsterAppearInterval = 0;
                     this.totalMonsters--;
                     if(this.totalMonsters == 0)
                     {
                        MainGame.getInstance().createMonster(67,600,160);
                        _stage151BossTime = new Stage151BossTime();
                        _stage151BossTime.x = 470;
                        _stage151BossTime.y = 100;
                        gc.gameInfo.addChild(_stage151BossTime);
                     }
                  }
               }
            }
            if(gc.bg1.x > -500)
            {
               gc.bg1.x -= 1;
            }
            else
            {
               gc.bg1.x = -500;
            }
            if(this.bgPart1)
            {
               this.bgPart1.x -= 4;
               if(this.bgPart1.x <= -940)
               {
                  this.bgPart1.x = 940;
               }
            }
            if(this.bgPart2)
            {
               this.bgPart2.x -= 4;
               if(this.bgPart2.x <= -940)
               {
                  this.bgPart2.x = 940;
               }
            }
         }
         if(_stage151BossTime)
         {
            _stage151BossTime.updateTime();
         }
      }
      
      public function updateLonghunInfo(longhun:uint) : void
      {
         if(_stage151BossTime)
         {
            _stage151BossTime.updateLonghun(longhun);
         }
      }
      
      override public function start() : void
      {
         super.start();
         for each(var bo in gc.getPlayerArray())
         {
            this.addBoatByBaseObject(bo);
         }
         this.bgPart1 = AUtils.getImageObj("bg151Part1") as Bitmap;
         this.bgPart2 = AUtils.getImageObj("bg151Part2") as Bitmap;
         this.bgPart2.x = 940;
         gc.gameSence.bgContainer.addChild(this.bgPart1);
         gc.gameSence.bgContainer.addChild(this.bgPart2);
      }
      
      public function addBoatByBaseObject(bo:BaseObject) : void
      {
         var swordBoat:Stage151Boat = new Stage151Boat(bo,-1);
         swordBoat.x = bo.x;
         swordBoat.y = bo.y + 90;
         gc.pWorld.getWallArray().push(swordBoat);
         gc.gameSence.addChild(swordBoat);
      }
      
      public function showResult(totalLonghun:uint) : void
      {
         totalLonghun = totalLonghun;
         var stage151Info:Stage151Info = new Stage151Info(totalLonghun);
         stage151Info.x = 470;
         stage151Info.y = 225;
         gc.gameInfo.addChild(stage151Info);
         TweenMax.delayedCall(5,function():*
         {
            TweenMax.to(stage151Info,3,{
               "alpha":0,
               "onComplete":function(_stage151Info:Stage151Info):*
               {
                  _stage151Info.destroy();
                  MainGame.getInstance().destroyGameAndSaveGame();
                  GMain.getInstance().switchSence("showStageMap");
               },
               "onCompleteParams":[stage151Info]
            });
         });
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
