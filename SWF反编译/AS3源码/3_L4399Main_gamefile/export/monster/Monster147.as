package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster147 extends BaseMonster
   {
      
      public static var Monster147DEAD_EVENT:String = "Monster147dead_event";
       
      
      private var propertyLevel:uint = 1;
      
      private var hit3Bullet:SpecialEffectBullet;
      
      public function Monster147()
      {
         super();
         this.normalAttackRate = 0.8;
         this.horizenSpeed = 4;
         this.setPropertyByLevel(1);
         this.isCanBeCatchSkill = true;
         this.isBoss = true;
         this.monsterName = "柳宿";
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 20];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 15];
         this.skillCD3 = [gc.frameClips * 8,gc.frameClips * 15];
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
      }
      
      public function setPropertyByLevel(lv:uint = 1) : void
      {
         this.propertyLevel = lv;
         if(lv > 10)
         {
            lv = 10;
         }
         this.setHp(500000 * lv);
         this.setSHp(500000 * lv);
         this.attackRange = 200;
         this.attackRangeY = 50;
         this.alertRangeY = 20;
         this.alertRange = 2500;
         this._anti.def = 50 * lv;
         this._anti.exp = 2000 * lv;
         this._anti.gxp = 500;
         this._anti.mDef = 0.05 * lv;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":10,
            "power":500 * lv,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-15,0],
            "attackInterval":10,
            "power":500 * lv,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":48,
            "power":250 * lv,
            "attackKind":"physics"
         };
         this.setIsZhuque(lv);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster147");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
            bbdc.setOffsetXY(5,-22);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[2,10],[2,2,2,2,10]]);
            bbdc.setFrameCount([6,4,1,5,4,2,5]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster147--BitmapData Error!");
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
            case "hit3":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
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
            case "hit3":
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
               this.dispatchEvent(new CommonEvent(Monster147DEAD_EVENT));
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
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 4)
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
         return true;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 1000;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.hit3Bullet == null;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.bbdc.hide();
         TweenMax.delayedCall(10,function(_self:Monster147):*
         {
            _self.bbdc.show();
         },[this]);
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(24);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.setYourFather(24);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster147Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 170;
         }
         else
         {
            b.x = this.x + 170;
         }
         b.y = this.y - 45;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         direct = direct;
         var target:BaseHero = gc.getRandomPlayer();
         if(target)
         {
            var stoneLen:uint = 5;
            for(var i:uint = 0; i < stoneLen; )
            {
               var b:SpecialEffectBullet = new SpecialEffectBullet("Monster147Bullet2");
               b.x = this.x + (2 - i) * 75;
               b.y = this.y + 75;
               b.setRole(this);
               b.setDirect(direct);
               b.setDestroyWhenLastFrame(false);
               b.setDisable();
               b.setAction("hit2");
               gc.gameSence.addChild(b);
               this.magicBulletArray.push(b);
               var targetY:Number = this.y - (150 + i % 2 * 75);
               TweenMax.to(b,1,{
                  "y":targetY,
                  "onComplete":function(_b:SpecialEffectBullet, _target:BaseHero, _self:Monster147):*
                  {
                     var eb:* = null;
                     var p:* = null;
                     if(!_self.isDead() && !_target.isDead())
                     {
                        eb = new EnemyMoveBullet("Monster147Bullet2");
                        eb.x = _b.x;
                        eb.y = _b.y;
                        eb.setRole(_self);
                        p = AUtils.GetNextPointByTwoObj(eb,_target);
                        eb.setSpeed(8 * p.x,8 * p.y);
                        eb.setAddSpeed(p.x,p.y);
                        eb.setDistance(2000);
                        eb.setDestroyWhenLastFrame(false);
                        eb.setDirect(direct);
                        eb.setAction("hit2");
                        gc.gameSence.addChild(eb);
                        _self.magicBulletArray.push(eb);
                     }
                     _b.destroy();
                  },
                  "onCompleteParams":[b,target,this]
               });
               i++;
            }
         }
      }
      
      private function doHi3(direct:uint) : void
      {
         this.hit3Bullet = new SpecialEffectBullet("Monster147Bullet3");
         this.hit3Bullet.x = this.x;
         this.hit3Bullet.y = this.y;
         this.hit3Bullet.setRole(this);
         this.hit3Bullet.setDestroyWhenLastFrame(false);
         this.hit3Bullet.setDirect(direct);
         this.hit3Bullet.setAction("hit3");
         this.hit3Bullet.setFollowDisplayObj(this);
         gc.gameSence.addChild(this.hit3Bullet);
         this.magicBulletArray.push(this.hit3Bullet);
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,canHurt);
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         _target = _target;
         sr = sr;
         force = force;
         var flag:Boolean = super.beMagicAttack(_target,sr,force);
         if(flag)
         {
            if(!this.isDead())
            {
               if(this.hit3Bullet)
               {
                  this.hit3Bullet.setFollowDisplayObj(null);
                  var targetX:Number = sr.x;
                  if(this.hit3Bullet.x < sr.x)
                  {
                     targetX += 600;
                  }
                  else
                  {
                     targetX -= 600;
                  }
                  TweenMax.to(this.hit3Bullet,2,{
                     "x":targetX,
                     "onComplete":function(_self:Monster147):*
                     {
                        _self.hit3Bullet.destroy();
                        _self.hit3Bullet = null;
                     },
                     "onCompleteParams":[this]
                  });
               }
            }
         }
         return flag;
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function step() : void
      {
         super.step();
         if(this.x > 1100)
         {
            this.x = 800;
         }
         else if(this.x < -100)
         {
            this.x = 100;
         }
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit2";
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.hit3Bullet = null;
      }
   }
}
