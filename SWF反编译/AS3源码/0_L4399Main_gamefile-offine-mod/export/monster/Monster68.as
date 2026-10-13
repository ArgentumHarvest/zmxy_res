package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.bullet.EnemyMoveBullet;
   import export.level.StageListener151;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.HitTest;
   
   public class Monster68 extends BaseMonster
   {
       
      
      private var status:uint = 0;
      
      private var changeStatusInterval:uint = 10;
      
      private var hit1Count:uint = 3;
      
      private var hit1CurrentCount:uint = 0;
      
      public function Monster68()
      {
         super();
         this.horizenSpeed = 0;
         this.normalAttackRate = 0.7;
         this._anti.def = 0;
         this._anti.exp = 3800;
         this._anti.gxp = 1900;
         this.setHp(14000);
         this.setSHp(14000);
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":99,
            "power":28,
            "attackKind":"physics"
         };
         this.attackRange = 2000;
         this.alertRange = 2000;
         this.isFly = false;
         this.graity = 0;
         this.isBoss = false;
         this.setAction("wait");
         this._anti.fallProbability = 0.1;
         this._anti.totalLonghun = 0;
         this._anti.fallList = [];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster68");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(9,-15);
            bbdc.setFrameStopCount([[10],[2,2,2,gc.frameClips * 6]]);
            bbdc.setFrameCount([1,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster68--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         if(str == "hurt" || str == "walk")
         {
            return;
         }
         super.setAction(str);
         var curPoint:Point = this.bbdc.getCurPoint();
         switch(str)
         {
            case "wait":
               this.setYourFather(gc.frameClips * this.changeStatusInterval);
               TweenMax.delayedCall(10,changeToHit1);
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               this.setYourFather(1);
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
         }
      }
      
      private function changeToHit1() : void
      {
         trace("可以打了");
         this.setAction("hit1");
         this.hit1CurrentCount = 0;
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
      }
      
      override public function addMonHurtMc(_hurt:int, isCrit:Boolean, _isShadow:Boolean = false) : *
      {
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
               this.setAction("wait");
               break;
            case "dead":
         }
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         var flag:Boolean = super.beMagicAttack(_target,sr,force);
         if(flag)
         {
            this.hit1CurrentCount++;
            if(this.hit1CurrentCount >= this.hit1Count)
            {
               this.setAction("wait");
               this.addLonghuns(2);
            }
         }
         return flag;
      }
      
      private function addLonghun() : void
      {
         var b:EnemyMoveBullet = new EnemyMoveBullet("Stage151LongHun");
         b.x = 400 + (RandomControllor.getIns().getRandom() - 0.5) * 800;
         b.y = this.y - 400;
         b.setRole(this);
         b.setSpeed(0,2);
         b.setAddSpeed(0,0.1);
         b.setDistance(1500);
         b.setDisable();
         b.setFuncWhenEnterFrame(checkHit);
         b.setDestroyWhenLastFrame(false);
         b.setDirect(0);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      public function addLonghuns(len:uint) : void
      {
         var i:* = 0;
         for(i = uint(0); i < len; )
         {
            this.addLonghun();
            i++;
         }
      }
      
      private function checkHit(bbb:BaseBullet) : void
      {
         bbb = bbb;
         for each(bb in this.magicBulletArray)
         {
            if(bb.speed.y != 0)
            {
               for each(bo in gc.getPlayerAndPetArray())
               {
                  if(HitTest.complexHitTestObject(bo.colipse,bb))
                  {
                     this._anti.totalLonghun++;
                     if(gc.pWorld.getBaseLevelListener() is StageListener151)
                     {
                        StageListener151(gc.pWorld.getBaseLevelListener()).updateLonghunInfo(this._anti.totalLonghun);
                     }
                     bb.setSpeed(0,0);
                     bb.setAddSpeed(0,0);
                     TweenMax.to(bb,1,{
                        "y":this.y - 80,
                        "alpha":0,
                        "onComplete":function(_bb:EnemyMoveBullet):*
                        {
                           _bb.destroy();
                        },
                        "onCompleteParams":[bb]
                     });
                  }
               }
            }
         }
      }
      
      public function getTotalLonghun() : uint
      {
         return this._anti.totalLonghun;
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         var _loc4_:* = state;
         if("hit1" !== _loc4_)
         {
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
      }
   }
}
