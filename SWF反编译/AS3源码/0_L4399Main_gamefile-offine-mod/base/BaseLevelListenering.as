package base
{
   import com.greensock.TweenMax;
   import com.superkaka.mvc.ControlFactory;
   import config.Config;
   import export.summon.SummonHouyi;
   import export.summon.SummonYuelao;
   import flash.display.Sprite;
   import flash.geom.Point;
   import manager.MusicManager;
   import mvc.control.SocketsSendControl;
   import mvc.controllor.RandomControllor;
   import mvc.net.sm.LoadingComplete;
   import my.ILightForBlackBG;
   import my.MainGame;
   import my.MyEquipObj;
   
   public class BaseLevelListenering
   {
       
      
      protected var gc:Config;
      
      private var mm:MusicManager;
      
      protected var waitForRegisterDataArray:Array;
      
      protected var waitForRegisterSprite:Sprite;
      
      protected var waitForRegisterDataArrayClone:Array;
      
      private var blackBg:Sprite;
      
      protected var isBaiguRelive:Boolean = false;
      
      protected var baiguBoss:BaseMonster;
      
      private var callReswarMonsterCount:uint = 0;
      
      private var callReswarMonsterCountConst:uint = 0;
      
      private var callReswarMonsterKind:int = 0;
      
      private var lightArray:Array;
      
      protected var summon:SummonHouyi;
      
      protected var summonYuelao:SummonYuelao;
      
      public function BaseLevelListenering()
      {
         waitForRegisterDataArray = [];
         waitForRegisterDataArrayClone = [];
         lightArray = [];
         super();
         gc = Config.getInstance();
         mm = MusicManager.getInstance();
      }
      
      public function init() : void
      {
         this.waitForRegisterSprite = AUtils.getNewObj("waitForBitmapDataRegister") as Sprite;
         GMain.getInstance().getTopSence().addChild(this.waitForRegisterSprite);
         this.waitForRegisterDataArrayClone = AUtils.clone(this.waitForRegisterDataArray) as Array;
         this.registerData();
      }
      
      protected function registerData() : void
      {
         if(waitForRegisterDataArray.length > 0)
         {
            var str:String = waitForRegisterDataArray.shift().toString();
            if(BaseBitmapDataPool.hasRegisteredData(str))
            {
               this.registerData();
               return;
            }
            BaseBitmapDataPool.registerData(str);
            if(waitForRegisterDataArray.length > 0)
            {
               TweenMax.delayedCall(0.1,function(self:BaseLevelListenering):*
               {
                  self.registerData();
               },[this]);
            }
            else
            {
               this.start();
            }
         }
         else
         {
            this.start();
         }
      }
      
      public function sendLoadingComplete() : void
      {
         var lp:LoadingComplete = new LoadingComplete();
         var ssc:SocketsSendControl = ControlFactory.getIns().getControl(SocketsSendControl) as SocketsSendControl;
         ssc.sendToFb(lp);
      }
      
      public function start() : void
      {
         if(!gc.checkPayForEquipment())
         {
            var temp:Array = [];
            var idx:int = 0;
            if(gc.player1.roleid > 0)
            {
               for each(eq in gc.player1.curarray)
               {
                  if(eq.getFillName() == "yxttzssz" || eq.getFillName() == "jlttzssz" || eq.getFillName() == "ssttzssz")
                  {
                     temp.push(eq);
                  }
               }
               for each(eqTemp in temp)
               {
                  idx = gc.player1.curarray.indexOf(eqTemp);
                  gc.player1.curarray.splice(idx,1);
                  gc.player1.szlist.push(eqTemp);
               }
               temp.length = 0;
            }
            if(gc.player2.roleid > 0)
            {
               for each(eq in gc.player2.curarray)
               {
                  if(eq.getFillName() == "yxttzssz" || eq.getFillName() == "jlttzssz" || eq.getFillName() == "ssttzssz")
                  {
                     temp.push(eq);
                  }
               }
               for each(eqTemp in temp)
               {
                  idx = gc.player2.curarray.indexOf(eqTemp);
                  gc.player2.curarray.splice(idx,1);
                  gc.player2.szlist.push(eqTemp);
               }
            }
         }
         if(GMain.getInstance().getTopSence().contains(this.waitForRegisterSprite))
         {
            GMain.getInstance().getTopSence().removeChild(this.waitForRegisterSprite);
         }
         gc.pWorld.pWorldStart();
         gc.obbsiteArray = gc.pWorld.monsterArray;
         if(gc.allTask)
         {
            var obj:Object = gc.allTask.getMonsterBirth();
            if(obj)
            {
               if(gc.curStageAndCurLevel.curStage == obj.stage && gc.curStageAndCurLevel.curLevel == obj.level)
               {
                  this.callReswarMonsterCountConst = obj.time * 24;
                  this.callReswarMonsterKind = int(obj.mname);
               }
            }
         }
         var dayAry1:Array = gc.dataObjectInstance.curDate.split("-");
         var year1:uint = int(dayAry1[0]);
         var month1:uint = int(dayAry1[1]) - 1;
         var day1:uint = int(dayAry1[2]);
         var date1:Date = new Date(year1,month1,day1);
         if(!gc.isGetXiongshouPresent)
         {
            if(gc.curStageAndCurLevel.curStage == 1 && gc.curStageAndCurLevel.curLevel > 1 || gc.curStageAndCurLevel.curStage == 2 || gc.curStageAndCurLevel.curStage == 3)
            {
               if(gc.isUseZhaoyaojing || RandomControllor.getIns().getRandom() <= 0.1)
               {
                  mm.play("xinnianMusic");
                  var time:uint = 8 + RandomControllor.getIns().getRandom() * 15;
                  TweenMax.delayedCall(time,function():*
                  {
                     MainGame.getInstance().createMonster(188,100,300);
                     gc.isGetXiongshouPresent = true;
                  });
               }
            }
         }
         if(gc.curStageAndCurLevel.curStage > 0 && gc.curStageAndCurLevel.curStage != 41)
         {
            if(gc.dataObject.houyiTimes > 0)
            {
               var bool:Boolean = this.callSummonHouyi();
               if(bool)
               {
                  gc.dataObject.houyiTimes--;
               }
            }
            if(gc.dataObject.yuelaoTimes > 0)
            {
               bool = this.callSummonYuelao();
               if(bool)
               {
                  gc.dataObject.yuelaoTimes--;
               }
            }
         }
      }
      
      public function callRewardMonster() : BaseMonster
      {
         var bh:BaseHero = gc.getRandomPlayer();
         if(bh)
         {
            return MainGame.getInstance().createMonster(this.callReswarMonsterKind,bh.x,bh.y - 200);
         }
         return null;
      }
      
      public function start1() : void
      {
      }
      
      public function start2() : void
      {
      }
      
      public function keyBoardDownForW(hero:BaseHero) : void
      {
      }
      
      public function keyBoardDownForWAtCommon(hero:BaseHero) : void
      {
      }
      
      public function startBlackBG() : void
      {
         if(!this.blackBg)
         {
            this.blackBg = new Sprite();
            this.blackBg.blendMode = "layer";
            gc.gameInfo.addChildAt(this.blackBg,0);
         }
      }
      
      public function stopBlackBG() : void
      {
         if(this.blackBg)
         {
            this.blackBg.graphics.clear();
            while(this.blackBg.numChildren > 0)
            {
               this.blackBg.removeChildAt(0);
            }
            if(gc.gameInfo)
            {
               if(gc.gameInfo.contains(this.blackBg))
               {
                  gc.gameInfo.removeChild(this.blackBg);
               }
            }
            this.blackBg = null;
         }
      }
      
      public function isInBlack() : Boolean
      {
         return this.blackBg;
      }
      
      private function drawBlackBG() : void
      {
         var p:* = null;
         var temp:* = null;
         p = null;
         temp = null;
         var point:* = null;
         if(this.blackBg)
         {
            while(this.blackBg.numChildren > 0)
            {
               this.blackBg.removeChildAt(0);
            }
            this.blackBg.graphics.clear();
            this.blackBg.graphics.beginFill(0,1);
            this.blackBg.graphics.drawRect(0,0,940,590);
            this.blackBg.graphics.endFill();
            for each(var bo in gc.getPlayerArray())
            {
               p = gc.gameSence.localToGlobal(new Point(bo.x,bo.y));
               temp = AUtils.getNewObj("ViewMask") as Sprite;
               temp.blendMode = "erase";
               temp.x = p.x;
               temp.y = p.y;
               this.blackBg.addChild(temp);
            }
            for each(var dioc in this.lightArray)
            {
               if(dioc)
               {
                  p = gc.gameSence.localToGlobal(new Point(dioc.posX,dioc.posY));
                  temp = AUtils.getNewObj("ViewMask") as Sprite;
                  temp.width = dioc.raidus * 2;
                  temp.height = dioc.raidus * 2;
                  temp.blendMode = "erase";
                  temp.x = p.x;
                  temp.y = p.y;
                  this.blackBg.addChild(temp);
               }
            }
            point = gc.gameInfo.localToGlobal(new Point(gc.gameInfo.x,gc.gameInfo.y));
            this.blackBg.x = point.x;
            this.blackBg.y = 0;
         }
      }
      
      public function addLightForBlackBG(disObjectC:ILightForBlackBG) : void
      {
         lightArray.push(disObjectC);
      }
      
      public function removeLightForBlackBG(disObjectC:ILightForBlackBG) : void
      {
         var idx:int = this.lightArray.indexOf(disObjectC);
         if(idx != -1)
         {
            this.lightArray[idx] = null;
         }
      }
      
      public function afterFallEquip(equipName:String) : void
      {
      }
      
      public function beforeFallEquip(bm:BaseMonster) : void
      {
      }
      
      public function step() : void
      {
         var equipAble:Boolean = false;
         var tx:* = null;
         var hero:* = null;
         var xx:Number = NaN;
         var yy:Number = NaN;
         var baigu:* = null;
         this.drawBlackBG();
         if(this.callReswarMonsterCountConst > 0)
         {
            if(gc.pWorld.getStopPointArray().length == 0)
            {
               if(gc.pWorld.monsterArray.length == 0)
               {
                  this.callReswarMonsterCount = this.callReswarMonsterCountConst - 1;
               }
            }
            if(this.callReswarMonsterCount < this.callReswarMonsterCountConst)
            {
               this.callReswarMonsterCount++;
               if(this.callReswarMonsterCount == this.callReswarMonsterCountConst)
               {
                  this.callRewardMonster();
                  this.callReswarMonsterCountConst = 0;
               }
            }
         }
         var players:Array = gc.getPlayerArray();
         if(this.summon)
         {
            this.summon.step();
            if(this.summon.getSourceRole().isDead())
            {
               for each(var bh in players)
               {
                  if(!bh.isDead())
                  {
                     this.summon.setSourceRole(bh);
                     break;
                  }
               }
            }
         }
         if(this.summonYuelao)
         {
            this.summonYuelao.step();
            if(this.summonYuelao.getSourceRole().isDead())
            {
               for each(bh in players)
               {
                  if(!bh.isDead())
                  {
                     this.summonYuelao.setSourceRole(bh);
                     break;
                  }
               }
            }
         }
         if(gc.curStageAndCurLevel.curStage >= 1 && gc.curStageAndCurLevel.curStage <= 3 || gc.curStageAndCurLevel.curStage >= 20 && gc.curStageAndCurLevel.curStage <= 23)
         {
            if(!this.isBaiguRelive)
            {
               if(!this.baiguBoss)
               {
                  for each(var bm in gc.pWorld.monsterArray)
                  {
                     if(bm.isBoss)
                     {
                        this.baiguBoss = bm;
                        break;
                     }
                  }
               }
               if(this.baiguBoss && this.baiguBoss.isDead())
               {
                  equipAble = false;
                  for each(bh in gc.getPlayerArray())
                  {
                     tx = bh.getPlayer().getCurEquipByType("zbtx");
                     if(tx && tx.getFillName() == "bgqmtx")
                     {
                        equipAble = true;
                        break;
                     }
                  }
                  if(equipAble)
                  {
                     this.isBaiguRelive = true;
                     hero = gc.getRandomPlayer();
                     xx = hero.x;
                     yy = hero.y - 100;
                     if(gc.curStageAndCurLevel.curStage == 22)
                     {
                        xx = 500;
                        yy = 400;
                     }
                     baigu = this.callMonsterById(204,xx,yy);
                     baigu.setFallList(this.baiguBoss.getFallList());
                     baigu.setProbability(this.baiguBoss.getProbability());
                  }
               }
            }
         }
      }
      
      protected function callMonsterById(id:int, xx:Number, yy:Number) : BaseMonster
      {
         return MainGame.getInstance().createMonster(id,xx,yy);
      }
      
      protected function callSummonHouyi() : Boolean
      {
         if(!this.summon)
         {
            this.summon = new SummonHouyi(gc.hero1,1);
            this.summon.x = 150;
            this.summon.y = 200;
            gc.gameSence.addChild(this.summon);
            return true;
         }
         return false;
      }
      
      protected function callSummonYuelao() : Boolean
      {
         if(!this.summonYuelao)
         {
            this.summonYuelao = new SummonYuelao(gc.hero1,1);
            this.summonYuelao.x = 150;
            this.summonYuelao.y = 200;
            gc.gameSence.addChild(this.summonYuelao);
            return true;
         }
         return false;
      }
      
      public function getSummons() : Array
      {
         var arr:Array = [];
         if(this.summon)
         {
            arr.push(this.summon);
         }
         if(this.summonYuelao)
         {
            arr.push(this.summonYuelao);
         }
         return arr;
      }
      
      public function callReswarMonsterImmediately() : void
      {
         var obj:* = null;
         if(gc.allTask)
         {
            obj = gc.allTask.getMonsterBirth();
            if(obj)
            {
               if(gc.curStageAndCurLevel.curStage == obj.stage && gc.curStageAndCurLevel.curLevel == obj.level)
               {
                  this.callReswarMonsterCount = this.callReswarMonsterCountConst - 1;
               }
            }
         }
      }
      
      public function destroy() : void
      {
         var str:* = null;
         if(this.summon)
         {
            this.summon.destroy();
            this.summon = null;
         }
         if(this.summonYuelao)
         {
            this.summonYuelao.destroy();
            this.summonYuelao = null;
         }
         while(this.waitForRegisterDataArrayClone.length > 0)
         {
            str = waitForRegisterDataArrayClone.shift().toString();
            BaseBitmapDataPool.removeData(str);
         }
         this.stopBlackBG();
         this.waitForRegisterDataArrayClone = null;
         this.waitForRegisterSprite = null;
         this.lightArray.length = 0;
         this.baiguBoss = null;
         this.blackBg = null;
         this.mm = null;
      }
   }
}
