package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import my.MainGame;
   
   public class Monster107 extends BaseMonster
   {
       
      
      private var roundArray:Array;
      
      private var isAllRoundsOutOver:Boolean = false;
      
      private var maxRoundCount:int = 6;
      
      private var totalRoundObject:Object;
      
      private var monster107Back:MovieClip;
      
      public function Monster107()
      {
         roundArray = [];
         totalRoundObject = {"value":maxRoundCount};
         super();
         this.horizenSpeed = 5;
         this.setHp(200000);
         this.setSHp(200000);
         this.normalAttackRate = 0.6;
         this.attackRange = 300;
         this.alertRange = 1000;
         this._anti.def = 300;
         this._anti.exp = 1000;
         this._anti.gxp = 500;
         this._anti.mDef = 0.4;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":800,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-5,0],
            "attackInterval":5,
            "power":100,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[0,0],
            "attackInterval":48,
            "power":300,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "转轮王";
         this.setAction("wait");
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
         this.skillCD1 = [gc.frameClips * 4,gc.frameClips * 8];
         this.skillCD2 = [gc.frameClips * 6,gc.frameClips * 12];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster107");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
            bbdc.setOffsetXY(-35,-65);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,2,2,2],[8],[2,2,2,29,10],[2,58],[10]]);
            bbdc.setFrameCount([6,6,1,5,2,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster107--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite2") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override protected function __added(evt:Event) : void
      {
         super.__added(evt);
         this.monster107Back = AUtils.getNewObj("Monster107Back") as MovieClip;
         this.monster107Back.obj.gotoAndStop(1);
         var idx:int = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(this.monster107Back,idx);
      }
      
      override public function step() : void
      {
         super.step();
         if(this.monster107Back)
         {
            this.monster107Back.x = this.x;
            this.monster107Back.y = this.y - 60;
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
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
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
            case "hit2":
               this.setAction("wait");
               break;
            case "hit3":
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
         switch(state)
         {
            case "hit1":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 58)
                  {
                     this.doHi2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi3(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= 400;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return true;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(45);
         this.setAction("hit1");
         this.lastHit = "hit1";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(60);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function attackTarget() : void
      {
         if(this.getRoundValue() > 0 || this.isAllRoundsOutOver)
         {
            this.faceToTarget();
            this.newAttackId();
            this.setAction("hit3");
            this.lastHit = "hit3";
         }
      }
      
      private function doHi3(direct:uint) : void
      {
         direct = direct;
         if(this.getRoundValue() > 0)
         {
            if(this.curAttackTarget)
            {
               var b:EnemyMoveBullet = new EnemyMoveBullet("Monster107Bullet3");
               b.x = this.x;
               b.y = this.y;
               b.setRole(this);
               var point:Point = AUtils.GetNextPointByTwoObj(this,this.curAttackTarget);
               b.setSpeed(point.x * 10,point.y * 10);
               var dis:Number = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) + 40;
               b.setDistance(dis,this.doHit3_2);
               b.setDestroyWhenLastFrame(false);
               b.setAction("hit3");
               gc.gameSence.addChild(b);
               this.magicBulletArray.push(b);
            }
            this.reduceRound();
         }
         else if(this.isAllRoundsOutOver)
         {
            var targetX:Number = this.x;
            var targetY:Number = this.y;
            for(var i:int = 0; i < this.roundArray.length; )
            {
               var emb:BaseBullet = this.roundArray[i] as BaseBullet;
               TweenMax.to(emb,2,{
                  "x":targetX,
                  "y":targetY,
                  "onUpdate":showShallow,
                  "onUpdateParams":[emb],
                  "onComplete":function():*
                  {
                     if(roundArray.length > 0)
                     {
                        recoverRound();
                     }
                  }
               });
               i++;
            }
            this.isAllRoundsOutOver = false;
         }
      }
      
      public function doHit3_2(xx:Number, yy:Number) : void
      {
         var b:EnemyMoveBullet = new EnemyMoveBullet("Monster107Bullet3");
         b.x = xx;
         b.y = yy;
         b.setRole(this);
         b.setSpeed(0,0);
         b.setDistance(1000);
         b.setDestroyWhenLastFrame(false);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         this.roundArray.push(b);
         if(this.roundArray.length == maxRoundCount)
         {
            this.isAllRoundsOutOver = true;
         }
      }
      
      private function showShallow(emb:BaseBullet) : void
      {
         if(emb && emb.getImgMc())
         {
            if(emb.getImgMc().currentFrame % 4 == 0)
            {
               AUtils.shallowEffect(emb);
            }
         }
      }
      
      private function reduceRound() : void
      {
         this.totalRoundObject.value -= 1;
         this.monster107Back.obj.gotoAndStop(this.monster107Back.obj.currentFrame + 1);
      }
      
      private function recoverRound() : void
      {
         var i:int = 0;
         var emb:* = null;
         this.monster107Back.obj.gotoAndStop(1);
         this.totalRoundObject.value = maxRoundCount;
         for(i = 0; i < this.roundArray.length; )
         {
            emb = this.roundArray[i] as BaseBullet;
            emb.destroy();
            i++;
         }
         this.roundArray.length = 0;
      }
      
      public function getRoundValue() : int
      {
         return this.totalRoundObject.value;
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
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function destroy() : void
      {
         var j:int = 0;
         var emb:* = null;
         for(j = 0; j < this.roundArray.length; )
         {
            emb = this.roundArray[j] as BaseBullet;
            emb.destroy();
            j++;
         }
         if(this.monster107Back)
         {
            if(this.monster107Back.parent)
            {
               this.monster107Back.parent.removeChild(this.monster107Back);
            }
         }
         this.roundArray.length = 0;
         super.destroy();
         MainGame.getInstance().createMonster(108,500,200);
      }
   }
}
