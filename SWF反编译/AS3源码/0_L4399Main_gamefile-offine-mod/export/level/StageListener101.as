package export.level
{
   import AssetsClass.DragonMysteriousShopAssets;
   import base.BaseAddEffect;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseLevelListenering;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.mapObject.TransferWind;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.HitTest;
   import my.MainGame;
   import my.MyEquipObj;
   
   public class StageListener101 extends BaseLevelListenering
   {
       
      
      private var trapInfo:Array;
      
      private const TIME_COUNT_SECOND_WIND:uint = 210;
      
      private const MAX_MONSTER_NUM:uint = 15;
      
      private const MONSTER_APPEAR_COUNT:uint = 120;
      
      private const LIGHT_FATHER_COUNT:uint = 24;
      
      private const PAOPAO_PER_COUNT:uint = 160;
      
      private var player1Hp:uint = 0;
      
      private var player1Mp:uint = 0;
      
      private var player1PetHp:uint = 0;
      
      private var player1PetMp:uint = 0;
      
      private var player2Hp:uint = 0;
      
      private var player2Mp:uint = 0;
      
      private var player2PetHp:uint = 0;
      
      private var player2PetMp:uint = 0;
      
      private var player1AddEffect:Array;
      
      private var player2AddEffect:Array;
      
      private var player1PetAddEffect:Array;
      
      private var player2PetAddEffect:Array;
      
      private var maxMonsterNum:int = 15;
      
      private var monsterAppearCount:int = 120;
      
      private var monsterArray:Array;
      
      private var timeCountSecondWind:int = 210;
      
      private var paopaoPerCount:int = 160;
      
      private var underSeaDoor:MovieClip;
      
      private var underSeaLight:MovieClip;
      
      private var underSeaLightArray:Array;
      
      private var lightFatherCount:uint = 24;
      
      private var curWind:TransferWind;
      
      private var stage107Hailuo:MovieClip;
      
      public function StageListener101()
      {
         trapInfo = [0,0,0,0];
         monsterArray = [44,45,46];
         underSeaLightArray = [1,1,1,1];
         super();
         waitForRegisterDataArray = ["Monster43","Monster44","Monster45","Monster46","Monster47"];
      }
      
      override public function step() : void
      {
         var appearNum:* = 0;
         var i:* = 0;
         var randIndex:* = 0;
         var randMonster:* = 0;
         var randPoint:* = null;
         var point:* = null;
         var randNum:* = 0;
         i = 0;
         var offsetX:Number = NaN;
         var offsetY:Number = NaN;
         var mc:* = null;
         var dis:Number = NaN;
         super.step();
         if(gc.curStageAndCurLevel.curLevel <= 5)
         {
            if(this.maxMonsterNum > 0)
            {
               if(this.monsterAppearCount > 0)
               {
                  this.monsterAppearCount--;
                  if(this.monsterAppearCount == 0)
                  {
                     appearNum = uint(2 + RandomControllor.getIns().getRandom() * 4);
                     for(i = uint(0); i < appearNum; )
                     {
                        if(gc.pWorld.monsterArray.length < gc.maxMonsterPerScreen)
                        {
                           randIndex = uint(RandomControllor.getIns().getRandom() * this.monsterArray.length);
                           randMonster = uint(this.monsterArray[randIndex]);
                           randPoint = new Point(200 + RandomControllor.getIns().getRandom() * 1000,300);
                           MainGame.getInstance().createMonster(randMonster,randPoint.x,randPoint.y);
                           this.maxMonsterNum--;
                        }
                        i++;
                     }
                     this.monsterAppearCount = 120;
                  }
               }
            }
         }
         if(this.timeCountSecondWind == 210)
         {
            if(this.maxMonsterNum <= 0 && gc.pWorld.monsterArray.length == 0)
            {
               this.curWind = new TransferWind(gc.curStageAndCurLevel.curLevel,0);
               this.curWind.x = 1880;
               this.curWind.y = 440;
               gc.gameSence.addChild(this.curWind);
               this.timeCountSecondWind--;
            }
         }
         else if(this.timeCountSecondWind < 210)
         {
            this.timeCountSecondWind--;
            if(this.timeCountSecondWind == 0)
            {
               if(this.curWind)
               {
                  this.curWind.destroy();
                  this.curWind = null;
               }
               this.curWind = new TransferWind(gc.curStageAndCurLevel.curLevel,1);
               this.curWind.x = 0;
               this.curWind.y = 440;
               gc.gameSence.addChild(this.curWind);
               this.timeCountSecondWind = 210 * 2;
            }
         }
         else
         {
            this.timeCountSecondWind--;
         }
         if(this.curWind)
         {
            this.curWind.step();
         }
         if(this.underSeaDoor)
         {
            this.checkIntoLevel6();
         }
         if(this.underSeaLight)
         {
            this.checkLight();
         }
         if(this.paopaoPerCount > 0)
         {
            this.paopaoPerCount--;
            if(this.paopaoPerCount == 0)
            {
               point = gc.gameSence.globalToLocal(new Point(480,250));
               randNum = uint(4 + RandomControllor.getIns().getRandom() * 6);
               for(i = uint(0); i < randNum; )
               {
                  offsetX = (RandomControllor.getIns().getRandom() - 0.5) * 1000;
                  offsetY = (RandomControllor.getIns().getRandom() - 0.5) * 400;
                  mc = AUtils.getNewObj("underSeaPaoPao") as MovieClip;
                  mc.x = point.x + offsetX;
                  mc.y = point.y + offsetY;
                  gc.gameSence.bgContainer.addChild(mc);
                  i++;
               }
               this.paopaoPerCount = 160;
            }
         }
         if(gc.curStageAndCurLevel.curLevel == 7)
         {
            for each(var bh in gc.getPlayerArray())
            {
               if(bh.x >= 1700 && bh.x <= 1800)
               {
                  if(bh.getPlayer().getSomeOneEquipNumberByName("wplwl") > 0)
                  {
                     bh.getPlayer().removeEquipFormBack("wplwl",2,1);
                     this.gotoLevel(8);
                     break;
                  }
               }
            }
            if(this.stage107Hailuo)
            {
               this.stage107Hailuo.gotoAndStop(1);
               for each(bh in gc.getPlayerArray())
               {
                  dis = AUtils.GetDisBetweenTwoPoint(new Point(bh.x,bh.y),new Point(this.stage107Hailuo.x + 170,this.stage107Hailuo.y + 130));
                  if(dis <= 200)
                  {
                     this.stage107Hailuo.gotoAndStop(2);
                  }
               }
            }
         }
      }
      
      private function checkLight() : void
      {
         if(this.lightFatherCount == 24)
         {
            for each(var bh in gc.getPlayerArray())
            {
               for each(var bb in bh.magicBulletArray)
               {
                  if(!bb.isDisabled)
                  {
                     if(HitTest.complexHitTestObject(bb,this.underSeaLight))
                     {
                        if(this.underSeaLight.currentFrame == 1)
                        {
                           this.underSeaLight.gotoAndStop(2);
                           this.underSeaLightArray[gc.curStageAndCurLevel.curLevel - 1] = 2;
                        }
                        else
                        {
                           this.underSeaLight.gotoAndStop(1);
                           this.underSeaLightArray[gc.curStageAndCurLevel.curLevel - 1] = 1;
                        }
                        this.lightFatherCount--;
                        break;
                     }
                  }
               }
            }
         }
         else
         {
            this.lightFatherCount--;
            if(this.lightFatherCount == 0)
            {
               this.lightFatherCount = 24;
            }
         }
      }
      
      private function checkIntoLevel6() : void
      {
         var colipse:* = null;
         var door:* = null;
         if(this.underSeaDoor)
         {
            colipse = this.underSeaDoor.getChildByName("colipse") as MovieClip;
            door = this.underSeaDoor.getChildByName("door") as MovieClip;
            if(colipse && door.currentFrame == door.totalFrames)
            {
               for each(var bh in gc.getPlayerArray())
               {
                  if(HitTest.complexHitTestObject(bh,colipse))
                  {
                     this.gotoLevel(7);
                  }
               }
            }
         }
      }
      
      private function addLevel5Door() : void
      {
         this.underSeaDoor = AUtils.getNewObj("underSeaDoor");
         this.underSeaDoor.x = 281;
         this.underSeaDoor.y = 0;
         gc.gameSence.bgContainer.addChild(this.underSeaDoor);
      }
      
      private function addLight() : void
      {
         this.underSeaLight = AUtils.getNewObj("underSeaLight");
         this.underSeaLight.x = 1173;
         this.underSeaLight.y = 356;
         gc.gameSence.bgContainer.addChild(this.underSeaLight);
         var frame:uint = this.underSeaLightArray[gc.curStageAndCurLevel.curLevel - 1];
         this.underSeaLight.gotoAndStop(frame);
      }
      
      private function checkLevel5Door() : void
      {
         var door:* = null;
         if(this.underSeaDoor)
         {
            door = this.underSeaDoor.getChildByName("door") as MovieClip;
            if(door)
            {
               if(this.underSeaLightArray.indexOf(1) == -1)
               {
                  door.gotoAndPlay(2);
               }
            }
         }
      }
      
      override public function start() : void
      {
         var flag:Boolean = false;
         var fabao:* = null;
         super.start();
         if(gc.gameVip && gc.gameVip.dataObject.targetNum == 5)
         {
            this.gotoLevel(7);
            gc.gameVip.dataObject.targetNum = 0;
         }
         else
         {
            flag = false;
            if(gc.player1)
            {
               fabao = gc.player1.getCurEquipByType("zbfb");
               if(fabao)
               {
                  if(fabao.getFillName() == "gcxdyy")
                  {
                     flag = true;
                  }
               }
            }
            if(gc.player2 && !flag)
            {
               fabao = gc.player2.getCurEquipByType("zbfb");
               if(fabao)
               {
                  if(fabao.getFillName() == "gcxdyy")
                  {
                     flag = true;
                  }
               }
            }
            if(flag)
            {
               gotoLevel(7);
            }
            else
            {
               gotoLevel(1);
            }
         }
      }
      
      public function gotoLevel(level:uint) : void
      {
         level = level;
         this.recordPlayerState();
         gc.curStageAndCurLevel.curLevel = level;
         gc.pWorld.mapChange();
         this.restorePlayersState();
         this.maxMonsterNum = 15;
         this.timeCountSecondWind = 210;
         this.monsterAppearCount = 120;
         this.paopaoPerCount = 160;
         if(this.curWind)
         {
            this.curWind.destroy();
            this.curWind = null;
         }
         this.underSeaLight = null;
         this.underSeaDoor = null;
         if(this.stage107Hailuo)
         {
            this.stage107Hailuo.removeEventListener("click",__openHailuo);
            this.stage107Hailuo = null;
         }
         if(gc.curStageAndCurLevel.curLevel == 5)
         {
            this.addLevel5Door();
            this.checkLevel5Door();
         }
         else if(gc.curStageAndCurLevel.curLevel == 7)
         {
            this.stage107Hailuo = AUtils.getNewObj("Stage107Hailuo") as MovieClip;
            this.stage107Hailuo.x = 172;
            this.stage107Hailuo.y = 226;
            this.stage107Hailuo.buttonMode = true;
            gc.gameSence.bgContainer.addChild(this.stage107Hailuo);
            this.stage107Hailuo.addEventListener("click",__openHailuo);
            TweenMax.delayedCall(4,function():*
            {
               MainGame.getInstance().createMonster(43,1000,200);
            });
         }
         else if(gc.curStageAndCurLevel.curLevel == 8)
         {
            MainGame.getInstance().createMonster(47,1000,200);
         }
         else if(gc.curStageAndCurLevel.curLevel < 5)
         {
            this.addLight();
         }
         if(this.summon)
         {
            gc.gameSence.addChild(this.summon);
         }
         gc.keyboardControl.continueAllControl();
      }
      
      private function __openHailuo(evt:MouseEvent) : void
      {
         var dragonmysteriousshop:* = null;
         if(this.stage107Hailuo.currentFrame == 2)
         {
            gc.keyboardControl.stopAllControl();
            MainGame.getInstance().stopGame();
            dragonmysteriousshop = new DragonMysteriousShopAssets();
            dragonmysteriousshop.addEventListener("close",_shopClose);
            gc.stage.addChild(dragonmysteriousshop);
         }
      }
      
      private function _shopClose(evt:Event) : void
      {
         evt.target.removeEventListener("close",_shopClose);
         MainGame.getInstance().continueGame();
         gc.keyboardControl.continueAllControl();
      }
      
      private function recordPlayerState() : void
      {
         if(gc.hero1)
         {
            this.player1Hp = gc.hero1.roleProperies.getHHP();
            this.player1Mp = gc.hero1.roleProperies.getMMP();
            if(gc.hero1.curAddEffect)
            {
               this.player1AddEffect = gc.hero1.curAddEffect.getAllBuffArray();
            }
            if(gc.hero1.getPet())
            {
               this.player1PetHp = gc.hero1.getPet().petInfo.getHp();
               this.player1PetMp = gc.hero1.getPet().petInfo.getMp();
               if(gc.hero1.getPet().curAddEffect)
               {
                  this.player1PetAddEffect = gc.hero1.getPet().curAddEffect.getAllBuffArray();
               }
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
            if(gc.hero2.curAddEffect)
            {
               this.player2AddEffect = gc.hero2.curAddEffect.getAllBuffArray();
            }
            if(gc.hero2.getPet())
            {
               this.player2PetHp = gc.hero2.getPet().petInfo.getHp();
               this.player2PetMp = gc.hero2.getPet().petInfo.getMp();
               if(gc.hero2.getPet().curAddEffect)
               {
                  this.player2PetAddEffect = gc.hero2.getPet().curAddEffect.getAllBuffArray();
               }
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
            try
            {
               for each(var obj in this.player1AddEffect)
               {
                  if(obj.name != BaseAddEffect.XLFB_BUFF)
                  {
                     gc.hero1.curAddEffect.add([obj]);
                  }
               }
            }
            catch(e:*)
            {
            }
            if(gc.hero1.getPet())
            {
               try
               {
                  for each(obj in this.player1PetAddEffect)
                  {
                     if(obj.name != BaseAddEffect.XLFB_BUFF)
                     {
                        gc.hero1.getPet().curAddEffect.add([obj]);
                     }
                  }
               }
               catch(e:*)
               {
               }
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
            try
            {
               for each(obj in this.player2AddEffect)
               {
                  if(obj.name != BaseAddEffect.XLFB_BUFF)
                  {
                     gc.hero2.curAddEffect.add([obj]);
                  }
               }
            }
            catch(e:*)
            {
            }
            if(gc.hero2.getPet())
            {
               try
               {
                  for each(obj in this.player2PetAddEffect)
                  {
                     if(obj.name != BaseAddEffect.XLFB_BUFF)
                     {
                        gc.hero2.getPet().curAddEffect.add([obj]);
                     }
                  }
               }
               catch(e:*)
               {
               }
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
      
      override public function destroy() : void
      {
         super.destroy();
         this.underSeaDoor = null;
         this.underSeaLight = null;
         if(this.stage107Hailuo)
         {
            this.stage107Hailuo.removeEventListener("click",__openHailuo);
            this.stage107Hailuo = null;
         }
      }
   }
}
