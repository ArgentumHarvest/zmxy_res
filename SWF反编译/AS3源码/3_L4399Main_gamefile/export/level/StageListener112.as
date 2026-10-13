package export.level
{
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import com.greensock.TweenMax;
   import export.level.StageListener112Child.Stage112Info;
   import export.level.StageListener112Child.Stage112Resule;
   import export.level.StageListener112Child.StageListener112Jweal;
   import export.monster.Monster49;
   import export.monster.Monster50;
   import export.monster.Monster51;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class StageListener112 extends BaseLevelListenering
   {
       
      
      private var jwealArray:Array;
      
      private var _stage112Info:Stage112Info;
      
      private var _anti:Antiwear;
      
      private const BAOXIANG_APPEAR_COUNT = 192.0;
      
      private var _baoxiangAppearCount:uint = 0;
      
      public function StageListener112()
      {
         jwealArray = [];
         super();
         this.waitForRegisterDataArray = ["Monster49"];
         this._anti = new Antiwear(new binaryEncrypt());
         this._anti.timeCount = gc.frameClips * 60;
         this._anti.totalJwealNum = 0;
         this._baoxiangAppearCount = 192;
      }
      
      public function get totalJwealNum() : uint
      {
         return this._anti.totalJwealNum;
      }
      
      public function set totalJwealNum(value:uint) : void
      {
         this._anti.totalJwealNum = value;
         if(this._stage112Info)
         {
            this._stage112Info.updateTotalJwealDisplay(this._anti.totalJwealNum);
         }
      }
      
      public function fallDownJweal(kind:uint, num:uint, point:Point) : void
      {
         var i:* = 0;
         var slj:* = null;
         for(i = uint(0); i < num; )
         {
            slj = new StageListener112Jweal(kind);
            slj.x = point.x - (i - num / 2) * 30;
            slj.y = point.y - 20;
            gc.gameSence.addChild(slj);
            this.jwealArray.push(slj);
            i++;
         }
      }
      
      override public function step() : void
      {
         var idx:int = 0;
         var m49:* = null;
         m49 = null;
         super.step();
         var temp:Array = [];
         for each(var slj in this.jwealArray)
         {
            if(!slj.isDestroy)
            {
               slj.step();
            }
            if(slj.isDestroy)
            {
               temp.push(slj);
            }
         }
         for each(slj in temp)
         {
            idx = this.jwealArray.indexOf(slj);
            if(idx != -1)
            {
               this.jwealArray.splice(idx,1);
            }
         }
         if(this._anti.timeCount < 0)
         {
            return;
         }
         if(this._anti.timeCount >= 0)
         {
            this._anti.timeCount--;
            if(this._anti.timeCount == 0)
            {
               this.showResult();
               for each(var bm in gc.pWorld.monsterArray)
               {
               }
               return;
            }
         }
         if(this._anti.timeCount < 0)
         {
            return;
         }
         if(this._stage112Info)
         {
            this._stage112Info.updateTimeCountDisplay(this._anti.timeCount / gc.frameClips);
         }
         var fish:Boolean = true;
         for each(bm in gc.pWorld.monsterArray)
         {
            if(bm is Monster50 || bm is Monster51)
            {
               fish = false;
               break;
            }
         }
         if(fish)
         {
            this.checkFishAppear();
         }
         if(this._baoxiangAppearCount > 0)
         {
            this._baoxiangAppearCount--;
            if(this._baoxiangAppearCount == 0)
            {
               if(RandomControllor.getIns().getRandom() <= 0.5)
               {
                  m49 = MainGame.getInstance().createMonster(49,-50,100) as Monster49;
                  m49.direct = 1;
               }
               else
               {
                  m49 = MainGame.getInstance().createMonster(49,1010,100) as Monster49;
                  m49.direct = 0;
               }
               this._baoxiangAppearCount = 192;
            }
         }
      }
      
      private function showResult() : void
      {
         TweenMax.delayedCall(1,function(_self:StageListener112):*
         {
            var i:* = 0;
            var result:Stage112Resule = new Stage112Resule(_self._anti.totalJwealNum);
            result.x = 480;
            result.y = 250;
            GMain.getInstance().getTopSence().addChild(result);
            if(gc.player1)
            {
               for(i = uint(0); i < _self._anti.totalJwealNum; )
               {
                  gc.putQhsInBackPack(gc.player1,"wpzz");
                  i++;
               }
            }
         },[this]);
      }
      
      override public function start() : void
      {
         super.start();
         gc.threebossChanllenge[1] = 1;
         if(!this._stage112Info)
         {
            this._stage112Info = new Stage112Info();
            this._stage112Info.x = 480;
            this._stage112Info.y = 70;
            if(gc.gameInfo)
            {
               gc.gameInfo.addChild(this._stage112Info);
            }
         }
      }
      
      private function checkFishAppear() : void
      {
         var m50:* = null;
         var m51:* = null;
         var randX:int = 480 + (RandomControllor.getIns().getRandom() - 0.5) * 960;
         if(RandomControllor.getIns().getRandom() <= 0.1)
         {
            m50 = MainGame.getInstance().createMonster(50,randX,450) as Monster50;
            if(randX < 480)
            {
               m50.getBBDC().turnRight();
            }
            else
            {
               m50.getBBDC().turnLeft();
            }
         }
         else
         {
            m51 = MainGame.getInstance().createMonster(51,randX,450) as Monster51;
            if(randX < 480)
            {
               m51.getBBDC().turnRight();
            }
            else
            {
               m51.getBBDC().turnLeft();
            }
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(this._stage112Info)
         {
            this._stage112Info.destroy();
            this._stage112Info = null;
         }
         this.jwealArray.length = 0;
      }
   }
}
