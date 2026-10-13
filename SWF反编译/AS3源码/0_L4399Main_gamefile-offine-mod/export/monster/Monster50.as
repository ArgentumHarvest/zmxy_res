package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import export.level.StageListener112;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster50 extends BaseMonster
   {
       
      
      private var timeCount:uint = 0;
      
      private var speedValue:uint = 10;
      
      private var jwealNum:uint = 3;
      
      public function Monster50()
      {
         super();
         this.horizenSpeed = 8;
         this.setHp(1);
         this.setSHp(1);
         this.normalAttackRate = 1;
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
         this.setAction("wait");
         this.timeCount = gc.frameClips * 5;
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster50");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],100,100,new Point(0,0));
            bbdc.setOffsetXY(0,0);
            bbdc.setFrameStopCount([[999,999,999,999,999]]);
            bbdc.setFrameCount([5]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster50--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ShaiZiObjectSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override protected function checkCanMove() : void
      {
      }
      
      override public function setAction(str:String) : void
      {
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
            case "hit1":
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
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
               this.setAction("dead");
               break;
            case "wait":
               this.setAction("dead");
               break;
            case "hurt":
               this.setAction("dead");
               break;
            case "hit1":
               this.setAction("dead");
               break;
            case "dead":
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         var _loc4_:* = state;
         if(this.bbdc.getCurFrameCount() == 999)
         {
            if(this.bbdc.getDirect() == 0)
            {
               this.speed.x = -12 + RandomControllor.getIns().getRandom() * 5;
            }
            else
            {
               this.speed.x = 12 + RandomControllor.getIns().getRandom() * 5;
            }
            this.speed.y = -25 - RandomControllor.getIns().getRandom() * 5;
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function step() : void
      {
         if(this.timeCount > 0)
         {
            this.timeCount--;
            if(this.timeCount == 0)
            {
               this.destroy();
            }
         }
         this.checkRotation();
         if(this.bbdc)
         {
            this.bbdc.step();
         }
         this.move();
      }
      
      private function checkRotation() : void
      {
         var angle:Number = NaN;
         var rota:Number = 0;
         if(this.speed.y != 0)
         {
            angle = 0;
            if(this.speed.x < 0 && this.speed.y > 0)
            {
               angle = Math.atan(Math.abs(this.speed.x / this.speed.y));
               angle += 3.14;
            }
            else if(this.speed.x > 0 && this.speed.y > 0)
            {
               angle = Math.atan(Math.abs(this.speed.y / this.speed.x));
               angle += 1.57;
            }
            else if(this.speed.x > 0 && this.speed.y < 0)
            {
               angle = Math.atan(Math.abs(this.speed.x / this.speed.y));
            }
            else if(this.speed.x < 0 && this.speed.y < 0)
            {
               angle = -Math.atan(Math.abs(this.speed.x / this.speed.y));
            }
            rota = angle * 180 / 3.141592653589793;
         }
         else if(this.speed.x < 0)
         {
            rota = 270;
         }
         else
         {
            rota = 90;
         }
         this.rotation = rota;
      }
      
      override protected function hasAttackTarget() : void
      {
      }
      
      override protected function turnLeft() : *
      {
      }
      
      override protected function turnRight() : *
      {
      }
      
      override public function setAttackBack(p:Point) : void
      {
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,false);
      }
      
      override protected function move() : void
      {
         super.move();
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return true;
      }
      
      override public function destroy() : void
      {
         if(this.getHp() <= 0)
         {
            if(gc.pWorld.getBaseLevelListener() is StageListener112)
            {
               StageListener112(gc.pWorld.getBaseLevelListener()).fallDownJweal(1,this.jwealNum,new Point(this.x,this.y));
            }
         }
         super.destroy();
      }
   }
}
