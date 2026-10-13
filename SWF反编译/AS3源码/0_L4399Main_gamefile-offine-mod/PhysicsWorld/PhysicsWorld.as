package PhysicsWorld
{
   import base.BaseAura;
   import base.BaseBullet;
   import base.BaseGameSence;
   import base.BaseHero;
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import base.BaseObject;
   import base.MonsterAppearPoint;
   import base.Wall;
   import config.Config;
   import export.GameInfo;
   import export.StopPoint;
   import export.level.StageListener01;
   import export.level.StageListener02;
   import export.level.StageListener03;
   import export.level.StageListener04;
   import export.level.StageListener05;
   import export.level.StageListener101;
   import export.level.StageListener11;
   import export.level.StageListener111;
   import export.level.StageListener112;
   import export.level.StageListener113;
   import export.level.StageListener12;
   import export.level.StageListener121;
   import export.level.StageListener122;
   import export.level.StageListener123;
   import export.level.StageListener124;
   import export.level.StageListener125;
   import export.level.StageListener13;
   import export.level.StageListener131;
   import export.level.StageListener141;
   import export.level.StageListener142;
   import export.level.StageListener151;
   import export.level.StageListener161;
   import export.level.StageListener171;
   import export.level.StageListener172;
   import export.level.StageListener173;
   import export.level.StageListener201;
   import export.level.StageListener21;
   import export.level.StageListener211;
   import export.level.StageListener212;
   import export.level.StageListener213;
   import export.level.StageListener22;
   import export.level.StageListener221;
   import export.level.StageListener222;
   import export.level.StageListener223;
   import export.level.StageListener23;
   import export.level.StageListener231;
   import export.level.StageListener232;
   import export.level.StageListener233;
   import export.level.StageListener241;
   import export.level.StageListener242;
   import export.level.StageListener243;
   import export.level.StageListener251;
   import export.level.StageListener252;
   import export.level.StageListener253;
   import export.level.StageListener254;
   import export.level.StageListener31;
   import export.level.StageListener32;
   import export.level.StageListener33;
   import export.level.StageListener401;
   import export.level.StageListener41;
   import export.level.StageListener411;
   import export.level.StageListener42;
   import export.level.StageListener421;
   import export.level.StageListener43;
   import export.level.StageListener431;
   import export.level.StageListener44;
   import export.level.StageListener441;
   import export.level.StageListener442;
   import export.level.StageListener443;
   import export.level.StageListener45;
   import export.level.StageListener451;
   import export.level.StageListener46;
   import export.level.StageListener461;
   import export.level.StageListener471;
   import export.level.StageListener4710;
   import export.level.StageListener4711;
   import export.level.StageListener4712;
   import export.level.StageListener4713;
   import export.level.StageListener4714;
   import export.level.StageListener472;
   import export.level.StageListener473;
   import export.level.StageListener474;
   import export.level.StageListener475;
   import export.level.StageListener476;
   import export.level.StageListener477;
   import export.level.StageListener478;
   import export.level.StageListener479;
   import export.level.StageListener481;
   import export.level.StageListener491;
   import export.level.StageListener501;
   import export.level.StageListener51;
   import export.level.StageListener511;
   import export.level.StageListener521;
   import export.level.StageListener531;
   import export.level.StageListener541;
   import export.level.StageListener551;
   import export.level.StageListener561;
   import export.level.StageListener571;
   import export.level.StageListener572;
   import export.level.StageListener581;
   import export.level.StageListener591;
   import export.level.StageListener601;
   import export.level.StageListener61;
   import export.level.StageListener611;
   import export.level.StageListener621;
   import export.level.StageListener631;
   import export.level.StageListener641;
   import export.level.StageListener651;
   import export.level.StageListener71;
   import export.level.StageListener81;
   import export.level.StageListener91;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import mvc.controllor.RandomControllor;
   import my.KeyBoardControl;
   import my.ViewControllor;
   
   public class PhysicsWorld
   {
       
      
      private var wallArray:Array;
      
      private var stopPointArray:Array;
      
      private var monsterDisappertPointArray:Array;
      
      private var markArray:Array;
      
      private var continueArray:Array;
      
      private var transferDoorArray:Array;
      
      private var auraArray:Array;
      
      private var otherHeroArray:Array;
      
      private var otherHeroUserArray;
      
      private var baseLevelListener:BaseLevelListenering;
      
      private var stageListener01:StageListener01;
      
      private var stageListener02:StageListener02;
      
      private var stageListener03:StageListener03;
      
      private var stageListener04:StageListener04;
      
      private var stageListener05:StageListener05;
      
      private var stageListener11:StageListener11;
      
      private var stageListener12:StageListener12;
      
      private var stageListener13:StageListener13;
      
      private var stageListener21:StageListener21;
      
      private var stageListener22:StageListener22;
      
      private var stageListener23:StageListener23;
      
      private var stageListener31:StageListener31;
      
      private var stageListener32:StageListener32;
      
      private var stageListener33:StageListener33;
      
      private var stageListener41:StageListener41;
      
      private var stageListener42:StageListener42;
      
      private var stageListener43:StageListener43;
      
      private var stageListener44:StageListener44;
      
      private var stageListener45:StageListener45;
      
      private var stageListener46:StageListener46;
      
      private var stageListener51:StageListener51;
      
      private var stageListener61:StageListener61;
      
      private var stageListener71:StageListener71;
      
      private var stageListener81:StageListener81;
      
      private var stageListener91:StageListener91;
      
      private var stageListener101:StageListener101;
      
      private var stageListener111:StageListener111;
      
      private var stageListener112:StageListener112;
      
      private var stageListener113:StageListener113;
      
      private var stageListener121:StageListener121;
      
      private var stageListener122:StageListener122;
      
      private var stageListener123:StageListener123;
      
      private var stageListener124:StageListener124;
      
      private var stageListener125:StageListener125;
      
      private var stageListener131:StageListener131;
      
      private var stageListener141:StageListener141;
      
      private var stageListener142:StageListener142;
      
      private var stageListener151:StageListener151;
      
      private var stageListener161:StageListener161;
      
      private var stageListener171:StageListener171;
      
      private var stageListener172:StageListener172;
      
      private var stageListener173:StageListener173;
      
      private var stageListener201:StageListener201;
      
      private var stageListener211:StageListener211;
      
      private var stageListener212:StageListener212;
      
      private var stageListener213:StageListener213;
      
      private var stageListener221:StageListener221;
      
      private var stageListener222:StageListener222;
      
      private var stageListener223:StageListener223;
      
      private var stageListener231:StageListener231;
      
      private var stageListener232:StageListener232;
      
      private var stageListener233:StageListener233;
      
      private var stageListener241:StageListener241;
      
      private var stageListener242:StageListener242;
      
      private var stageListener243:StageListener243;
      
      private var stageListener251:StageListener251;
      
      private var stageListener252:StageListener252;
      
      private var stageListener253:StageListener253;
      
      private var stageListener254:StageListener254;
      
      private var stageListener401:StageListener401;
      
      private var stageListener411:StageListener411;
      
      private var stageListener421:StageListener421;
      
      private var stageListener431:StageListener431;
      
      private var stageListener441:StageListener441;
      
      private var stageListener442:StageListener442;
      
      private var stageListener443:StageListener443;
      
      private var stageListener451:StageListener451;
      
      private var stageListener461:StageListener461;
      
      private var stageListener471:StageListener471;
      
      private var stageListener472:StageListener472;
      
      private var stageListener473:StageListener473;
      
      private var stageListener474:StageListener474;
      
      private var stageListener475:StageListener475;
      
      private var stageListener476:StageListener476;
      
      private var stageListener477:StageListener477;
      
      private var stageListener478:StageListener478;
      
      private var stageListener479:StageListener479;
      
      private var stageListener4710:StageListener4710;
      
      private var stageListener4711:StageListener4711;
      
      private var stageListener4712:StageListener4712;
      
      private var stageListener4713:StageListener4713;
      
      private var stageListener4714:StageListener4714;
      
      private var stageListener481:StageListener481;
      
      private var stageListener491:StageListener491;
      
      private var stageListener501:StageListener501;
      
      private var stageListener511:StageListener511;
      
      private var stageListener521:StageListener521;
      
      private var stageListener531:StageListener531;
      
      private var stageListener541:StageListener541;
      
      private var stageListener551:StageListener551;
      
      private var stageListener561:StageListener561;
      
      private var stageListener571:StageListener571;
      
      private var stageListener572:StageListener572;
      
      private var stageListener581:StageListener581;
      
      private var stageListener591:StageListener591;
      
      private var stageListener601:StageListener601;
      
      private var stageListener611:StageListener611;
      
      private var stageListener621:StageListener621;
      
      private var stageListener631:StageListener631;
      
      private var stageListener641:StageListener641;
      
      private var stageListener651:StageListener651;
      
      private var otherArray:Array;
      
      private var isSourceReady:Boolean = false;
      
      public var monsterArray:Array;
      
      public var heroArray:Array;
      
      public var likeMonsterArray:Array;
      
      private var gc:Config;
      
      public function PhysicsWorld()
      {
         wallArray = [];
         stopPointArray = [];
         monsterDisappertPointArray = [];
         markArray = [];
         continueArray = [];
         transferDoorArray = [];
         auraArray = [];
         otherHeroArray = [];
         otherHeroUserArray = [];
         otherArray = [];
         monsterArray = [];
         heroArray = [];
         likeMonsterArray = [];
         super();
         gc = Config.getInstance();
      }
      
      public function addSubObj(obj:*) : void
      {
         var newObj:* = null;
         var sp:* = null;
         var j:int = 0;
         var s:* = null;
         if(obj is MovieClip)
         {
            newObj = obj as MovieClip;
            if(newObj.getChildByName("isWall"))
            {
               if(newObj.rotation == 0)
               {
                  wallArray.push(newObj as MovieClip);
               }
               else
               {
                  wallArray.unshift(newObj as MovieClip);
               }
               if(gc.isHideDebug)
               {
                  newObj.visible = false;
               }
            }
            if(newObj.getChildByName("isThroughWall"))
            {
               wallArray.push(newObj as MovieClip);
               if(gc.isHideDebug)
               {
                  newObj.visible = false;
               }
            }
            if(newObj.getChildByName("isThroughUpButDownWall"))
            {
               wallArray.push(newObj as MovieClip);
               if(gc.isHideDebug)
               {
                  newObj.visible = false;
               }
            }
            if(newObj.getChildByName("isThroughDownButUpWall"))
            {
               wallArray.push(newObj as MovieClip);
               if(gc.isHideDebug)
               {
                  newObj.visible = false;
               }
            }
            if(newObj.getChildByName("noContinueGo"))
            {
               continueArray.push(newObj as Sprite);
               if(gc.isHideDebug)
               {
                  newObj.visible = false;
               }
            }
            if(newObj.getChildByName("isTransferDoor"))
            {
               transferDoorArray.push(newObj as Sprite);
               if(gc.curStageAndCurLevel.curStage != 0)
               {
                  newObj.visible = false;
               }
            }
            if(newObj.getChildByName("monsterDisapperaPoint"))
            {
               this.monsterDisappertPointArray.push(newObj);
               if(gc.isHideDebug)
               {
                  newObj.visible = false;
               }
            }
            if(newObj.getChildByName("isHideWall"))
            {
               this.otherArray.push(newObj);
               if(gc.isHideDebug)
               {
                  newObj.visible = false;
               }
            }
            if(newObj.getChildByName("stophere"))
            {
               sp = new StopPoint();
               sp.setXY(newObj.x,newObj.y);
               if(stopPointArray.length > 0)
               {
                  for(j = 0; j < stopPointArray.length; )
                  {
                     s = stopPointArray[j] as StopPoint;
                     if(s.getDataX() >= newObj.x)
                     {
                        stopPointArray.splice(j,0,sp);
                        break;
                     }
                     if(j == stopPointArray.length - 1)
                     {
                        stopPointArray.splice(j + 1,0,sp);
                        break;
                     }
                     j++;
                  }
               }
               else
               {
                  stopPointArray.push(sp);
               }
               if(gc.isHideDebug)
               {
                  newObj.visible = false;
               }
            }
         }
      }
      
      public function pWorldInit() : void
      {
         this.baseLevelListener = AUtils.getNewObj("export.level.StageListener" + gc.curStageAndCurLevel.curStage + gc.curStageAndCurLevel.curLevel) as BaseLevelListenering;
         this.baseLevelListener.init();
      }
      
      public function pWorldStart() : void
      {
         var i:int = 0;
         var s:* = null;
         trace("--pWorldStart--");
         gc.keyboardControl = new KeyBoardControl(gc.stage);
         gc.vControllor = new ViewControllor();
         for(i = 0; i < stopPointArray.length; )
         {
            s = StopPoint(stopPointArray[i]);
            s.idx = i;
            i++;
         }
         gc.createHero();
         gc.gameInfo = new GameInfo();
         GMain.getInstance().getMainSence().addChild(gc.gameInfo);
         this.isSourceReady = true;
         if(gc.curStageAndCurLevel.curStage == 1 && gc.curStageAndCurLevel.curLevel == 1)
         {
            gc.maxMonsterPerScreen = 100;
         }
         else if(gc.curStageAndCurLevel.curStage == 12)
         {
            if(gc.getPlayerArray().length == 1)
            {
               gc.maxMonsterPerScreen = 4;
            }
            else
            {
               gc.maxMonsterPerScreen = 5;
            }
         }
         else if(gc.curStageAndCurLevel.curStage == 54)
         {
            if(gc.stage541Type == 1)
            {
               gc.maxMonsterPerScreen = 7;
            }
            else
            {
               gc.maxMonsterPerScreen = 5;
            }
         }
         else if(gc.getPlayerArray().length == 1)
         {
            gc.maxMonsterPerScreen = 6;
         }
         else
         {
            gc.maxMonsterPerScreen = 8;
         }
      }
      
      public function mapChange() : void
      {
         trace("--mapChange--");
         this.isSourceReady = false;
         this.destroyWhenChangeMap();
         if(gc.vControllor)
         {
            gc.vControllor.destroy();
         }
         gc.vControllor = new ViewControllor();
         gc.gameSence.destroy();
         gc.gameSence = null;
         trace("gc.curStageAndCurLevel.curStage:" + gc.curStageAndCurLevel.curStage);
         trace("gc.curStageAndCurLevel.curLevel:" + gc.curStageAndCurLevel.curLevel);
         gc.gameSence = AUtils.getNewObj("export.gameSence.sl" + gc.curStageAndCurLevel.curStage + gc.curStageAndCurLevel.curLevel) as BaseGameSence;
         GMain.getInstance().getMainSence().addChild(gc.gameSence);
         gc.createHero();
         gc.gameInfo.destroy();
         gc.gameInfo = new GameInfo();
         GMain.getInstance().getMainSence().addChild(gc.gameInfo);
         this.isSourceReady = true;
      }
      
      public function mutiMapChange() : void
      {
         this.mapChange();
         for each(var bo in gc.getPlayerAndPetArray())
         {
            bo.sid = gc.sid;
         }
         gc.setMyData();
      }
      
      public function getRandomMonster() : BaseMonster
      {
         var len:int = this.monsterArray.length;
         var rand:int = RandomControllor.getIns().getRandom() * len;
         return this.monsterArray[rand];
      }
      
      public function getWallArray() : Array
      {
         return this.wallArray;
      }
      
      public function getMarkArray() : Array
      {
         return this.markArray;
      }
      
      public function getNoContinueArray() : Array
      {
         return this.continueArray;
      }
      
      public function getTransferDoorArray() : Array
      {
         return this.transferDoorArray;
      }
      
      public function getOtherHeroArray() : Array
      {
         return this.otherHeroArray;
      }
      
      public function getOtherHeroUserArray() : Array
      {
         return this.otherHeroUserArray;
      }
      
      public function getStopPointArray() : Array
      {
         return this.stopPointArray;
      }
      
      public function getMonsterAppearArray() : Array
      {
         return this.monsterDisappertPointArray;
      }
      
      public function getOtherArray() : Array
      {
         return this.otherArray;
      }
      
      public function getAuraArray() : Array
      {
         return this.auraArray;
      }
      
      public function getBaseLevelListener() : BaseLevelListenering
      {
         return this.baseLevelListener;
      }
      
      private function clearWaitFromParentArray(wArray:Array, pArray:Array) : void
      {
         var temp:* = undefined;
         var i:* = 0;
         var idx:int = 0;
         for(i = uint(0); wArray.length > 0; )
         {
            temp = wArray.shift();
            idx = pArray.indexOf(temp);
            if(idx != -1)
            {
               pArray.splice(idx,1);
            }
            i++;
         }
      }
      
      public function step() : void
      {
         var magicBulletCount:* = 0;
         var bb:* = null;
         var bbLen:* = 0;
         var bm:* = null;
         var bh:* = null;
         var lbm:* = null;
         var wa:* = null;
         var ba:* = null;
         var i:int = 0;
         var map:* = null;
         var sp:* = null;
         if(!this.isSourceReady)
         {
            return;
         }
         if(gc.isStopGame)
         {
            return;
         }
         if(gc.gameInfo)
         {
            gc.gameInfo.step();
         }
         var waitForDeleteArray1:Array = [];
         var waitForDeleteArray2:Array = [];
         var alen:uint = this.monsterArray.length;
         while(alen-- > 0)
         {
            if(this.monsterArray[alen])
            {
               bm = this.monsterArray[alen];
               if(!bm.isReadyToDestroy)
               {
                  bbLen = uint(bm.magicBulletArray.length);
                  for(magicBulletCount = uint(0); magicBulletCount < bbLen; )
                  {
                     bb = bm.magicBulletArray[magicBulletCount] as BaseBullet;
                     if(!bb.isReadyToDestroy)
                     {
                        bb.step2();
                     }
                     if(bb.isReadyToDestroy)
                     {
                        waitForDeleteArray2.push(bb);
                     }
                     magicBulletCount++;
                  }
                  this.clearWaitFromParentArray(waitForDeleteArray2,bm.magicBulletArray);
                  bm.step();
               }
               if(bm.isReadyToDestroy)
               {
                  waitForDeleteArray1.push(bm);
               }
            }
         }
         this.clearWaitFromParentArray(waitForDeleteArray1,monsterArray);
         alen = this.heroArray.length;
         while(alen-- > 0)
         {
            if(this.heroArray[alen])
            {
               bh = this.heroArray[alen];
               bbLen = uint(bh.magicBulletArray.length);
               if(!bh.isReadyToDestroy)
               {
                  for(magicBulletCount = uint(0); magicBulletCount < bbLen; )
                  {
                     bb = bh.magicBulletArray[magicBulletCount] as BaseBullet;
                     if(!bb.isReadyToDestroy)
                     {
                        bb.step2();
                     }
                     if(bb.isReadyToDestroy)
                     {
                        waitForDeleteArray2.push(bb);
                     }
                     magicBulletCount++;
                  }
                  this.clearWaitFromParentArray(waitForDeleteArray2,bh.magicBulletArray);
                  bh.step();
               }
               if(bh.isReadyToDestroy)
               {
                  waitForDeleteArray1.push(bh);
               }
            }
         }
         this.clearWaitFromParentArray(waitForDeleteArray1,this.heroArray);
         alen = this.otherHeroArray.length;
         while(alen-- > 0)
         {
            if(this.otherHeroArray[alen])
            {
               bh = this.otherHeroArray[alen];
               if(!bh.isReadyToDestroy)
               {
                  bbLen = uint(bh.magicBulletArray.length);
                  for(magicBulletCount = uint(0); magicBulletCount < bbLen; )
                  {
                     bb = bh.magicBulletArray[magicBulletCount] as BaseBullet;
                     if(!bb.isReadyToDestroy)
                     {
                        bb.step2();
                     }
                     if(bb.isReadyToDestroy)
                     {
                        waitForDeleteArray2.push(bb);
                     }
                     magicBulletCount++;
                  }
                  this.clearWaitFromParentArray(waitForDeleteArray2,bh.magicBulletArray);
                  bh.step();
               }
               if(bh.isReadyToDestroy)
               {
                  waitForDeleteArray1.push(bh);
               }
            }
         }
         this.clearWaitFromParentArray(waitForDeleteArray1,this.otherHeroArray);
         alen = this.likeMonsterArray.length;
         while(alen-- > 0)
         {
            if(this.likeMonsterArray[alen])
            {
               lbm = this.likeMonsterArray[alen];
               if(!lbm.isReadyToDestroy)
               {
                  for(magicBulletCount = uint(0); magicBulletCount < lbm.magicBulletArray.length; )
                  {
                     bb = lbm.magicBulletArray[magicBulletCount] as BaseBullet;
                     if(!bb.isReadyToDestroy)
                     {
                        bb.step2();
                     }
                     if(bb.isReadyToDestroy)
                     {
                        waitForDeleteArray2.push(bb);
                     }
                     magicBulletCount++;
                  }
                  this.clearWaitFromParentArray(waitForDeleteArray2,lbm.magicBulletArray);
                  lbm.step();
               }
               if(lbm.isReadyToDestroy)
               {
                  waitForDeleteArray1.push(lbm);
               }
            }
         }
         this.clearWaitFromParentArray(waitForDeleteArray1,this.likeMonsterArray);
         alen = this.wallArray.length;
         while(alen-- > 0)
         {
            if(this.wallArray[alen])
            {
               wa = this.wallArray[alen] as Wall;
               wa.step();
               if(wa.isReadyToDestroy)
               {
                  waitForDeleteArray1.push(wa);
               }
            }
         }
         this.clearWaitFromParentArray(waitForDeleteArray1,this.wallArray);
         alen = this.auraArray.length;
         while(alen-- > 0)
         {
            if(this.auraArray[alen])
            {
               ba = this.auraArray[alen] as BaseAura;
               ba.step();
               if(ba.isReadyToDestroy)
               {
                  waitForDeleteArray1.push(ba);
               }
            }
         }
         this.clearWaitFromParentArray(waitForDeleteArray1,this.auraArray);
         var mapArr:Array = this.getMonsterAppearArray();
         for(i = 0; i < mapArr.length; )
         {
            map = mapArr[i] as MonsterAppearPoint;
            map.step();
            i++;
         }
         for(i = 0; i < this.stopPointArray.length; )
         {
            sp = stopPointArray[i] as StopPoint;
            sp.step();
            i++;
         }
         gc.vControllor.step();
         if(this.baseLevelListener)
         {
            this.baseLevelListener.step();
         }
      }
      
      public function destroyWhenChangeMap() : void
      {
         var i:int = 0;
         var sp:* = null;
         var wall:* = null;
         var mc:* = null;
         var m:* = null;
         var ba:* = null;
         trace("destroyWhenChangeMap");
         for(i = 0; i < this.stopPointArray.length; )
         {
            sp = stopPointArray[0] as StopPoint;
            sp.destroy();
         }
         this.stopPointArray = [];
         for(i = 0; i < this.wallArray.length; )
         {
            wall = wallArray[0] as Wall;
            wall.destroy();
         }
         this.wallArray.length = 0;
         this.markArray.length = 0;
         for(i = 0; i < otherArray.length; )
         {
            mc = MovieClip(otherArray[i]);
            if(mc.parent)
            {
               mc.parent.removeChild(mc);
            }
            i++;
         }
         this.otherArray.length = 0;
         this.continueArray.length = 0;
         this.transferDoorArray.length = 0;
         this.monsterDisappertPointArray.length = 0;
         for(i = 0; i < monsterArray.length; )
         {
            m = monsterArray[i] as BaseMonster;
            m.destroy();
            i++;
         }
         this.monsterArray.length = 0;
         for(i = 0; i < likeMonsterArray.length; )
         {
            m = likeMonsterArray[i] as BaseMonster;
            m.destroy();
            i++;
         }
         this.likeMonsterArray.length = 0;
         for(i = 0; i < auraArray.length; )
         {
            ba = auraArray[i] as BaseAura;
            ba.destroy();
            i++;
         }
         this.auraArray.length = 0;
         this.otherHeroArray.length = 0;
         this.otherHeroUserArray.length = 0;
         this.isSourceReady = false;
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         var sp:* = null;
         var wall:* = null;
         var mc:* = null;
         var m:* = null;
         var ba:* = null;
         for(i = 0; i < this.stopPointArray.length; )
         {
            sp = stopPointArray[0] as StopPoint;
            sp.destroy();
         }
         this.stopPointArray = [];
         for(i = 0; i < this.wallArray.length; )
         {
            wall = wallArray[0] as Wall;
            wall.destroy();
         }
         this.wallArray = [];
         this.markArray = [];
         for(i = 0; i < otherArray.length; )
         {
            mc = MovieClip(otherArray[i]);
            if(mc.parent)
            {
               mc.parent.removeChild(mc);
            }
            i++;
         }
         this.otherArray = [];
         this.continueArray = [];
         this.transferDoorArray = [];
         this.monsterDisappertPointArray = [];
         for(i = 0; i < monsterArray.length; )
         {
            m = monsterArray[i] as BaseMonster;
            m.destroy();
            i++;
         }
         this.monsterArray = [];
         for(i = 0; i < likeMonsterArray.length; )
         {
            m = likeMonsterArray[i] as BaseMonster;
            m.destroy();
            i++;
         }
         this.likeMonsterArray = [];
         for(i = 0; i < auraArray.length; )
         {
            ba = auraArray[i] as BaseAura;
            ba.destroy();
            i++;
         }
         this.auraArray = [];
         if(this.baseLevelListener)
         {
            this.baseLevelListener.destroy();
            this.baseLevelListener = null;
         }
         this.otherHeroArray = [];
         this.otherHeroUserArray = [];
         this.isSourceReady = false;
      }
   }
}
