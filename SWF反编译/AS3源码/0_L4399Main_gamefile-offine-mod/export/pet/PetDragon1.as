package export.pet
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BasePet;
   import com.greensock.TweenMax;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import petInfo.PetInfo;
   
   public class PetDragon1 extends BasePet
   {
       
      
      public var continueCount:int = 0;
      
      public var totalHurt:int = 0;
      
      private var type:int = 0;
      
      private var fenshenArray:Array;
      
      public function PetDragon1(bh:BaseHero, pi:PetInfo)
      {
         fenshenArray = [];
         super(bh,pi);
         this.horizenSpeed = 5;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":12,
            "attackKind":"physics"
         };
         this.attackRange = 150;
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 2,gc.frameClips * 20];
      }
      
      public function setContinueTime(v:int) : void
      {
         this.continueCount = v;
         if(v > 0)
         {
            type = 1;
         }
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("PetDragonBmd1");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
            bbdc.setOffsetXY(1,-5);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,10],[2,2,2,10],[2,2,2,2,10]]);
            bbdc.setFrameCount([6,1,4,4,5]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("PetDragonBmd1--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite3") as Sprite;
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
            case "hit2":
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
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
            case "hit2":
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
               this.destroy();
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         var point:Point = new Point();
         switch(state)
         {
            case "hit1":
               if(gc.isSingleGame() || gc.sid == this.sourceRole.sid)
               {
                  if(p.x == 3)
                  {
                     if(this.bbdc.getCurFrameCount() == 10)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 30;
                        }
                        else
                        {
                           point.x = this.x + 30;
                        }
                        point.y = this.y;
                        this.doHit1(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit1",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit2":
               if(gc.isSingleGame() || gc.sid == this.sourceRole.sid)
               {
                  if(p.x == 4)
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        this.doHit2(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit2",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         if(this.type == 0)
         {
            return this.curAttackTarget != null && this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("fs") && this._petInfo.findHasStudySkill("fs");
         }
         return false;
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,canHurt);
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setAction("hit2");
         this.lastHit = "hit2";
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit2Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("fs"));
      }
      
      private function doHit1(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetDragon1Bullet1");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         if(this.type == 1)
         {
            b.setFuncWhenHit(addHurt);
         }
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function addHurt(bb:BaseBullet) : void
      {
         this.totalHurt += bb.hurt;
      }
      
      private function doHit2(direct:uint, point:Point) : void
      {
         var pi:PetInfo = new PetInfo();
         pi.setHp(this._petInfo.getHp());
         pi.setSHp(pi.getHp());
         pi.setMp(this._petInfo.getMp());
         pi.setSMp(pi.getMp());
         pi.setAtk(this._petInfo.getAtk());
         pi.setCrit(this._petInfo.getCrit());
         pi.setDef(this._petInfo.getDef());
         pi.setEHp(this._petInfo.getEHp());
         pi.setEMp(this._petInfo.getEMp());
         pi.setLevel(this._petInfo.getLevel());
         pi.setMDef(this._petInfo.getMDef());
         pi.setMiss(this._petInfo.getMiss());
         pi.setMoveSpeed(this._petInfo.getMoveSpeed());
         pi.setPetNameAndLevel(this._petInfo.getPetName(),this._petInfo.getLevel());
         var pd1:PetDragon1 = new PetDragon1(this.sourceRole,pi);
         pd1.setContinueTime(gc.frameClips * 10);
         pd1.alpha = 0.5;
         pd1.x = this.x + (RandomControllor.getIns().getRandom() - 0.5) * 300;
         pd1.y = this.y - 50;
         gc.gameSence.addChild(pd1);
         this.fenshenArray.push(pd1);
      }
      
      override protected function checkBuffSkill() : void
      {
         if(this.type == 0)
         {
            super.checkBuffSkill();
            return;
         }
      }
      
      override public function setOtherAttack(attackKind:String, direct:uint, point:Point, params:Array = null, initTimer:uint = 0) : void
      {
         switch(attackKind)
         {
            case "hit1":
               this.doHit1(direct,point);
               break;
            case "hit2":
               this.doHit2(direct,point);
               break;
            case "hit2Action":
               this.releSkill1();
               break;
            case "normalHit":
               this.normalHit();
         }
      }
      
      override protected function normalHit() : void
      {
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"normalHit",this.getBBDC().getDirect(),0,0,[]);
         }
         this.newAttackId();
         this.setAction("hit1");
         this.lastHit = "hit1";
      }
      
      override public function getRealPower(cur:String, crit:Boolean = true) : int
      {
         var critValue:uint = !!this.getCriteValue(crit) ? 2 : 1;
         var hurtAdd:uint = this.getMagicAddValue();
         var wsAdd:Number = !!this.isGXP ? 1.2 : 1;
         switch(cur)
         {
            case "hit1":
               return (this._petInfo.getAtk() + hurtAdd) * critValue * wsAdd * this.hurtBaseEffectRate();
            case "hit2":
               return 0;
            default:
               return 0;
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         var temp:* = null;
         var idx:int = 0;
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
         if(this.type == 1)
         {
            if(this.continueCount > 0)
            {
               this.continueCount--;
               if(this.continueCount == 0)
               {
                  this._petInfo.setHp(0);
                  this.destroy();
               }
            }
         }
         else if(this.type == 0)
         {
            temp = [];
            for each(var pd in this.fenshenArray)
            {
               if(pd.continueCount > 0)
               {
                  pd.step();
               }
               if(pd.continueCount == 0 || pd.petInfo.getHp() <= 0)
               {
                  if(pd.continueCount == 0)
                  {
                     this.cureHp(pd.totalHurt / 10);
                  }
                  else
                  {
                     pd.destroy();
                  }
                  temp.push(pd);
               }
            }
            if(temp.length > 0)
            {
               for each(pd in temp)
               {
                  idx = this.fenshenArray.indexOf(pd);
                  if(idx != -1)
                  {
                     this.fenshenArray.splice(idx,1);
                  }
               }
            }
         }
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2";
      }
      
      override public function destroy() : void
      {
         if(this.type == 0)
         {
            for each(pd1 in this.fenshenArray)
            {
               pd1.destroy();
            }
            super.destroy();
         }
         else
         {
            if(this.bbdc)
            {
               this.bbdc.destroy();
            }
            if(this.curAddEffect)
            {
               this.curAddEffect.destroy();
               this.curAddEffect = null;
            }
            this.isReadyToDestroy = true;
            TweenMax.to(this,1,{
               "alpha":0,
               "onComplete":function(_self:BasePet):*
               {
                  if(_self.parent)
                  {
                     _self.parent.removeChild(_self);
                  }
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
            if(this.sourceRole)
            {
               this.sourceRole = null;
            }
         }
         this.fenshenArray.length = 0;
      }
   }
}
