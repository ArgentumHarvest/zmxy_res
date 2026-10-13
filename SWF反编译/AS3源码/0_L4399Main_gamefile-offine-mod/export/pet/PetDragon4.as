package export.pet
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BasePet;
   import com.greensock.TweenMax;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import petInfo.PetInfo;
   
   public class PetDragon4 extends BasePet
   {
       
      
      public var continueCount:int = 0;
      
      public var totalHurt:int = 0;
      
      private var type:int = 0;
      
      private var fenshenArray:Array;
      
      public var isAoyi:Boolean = false;
      
      public function PetDragon4(bh:BaseHero, pi:PetInfo)
      {
         fenshenArray = [];
         super(bh,pi);
         this.horizenSpeed = 5;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":10,
            "power":12,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":8,
            "power":12,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":999,
            "power":12,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":999,
            "power":12,
            "attackKind":"magic"
         };
         this.attackRange = 150;
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 2,gc.frameClips * 20];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 10];
         this.skillCD3 = [gc.frameClips * 8,gc.frameClips * 16];
         this.skillCD4 = [gc.frameClips * 30,gc.frameClips * 60];
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
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("PetDragonBmd4");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,250,new Point(0,0));
            bbdc.setOffsetXY(31,-25);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,7,2,2,10],[2,2,2,2,10],[30],[2,2,30],[48],[2,40]]);
            bbdc.setFrameCount([6,4,1,5,6,5,1,3,1,2]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("PetDragonBmd4--BitmapData Error!");
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
               this.isAoyi = false;
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "walk":
               this.isAoyi = false;
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               this.isAoyi = false;
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
            case "hit6":
               if(curPoint.y != 9)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(9);
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
               this.setStatic();
               if(this.isAoyi)
               {
                  if(this._petInfo.findHasStudySkill("ltwj"))
                  {
                     this.releSkill3WithoutMana();
                  }
                  else
                  {
                     this.isAoyi = false;
                     this.setAction("wait");
                  }
               }
               else
               {
                  this.setAction("wait");
               }
               break;
            case "hit4":
               this.isAoyi = false;
               this.setAction("wait");
               break;
            case "hit5":
               if(this.isAoyi)
               {
                  if(this._petInfo.findHasStudySkill("sdcc"))
                  {
                     this.releSkill2WithoutMana();
                  }
                  else if(this._petInfo.findHasStudySkill("ltwj"))
                  {
                     this.setAction("hit6");
                     this.lastHit = "hit6";
                  }
                  else
                  {
                     this.setAction("wait");
                  }
               }
               else
               {
                  this.setAction("wait");
               }
               break;
            case "hit6":
               this.releSkill3WithoutMana();
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
                     if(this.bbdc.getCurFrameCount() == 7)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 65;
                        }
                        else
                        {
                           point.x = this.x + 65;
                        }
                        point.y = this.y - 15;
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
               break;
            case "hit3":
               if(gc.isSingleGame() || gc.sid == this.sourceRole.sid)
               {
                  if(p.x == 0)
                  {
                     if(this.bbdc.getCurFrameCount() == 24)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 0;
                        }
                        else
                        {
                           point.x = this.x + 0;
                        }
                        point.y = this.y + 10;
                        this.doHit3(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit3",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
                  if(direct == 0)
                  {
                     this.speed.x = -10;
                  }
                  else
                  {
                     this.speed.x = 10;
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
                           point.x = this.x - 0;
                        }
                        else
                        {
                           point.x = this.x + 0;
                        }
                        point.y = this.y + 40;
                        this.doHit4(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit4",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit5":
               if(gc.isSingleGame() || gc.sid == this.sourceRole.sid)
               {
                  this.speed.x = 0;
                  this.speed.y = -5;
                  if(p.x == 0)
                  {
                     if(this.bbdc.getCurFrameCount() == 48)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 0;
                        }
                        else
                        {
                           point.x = this.x + 0;
                        }
                        point.y = this.y + 40;
                        this.doHit5(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit5",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                     else if(this.bbdc.getCurFrameCount() == 36)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 0;
                        }
                        else
                        {
                           point.x = this.x + 0;
                        }
                        point.y = this.y + 40;
                        this.doHit5(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit5",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                     else if(this.bbdc.getCurFrameCount() == 24)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 0;
                        }
                        else
                        {
                           point.x = this.x + 0;
                        }
                        point.y = this.y + 40;
                        this.doHit5(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit5",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                     else if(this.bbdc.getCurFrameCount() == 12)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 0;
                        }
                        else
                        {
                           point.x = this.x + 0;
                        }
                        point.y = this.y + 40;
                        this.doHit5(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit5",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit6":
               if(gc.isSingleGame() || gc.sid == this.sourceRole.sid)
               {
                  if(this.standInObj)
                  {
                     this.releSkill3WithoutMana();
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
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this._petInfo.findHasStudySkill("sdcc") && this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("sdcc") && this.curAttackTarget != null && AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= 300;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this._petInfo.findHasStudySkill("ltwj") && this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("ltwj") && this.curAttackTarget != null && AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= 500;
      }
      
      override protected function beforeSkill4Start() : Boolean
      {
         var dis:Number = NaN;
         if(this.type == 0)
         {
            if(this.curAttackTarget)
            {
               if(this._petInfo.findHasStudySkill("qlaoyi") && this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("qlaoyi"))
               {
                  dis = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget);
                  if(dis <= 200)
                  {
                     return true;
                  }
               }
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
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit2Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this.newAttackId();
         this.setAction("hit2");
         this.lastHit = "hit2";
         this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("fs"));
      }
      
      override protected function releSkill2() : void
      {
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit3Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this.newAttackId();
         this.setAction("hit3");
         this.lastHit = "hit3";
         this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("sdcc"));
      }
      
      public function releSkill2WithoutMana() : void
      {
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit3Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this.newAttackId();
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit4Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this.newAttackId();
         this.setAction("hit4");
         this.lastHit = "hit4";
         this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("ltwj"));
      }
      
      public function releSkill3WithoutMana() : void
      {
         if(gc.sid == this.sourceRole.sid)
         {
            if(this.type == 0)
            {
               this.faceToTarget();
            }
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit4Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this.newAttackId();
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      override protected function releSkill4() : void
      {
         this.isAoyi = true;
         this.addAoyiBuff();
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit5Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this.newAttackId();
         this.setAction("hit5");
         this.lastHit = "hit5";
      }
      
      private function doHit1(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetDragon3Bullet1");
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
         var pd4:PetDragon4 = this.createFenshen();
      }
      
      private function createFenshen() : PetDragon4
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
         pi.setCurExper(0);
         pi.skill = this._petInfo.skill.concat();
         pi.isFight = 1;
         var pd1:PetDragon4 = new PetDragon4(this.sourceRole,pi);
         pd1.setContinueTime(gc.frameClips * 12);
         pd1.alpha = 0.5;
         pd1.x = this.x + (RandomControllor.getIns().getRandom() - 0.5) * 300;
         pd1.y = this.y - 50;
         gc.gameSence.addChild(pd1);
         this.fenshenArray.push(pd1);
         return pd1;
      }
      
      private function doHit3(direct:uint, point:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("PetDragon2Bullet2");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         if(this.type == 1)
         {
            b.setFuncWhenHit(addHurt);
         }
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4(direct:uint, point:Point) : void
      {
         direct = direct;
         point = point;
         this.doSingleHit4(direct,point);
         TweenMax.delayedCall(0.2,function(_self:PetDragon4, _direct:uint, _point:Point):*
         {
            if(!_self.isDead() && _self._petInfo.isFight == 1)
            {
               _self.doSingleHit4(_direct,new Point(_point.x - 150,_point.y - 10));
               _self.doSingleHit4(_direct,new Point(_point.x + 90,_point.y - 25));
            }
         },[this,direct,point]);
         TweenMax.delayedCall(0.4,function(_self:PetDragon4, _direct:uint, _point:Point):*
         {
            if(!_self.isDead() && _self._petInfo.isFight == 1)
            {
               _self.doSingleHit4(_direct,new Point(_point.x - 90,_point.y - 25));
               _self.doSingleHit4(_direct,new Point(_point.x + 150,_point.y - 10));
            }
         },[this,direct,point]);
         TweenMax.delayedCall(0.6,function(_self:PetDragon4, _direct:uint, _point:Point):*
         {
            if(!_self.isDead() && _self._petInfo.isFight == 1)
            {
               _self.doSingleHit4(_direct,new Point(_point.x - 270,_point.y - 25));
               _self.doSingleHit4(_direct,new Point(_point.x + 210,_point.y - 10));
            }
         },[this,direct,point]);
         TweenMax.delayedCall(0.8,function(_self:PetDragon4, _direct:uint, _point:Point):*
         {
            if(!_self.isDead() && _self._petInfo.isFight == 1)
            {
               _self.doSingleHit4(_direct,new Point(_point.x - 210,_point.y - 25));
               _self.doSingleHit4(_direct,new Point(_point.x + 270,_point.y - 10));
            }
         },[this,direct,point]);
      }
      
      private function doSingleHit4(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetDragon3Bullet3");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         if(this.type == 1)
         {
            b.setFuncWhenHit(addHurt);
         }
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit5(direct:uint, point:Point) : void
      {
         var b:* = null;
         var pd4:* = null;
         if(this.bbdc)
         {
            if(this.bbdc.getCurFrameCount() == 48)
            {
               b = new FollowBaseObjectBullet("PetDragonBullet4");
               b.x = this.x;
               b.y = this.y;
               b.setHurtCanCutDownEffect(false);
               b.setRole(this);
               b.setDirect(direct);
               b.setAction("hit4");
               gc.gameSence.addChild(b);
               this.magicBulletArray.push(b);
            }
         }
         if(this._petInfo.findHasStudySkill("fs"))
         {
            pd4 = this.createFenshen();
            if(this.bbdc)
            {
               if(this.bbdc.getCurFrameCount() == 48)
               {
                  pd4.turnLeft();
               }
               else if(this.bbdc.getCurFrameCount() == 36)
               {
                  pd4.turnRight();
               }
               else if(this.bbdc.getCurFrameCount() == 24)
               {
                  pd4.turnLeft();
               }
               else if(this.bbdc.getCurFrameCount() == 12)
               {
                  pd4.turnRight();
               }
            }
            pd4.isAoyi = true;
            if(this._petInfo.findHasStudySkill("sdcc"))
            {
               pd4.releSkill2WithoutMana();
            }
            else if(this._petInfo.findHasStudySkill("ltwj"))
            {
               pd4.setAction("hit6");
               pd4.lastHit = "hit6";
            }
            else
            {
               pd4.isAoyi = false;
               this.isAoyi = false;
            }
         }
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
         var critValue:uint = !!this.getCriteValue(crit) ? 2 : 1;
         var hurtAdd:uint = this.getMagicAddValue();
         var wsAdd:Number = !!this.isGXP ? 1.2 : 1;
         switch(cur)
         {
            case "hit1":
               return (this._petInfo.getAtk() + hurtAdd) * critValue * wsAdd * this.hurtBaseEffectRate();
            case "hit2":
               obj = this._petInfo.getPetHarmObj("sdcc");
               if(obj)
               {
                  return (obj.first + hurtAdd) * critValue * wsAdd * this.hurtBaseEffectRate();
               }
               return 0;
               break;
            case "hit3":
               obj = this._petInfo.getPetHarmObj("ltwj");
               if(obj)
               {
                  return (obj.first + hurtAdd) * critValue * wsAdd * this.hurtBaseEffectRate();
               }
               return 0;
               break;
            case "hit4":
               obj = this._petInfo.getPetHarmObj("ltwj");
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
                     this.addExp(pd.getExp());
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
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit3" || this.curAction == "hit5";
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit4";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6";
      }
      
      override public function destroy() : void
      {
         if(this.type == 0)
         {
            for each(pd1 in this.fenshenArray)
            {
               pd1._petInfo.isFight = 0;
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
               "onComplete":function(_self:PetDragon4):*
               {
                  if(_self.sourceRole)
                  {
                     _self.sourceRole = null;
                  }
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
         }
         this.fenshenArray.length = 0;
      }
   }
}
