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
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster157 extends BaseMonster
   {
      
      public static var Monster157DEAD_EVENT:String = "Monster157dead_event";
       
      
      private var propertyLevel:uint = 1;
      
      public function Monster157()
      {
         super();
         this.normalAttackRate = 0;
         this.horizenSpeed = 4;
         this.setPropertyByLevel(1);
         this.isCanBeCatchSkill = true;
         this.isBoss = true;
         this.monsterName = "虚宿";
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 4,gc.frameClips * 10];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 12];
         this.skillCD3 = [gc.frameClips * 0.5,gc.frameClips * 1];
         this.skillCD4 = [gc.frameClips * 5,gc.frameClips * 15];
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
            "attackBackSpeed":[-15,0],
            "attackInterval":10,
            "power":500 * lv,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "power":500 * lv,
            "attackKind":"physics"
         };
         this.setIsXuanwu(lv);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster157");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],220,220,new Point(0,0));
            bbdc.setOffsetXY(0,0);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[30,35]]);
            bbdc.setFrameCount([6,4,1,5,4,2]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster157--BitmapData Error!");
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
               this.dispatchEvent(new CommonEvent(Monster157DEAD_EVENT));
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
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() > 1)
                  {
                     this.checkHit2();
                     if(direct == 0)
                     {
                        this.speed.x = -15;
                     }
                     else
                     {
                        this.speed.x = 15;
                     }
                  }
                  else
                  {
                     this.setAction("wait");
                  }
               }
               else
               {
                  this.speed.x = 0;
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return true;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return true;
      }
      
      override protected function beforeSkill4Start() : Boolean
      {
         return true;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(15);
         this.setAction("hit1");
         this.lastHit = "hit1";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(30);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill3() : void
      {
         var playerArray:Array = gc.getPlayerArray();
         var hpRate:Number = 0;
         for each(var bh in playerArray)
         {
            hpRate += bh.roleProperies.getHHP() / bh.roleProperies.getSHHP();
         }
         hpRate /= playerArray.length;
         var hurtAddRate:Number = 1 - hpRate;
         if(hurtAddRate > 1)
         {
            hurtAddRate = 1;
         }
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-15,0],
            "attackInterval":10,
            "power":500 * this.propertyLevel * (1 + hurtAddRate),
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "power":500 * this.propertyLevel * (1 + hurtAddRate),
            "attackKind":"physics"
         };
      }
      
      override protected function releSkill4() : void
      {
         this.bbdc.alpha = 0.5;
         TweenMax.delayedCall(6,function(_self:Monster157):*
         {
            _self.bbdc.alpha = 1;
         },[this]);
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster157Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 110;
         }
         else
         {
            b.x = this.x + 110;
         }
         b.y = this.y - 52;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(bo:BaseObject) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster157Bullet2");
         b.x = bo.x;
         b.y = bo.y;
         b.setRole(this);
         b.setDirect(0);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function checkHit2() : void
      {
         var enemy:Array = gc.getPlayerAndPetArray();
         for each(var bo in enemy)
         {
            if(this.colipse.hitTestObject(bo.colipse))
            {
               this.doHi2(bo);
               this.bbdc.setCurFrameCount(1);
               this.setYourFather(35);
               return;
            }
         }
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
      
      override public function setAttackBack(p:Point) : void
      {
         if(this.bbdc.alpha != 1)
         {
            return;
         }
         super.setAttackBack(p);
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         if(this.bbdc.alpha != 1)
         {
            canHurt = false;
         }
         super.reduceHp(re,canHurt);
      }
      
      override protected function attackTarget() : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         return Boolean(super.beMagicAttack(_target,sr,force));
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2";
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit1";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit2";
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
