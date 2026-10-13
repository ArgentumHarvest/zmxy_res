package export.level
{
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import base.BaseSummon;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.FallEquipObj;
   import my.HitTest;
   import my.MainGame;
   
   public class StageListener81 extends BaseLevelListenering
   {
       
      
      private var floorBm:Bitmap;
      
      private var bgBm:Bitmap;
      
      private var levelNum:MovieClip;
      
      private var curLevelObj:Antiwear;
      
      private var maxMonsterNumInCurFloor:int;
      
      private var jwealSprite:Sprite;
      
      private var jwealSpriteCount:uint = 5;
      
      private var player1Hp:uint = 0;
      
      private var player1Mp:uint = 0;
      
      private var player1PetHp:uint = 0;
      
      private var player1PetMp:uint = 0;
      
      private var player2Hp:uint = 0;
      
      private var player2Mp:uint = 0;
      
      private var player2PetHp:uint = 0;
      
      private var player2PetMp:uint = 0;
      
      public function StageListener81()
      {
         curLevelObj = new Antiwear(new binaryEncrypt());
         super();
         this.waitForRegisterDataArray = ["Monster35","Monster36","Monster37","Monster38","Monster39","Monster40","Monster41"];
         curLevelObj.curLevel = 1;
      }
      
      public function gotoLevel(level:uint) : void
      {
         curLevelObj.curLevel = level - 1;
         this.keyBoardDownForW(null);
         for each(var bm in gc.pWorld.monsterArray)
         {
            bm.destroy();
            for each(var bb in bm.magicBulletArray)
            {
               bb.destroy();
            }
         }
         gc.pWorld.monsterArray.length = 0;
      }
      
      override public function step() : void
      {
         super.step();
         if(curLevelObj.curLevel % 6 != 0)
         {
            if(this.maxMonsterNumInCurFloor <= 0)
            {
               if(gc.pWorld.monsterArray.length == 0)
               {
                  this.showTransferDoor();
               }
            }
         }
         if(this.jwealSpriteCount > 0)
         {
            if(this.jwealSprite)
            {
               var colipse:MovieClip = this.jwealSprite.getChildByName("colipse") as MovieClip;
               if(colipse)
               {
                  for each(bh in gc.getPlayerArray())
                  {
                     for each(bb in bh.magicBulletArray)
                     {
                        if(!bb.isDisabled)
                        {
                           if(HitTest.complexHitTestObject(bb,colipse))
                           {
                              this.jwealSpriteCount--;
                              var img:MovieClip = AUtils.getNewObj("HeroBeHurt");
                              img.x = colipse.x + 30;
                              img.y = colipse.y + 30;
                              this.jwealSprite.addChild(img);
                              if(this.jwealSpriteCount <= 0)
                              {
                                 TweenMax.to(this.jwealSprite,1,{
                                    "alpha":0,
                                    "onComplete":function(_self:StageListener81):*
                                    {
                                       _self.checkFallDown();
                                    },
                                    "onCompleteParams":[this]
                                 });
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function checkFallDown() : void
      {
         var fe:* = null;
         var fallName:String = "tlzsp";
         if(curLevelObj.curLevel == 6)
         {
            fallName = "tlzsp";
         }
         else if(curLevelObj.curLevel == 12)
         {
            fallName = "llzsp";
         }
         else if(curLevelObj.curLevel == 18)
         {
            fallName = "hlzsp";
         }
         else if(curLevelObj.curLevel == 24)
         {
            fallName = "flzsp";
         }
         if(RandomControllor.getIns().getRandom() <= 0.100012324)
         {
            fe = new FallEquipObj({
               "name":fallName,
               "bigtype":"dj"
            });
            fe.x = this.jwealSprite.x + 40;
            fe.y = 200;
            this.gc.gameSence.addChild(fe);
            this.gc.otherList.push(fe);
         }
         if(this.jwealSprite)
         {
            if(gc.gameSence.contains(this.jwealSprite))
            {
               gc.gameSence.removeChild(this.jwealSprite);
            }
            this.jwealSpriteCount = 5;
            this.jwealSprite = null;
         }
      }
      
      override public function start() : void
      {
         super.start();
         this.turnToDay();
         if(gc.gameVip)
         {
            if(gc.gameVip.dataObject.targetNum == 1)
            {
               this.gotoLevel(6);
               gc.gameVip.dataObject.targetNum = 0;
            }
            else if(gc.gameVip.dataObject.targetNum == 2)
            {
               this.gotoLevel(12);
               gc.gameVip.dataObject.targetNum = 0;
            }
            else if(gc.gameVip.dataObject.targetNum == 3)
            {
               this.gotoLevel(18);
               gc.gameVip.dataObject.targetNum = 0;
            }
            else if(gc.gameVip.dataObject.targetNum == 4)
            {
               this.gotoLevel(24);
               gc.gameVip.dataObject.targetNum = 0;
            }
         }
      }
      
      private function startMonsterAppear() : void
      {
         if(curLevelObj.curLevel % 6 == 0)
         {
            TweenMax.delayedCall(4,function(_self:StageListener81):*
            {
               _self.turnToNight();
            },[this]);
         }
         else
         {
            TweenMax.delayedCall(4,function(_self:StageListener81):*
            {
               _self.randMonsterAppear();
            },[this]);
         }
      }
      
      private function randMonsterAppear() : void
      {
         var randNum:uint = 2 + Math.ceil(RandomControllor.getIns().getRandom() * 2);
         for(var i:uint = 0; i < randNum; )
         {
            var randKind:uint = 39 + RandomControllor.getIns().getRandom() * 3;
            var randPoint:Point = new Point(200 + RandomControllor.getIns().getRandom() * 900,250);
            if(gc.pWorld.monsterArray.length < gc.maxMonsterPerScreen)
            {
               MainGame.getInstance().createMonster(randKind,randPoint.x,randPoint.y);
               this.maxMonsterNumInCurFloor--;
            }
            i++;
         }
         if(this.maxMonsterNumInCurFloor > 0)
         {
            TweenMax.delayedCall(4,function(_self:StageListener81):*
            {
               _self.randMonsterAppear();
            },[this]);
         }
      }
      
      private function showTransferDoor() : void
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
      
      override public function keyBoardDownForW(hero:BaseHero) : void
      {
         TweenMax.killAll();
         this.recordPlayerState();
         gc.pWorld.mapChange();
         this.restorePlayersState();
         if(curLevelObj.curLevel < 24)
         {
            if(curLevelObj.curLevel > 1)
            {
               if(curLevelObj.curLevel == 6 || curLevelObj.curLevel == 12 || curLevelObj.curLevel == 18)
               {
                  if(gc.isHideDebug)
                  {
                     MainGame.getInstance().doSaveGame();
                  }
               }
            }
            curLevelObj.curLevel++;
            this.turnToDay();
         }
         else
         {
            if(!gc.isHideDebug)
            {
            }
            gc.keyboardControl.destroy();
            gc.eventManger.dispatchEvent(new Event("LevelVictor"));
            MainGame.getInstance().levelClear();
         }
         for each(var sm in this.getSummons())
         {
            if(sm.parent)
            {
               sm.parent.removeChild(sm);
            }
            gc.gameSence.addChild(sm);
         }
      }
      
      private function recordPlayerState() : void
      {
         if(gc.hero1)
         {
            this.player1Hp = gc.hero1.roleProperies.getHHP();
            this.player1Mp = gc.hero1.roleProperies.getMMP();
            if(gc.hero1.getPet())
            {
               this.player1PetHp = gc.hero1.getPet().petInfo.getHp();
               this.player1PetMp = gc.hero1.getPet().petInfo.getMp();
            }
            else
            {
               this.player1PetHp = 0;
               this.player1PetMp = 0;
            }
         }
         if(gc.hero2)
         {
            this.player2Hp = gc.hero2.roleProperies.getHHP();
            this.player2Mp = gc.hero2.roleProperies.getMMP();
            if(gc.hero2.getPet())
            {
               this.player2PetHp = gc.hero2.getPet().petInfo.getHp();
               this.player2PetMp = gc.hero2.getPet().petInfo.getMp();
            }
            else
            {
               this.player2PetHp = 0;
               this.player2PetMp = 0;
            }
         }
      }
      
      private function restorePlayersState() : void
      {
         if(gc.hero1)
         {
            if(this.player1Hp > 0)
            {
               gc.hero1.roleProperies.dispatchEvent(new CommonEvent("SetHHp",[this.player1Hp]));
            }
            else
            {
               gc.hero1.roleProperies.dispatchEvent(new CommonEvent("SetHHp",[1]));
            }
            if(this.player1Mp > 0)
            {
               gc.hero1.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.player1Mp]));
            }
            else
            {
               gc.hero1.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[1]));
            }
            if(gc.hero1.getPet())
            {
               if(this.player1PetHp > 0)
               {
                  gc.hero1.getPet().petInfo.setHp(this.player1PetHp);
                  gc.hero1.getPet().petInfo.setMp(this.player1PetMp);
               }
               else
               {
                  gc.hero1.getPet().destroy();
               }
            }
         }
         if(gc.hero2)
         {
            if(this.player2Hp > 0)
            {
               gc.hero2.roleProperies.dispatchEvent(new CommonEvent("SetHHp",[this.player2Hp]));
            }
            else
            {
               gc.hero2.roleProperies.dispatchEvent(new CommonEvent("SetHHp",[1]));
            }
            if(this.player2Mp > 0)
            {
               gc.hero2.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.player2Mp]));
            }
            else
            {
               gc.hero2.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[1]));
            }
            if(gc.hero2.getPet())
            {
               if(this.player2PetHp > 0)
               {
                  gc.hero2.getPet().petInfo.setHp(this.player2PetHp);
                  gc.hero2.getPet().petInfo.setMp(this.player2PetMp);
               }
               else
               {
                  gc.hero2.getPet().destroy();
               }
            }
         }
      }
      
      private function turnToDay() : void
      {
         if(curLevelObj.curLevel % 6 != 0)
         {
            this.maxMonsterNumInCurFloor = 20 * (1 + (curLevelObj.curLevel - 1) * 0.1);
         }
         else
         {
            this.maxMonsterNumInCurFloor = 0;
         }
         if(this.floorBm && gc.gameSence.bgContainer.contains(this.floorBm))
         {
            gc.gameSence.bgContainer.removeChild(this.floorBm);
            this.floorBm = null;
         }
         if(this.bgBm && gc.gameSence.bgContainer.contains(this.bgBm))
         {
            gc.gameSence.bgContainer.removeChild(this.bgBm);
            this.bgBm = null;
         }
         if(this.levelNum && gc.gameSence.bgContainer.contains(this.levelNum))
         {
            gc.gameSence.bgContainer.removeChild(this.levelNum);
            this.levelNum = null;
         }
         floorBm = AUtils.getImageObj("white_floor");
         bgBm = AUtils.getImageObj("white_bg");
         levelNum = AUtils.getNewObj("SL81LevelNum") as MovieClip;
         levelNum.gotoAndStop(curLevelObj.curLevel);
         levelNum.x = 455;
         levelNum.y = 60;
         bgBm.x = -30;
         bgBm.y = 0;
         floorBm.x = -30;
         floorBm.y = 498;
         gc.gameSence.bgContainer.addChild(bgBm);
         gc.gameSence.bgContainer.addChild(floorBm);
         gc.gameSence.bgContainer.addChild(levelNum);
         this.startMonsterAppear();
         if(this.jwealSprite)
         {
            if(gc.gameSence.contains(this.jwealSprite))
            {
               gc.gameSence.removeChild(this.jwealSprite);
            }
            this.jwealSpriteCount = 5;
            this.jwealSprite = null;
         }
         gc.gameInfo.clearBossBlood();
      }
      
      private function turnToNight() : void
      {
         var monsterKind:uint = 35;
         if(curLevelObj.curLevel == 6)
         {
            monsterKind = 35;
         }
         else if(curLevelObj.curLevel == 12)
         {
            monsterKind = 36;
         }
         else if(curLevelObj.curLevel == 18)
         {
            monsterKind = 38;
         }
         else if(curLevelObj.curLevel == 24)
         {
            monsterKind = 37;
         }
         MainGame.getInstance().createMonster(monsterKind,800,200);
         if(this.floorBm && gc.gameSence.bgContainer.contains(this.floorBm))
         {
            gc.gameSence.bgContainer.removeChild(this.floorBm);
            this.floorBm = null;
         }
         if(this.bgBm && gc.gameSence.bgContainer.contains(this.bgBm))
         {
            gc.gameSence.bgContainer.removeChild(this.bgBm);
            this.bgBm = null;
         }
         if(this.levelNum && gc.gameSence.bgContainer.contains(this.levelNum))
         {
            gc.gameSence.bgContainer.removeChild(this.levelNum);
            this.levelNum = null;
         }
         floorBm = AUtils.getImageObj("black_floor");
         bgBm = AUtils.getImageObj("black_bg");
         levelNum = AUtils.getNewObj("SL81LevelNum") as MovieClip;
         levelNum.gotoAndStop(curLevelObj.curLevel);
         levelNum.x = 455;
         levelNum.y = 60;
         bgBm.x = -30;
         bgBm.y = 0;
         floorBm.x = -30;
         floorBm.y = 498;
         gc.gameSence.bgContainer.addChild(bgBm);
         gc.gameSence.bgContainer.addChild(floorBm);
         gc.gameSence.bgContainer.addChild(levelNum);
      }
      
      public function showJwealSprite() : void
      {
         if(!this.jwealSprite)
         {
            if(curLevelObj.curLevel == 6)
            {
               this.jwealSprite = AUtils.getNewObj("Map81Tujweal") as Sprite;
            }
            else if(curLevelObj.curLevel == 12)
            {
               this.jwealSprite = AUtils.getNewObj("Map81Leijweal") as Sprite;
            }
            else if(curLevelObj.curLevel == 18)
            {
               this.jwealSprite = AUtils.getNewObj("Map81Firejweal") as Sprite;
            }
            else if(curLevelObj.curLevel == 24)
            {
               this.jwealSprite = AUtils.getNewObj("Map81Windjweal") as Sprite;
            }
            if(this.jwealSprite)
            {
               this.jwealSprite.x = 1000;
               this.jwealSprite.y = 305;
               gc.gameSence.addChild(this.jwealSprite);
            }
         }
      }
      
      public function getCurLevel() : uint
      {
         return curLevelObj.curLevel;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
