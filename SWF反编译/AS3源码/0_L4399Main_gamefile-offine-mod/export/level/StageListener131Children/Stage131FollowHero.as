package export.level.StageListener131Children
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.ANumber;
   import my.HitTest;
   
   public class Stage131FollowHero extends BaseObject
   {
       
      
      private var followHero:BaseHero;
      
      private var actionPerManyFrames:uint = 12;
      
      private var hpSlip:Sprite;
      
      private var toGetFlower:StageListener131Jweal;
      
      public function Stage131FollowHero(target:BaseHero)
      {
         super();
         this.followHero = target;
         this.horizenSpeed = 7;
         this._anti.hp = 10000;
         this._anti.shp = 10000;
         this.newHpSlip();
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Stage131FollowHeroBMD");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(-10,-16);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4],[10],[2,2,2,2,7],[4,40]]);
            bbdc.setFrameCount([6,1,1,5,2]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Stage131FollowHeroBMD--BitmapData Error!");
      }
      
      override protected function __added(evt:Event) : void
      {
         super.__added(evt);
         gc.gameInfo.addBossBlood("仙女",100 - Math.round(100 * (this.getHp() / this.getSHp())));
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         if(!this.bbdc)
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
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
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
            case "hurt":
               if(this.toGetFlower)
               {
                  this.toGetFlower = null;
               }
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         var _loc4_:* = state;
         if("hit1" === _loc4_)
         {
            this.setStatic();
         }
      }
      
      override protected function scriptFrameOverFunc(row:int) : void
      {
         if(!this.bbdc)
         {
            return;
         }
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
               this.getFlower();
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
               this.destroy();
         }
      }
      
      public function setFlowerTarget(flower:StageListener131Jweal) : void
      {
         if(!this.toGetFlower)
         {
            this.toGetFlower = flower;
            this.setAction("hit1");
         }
      }
      
      private function getFlower() : void
      {
         if(this.toGetFlower)
         {
            this.toGetFlower.beGet();
            this.toGetFlower = null;
         }
      }
      
      override public function step() : void
      {
         super.step();
         this.checkTargetHero();
         if(!this.isDead() && !this.isAttacking())
         {
            this.followToHero();
         }
      }
      
      private function checkTargetHero() : void
      {
         var closeToHero:* = null;
         var dis:Number = NaN;
         var playersNum:uint = gc.getPlayerArray().length;
         var minDis:* = Number(999999);
         for each(var bh in gc.getPlayerArray())
         {
            dis = AUtils.GetDisBetweenTwoObj(this,bh);
            if(dis < minDis)
            {
               minDis = dis;
               closeToHero = bh;
            }
         }
         if(closeToHero)
         {
            this.followHero = closeToHero;
         }
      }
      
      private function followToHero() : void
      {
         if(this.followHero)
         {
            if(this.actionPerManyFrames > 0)
            {
               this.actionPerManyFrames--;
            }
            if(this.actionPerManyFrames == 0)
            {
               if(!this.isBeAttacking() && !this.isAttacking())
               {
                  this.Intelligence();
                  this.actionPerManyFrames = 12;
               }
            }
         }
      }
      
      private function Intelligence() : void
      {
         var dis:Number = NaN;
         if(this.followHero)
         {
            dis = AUtils.GetDisBetweenTwoObj(this,this.followHero);
            if(dis > 150)
            {
               this.moveToFollowHero();
            }
            else if(RandomControllor.getIns().getRandom() <= 0.3)
            {
               this.moveToFollowHero();
            }
            else
            {
               this.setStatic();
               this.setAction("wait");
            }
         }
      }
      
      private function moveToFollowHero() : void
      {
         if(this.x < this.followHero.x)
         {
            this.turnRight();
         }
         else
         {
            this.turnLeft();
         }
      }
      
      public function setHp(v:int) : void
      {
         this._anti.hp = v;
      }
      
      public function getHp() : int
      {
         return this._anti.hp;
      }
      
      public function getSHp() : int
      {
         return this._anti.shp;
      }
      
      public function cureHp(v:uint) : void
      {
         if(this.getHp() + v > this.getSHp())
         {
            this.setHp(this.getSHp());
         }
         else
         {
            this.setHp(this.getHp() + v);
         }
         this.addCureMc(v);
         this.drawMonsterHp();
      }
      
      protected function drawMonsterHp() : void
      {
         gc.gameInfo.addBossBlood("仙女",100 - Math.round(100 * (this.getHp() / this.getSHp())));
         hpSlip.graphics.clear();
         hpSlip.alpha = 1;
         var reduce:* = Number(this.getHp() / this.getSHp());
         reduce = reduce < 0 ? 0 : reduce;
         if(this.getHp() >= 0)
         {
            hpSlip.graphics.lineStyle(1.2,0);
            hpSlip.graphics.drawRect(0,5,50,5);
            hpSlip.graphics.beginFill(16711680);
            if(this.getBBDC().getDirect() == 0)
            {
               hpSlip.graphics.drawRect(0,5,50 * reduce,5);
            }
            else if(this.getBBDC().getDirect() == 1)
            {
               hpSlip.graphics.drawRect(50 - 50 * reduce,5,50 * reduce,5);
            }
            hpSlip.graphics.endFill();
         }
      }
      
      protected function showHpSlip() : void
      {
         this.hpSlip.visible = true;
         TweenMax.to(this.hpSlip,2,{
            "alpha":0,
            "onComplete":removedHpSlip
         });
      }
      
      protected function removedHpSlip() : void
      {
         hpSlip.visible = false;
      }
      
      protected function newHpSlip() : void
      {
         hpSlip = new Sprite();
         hpSlip.x = -23;
         hpSlip.y = -this.colipse.height / 2 - 10;
         hpSlip.visible = false;
         addChild(hpSlip);
      }
      
      public function addHeroHurtMc(_hurt:int) : void
      {
         var monHurtNumMc:ANumber = new ANumber();
         this.gc.gameSence.addChild(monHurtNumMc);
         monHurtNumMc.aNumImage("pnum",_hurt,this.x - 20,this.y - 60,20);
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         var obj:* = null;
         var point:* = null;
         var arr:* = null;
         var i:* = 0;
         var o:* = null;
         var hurt:int = 0;
         if(this._anti.isYourFather)
         {
            return false;
         }
         if(force || this.colipse && AUtils.testIntersects(this.colipse,_target,gc.gameSence) && HitTest.complexHitTestObject(this.colipse,_target))
         {
            obj = sr.attackBackInfoDict[_target.curAction];
            if(obj)
            {
               point = this.getBeattackBackSpeed(_target,obj);
               if(_target.getImcName() != "Role1Bullet12")
               {
                  this.setAttackBack(point);
               }
               if(obj.addEffect)
               {
                  arr = AUtils.clone(obj.addEffect) as Array;
                  for(i = uint(0); i < arr.length; )
                  {
                     o = arr[i];
                     if(o.time == BaseBullet.DESIDE_BY_FRAMES_LEFT)
                     {
                        o.time = _target.getFrameLeft();
                     }
                     i++;
                  }
                  this.addCurAddEffect(arr);
               }
            }
            hurt = sr.getRealPower(_target.curAction);
            this.reduceHp(hurt,true);
            this.addHeroHurtMc(hurt);
            return true;
         }
         return false;
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         this.setHp(this.getHp() - re);
         this.drawMonsterHp();
         if(this.isDead())
         {
            if(this.curAction != "dead")
            {
               this.setAction("dead");
            }
         }
         else if(canHurt)
         {
            if(this.curAction == "hurt")
            {
               if(this.bbdc)
               {
                  this.bbdc.setFramePointX(0);
               }
            }
            else
            {
               this.setAction("hurt");
            }
         }
      }
      
      override public function isDead() : Boolean
      {
         return this.getHp() <= 0;
      }
      
      public function destroy() : void
      {
         if(this.curAddEffect)
         {
            this.curAddEffect.destroy();
            this.curAddEffect = null;
         }
         this.isReadyToDestroy = true;
         TweenMax.to(this,1,{
            "alpha":0,
            "onComplete":function(_self:Stage131FollowHero):*
            {
               _self.removeFromStage();
            },
            "onCompleteParams":[this]
         });
         for(var i:int = 0; i < this.magicBulletArray.length; )
         {
            var bb:BaseBullet = this.magicBulletArray[i] as BaseBullet;
            bb.destroy();
            i++;
         }
         this.magicBulletArray = [];
         this.followHero = null;
      }
      
      private function removeFromStage() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(this.bbdc)
         {
            this.bbdc.destroy();
            this.bbdc = null;
         }
      }
   }
}
