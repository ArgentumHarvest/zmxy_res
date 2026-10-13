package export.level
{
   import base.BaseHero;
   import base.BaseLevelListenering;
   import base.BaseObject;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.level.StageListener113Child.Stage113Info;
   import export.level.StageListener113Child.Stage113Resule;
   import export.level.StageListener113Child.StageListener113Flowers;
   import export.monster.Monster52;
   import flash.display.MovieClip;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class StageListener113 extends BaseLevelListenering
   {
       
      
      private var _waterWave:MovieClip;
      
      private var _peachEffect:MovieClip;
      
      private var _peachMonster:Monster52;
      
      private var _flowerArray:Array;
      
      private const FLOWERAPPEARCOUNTCONST:uint = 192;
      
      private var flowerAppearCount:uint = 192;
      
      private var _stage113Info:Stage113Info;
      
      private var _anti:Antiwear;
      
      public function StageListener113()
      {
         _flowerArray = [];
         super();
         this._anti = new Antiwear(new binaryEncrypt());
         this._anti.timeCount = gc.frameClips * 60;
         this._anti.blood = 0;
      }
      
      override public function step() : void
      {
         var idx:int = 0;
         var isVisible:Boolean = false;
         super.step();
         var temp:Array = [];
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
               gc.keyboardControl.stopAllControl();
               if(this._peachMonster)
               {
                  this._peachMonster.setYourFather(100000);
               }
               return;
            }
         }
         if(this._anti.timeCount < 0)
         {
            return;
         }
         if(this._waterWave)
         {
            if(!this._waterWave.visible)
            {
               for each(var bh in gc.getPlayerArray())
               {
                  if(bh.standInObj)
                  {
                     if(bh.standInObj.width >= 900)
                     {
                        this.showWaterWave();
                     }
                  }
               }
            }
            else
            {
               isVisible = false;
               for each(bh in gc.getPlayerArray())
               {
                  if(bh.standInObj)
                  {
                     if(bh.standInObj.width >= 900)
                     {
                        isVisible = true;
                     }
                  }
               }
               if(!isVisible)
               {
                  this._waterWave.visible = false;
               }
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
         if(this._stage113Info)
         {
            this._stage113Info.updateTimeCountDisplay(this._anti.timeCount / gc.frameClips);
         }
      }
      
      public function updateBloodDisplay(bd:int) : void
      {
         var rate:int = 2;
         this._anti.blood = bd * rate;
         if(this._stage113Info)
         {
            this._stage113Info.updateBloodDisplay(this._anti.blood);
         }
      }
      
      private function showResult() : void
      {
         var expAdd:int = 20000 * this._anti.blood / 1000000;
         if(expAdd > 20000)
         {
            expAdd = 20000;
         }
         TweenMax.delayedCall(1,function(_self:StageListener113):*
         {
            var result:Stage113Resule = new Stage113Resule(expAdd);
            result.x = 480;
            result.y = 250;
            GMain.getInstance().getTopSence().addChild(result);
            for each(var bh in gc.getPlayerArray())
            {
               bh.roleProperies.dispatchEvent(new CommonEvent("AddExper",[expAdd]));
            }
         },[this]);
      }
      
      private function showFlower() : void
      {
         var flower:* = null;
         if(RandomControllor.getIns().getRandom() <= 0.5)
         {
            flower = new StageListener113Flowers(1);
         }
         else
         {
            flower = new StageListener113Flowers(2);
         }
         flower.x = 400 + RandomControllor.getIns().getRandom() * 350;
         flower.y = -10;
         gc.gameSence.addChild(flower);
         this._flowerArray.push(flower);
         var flo:StageListener113Flowers = new StageListener113Flowers(3);
         flo.direct = 2;
         flo.speed.x = -5;
         flo.speed.y = 0;
         flo.x = 1000;
         flo.y = 420;
         gc.gameSence.addChild(flo);
         this._flowerArray.push(flo);
      }
      
      private function showWaterWave() : void
      {
         this._waterWave.visible = true;
         if(this._peachMonster)
         {
            if(this._peachMonster.getKind() == 1)
            {
               this.checkPeachEffect();
            }
         }
      }
      
      private function checkPeachEffect() : void
      {
         if(!this._peachEffect)
         {
            this._peachEffect = AUtils.getNewObj("peachEffect") as MovieClip;
            this._peachEffect.gotoAndPlay(2);
            this._peachEffect.x = 600;
            this._peachEffect.y = -173;
            gc.gameSence.addChild(this._peachEffect);
            TweenMax.delayedCall(1,function(_self:StageListener113):*
            {
               _self._peachMonster.setKind(2);
            },[this]);
            TweenMax.delayedCall(2,function(_self:StageListener113):*
            {
               _self._peachEffect = null;
            },[this]);
         }
      }
      
      override public function start() : void
      {
         super.start();
         gc.threebossChanllenge[2] = 1;
         this._waterWave = gc.gameSence.getChildByNameInBgSprite("waterWave") as MovieClip;
         this._peachEffect = gc.gameSence.getChildByNameInBgSprite("peachEffect") as MovieClip;
         if(!this._peachMonster)
         {
            this._peachMonster = MainGame.getInstance().createMonster(52,656,130) as Monster52;
         }
         for each(var bo in gc.getPlayerAndPetArray())
         {
            bo.x = 300;
            bo.y = 100;
         }
         if(!this._stage113Info)
         {
            this._stage113Info = new Stage113Info();
            this._stage113Info.x = 480;
            this._stage113Info.y = 70;
            if(gc.gameInfo)
            {
               gc.gameInfo.addChild(this._stage113Info);
            }
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this._flowerArray.length = 0;
         this._peachMonster = null;
         this._peachEffect = null;
         this._waterWave = null;
      }
   }
}
