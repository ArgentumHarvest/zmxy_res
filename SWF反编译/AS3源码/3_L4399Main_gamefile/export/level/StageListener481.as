package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.level.StageListener481Children.Stage481Info;
   import export.level.StageListener481Children.Stage481Result;
   import export.level.StageListener481Children.StageListener481Xuehua;
   import export.monster.Monster153;
   import flash.display.Bitmap;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   import my.MyEquipObj;
   
   public class StageListener481 extends BaseLevelListenering
   {
       
      
      private var _flowerArray:Array;
      
      private const FLOWERAPPEARCOUNTCONST:uint = 192;
      
      private var flowerAppearCount:uint = 192;
      
      private var _anti:Antiwear;
      
      private var _stage481Info:Stage481Info;
      
      private var _stepKind:uint = 0;
      
      private var snowBoss:Monster153;
      
      public function StageListener481()
      {
         _flowerArray = [];
         super();
         waitForRegisterDataArray = ["Monster153"];
         this._anti = new Antiwear(new binaryEncrypt());
         this._anti.timeCount = gc.frameClips * 60;
         this._anti.blood = 0;
      }
      
      override public function start() : void
      {
         var eq:* = null;
         var eq2:* = null;
         super.start();
         var bm:Bitmap = AUtils.getImageObj("Stage481Tishi") as Bitmap;
         bm.x = 272;
         bm.y = 296;
         gc.gameSence.getBgSprite().addChild(bm);
         this.snowBoss = MainGame.getInstance().createMonster(153,700,420) as Monster153;
         var isXinniankuaile:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            eq = gc.player1.getCurEquipByType("zbtx");
            if(eq)
            {
               if(eq.getFillName().indexOf("xnkl") != -1)
               {
                  isXinniankuaile = true;
               }
            }
         }
         if(!isXinniankuaile)
         {
            if(gc.player2.roleid > 0)
            {
               eq2 = gc.player2.getCurEquipByType("zbtx");
               if(eq2)
               {
                  if(eq2.getFillName().indexOf("xnkl") != -1)
                  {
                     isXinniankuaile = true;
                  }
               }
            }
         }
         if(isXinniankuaile)
         {
            this.showNianshou();
         }
         else
         {
            this.startSnowBoss();
         }
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function showNianshou() : void
      {
         MainGame.getInstance().createMonster(155,500,300);
      }
      
      public function startSnowBoss() : void
      {
         this._stepKind = 1;
         this.snowBoss.setYourFather(0);
         if(gc.gameInfo)
         {
            gc.gameInfo.clearBossBlood();
         }
         if(!this._stage481Info)
         {
            this._stage481Info = new Stage481Info();
            this._stage481Info.x = 480;
            this._stage481Info.y = 70;
            if(gc.gameInfo)
            {
               gc.gameInfo.addChild(this._stage481Info);
            }
         }
      }
      
      override public function step() : void
      {
         var temp:* = null;
         var idx:int = 0;
         super.step();
         if(this._stepKind == 1)
         {
            temp = [];
            for each(var flower in this._flowerArray)
            {
               if(!flower.isDestroy)
               {
                  flower.step();
               }
               if(flower.isDestroy)
               {
                  temp.push(flower);
               }
            }
            for each(var slj in temp)
            {
               idx = this._flowerArray.indexOf(slj);
               if(idx != -1)
               {
                  this._flowerArray.splice(idx,1);
               }
            }
            if(this.flowerAppearCount > 0)
            {
               this.flowerAppearCount--;
               if(this.flowerAppearCount == 0)
               {
                  this.showFlower();
                  this.flowerAppearCount = 192;
               }
            }
            if(this._anti.timeCount < 0)
            {
               return;
            }
            if(this.snowBoss)
            {
               if(this.snowBoss.isDead())
               {
                  this._anti.timeCount = -1;
                  this.showResult();
                  return;
               }
            }
            if(this._anti.timeCount >= 0)
            {
               this._anti.timeCount--;
               if(this._anti.timeCount == 0)
               {
                  this.showResult();
                  if(this.snowBoss)
                  {
                     this.snowBoss.setYourFather(100000);
                  }
                  return;
               }
            }
            if(this._anti.timeCount < 0)
            {
               return;
            }
            if(this._stage481Info)
            {
               this._stage481Info.updateTimeCountDisplay(this._anti.timeCount / gc.frameClips);
            }
         }
         else if(this.snowBoss)
         {
            this.snowBoss.setYourFather(10000);
         }
      }
      
      private function showResult() : void
      {
         var expAdd:int = 20000 * this._anti.blood / 1000000;
         if(expAdd > 20000)
         {
            expAdd = 20000;
         }
         TweenMax.delayedCall(1,function(_self:StageListener481):*
         {
            var result:Stage481Result = new Stage481Result(expAdd);
            result.x = 480;
            result.y = 250;
            GMain.getInstance().getTopSence().addChild(result);
            for each(var bh in gc.getPlayerArray())
            {
               bh.roleProperies.dispatchEvent(new CommonEvent("AddExper",[expAdd]));
            }
         },[this]);
      }
      
      public function updateBloodDisplay(bd:int) : void
      {
         this._anti.blood = bd;
         if(this._stage481Info)
         {
            this._stage481Info.updateBloodDisplay(bd);
         }
      }
      
      private function showFlower() : void
      {
         var flower:* = null;
         if(this._flowerArray.length < 10)
         {
            flower = new StageListener481Xuehua();
            flower.x = 400 + RandomControllor.getIns().getRandom() * 550;
            flower.y = -10;
            gc.gameSence.addChild(flower);
            this._flowerArray.push(flower);
         }
      }
      
      override public function destroy() : void
      {
         this._flowerArray.length = 0;
         this._stage481Info = null;
         this.snowBoss = null;
         super.destroy();
      }
   }
}
