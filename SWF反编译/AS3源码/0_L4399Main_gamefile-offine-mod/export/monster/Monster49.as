package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import export.bullet.FollowBaseObjectBullet;
   import export.level.StageListener112;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster49 extends BaseMonster
   {
       
      
      private var _direct:uint = 0;
      
      private var timeCount:uint = 0;
      
      private var speedValue:uint = 10;
      
      private var jwealNum:uint = 0;
      
      private var _lv:uint;
      
      public function Monster49()
      {
         super();
         this.horizenSpeed = 8;
         this._lv = 999;
         var _loc3_:int = 0;
         var _loc2_:* = gc.getPlayerArray();
         for each(var bh in _loc2_)
         {
            this._lv = bh.roleProperies.getLevel();
         }
         this.setHp(this._lv * this._lv * 10);
         this.setSHp(this._lv * this._lv * 10);
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
         this.timeCount = gc.frameClips * 10;
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
      }
      
      public function get direct() : uint
      {
         return _direct;
      }
      
      public function set direct(value:uint) : void
      {
         _direct = value;
         if(_direct == 1)
         {
            this.bbdc.turnRight();
         }
         else
         {
            this.bbdc.turnLeft();
         }
         this.speedValue = 5 + RandomControllor.getIns().getRandom() * 8;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster49");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],125,125,new Point(0,0));
            bbdc.setOffsetXY(0,0);
            bbdc.setFrameStopCount([[2,2,2,5,2,2]]);
            bbdc.setFrameCount([6]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster49--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ShaiZiObjectSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
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
               this.bbdc.setFramePointX(0);
               break;
            case "wait":
               this.bbdc.setFramePointX(0);
               break;
            case "hurt":
               this.setAction("wait");
               break;
            case "hit1":
               this.setAction("wait");
               break;
            case "dead":
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         var _loc4_:* = state;
         if("hit1" === _loc4_)
         {
            if(p.x == 0)
            {
               if(this.bbdc.getCurFrameCount() == 2)
               {
                  this.doHi1(direct);
               }
            }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster49Bullet1");
         b.x = this.x;
         b.y = this.y;
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips);
         b.setHurtCanCutDownEffect(false);
         b.setRole(this);
         b.setDirect(direct);
         b.setFuncWhenHit(hit1WhenHit);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function hit1WhenHit(bb:BaseBullet) : void
      {
         var num:uint = this._lv * 0.1;
         num = num < 1 ? 1 : num;
         if(gc.pWorld.getBaseLevelListener() is StageListener112)
         {
            if(StageListener112(gc.pWorld.getBaseLevelListener()).totalJwealNum <= num)
            {
               num = StageListener112(gc.pWorld.getBaseLevelListener()).totalJwealNum;
               StageListener112(gc.pWorld.getBaseLevelListener()).totalJwealNum = 0;
            }
            else
            {
               StageListener112(gc.pWorld.getBaseLevelListener()).totalJwealNum = StageListener112(gc.pWorld.getBaseLevelListener()).totalJwealNum - num;
            }
         }
         this.jwealNum += num;
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         super.myIntelligence();
         if(this.timeCount > 0)
         {
            this.timeCount--;
            if(this.timeCount == 0)
            {
               this.destroy();
            }
         }
         if(this.curAttackTarget)
         {
            if(this.y - this.curAttackTarget.y >= 100)
            {
               if(this._direct == 1)
               {
                  if(this.x < this.curAttackTarget.x)
                  {
                     this.jump();
                  }
               }
               else if(this.x > this.curAttackTarget.x)
               {
                  this.jump();
               }
            }
         }
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
         if(this._direct == 1)
         {
            this.speed.x = speedValue;
         }
         else
         {
            this.speed.x = -speedValue;
         }
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
