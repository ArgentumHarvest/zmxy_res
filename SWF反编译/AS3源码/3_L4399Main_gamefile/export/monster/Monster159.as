package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster159 extends BaseMonster
   {
      
      public static var Monster159DEAD_EVENT:String = "Monster159dead_event";
       
      
      private var propertyLevel:uint = 1;
      
      private var isBati:Boolean = false;
      
      private var directCount:uint = 24;
      
      public function Monster159()
      {
         super();
         this.normalAttackRate = 0.7;
         this.horizenSpeed = 4;
         this.setPropertyByLevel(1);
         this.isCanBeCatchSkill = true;
         this.isBoss = true;
         this.monsterName = "牛宿";
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 4,gc.frameClips * 10];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 9];
         this.skillCD3 = [gc.frameClips * 5,gc.frameClips * 8];
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
      }
      
      public function setPropertyByLevel(lv:uint = 1) : void
      {
         this.skillCD1 = [gc.frameClips * 3,gc.frameClips * (2 * (lv + 1))];
         this.propertyLevel = lv;
         if(lv > 10)
         {
            lv = 10;
         }
         this.setHp(500000 * lv);
         this.setSHp(500000 * lv);
         this.attackRange = 150;
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
            "power":250 * lv,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":999,
            "power":500 * lv,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":24,
            "power":250 * lv,
            "attackKind":"physics"
         };
         this.setIsXuanwu(lv);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster159");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
            bbdc.setOffsetXY(0,-20);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,10],[2,10],[2,2,10],[1,1,1,1]]);
            bbdc.setFrameCount([6,4,1,5,3,2,3,72]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster159--BitmapData Error!");
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
            case "hit4":
               if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
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
            case "hit4":
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
               this.dispatchEvent(new CommonEvent(Monster159DEAD_EVENT));
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
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi3(direct);
                  }
               }
               break;
            case "hit4":
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
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 100;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(5);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(5);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(72);
         this.setAction("hit4");
         this.lastHit = "hit4";
         this.doHi4(0);
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster159Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 60;
         }
         else
         {
            b.x = this.x + 60;
         }
         b.y = this.y + 45;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         direct = direct;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster159Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 95;
         }
         else
         {
            b.x = this.x + 95;
         }
         b.y = this.y - 25;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         this.isBati = true;
         this.shadowCount = 0;
         this.normalAttackRate = 1;
         this.horizenSpeed = 8;
         TweenMax.delayedCall(this.propertyLevel + 2,function(_self:Monster159):*
         {
            if(!_self.isReadyToDestroy)
            {
               _self.isBati = false;
               _self.normalAttackRate = 0.7;
               _self.horizenSpeed = 4;
            }
         },[this]);
      }
      
      private function doHi3(direct:uint) : void
      {
         var i:* = 0;
         var b:* = null;
         var nums:uint = 3 + int(RandomControllor.getIns().getRandom() * 3);
         for(i = uint(0); i < nums; )
         {
            b = new SpecialEffectBullet("Monster159Bullet3");
            b.x = 100 + RandomControllor.getIns().getRandom() * 800;
            b.y = 510;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit3");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
            i++;
         }
      }
      
      private function doHi4(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster159Bullet4");
         if(direct == 0)
         {
            b.x = this.x - 0;
         }
         else
         {
            b.x = this.x + 0;
         }
         b.y = this.y + 80;
         b.setHurtCanCutDownEffect(false);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function step() : void
      {
         super.step();
         if(this.isBati)
         {
            shadowCount++;
            if(this.shadowCount % 4 == 0)
            {
               this.shadowEffect();
            }
         }
         if(this.x > 1100)
         {
            this.x = 800;
         }
         else if(this.x < -100)
         {
            this.x = 100;
         }
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         if(!this.isBati)
         {
            super.reduceHp(re,canHurt);
         }
         else
         {
            super.reduceHp(re,false);
         }
      }
      
      override public function setAttackBack(p:Point) : void
      {
         if(!this.isBati)
         {
            super.setAttackBack(p);
         }
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
         if(this.curAction == "hit4")
         {
            if(directCount > 0)
            {
               directCount--;
               if(directCount == 0)
               {
                  if(this.curAttackTarget)
                  {
                     if(this.x > this.curAttackTarget.x)
                     {
                        if(this.speed.x > 0)
                        {
                           this.speed.x *= -1;
                        }
                     }
                     else if(this.x < this.curAttackTarget.x)
                     {
                        if(this.speed.x < 0)
                        {
                           this.speed.x *= -1;
                        }
                     }
                  }
               }
               directCount = 24;
            }
         }
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         return Boolean(super.beMagicAttack(_target,sr,force));
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit2" || this.curAction == "hit3";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit4";
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
