package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import export.level.StageListener481;
   import flash.geom.Point;
   
   public class Monster153 extends BaseMonster
   {
       
      
      public function Monster153()
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
         this._anti.gxp = 0;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":5,
            "attackKind":"physics"
         };
         this.isBoss = false;
         this.setAction("wait");
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"p_cybxjl",
            "bigtype":"cwzb"
         }];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster153");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],160,210,new Point(0,0));
            bbdc.setOffsetXY(0,0);
            bbdc.setFrameStopCount([[3,3,3,3,3,3],[10]]);
            bbdc.setFrameCount([6,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster153--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = this.body;
         this.addChild(this.colipse);
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         var stageListener481:* = null;
         super.reduceHp(re,canHurt);
         if(gc.pWorld.getBaseLevelListener() is StageListener481)
         {
            stageListener481 = gc.pWorld.getBaseLevelListener() as StageListener481;
            stageListener481.updateBloodDisplay(this.getSHp() - this.getHp());
         }
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
            case "hurt":
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
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
