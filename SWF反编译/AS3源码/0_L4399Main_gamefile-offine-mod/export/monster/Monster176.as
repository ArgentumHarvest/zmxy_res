package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster176 extends BaseMonster
   {
       
      
      public function Monster176()
      {
         super();
         this.normalAttackRate = 0.8;
         this.horizenSpeed = 4;
         this.isCanBeCatchSkill = true;
         this.setAction("wait");
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
         this.skillCD1 = [gc.frameClips * (int(1 + RandomControllor.getIns().getRandom() * 10)),gc.frameClips * 15];
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
      }
      
      override public function setLevel(v:uint) : void
      {
         if(gc.curStageAndCurLevel.curStage == 54)
         {
            this.setHp(250000 * v);
            this.setSHp(250000 * v);
            this._anti.def = 25 * v;
            this._anti.exp = 100 * v;
            this._anti.gxp = 500;
            this._anti.mDef = 0.025 * v;
            this.attackBackInfoDict["hit1"] = {
               "hitMaxCount":99,
               "attackBackSpeed":[6,-5],
               "attackInterval":999,
               "power":100 * v,
               "attackKind":"physics"
            };
            this.attackBackInfoDict["hit2"] = {
               "hitMaxCount":99,
               "attackBackSpeed":[6,-5],
               "attackInterval":999,
               "power":500 * v,
               "attackKind":"physics"
            };
            this._anti.fallProbability = 0.02 * v;
            this._anti.fallList = [{
               "name":"xns1",
               "bigtype":"dj"
            }];
            this.curAddEffect.add([{
               "name":"father",
               "time":gc.frameClips * 1,
               "interval":1000,
               "isForever":1
            }]);
         }
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster176");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(10,5);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,10],[20]]);
            bbdc.setFrameCount([6,4,1,5,2,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster176--BitmapData Error!");
      }
      
      public function setType(type:uint) : void
      {
         type = 1;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster176_" + type);
         this.bbdc.replaceBitmapDataByName("body",bmdArray);
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite2") as Sprite;
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
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               this.setStatic();
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
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
            case "hit1":
               this.setAction("wait");
               break;
            case "hit2":
               this.setStatic();
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
               this.dropAura();
               this.destroy();
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         switch(state)
         {
            case "hit1":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     this.doHi2(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 450;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(10);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster176Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 145;
         }
         else
         {
            b.x = this.x + 145;
         }
         b.y = this.y - 25;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:* = null;
         var num:* = 0;
         var i:* = 0;
         if(this.curAttackTarget)
         {
            num = uint(3 + RandomControllor.getIns().getRandom() * 3);
            for(i = uint(0); i < num; )
            {
               b = new EnemyMoveBullet("Monster176Bullet2");
               b.x = this.curAttackTarget.x + (RandomControllor.getIns().getRandom() - 0.5) * 500;
               b.y = (RandomControllor.getIns().getRandom() - 0.5) * 100;
               b.setSpeed(0,1);
               b.setAddSpeed(0,0.5);
               b.setDestroyWhenLastFrame(false);
               b.setDistance(600);
               b.setRole(this);
               b.setDirect(direct);
               b.setAction("hit2");
               gc.gameSence.addChild(b);
               this.magicBulletArray.push(b);
               i++;
            }
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
