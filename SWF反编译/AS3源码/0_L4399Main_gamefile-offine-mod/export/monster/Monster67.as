package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import export.level.StageListener151;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class Monster67 extends BaseMonster
   {
       
      
      private var m68:Monster68;
      
      private var m68BG:Bitmap;
      
      private var updateInterval:uint = 0;
      
      private var updateIntervalCount:uint = 0;
      
      public function Monster67()
      {
         super();
         this.horizenSpeed = 0;
         this.normalAttackRate = 0.4;
         this._anti.def = 0;
         this._anti.exp = 3800;
         this._anti.gxp = 1900;
         this._anti.power = 40;
         this.setHp(15000);
         this.setSHp(15000);
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":99,
            "power":this._anti.power,
            "attackKind":"magic"
         };
         this.attackRange = 2000;
         this.alertRange = 2000;
         this.isFly = false;
         this.graity = 0;
         this.isBoss = true;
         this.monsterName = "饕餮";
         this.setAction("wait");
         this.setToCountSuppressLevel(40);
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [];
         this._anti.updateTimes = 10;
         this.updateInterval = gc.frameClips * (17 - gc.getAverageLevel() / 10);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster67");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],400,400,new Point(0,0));
            bbdc.setOffsetXY(9,-15);
            bbdc.setFrameStopCount([[10],[10]]);
            bbdc.setFrameCount([1,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster67--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override protected function __added(evt:Event) : void
      {
         super.__added(evt);
         this.m68BG = AUtils.getImageObj("Monster67Body") as Bitmap;
         this.m68BG.addEventListener("addedToStage",__m68bgadded,false,0,true);
         this.m68BG.x = this.x - 410;
         this.m68BG.y = this.y - 150;
         var idx1:int = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(this.m68BG,idx1);
      }
      
      private function __m68bgadded(evt:Event) : void
      {
         this.m68 = new Monster68();
         this.m68.x = this.x + 5;
         this.m68.y = this.y + 245;
         var idx2:int = gc.gameSence.getChildIndex(this.m68BG);
         gc.gameSence.addChildAt(this.m68,idx2);
         gc.pWorld.monsterArray.push(this.m68);
      }
      
      override public function setAction(str:String) : void
      {
         str = str;
         if(str == "hurt")
         {
            return;
         }
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
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               this.destroy();
               this.dropAura();
               if(this.m68BG)
               {
                  TweenMax.to(this.m68BG,1,{
                     "alpha":0,
                     "onComplete":function(_bm:Bitmap):*
                     {
                        _bm = null;
                     },
                     "onCompleteParams":[this.m68BG]
                  });
               }
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
               if(this.bbdc.getCurFrameCount() == 10)
               {
                  this.doHi1(direct);
               }
            }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster67Bullet1Buff");
         if(direct == 0)
         {
            b.x = this.x - 0;
         }
         else
         {
            b.x = this.x + 0;
         }
         b.y = this.y;
         b.setRole(this);
         b.setDisable();
         b.setFuncWhenDestroy(dohit1_2);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function dohit1_2(bb:BaseBullet) : void
      {
         var b:* = null;
         var point:* = null;
         for each(var bh in gc.getPlayerAndPetArray())
         {
            b = new EnemyMoveBullet("Monster67Bullet1");
            b.x = this.x;
            b.y = this.y;
            b.setRole(this);
            point = AUtils.GetNextPointByTwoObj(this,bh);
            b.setSpeed(point.x * 2,point.y * 2);
            b.setAddSpeed(point.x * 0.7,point.y * 0.7);
            b.setDistance(1500);
            b.setDestroyWhenLastFrame(false);
            b.setDirect(0);
            b.setAction("hit1");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
         }
      }
      
      override protected function move() : void
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
         if(this.updateIntervalCount < this.updateInterval)
         {
            this.updateIntervalCount++;
            if(this.updateIntervalCount == this.updateInterval)
            {
               this.update();
               this.updateIntervalCount = 0;
            }
         }
      }
      
      private function update() : void
      {
         if(this._anti.updateTimes > 0)
         {
            gc.ts.setTxt("小心!饕餮能力大幅度加强",4);
            gc.stage.addChild(gc.ts);
            this.setHp(this.getHp() * 2);
            this.setSHp(this.getSHp() * 2);
            this._anti.power *= 2;
            this.attackBackInfoDict["hit1"] = {
               "hitMaxCount":99,
               "attackBackSpeed":[6,-5],
               "attackInterval":99,
               "power":this._anti.power,
               "attackKind":"magic"
            };
            this._anti.updateTimes--;
         }
      }
      
      override public function destroy() : void
      {
         if(this.getHp() <= 0)
         {
            if(this.m68)
            {
               if(gc.pWorld.getBaseLevelListener() is StageListener151)
               {
                  TweenMax.delayedCall(4,function(_m68:Monster68):*
                  {
                     StageListener151(gc.pWorld.getBaseLevelListener()).showResult(_m68.getTotalLonghun());
                  },[this.m68]);
               }
            }
         }
         super.destroy();
         if(this.m68)
         {
            this.m68.addLonghuns(10);
            this.m68.visible = false;
            TweenMax.delayedCall(4,function(_m68:Monster68):*
            {
               if(!_m68.isReadyToDestroy)
               {
                  _m68.destroy();
                  _m68 = null;
               }
            },[this.m68]);
         }
      }
   }
}
