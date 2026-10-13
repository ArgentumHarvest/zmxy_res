package export.pet
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BasePet;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import petInfo.PetInfo;
   
   public class PetRabbit4 extends BasePet
   {
       
      
      public function PetRabbit4(bh:BaseHero, pi:PetInfo)
      {
         super(bh,pi);
         this.horizenSpeed = 5;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":12,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":12,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":999,
            "power":12,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.PETHORSE_ICE,
               "time":gc.frameClips * 4,
               "rate":0.5
            }]
         };
         this.attackRange = 350;
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 8,gc.frameClips * 20];
         this.skillCD2 = [gc.frameClips * 8,gc.frameClips * 15];
         this.skillCD3 = [gc.frameClips * 30,gc.frameClips * 60];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("PetPetRabbitBmd4");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
            bbdc.setOffsetXY(-7,-41);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,2,2],[2,10],[10],[1,1,1,7,1,40]]);
            bbdc.setFrameCount([6,4,1,5,5,2,1,6]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("PetPetRabbitBmd4--BitmapData Error!");
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
                  if(p.x == 4)
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
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
               this.setStatic();
               if(p.x <= 3)
               {
                  this.speed.y = -20;
               }
               else
               {
                  this.speed.y = 0;
               }
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 7)
                  {
                     if(direct == 0)
                     {
                        point.x = this.x - 20;
                     }
                     else
                     {
                        point.x = this.x + 20;
                     }
                     point.y = this.y - 70;
                     this.doHit2_1(direct,point);
                  }
               }
               if(gc.isSingleGame() || gc.sid == this.sourceRole.sid)
               {
                  if(p.x == 4)
                  {
                     if(this.bbdc.getCurFrameCount() == 1)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x + 210;
                        }
                        else
                        {
                           point.x = this.x - 210;
                        }
                        point.y = this.y + 50;
                        this.doHit2_2(direct,point);
                     }
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         if(this._petInfo.findHasStudySkill("jf"))
         {
            if(this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("jf"))
            {
               return true;
            }
         }
         return false;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         if(this._petInfo.findHasStudySkill("bs"))
         {
            if(this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("bs"))
            {
               return true;
            }
         }
         return false;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         if(this._petInfo.findHasStudySkill("ysaoyi"))
         {
            if(this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("ysaoyi"))
            {
               return true;
            }
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
         this.faceToTarget();
         this.addCurAddEffect([{
            "name":BaseAddEffect.PET_RABBIT_JIFENG,
            "time":gc.frameClips * 10
         }]);
         if(gc.sid == this.sourceRole.sid)
         {
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit2Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("jf"));
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setAction("hit2");
         this.lastHit = "hit2";
         if(gc.sid == this.sourceRole.sid)
         {
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit3Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("jf"));
      }
      
      override protected function releSkill3() : void
      {
         this.addAoyiBuff();
         this.addCurAddEffect([{
            "name":BaseAddEffect.PET_RABBIT4_AOYI1,
            "time":gc.frameClips * 10
         },{
            "name":BaseAddEffect.PET_RABBIT4_AOYI2,
            "time":gc.frameClips * 10
         }]);
         if(this.sourceRole)
         {
            this.sourceRole.addCurAddEffect([{
               "name":BaseAddEffect.PET_RABBIT4_AOYI1,
               "time":gc.frameClips * 10
            }]);
         }
      }
      
      private function doHit1(direct:uint, point:Point) : void
      {
         var b:EnemyMoveBullet = new EnemyMoveBullet("PetPetRabbitBullet1");
         if(direct == 0)
         {
            b.setSpeed(-15,0);
         }
         else
         {
            b.setSpeed(15,0);
         }
         b.setDistance(600);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 4);
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         b.setFuncWhenHit(hit1Over);
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2_1(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetPetRabbitBulletBuff");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setDisable();
         b.setAction("hit3");
         b.setFuncWhenHit(hit1Over);
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2_2(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetPetRabbitBullet4");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         b.setFuncWhenHit(hit1Over);
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function hit1Over(bb:BaseBullet) : void
      {
         this.checkSkillYG(bb);
      }
      
      private function checkSkillYG(bb:BaseBullet) : void
      {
         var rate:Number = NaN;
         var b:* = null;
         if(this._petInfo.findHasStudySkill("yg"))
         {
            rate = 0.3;
            if(this.getCurAddEffect(BaseAddEffect.PET_RABBIT4_AOYI2))
            {
               rate = 0.5;
            }
            if(RandomControllor.getIns().getRandom() < rate)
            {
               b = new SpecialEffectBullet("Monster130Bullet2");
               b.x = bb.x;
               b.y = bb.y - 40;
               b.setRole(this);
               b.setDirect(0);
               b.setAction("hit2");
               gc.gameSence.addChild(b);
               this.magicBulletArray.push(b);
            }
         }
      }
      
      override public function setOtherAttack(attackKind:String, direct:uint, point:Point, params:Array = null, initTimer:uint = 0) : void
      {
         switch(attackKind)
         {
            case "hit1":
               this.doHit1(direct,point);
               break;
            case "hit3":
               this.doHit2_2(direct,point);
               break;
            case "hit2Action":
               this.releSkill1();
               break;
            case "hit3Action":
               this.releSkill2();
               break;
            case "normalHit":
               this.normalHit();
         }
      }
      
      override protected function normalHit() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setAction("hit1");
         this.lastHit = "hit1";
         if(gc.sid == this.sourceRole.sid)
         {
            gc.sendPetAttack(this.sourceRole.getRoleId(),"normalHit",this.getBBDC().getDirect(),0,0,[]);
         }
      }
      
      override public function getRealPower(cur:String, crit:Boolean = true) : int
      {
         var obj:* = null;
         obj = null;
         var critValue:uint = !!this.getCriteValue(crit) ? 2 : 1;
         var hurtAdd:uint = this.getMagicAddValue();
         var wsAdd:Number = !!this.isGXP ? 1.2 : 1;
         switch(cur)
         {
            case "hit1":
               return (this._petInfo.getAtk() + hurtAdd) * critValue * wsAdd * this.hurtBaseEffectRate();
            case "hit2":
               obj = this._petInfo.getPetHarmObj("yg");
               if(obj)
               {
                  return (obj.first + hurtAdd) * critValue * wsAdd * this.hurtBaseEffectRate();
               }
               return 0;
               break;
            case "hit3":
               obj = this._petInfo.getPetHarmObj("bs");
               if(obj)
               {
                  return (obj.first + hurtAdd) * critValue * wsAdd * this.hurtBaseEffectRate();
               }
               return 0;
               break;
            default:
               return 0;
         }
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
         if(this.getCurAddEffect(BaseAddEffect.PET_RABBIT_JIFENG))
         {
            this.attackRate = 1;
         }
         else
         {
            this.attackRate = 0.7;
         }
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit2";
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1";
      }
   }
}
