package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import export.level.StageListener172;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class Monster108 extends BaseMonster
   {
       
      
      private var hit1Count:int = 96;
      
      private var backCount:int = 96;
      
      private var positionArray:Array;
      
      private var backType:int;
      
      private var backArray:Array;
      
      private var outIndexArray:Array;
      
      private var stepCount:int = 0;
      
      private var thisBG:MovieClip;
      
      public function Monster108()
      {
         positionArray = [[70,460],[185,460],[300,460],[415,460],[530,460],[645,460],[760,460],[875,460]];
         backArray = [[0,1,2,3],[4,5,6,7],[0,2,4,6],[1,3,5,7]];
         outIndexArray = [0,1,2,3,4,5,6,7];
         super();
         this.horizenSpeed = 5;
         this.setHp(1000000);
         this.setSHp(1000000);
         this.normalAttackRate = 0.6;
         this.attackRange = 300;
         this.alertRange = 1000;
         this._anti.def = 0;
         this._anti.exp = 1000;
         this._anti.gxp = 500;
         this._anti.mDef = 0.2;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":48,
            "power":1000,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "转轮王";
         this.setAction("wait");
         this._anti.fallProbability = 1;
         this._anti.fallList = [{
            "name":"ttlpsp2",
            "bigtype":"dj"
         }];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster108");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(5,-5);
            bbdc.setFrameStopCount([[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]]);
            bbdc.setFrameCount([19]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster108--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("Monster104ObjectSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override protected function __added(evt:Event) : void
      {
         super.__added(evt);
         this.thisBG = AUtils.getNewObj("Monster108BG") as MovieClip;
         this.thisBG.x = this.x - 20;
         this.thisBG.y = this.y + 40;
         var idx:int = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(this.thisBG,idx);
         this.thisBG.gotoAndStop(1);
         if(gc.pWorld.getBaseLevelListener() is StageListener172)
         {
            StageListener172(gc.pWorld.getBaseLevelListener()).showMovingFloor();
            StageListener172(gc.pWorld.getBaseLevelListener()).showStandingFloor();
         }
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override protected function myIntelligence() : void
      {
         if(stepCount == 0)
         {
            if(hit1Count > 0)
            {
               hit1Count--;
               if(hit1Count == 0)
               {
                  this.doHit1();
                  hit1Count = 96;
               }
            }
         }
         else if(stepCount == 1)
         {
            if(backCount > 0)
            {
               backCount--;
               if(backCount == 0)
               {
                  this.back();
                  backCount = 96;
               }
            }
         }
      }
      
      override protected function checkCanMove() : void
      {
      }
      
      override protected function move() : void
      {
      }
      
      private function doHit1() : void
      {
         var b:EnemyMoveBullet = new EnemyMoveBullet("Monster107Bullet3");
         b.x = this.x;
         b.y = this.y - 50;
         b.setRole(this);
         b.setSpeed(0,0);
         b.setDistance(1000);
         b.setDestroyWhenLastFrame(false);
         b.setAction("hit1");
         gc.gameSence.addChildAt(b,gc.gameSence.getChildIndex(this) + 1);
         this.magicBulletArray.push(b);
         var idx:int = int(RandomControllor.getIns().getRandom() * this.outIndexArray.length);
         var posIdx:int = this.outIndexArray[idx];
         this.outIndexArray.splice(idx,1);
         var p:Point = gc.gameSence.globalToLocal(new Point(positionArray[posIdx][0],positionArray[posIdx][1]));
         TweenMax.to(b,2,{
            "x":p.x,
            "y":p.y,
            "onComplete":function(_self:Monster108):*
            {
               if(_self.magicBulletArray.length == 8)
               {
                  _self.stepCount = 1;
               }
            },
            "onCompleteParams":[this]
         });
         this.thisBG.gotoAndStop(this.thisBG.currentFrame + 1);
      }
      
      private function back() : void
      {
         var indexArray:Array = this.backArray[this.backType] as Array;
         if(this.magicBulletArray.length == 8)
         {
            for(var i:int = 0; i < this.magicBulletArray.length; )
            {
               var seb:BaseBullet = this.magicBulletArray[i] as BaseBullet;
               if(indexArray.indexOf(i) != -1)
               {
                  TweenMax.to(seb,1,{
                     "x":this.x + this.colipse.x,
                     "y":this.y + this.colipse.y,
                     "onCompleteParams":[seb,this],
                     "onComplete":function(s:BaseBullet, _self:Monster108):*
                     {
                        s.destroy();
                        _self.thisBG.gotoAndStop(5);
                     }
                  });
               }
               i++;
            }
         }
         else
         {
            for(i = 0; i < this.magicBulletArray.length; )
            {
               seb = this.magicBulletArray[i] as BaseBullet;
               TweenMax.to(seb,1,{
                  "x":this.x + this.colipse.x,
                  "y":this.y + this.colipse.y,
                  "onCompleteParams":[seb,this],
                  "onComplete":function(s:BaseBullet, _self:Monster108):*
                  {
                     s.destroy();
                     stepCount = 0;
                     outIndexArray = [0,1,2,3,4,5,6,7];
                     _self.thisBG.gotoAndStop(1);
                  }
               });
               i++;
            }
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
            case "dead":
               this.setYourFather(10);
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
         state;
      }
      
      override protected function attackTarget() : void
      {
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster107Bullet2");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster107Bullet1");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(this.thisBG)
         {
            if(this.thisBG.parent)
            {
               this.thisBG.parent.removeChild(this.thisBG);
            }
         }
         if(this.getHp() <= 0)
         {
            if(this.isBoss)
            {
               var ta:Array = gc.pWorld.getTransferDoorArray();
               for(var i:int = 0; i < ta.length; )
               {
                  var mc:MovieClip = ta[i];
                  mc.visible = true;
                  i++;
               }
            }
         }
         TweenMax.delayedCall(5,function(_self:Monster108):*
         {
            _self.callMonster109();
         },[this]);
      }
      
      private function callMonster109() : void
      {
         var i:int = 0;
         var mc:* = null;
         var ta:Array = gc.pWorld.getTransferDoorArray();
         for(i = 0; i < ta.length; )
         {
            mc = ta[i];
            mc.visible = false;
            i++;
         }
         MainGame.getInstance().createMonster(109,600,300);
      }
   }
}
