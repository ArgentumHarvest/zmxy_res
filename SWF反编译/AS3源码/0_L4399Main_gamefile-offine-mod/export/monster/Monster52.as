package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import export.level.StageListener113;
   import flash.geom.Point;
   
   public class Monster52 extends BaseMonster
   {
       
      
      private var _kind:uint;
      
      private var CHANGE_STATE_COUNT:int = 120;
      
      private var turnToKind1Count:int;
      
      public function Monster52()
      {
         turnToKind1Count = CHANGE_STATE_COUNT;
         super();
         this.horizenSpeed = 8;
         this.setHp(1000000);
         this.setSHp(1000000);
         this.normalAttackRate = 0.25;
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.mDef = 0;
         this._anti.def = 0;
         this._anti.exp = 4;
         this._anti.gxp = 1;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":5,
            "attackKind":"physics"
         };
         this.isBoss = false;
         this.setKind(1);
         this.setAction("wait");
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
         this.CHANGE_STATE_COUNT = 24 * (43 - gc.getAverageLevel() / 2);
         this.turnToKind1Count = CHANGE_STATE_COUNT;
      }
      
      public function setKind(k:uint) : void
      {
         this._kind = k;
         this.setAction(this.curAction);
         if(this._kind == 1)
         {
            this._anti.mDef = 0.99;
            this._anti.def = 999999;
         }
         else if(this._kind == 2)
         {
            this._anti.mDef = 0;
            this._anti.def = 0;
         }
      }
      
      public function getKind() : uint
      {
         return this._kind;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster52");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,285,new Point(0,0));
            bbdc.setOffsetXY(0,0);
            bbdc.setFrameStopCount([[999],[999]]);
            bbdc.setFrameCount([1,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster52--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = this.body;
         this.addChild(this.colipse);
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         var stageListener113:* = null;
         if(this._kind == 1)
         {
            re = 1;
         }
         super.reduceHp(re,canHurt);
         if(gc.pWorld.getBaseLevelListener() is StageListener113)
         {
            stageListener113 = gc.pWorld.getBaseLevelListener() as StageListener113;
            stageListener113.updateBloodDisplay(this.getSHp() - this.getHp());
         }
      }
      
      override public function setAction(str:String) : void
      {
         super.setAction(str);
         var curPoint:Point = this.bbdc.getCurPoint();
         var pointY:uint = this._kind - 1;
         switch(str)
         {
            case "wait":
               if(curPoint.y != pointY)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(pointY);
               }
               this.bbdc.setState(str);
               break;
            case "walk":
               if(curPoint.y != pointY)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(pointY);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               if(curPoint.y != pointY)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(pointY);
               }
               this.bbdc.setState(str);
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
            case "hurt":
               this.setStatic();
               this.setAction("wait");
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
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
         if(this._kind == 2)
         {
            if(this.turnToKind1Count > 0)
            {
               this.turnToKind1Count--;
               if(this.turnToKind1Count == 0)
               {
                  this.setKind(1);
                  this.turnToKind1Count = CHANGE_STATE_COUNT;
               }
            }
         }
      }
      
      override public function setHp(h:int) : void
      {
         super.setHp(h);
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
