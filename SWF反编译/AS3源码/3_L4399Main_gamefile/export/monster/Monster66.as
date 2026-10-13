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
   import event.CommonEvent;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import my.SingleSavedBuff;
   
   public class Monster66 extends BaseMonster
   {
       
      
      private var _life:uint = 3;
      
      public function Monster66()
      {
         super();
         this.horizenSpeed = 3;
         this.normalAttackRate = 0.7;
         this._anti.def = 100;
         this._anti.exp = 175;
         this._anti.gxp = 80;
         this.setHp(500000);
         this.setSHp(500000);
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":99,
            "power":5,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.MONSTER66HURT,
               "time":1
            }]
         };
         this.attackRange = 300;
         this.alertRange = 2000;
         this.isFly = true;
         this.graity = 0;
         this.isBoss = false;
         this.setAction("wait");
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster66");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(9,-15);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,7],[2,2,2,6]]);
            bbdc.setFrameCount([6,1,5,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster66--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
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
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
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
            case "dead":
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
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
         var _loc4_:* = state;
         if("hit1" === _loc4_)
         {
            if(p.x == 3)
            {
               if(this.bbdc.getCurFrameCount() == 6)
               {
                  this.doHi1(direct);
               }
            }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster66Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 85;
         }
         else
         {
            b.x = this.x + 85;
         }
         b.y = this.y - 15;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         var ssb:* = null;
         var flag:Boolean = super.beMagicAttack(_target,sr,force);
         if(flag)
         {
            if(this._life > 0)
            {
               this._life--;
            }
            if(this._life == 0)
            {
               if(this.curAction != "dead")
               {
                  this.setAction("dead");
                  if(gc.gameInfo)
                  {
                     if(gc.savedBuff)
                     {
                        ssb = gc.savedBuff.getBuffByType(SingleSavedBuff.BUFF_EXP_ADD);
                        if(ssb)
                        {
                           this._anti.exp *= ssb.value;
                        }
                     }
                  }
                  if(this.curAttackTarget is BaseHero)
                  {
                     if(BaseHero(this.curAttackTarget).getPet())
                     {
                        BaseHero(this.curAttackTarget).getPet().petInfo.setCurExper(BaseHero(this.curAttackTarget).getPet().petInfo.getCurExper() + this._anti.exp);
                     }
                     else
                     {
                        BaseHero(this.curAttackTarget).roleProperies.dispatchEvent(new CommonEvent("AddExper",[this._anti.exp]));
                     }
                  }
                  else if(this.curAttackTarget is BasePet)
                  {
                     BasePet(this.curAttackTarget).petInfo.setCurExper(BasePet(this.curAttackTarget).petInfo.getCurExper() + this._anti.exp);
                  }
               }
            }
         }
         return flag;
      }
      
      override public function addMonHurtMc(_hurt:int, isCrit:Boolean, _isShadow:Boolean = false) : *
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
      }
   }
}
