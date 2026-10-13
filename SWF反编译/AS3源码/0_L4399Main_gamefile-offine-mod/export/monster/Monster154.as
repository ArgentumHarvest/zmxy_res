package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import flash.events.Event;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster154 extends BaseMonster
   {
       
      
      public function Monster154()
      {
         super();
         this.horizenSpeed = 8;
         this.setHp(1000000);
         this.setSHp(1000000);
         this.normalAttackRate = 0.25;
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.mDef = 0;
         this._anti.def = 0;
         this._anti.exp = 0;
         this._anti.gxp = 100;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":5,
            "attackKind":"physics"
         };
         this.isBoss = false;
         this.setAction("wait");
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
         this.isFly = true;
         this.graity = 0;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster154");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],140,196,new Point(0,0));
            bbdc.setOffsetXY(0,0);
            bbdc.setFrameStopCount([[2,2,2,3,3,2,2]]);
            bbdc.setFrameCount([7]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster154--BitmapData Error!");
      }
      
      override protected function __added(evt:Event) : void
      {
         super.__added(evt);
         this.goRight();
      }
      
      override protected function newColipse() : void
      {
         this.colipse = this.body;
         this.addChild(this.colipse);
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,canHurt);
      }
      
      override public function setAction(str:String) : void
      {
         var rand:Number = NaN;
         var dl:Number = NaN;
         super.setAction(str);
         var curPoint:Point = this.bbdc.getCurPoint();
         switch(str)
         {
            case "wait":
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "walk":
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               rand = RandomControllor.getIns().getRandom();
               if(rand < 0.7)
               {
                  gc.setNewYearThreeTreasure("bz",1);
                  gc.ts.setTxt("获得鞭炮x1");
                  gc.stage.addChild(gc.ts);
               }
               else if(rand < 0.9)
               {
                  gc.setNewYearThreeTreasure("yh",1);
                  gc.ts.setTxt("获得烟花x1");
                  gc.stage.addChild(gc.ts);
               }
               dl = gc.getNewYearThreeTreasure("dl");
               if(dl > 0)
               {
                  gc.setNewYearThreeTreasure("dl",-1);
                  gc.eventManger.dispatchEvent(new Event("DLREFRESH"));
               }
               this.setHp(0);
               this.setAction("dead");
               break;
            case "dead":
               this.dropAura();
               this.destroy();
         }
      }
      
      override protected function scriptFrameOverFunc(row:int) : void
      {
         var state:String = this.bbdc.getState();
         switch(state)
         {
            case "walk":
               this.bbdc.setFramePointX(0);
               break;
            case "wait":
               this.bbdc.setFramePointX(0);
               break;
            case "dead":
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         state;
      }
      
      override protected function turnLeft() : *
      {
      }
      
      override protected function turnRight() : *
      {
      }
      
      private function goLeft() : void
      {
         var randTime:Number = 0.5 + RandomControllor.getIns().getRandom();
         var offsetX:Number = 30 + RandomControllor.getIns().getRandom() * 50;
         TweenMax.to(this,randTime,{
            "x":this.x - offsetX,
            "onComplete":goRight
         });
      }
      
      private function goRight() : void
      {
         var randTime:Number = 0.5 + RandomControllor.getIns().getRandom();
         var offsetX:Number = 30 + RandomControllor.getIns().getRandom() * 50;
         TweenMax.to(this,randTime,{
            "x":this.x + offsetX,
            "onComplete":goLeft
         });
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function addCurAddEffect(arr:Array) : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
         this.y -= 3;
         if(this.y < -600)
         {
            this.destroy();
         }
      }
      
      override protected function drawMonsterHp() : void
      {
      }
      
      override protected function move() : void
      {
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
