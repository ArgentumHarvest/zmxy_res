package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import base.BaseObject;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster126 extends BaseMonster
   {
       
      
      public function Monster126()
      {
         var addBeishu:Number = NaN;
         super();
         this.horizenSpeed = 4;
         this.setHp(110000);
         this.setSHp(110000);
         this._anti.def = 100;
         this._anti.exp = 500;
         this._anti.gxp = 250;
         this._anti.mDef = 0.1;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":800,
            "power":900,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":900,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.POISON,
               "time":gc.frameClips * 3,
               "power":900
            }]
         };
         this.attackRange = 250;
         this.alertRange = 1000;
         this.isBoss = false;
         this.setAction("wait");
         this._anti.fallProbability = 0.1;
         if(gc.curStageAndCurLevel.curStage == 23 || gc.curStageAndCurLevel.curStage == 25)
         {
            addBeishu = 2;
            if(gc.curStageAndCurLevel.curStage == 25)
            {
               addBeishu = 3;
            }
            this._anti.fallList = [{
               "name":"wpxt",
               "bigtype":"dj"
            }];
            this.setHp(110000 * addBeishu);
            this.setSHp(110000 * addBeishu);
            this._anti.def = 100 * addBeishu;
            this._anti.exp = 500 * addBeishu;
            this._anti.gxp = 250 * addBeishu;
            this._anti.mDef = 0.1 * addBeishu;
            this.attackBackInfoDict["hit1"] = {
               "hitMaxCount":99,
               "attackBackSpeed":[6,-5],
               "attackInterval":800,
               "power":900 * addBeishu,
               "attackKind":"magic"
            };
            this.attackBackInfoDict["hit2"] = {
               "hitMaxCount":1,
               "attackBackSpeed":[0,0],
               "attackInterval":999,
               "power":900 * addBeishu,
               "attackKind":"magic",
               "addEffect":[{
                  "name":BaseAddEffect.POISON,
                  "time":gc.frameClips * 3,
                  "power":900
               }]
            };
         }
         else
         {
            this._anti.fallList = [];
         }
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster126");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
            bbdc.setOffsetXY(5,-8);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,10,144],[2,2,10]]);
            bbdc.setFrameCount([6,1,6,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster126--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
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
            case "hurt":
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               this.setYourFather(999);
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
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
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "dead":
               if(p.x == 5)
               {
                  if(this.bbdc.getCurFrameCount() == 144)
                  {
                     this.doWhenDead(direct);
                  }
               }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster126Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 60;
         }
         else
         {
            b.x = this.x + 60;
         }
         b.y = this.y - 10;
         b.setFuncWhenDestroy(dohit1_2);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function dohit1_2(bb:BaseBullet) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster126Bullet1_2");
         if(bb.getDirect() == -1)
         {
            b.x = bb.x - 190;
         }
         else
         {
            b.x = bb.x + 190;
         }
         b.y = bb.y + 50;
         b.setRole(this);
         b.setDirect(0);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doWhenDead(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster126Bullet2_1");
         b.x = this.x;
         b.y = this.y - 30;
         b.setRole(this);
         b.setDisable();
         b.setFuncWhenDestroy(deadFunction);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function deadFunction(bb:BaseBullet) : void
      {
         var b:* = null;
         var point:* = null;
         var targetArray:Array = gc.getPlayerAndPetArray();
         var randBo:BaseObject = targetArray[int(RandomControllor.getIns().getRandom() * targetArray.length)] as BaseObject;
         if(randBo)
         {
            b = new EnemyMoveBullet("Monster126Bullet2_2");
            b.x = bb.x;
            b.y = bb.y;
            b.setRole(this);
            point = AUtils.GetNextPointByTwoObj(this,randBo);
            b.setSpeed(point.x * 1,point.y * 1);
            b.setAddSpeed(point.x,point.y);
            b.setDistance(1000);
            b.setDestroyWhenLastFrame(false);
            b.setDirect(0);
            b.setAction("hit2");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
         }
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
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
