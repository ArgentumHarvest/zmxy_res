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
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.bullet.FollowBaseObjectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   import my.SingleSavedBuff;
   
   public class Monster111 extends BaseMonster
   {
       
      
      private var isDazuo:Boolean = false;
      
      private var m112:Monster112;
      
      private var m113:Monster113;
      
      private var isgetExp:Boolean = false;
      
      public function Monster111()
      {
         super();
         this.horizenSpeed = 4;
         this.setHp(1600000);
         this.setSHp(1600000);
         this.attackRange = 1000;
         this.alertRange = 1000;
         this._anti.mDef = 0;
         this._anti.def = 0;
         this._anti.exp = 2000;
         this._anti.gxp = 1000;
         this.normalAttackRate = 0.1;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[6,-5],
            "attackInterval":10,
            "power":116,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[6,-5],
            "attackInterval":10,
            "power":99999,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[6,-5],
            "attackInterval":24,
            "power":99999,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "罗宣";
         this.setAction("wait");
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"p_cyst",
            "bigtype":"cwzb"
         }];
         TweenMax.delayedCall(5,function(_self:Monster111):*
         {
            _self.callFabao();
         },[this]);
      }
      
      private function callFabao() : void
      {
         this.isDazuo = true;
         this.m112 = MainGame.getInstance().createMonster(112,this.x,this.y) as Monster112;
         this.m113 = MainGame.getInstance().createMonster(113,this.x,this.y) as Monster113;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster111");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
            bbdc.setOffsetXY(0,-10);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,3,2,4],[2,2,2],[2,2,2,2],[2,2,50]]);
            bbdc.setFrameCount([6,4,1,5,6,3,4,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster111--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite2") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         if(str == "wait" || str == "walk")
         {
            if(this.isDazuo)
            {
               str = "wait2";
            }
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
            case "hurt":
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
               break;
            case "wait2":
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit1_1":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "hit1_2":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
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
            case "hit1_1":
               this.setAction("hit1_2");
               break;
            case "hit1_2":
               this.faceToTarget();
               this.setAction("wait");
               break;
            case "hit2":
               this.setAction("dead");
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
            case "hit1_1":
               this.speed.y = -15;
               break;
            case "hit1_2":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.x = 1800 + (RandomControllor.getIns().getRandom() - 0.5) * 940;
                  }
               }
               this.speed.y = 15;
               break;
            case "hit2":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi2(direct);
                  }
               }
         }
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:* = null;
         b = new FollowBaseObjectBullet("Monster111Bullet1");
         b.x = 1700;
         b.y = 480;
         b.setRole(this);
         b.setHurtCanCutDownEffect(false);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new FollowBaseObjectBullet("Monster111Bullet1");
         b.x = 2600;
         b.y = 480;
         b.setRole(this);
         b.setHurtCanCutDownEffect(false);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function attackTarget() : void
      {
         if(this.isDazuo)
         {
            this.faceToTarget();
            this.newAttackId();
            this.setAction("hit1_1");
            this.lastHit = "hit1_1";
         }
      }
      
      override protected function move() : void
      {
         if(this.isDazuo)
         {
            this.speed.x = 0;
         }
         super.move();
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         this.setMiss(0);
         var isMissBuff:Boolean = false;
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster111Buff")
            {
               this.setMiss(0.9);
               isMissBuff = true;
            }
         }
         var flag:Boolean = super.beMagicAttack(_target,sr,force);
         if(flag)
         {
            if(!isMissBuff)
            {
               this.doBuff();
            }
         }
         return flag;
      }
      
      private function doBuff() : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster111Buff");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDirect(0);
         b.setDisable();
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 8);
         b.setHurtCanCutDownEffect(false);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         var ssb:* = null;
         var obj:* = null;
         if(this.isDazuo)
         {
            canHurt = false;
         }
         this.setHp(this.getHp() - re);
         this.drawMonsterHp();
         if(this.isDead())
         {
            if(this.curAction != "dead" && this.curAction != "hit2")
            {
               if(!this.isgetExp)
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
                  this.isgetExp = true;
               }
               this.setYourFather(9999);
               this.setAction("hit2");
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
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit1_1" || this.curAction == "hit1_2";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1_1" || this.curAction == "hit1_2" || this.curAction == "hit2";
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
         if(!this.isDead())
         {
            if(this.m112)
            {
               if(this.m112.isDead())
               {
                  if(this.m113)
                  {
                     if(this.m113.isDead())
                     {
                        this.reduceHp(this.getSHp());
                     }
                  }
               }
            }
         }
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         if(this.m112)
         {
            this.m112.destroy();
            this.m112 = null;
         }
         if(this.m113)
         {
            this.m113.destroy();
            this.m113 = null;
         }
         super.destroy();
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
