package export.pet
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseObject;
   import base.BasePet;
   import com.greensock.TweenMax;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import petInfo.PetInfo;
   
   public class PetHorse4 extends BasePet
   {
       
      
      private var skill1Release:Boolean = false;
      
      public function PetHorse4(bh:BaseHero, pi:PetInfo)
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
            "attackBackSpeed":[-10,0],
            "attackInterval":24,
            "power":12,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.PETHORSE_ICE,
               "time":gc.frameClips * 2
            }]
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":999,
            "power":12,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":999,
            "power":12,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit5_1"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":12,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit5_2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":12,
            "power":12,
            "attackKind":"magic"
         };
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 4,gc.frameClips * 8];
         this.skillCD2 = [gc.frameClips * 6,gc.frameClips * 10];
         this.skillCD3 = [gc.frameClips * 8,gc.frameClips * 15];
         this.skillCD4 = [gc.frameClips * 30,gc.frameClips * 60];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("PetHorseBmd4");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(1,-25);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,20],[15],[2,2,1,1,10],[2,2,20],[2,2,10]]);
            bbdc.setFrameCount([6,4,1,5,3,1,5,3,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("PetHorseBmd4--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite4") as Sprite;
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
            case "hit3":
               this.setAction("wait");
               break;
            case "hit4":
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
                  if(p.x == 2)
                  {
                     if(this.bbdc.getCurFrameCount() == 20)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 150;
                        }
                        else
                        {
                           point.x = this.x + 150;
                        }
                        point.y = this.y - 140;
                        this.doHit1(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit1",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit2":
               if(gc.isSingleGame() || gc.sid == this.sourceRole.sid)
               {
                  if(p.x == 0)
                  {
                     if(this.bbdc.getCurFrameCount() == 15)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 70;
                        }
                        else
                        {
                           point.x = this.x + 70;
                        }
                        point.y = this.y - 85;
                        this.doHit2(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit2",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit3":
               if(gc.isSingleGame() || gc.sid == this.sourceRole.sid)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getCurFrameCount() == 1)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 80;
                        }
                        else
                        {
                           point.x = this.x + 80;
                        }
                        point.y = this.y - 45;
                        this.doHit3(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit3",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit4":
               if(gc.isSingleGame() || gc.sid == this.sourceRole.sid)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getCurFrameCount() == 20)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 55;
                        }
                        else
                        {
                           point.x = this.x + 55;
                        }
                        point.y = this.y - 50;
                        this.doHit4(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit4",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit5":
               if(gc.isSingleGame() || gc.sid == this.sourceRole.sid)
               {
                  if(p.x == 2)
                  {
                     if(this.bbdc.getCurFrameCount() == 10)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 55;
                        }
                        else
                        {
                           point.x = this.x + 55;
                        }
                        point.y = this.y - 50;
                        this.doHit5(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit5",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.skill1Release && this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("bd") && this._petInfo.findHasStudySkill("bd");
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         var dis:Number = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget);
         return dis >= 50 && dis <= 100 && this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("sp") && this._petInfo.findHasStudySkill("sp");
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         var dis:Number = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget);
         return dis <= 250 && this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("bz") && this._petInfo.findHasStudySkill("bz");
      }
      
      override protected function beforeSkill4Start() : Boolean
      {
         var dis:Number = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget);
         return this.curAttackTarget != null && this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("tmaoyi") && this._petInfo.findHasStudySkill("tmaoyi");
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,canHurt);
         this.skill1Release = true;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit2Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this.setAction("hit2");
         this.lastHit = "hit2";
         this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("bd"));
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit3Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this.setAction("hit3");
         this.lastHit = "hit3";
         this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("sp"));
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit4Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this.setAction("hit4");
         this.lastHit = "hit4";
         this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("bz"));
      }
      
      override protected function releSkill4() : void
      {
         this.addAoyiBuff();
         this.setYourFather(20);
         this.newAttackId();
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit5Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this.setAction("hit5");
         this.lastHit = "hit5";
         this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("tmaoyi"));
      }
      
      private function doHit1(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetHorse3Bullet1");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2(direct:uint, point:Point) : void
      {
         this.setYourFather(15);
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("PetHorse3Bullet2");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setHurtCanCutDownEffect(false);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         this.skill1Release = false;
      }
      
      private function doHit3(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetHorse3Bullet3");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetHorse3Bullet4");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit5(direct:uint, point:Point) : void
      {
         var b:* = null;
         var target:* = null;
         var i:* = 0;
         trace("dohit5");
         if(this._petInfo.findHasStudySkill("bd"))
         {
            this.attackBackInfoDict["hit5_1"] = {
               "hitMaxCount":1,
               "attackBackSpeed":[0,0],
               "attackInterval":999,
               "power":12,
               "attackKind":"magic",
               "addEffect":[{
                  "name":BaseAddEffect.PETHORSE_ICE,
                  "time":gc.frameClips * 2
               }]
            };
         }
         else
         {
            this.attackBackInfoDict["hit5_1"] = {
               "hitMaxCount":1,
               "attackBackSpeed":[0,0],
               "attackInterval":999,
               "power":12,
               "attackKind":"magic"
            };
         }
         var maxNum:uint = gc.pWorld.monsterArray.length;
         for(i = uint(0); i < maxNum; )
         {
            target = gc.pWorld.monsterArray[maxNum - i - 1] as BaseObject;
            b = new EnemyMoveBullet("PetHorse4Bullet5");
            b.x = this.x + (maxNum / 2 - i) * 90;
            b.y = 50;
            b.setDestroyWhenLastFrame(false);
            b.setDestroyInCount(gc.frameClips * 10);
            b.setDistance(2000);
            b.setRole(this);
            b.setFuncWhenHit(this.hit5Hit);
            b.setDirect(0);
            if(this._petInfo.findHasStudySkill("sp"))
            {
               b.setSpeed(0,1);
               b.setAddSpeed(0,1);
               b.setMoveTarget(target);
            }
            else
            {
               b.setSpeed(0,1);
               b.setAddSpeed(0,1);
            }
            b.setAction("hit5_1");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
            i++;
         }
      }
      
      private function hit5Hit(bb:BaseBullet) : void
      {
         bb = bb;
         if(this._petInfo.findHasStudySkill("bz"))
         {
            if(this._petInfo.findHasStudySkill("bd"))
            {
               TweenMax.delayedCall(1.9,function(_self:PetHorse4, _bb:BaseBullet):*
               {
                  var b:* = null;
                  if(!_self.isDead())
                  {
                     b = new SpecialEffectBullet("PetHorse4Bullet5Explode");
                     b.x = _bb.x;
                     b.y = _bb.y;
                     b.setRole(_self);
                     b.setDirect(0);
                     b.setAction("hit5_2");
                     gc.gameSence.addChild(b);
                     _self.magicBulletArray.push(b);
                  }
               },[this,bb]);
            }
            else if(!this.isDead())
            {
               var b:SpecialEffectBullet = new SpecialEffectBullet("PetHorse4Bullet5Explode");
               b.x = bb.x;
               b.y = bb.y;
               b.setRole(this);
               b.setDirect(0);
               b.setAction("hit5_2");
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
            case "hit2":
               this.doHit2(direct,point);
               break;
            case "hit3":
               this.doHit3(direct,point);
               break;
            case "hit4":
               this.doHit4(direct,point);
               break;
            case "hit5":
               this.doHit5(direct,point);
               break;
            case "hit2Action":
               this.releSkill1();
               break;
            case "hit3Action":
               this.releSkill2();
               break;
            case "hit4Action":
               this.releSkill3();
               break;
            case "hit5Action":
               this.releSkill4();
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
         var obj:* = null;
         obj = null;
         obj = null;
         obj = null;
         obj = null;
         var critValue:uint = !!this.getCriteValue(crit) ? 2 : 1;
         var hurtAdd:uint = this.getMagicAddValue();
         var wsAdd:Number = !!this.isGXP ? 1.2 : 1;
         switch(cur)
         {
            case "hit1":
               return (this._petInfo.getAtk() + hurtAdd) * critValue * wsAdd * this.hurtBaseEffectRate();
            case "hit2":
               obj = this._petInfo.getPetHarmObj("bd");
               if(obj)
               {
                  return (obj.first + hurtAdd) * critValue * wsAdd * this.hurtBaseEffectRate();
               }
               return 0;
               break;
            case "hit3":
               obj = this._petInfo.getPetHarmObj("sp");
               if(obj)
               {
                  return (obj.first + hurtAdd) * critValue * wsAdd * this.hurtBaseEffectRate();
               }
               return 0;
               break;
            case "hit4":
               obj = this._petInfo.getPetHarmObj("bz");
               if(obj)
               {
                  return (obj.first + hurtAdd) * critValue * wsAdd * this.hurtBaseEffectRate();
               }
               return 0;
               break;
            case "hit5_1":
               obj = this._petInfo.getPetHarmObj("sp");
               if(obj)
               {
                  return (obj.first + hurtAdd) * critValue * wsAdd * this.hurtBaseEffectRate();
               }
               return 0;
               break;
            case "hit5_2":
               obj = this._petInfo.getPetHarmObj("bz");
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
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
   }
}
