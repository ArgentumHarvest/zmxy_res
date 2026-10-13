package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import base.BaseObject;
   import base.BasePet;
   import base.BaseSummon;
   import event.CommonEvent;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   import my.SingleSavedBuff;
   
   public class Monster69 extends BaseMonster
   {
       
      
      private var fuhuoTimes:uint = 5;
      
      private var xuqiTimesMax:uint = 0;
      
      public function Monster69()
      {
         super();
         this.horizenSpeed = 7;
         this.setHp(1000000);
         this.setSHp(1000000);
         this.normalAttackRate = 0.6;
         this.attackRange = 350;
         this.alertRange = 2000;
         this._anti.def = 350;
         this._anti.exp = 1000;
         this._anti.gxp = 500;
         this._anti.mDef = 0.25;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-5,0],
            "attackInterval":24,
            "power":1000,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-5,0],
            "attackInterval":999,
            "power":1000,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-5,0],
            "attackInterval":999,
            "power":1000,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":100,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-15,0],
            "attackInterval":25,
            "power":1000,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "天庭战神";
         this._anti.xuqiTimes = 1;
         this.setAction("wait");
         this.setToCountSuppressLevel(50);
         this._anti.fallProbability = 0.02;
         this._anti.fallList = [{
            "name":"clj",
            "bigtype":"zb"
         }];
         this.skillCD1 = [gc.frameClips * 5,gc.frameClips * 10];
         this.skillCD2 = [gc.frameClips * 6,gc.frameClips * 12];
         this.skillCD3 = [gc.frameClips * 7,gc.frameClips * 14];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster69");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
            bbdc.setOffsetXY(-10,-20);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,168],[2,2,2,10],[2,2,2,10],[2,2,2,10],[2,72],[48]]);
            bbdc.setFrameCount([6,4,1,4,4,4,4,2,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster69--BitmapData Error!");
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
            case "hit5":
               if(curPoint.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               if(this.fuhuoTimes > 0)
               {
                  if(RandomControllor.getIns().getRandom() <= 0.1)
                  {
                     gc.eventManger.dispatchEvent(new Event("showStage161Light"));
                  }
               }
               else
               {
                  gc.eventManger.dispatchEvent(new Event("showStage161Light"));
               }
               this.setYourFather(168);
               this.setStatic();
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
         }
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         var ssb:* = null;
         var obj:* = null;
         this.addMonHurtMc(re,this.isCrit);
         this.setHp(this.getHp() - re);
         this.drawMonsterHp();
         if(this.isDead())
         {
            if(this.curAction != "dead")
            {
               if(this.fuhuoTimes == 0)
               {
                  if(gc.gameInfo)
                  {
                     if(gc.savedBuff)
                     {
                        ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_EXP_ADD);
                        if(ssb)
                        {
                           trace("经验加成");
                           this._anti.exp *= ssb.value;
                        }
                     }
                  }
                  if(this.curAttackTarget is BaseHero)
                  {
                     if(BaseHero(this.curAttackTarget).getPet())
                     {
                        BaseHero(this.curAttackTarget).roleProperies.dispatchEvent(new CommonEvent("AddExper",[this._anti.exp / 2]));
                        BaseHero(this.curAttackTarget).getPet().petInfo.setCurExper(BaseHero(this.curAttackTarget).getPet().petInfo.getCurExper() + this._anti.exp / 2);
                     }
                     else
                     {
                        BaseHero(this.curAttackTarget).roleProperies.dispatchEvent(new CommonEvent("AddExper",[this._anti.exp]));
                     }
                     obj = BaseHero(this.curAttackTarget).curAddEffect.getBuffByName(BaseAddEffect.SHENMISHANGRENSHIZHUANG);
                     if(obj)
                     {
                        BaseHero(this.curAttackTarget).cureHp(obj.hurt);
                     }
                  }
                  else if(this.curAttackTarget is BasePet)
                  {
                     BasePet(this.curAttackTarget).petInfo.setCurExper(BasePet(this.curAttackTarget).petInfo.getCurExper() + this._anti.exp);
                  }
                  else if(this.curAttackTarget is BaseSummon)
                  {
                     BaseSummon(this.curAttackTarget).getSourceRole().roleProperies.dispatchEvent(new CommonEvent("AddExper",[this._anti.exp]));
                  }
               }
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
         if(this.isBoss)
         {
            gc.gameInfo.addBossBlood(this.monsterName,100 - Math.round(100 * (this.getHp() / this.getSHp())));
         }
      }
      
      override protected function scriptFrameOverFunc(row:int) : void
      {
         var b:* = null;
         var direct:* = 0;
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
            case "hit4":
               this.xuqiTimesMax++;
               if(this.xuqiTimesMax > 10)
               {
                  this.xuqiTimesMax = 10;
               }
               this.attackBackInfoDict["hit1"] = {
                  "hitMaxCount":99,
                  "attackBackSpeed":[0,0],
                  "attackInterval":24,
                  "power":1000 + this.xuqiTimesMax * 200,
                  "attackKind":"magic"
               };
               this.attackBackInfoDict["hit2"] = {
                  "hitMaxCount":99,
                  "attackBackSpeed":[0,0],
                  "attackInterval":999,
                  "power":1000 + this.xuqiTimesMax * 200,
                  "attackKind":"magic"
               };
               this.attackBackInfoDict["hit3"] = {
                  "hitMaxCount":99,
                  "attackBackSpeed":[0,0],
                  "attackInterval":999,
                  "power":1000 + this.xuqiTimesMax * 200,
                  "attackKind":"magic"
               };
               this.attackBackInfoDict["hit5"] = {
                  "hitMaxCount":99,
                  "attackBackSpeed":[0,0],
                  "attackInterval":25,
                  "power":1000 + this.xuqiTimesMax * 200,
                  "attackKind":"magic"
               };
               this.setAction("wait");
               break;
            case "hit5":
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
               if(this.fuhuoTimes > 0)
               {
                  b = new FollowBaseObjectBullet("Monster69Fuhuo");
                  direct = uint(this.getBBDC().getDirect());
                  if(direct == 0)
                  {
                     b.x = this.x - 60;
                  }
                  else
                  {
                     b.x = this.x + 60;
                  }
                  b.y = this.y - 60;
                  b.setRole(this);
                  b.setDisable();
                  b.setDirect(direct);
                  b.setAction("hit2");
                  gc.gameSence.addChild(b);
                  this.magicBulletArray.push(b);
                  this.setHp(this.getSHp());
                  if(gc.gameInfo)
                  {
                     gc.gameInfo.addBossBlood(this.monsterName,100 - Math.round(100 * (this.getHp() / this.getSHp())));
                  }
                  this.setAction("wait");
                  this.setYourFather(48);
                  this.fuhuoTimes--;
                  gc.eventManger.dispatchEvent(new Event("hideStage161Light"));
               }
               else
               {
                  this.destroy();
               }
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
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi3(direct);
                  }
               }
               break;
            case "hit4":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 72)
                  {
                     this.doHi4(direct);
                  }
               }
               break;
            case "hit5":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 24)
                  {
                     this.doHi5(direct);
                  }
                  if(this.bbdc.getCurFrameCount() >= 24)
                  {
                     this.speed.y = -3;
                  }
                  else
                  {
                     this.speed.y = 0;
                  }
                  this.speed.x = 0;
               }
               break;
            case "dead":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 168)
                  {
                     this._anti.fallProbability = 0.02 * (6 - this.fuhuoTimes);
                     this.fallEquip();
                  }
               }
         }
      }
      
      override protected function attackTarget() : void
      {
         this.faceToTarget();
         this.newAttackId();
         var rand:Number = RandomControllor.getIns().getRandom();
         if(rand < 0.3)
         {
            this.setAction("hit1");
            this.lastHit = "hit1";
         }
         else if(rand < 0.6)
         {
            this.setAction("hit2");
            this.lastHit = "hit2";
         }
         else
         {
            this.setAction("hit3");
            this.lastHit = "hit3";
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return true;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget != null;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.curAttackTarget != null && this.curAction == "wait";
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(5);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(48);
         this.setAction("hit5");
         this.lastHit = "hit5";
      }
      
      override protected function releSkill3() : void
      {
         var m101:Monster101 = MainGame.getInstance().createMonster(101,this.x,this.y) as Monster101;
         m101.setXuqiLevel(this._anti.xuqiTimes);
         this.newAttackId();
         this.setYourFather(10);
         if(this.curAttackTarget)
         {
            if(RandomControllor.getIns().getRandom() < 0.5)
            {
               this.x = this.curAttackTarget.x - 20;
               this.y = this.curAttackTarget.y - 160;
               this.turnRight();
            }
            else
            {
               this.x = this.curAttackTarget.x + 20;
               this.y = this.curAttackTarget.y - 160;
               this.turnLeft();
            }
            if(this.y < -500)
            {
               this.y = -500;
            }
            this.attackTarget();
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster69Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 200;
         }
         else
         {
            b.x = this.x + 200;
         }
         b.y = this.y - 160;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster69Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 195;
         }
         else
         {
            b.x = this.x + 195;
         }
         b.y = this.y - 130;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster69Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 220;
         }
         else
         {
            b.x = this.x + 220;
         }
         b.y = this.y - 75;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi4(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster69Bullet4");
         if(direct == 0)
         {
            b.x = this.x - 105;
         }
         else
         {
            b.x = this.x + 105;
         }
         b.y = this.y - 160;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi5(direct:uint) : void
      {
         var b:* = null;
         b = new FollowBaseObjectBullet("Monster69Bullet5_1");
         if(direct == 0)
         {
            b.x = this.x - 150;
         }
         else
         {
            b.x = this.x + 150;
         }
         b.y = this.y - 160;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit5");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new FollowBaseObjectBullet("Monster69Bullet5_2");
         if(direct == 0)
         {
            b.x = this.x - 15;
         }
         else
         {
            b.x = this.x + 15;
         }
         b.y = this.y - 360;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit5");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         var isHit4:Boolean = this.curAction == "hit4";
         var flag:Boolean = super.beMagicAttack(_target,sr,force);
         if(flag && isHit4)
         {
            sr.addCurAddEffect([{
               "name":BaseAddEffect.PETMONKEY_FIRE,
               "time":gc.frameClips * 3,
               "hurt":500
            }]);
         }
         return flag;
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
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit5";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         super.destroy();
         if(this.getHp() <= 0)
         {
            if(this.isBoss)
            {
               ta = gc.pWorld.getTransferDoorArray();
               for(i = 0; i < ta.length; )
               {
                  mc = ta[i];
                  mc.visible = true;
                  i++;
               }
            }
         }
      }
   }
}
