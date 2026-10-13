package export.pet
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import base.BasePet;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mvc.controllor.RandomControllor;
   import petInfo.PetInfo;
   
   public class PetMonkey4 extends BasePet
   {
       
      
      private const hit5Const:int = 5;
      
      private var hit5Times:int = 0;
      
      private var skill3Release:Boolean = false;
      
      public function PetMonkey4(bh:BaseHero, pi:PetInfo)
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
            "attackBackSpeed":[-15,0],
            "attackInterval":24,
            "power":12,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.PETMONKEY_FIRE,
               "time":4 * gc.frameClips,
               "hurt":this._petInfo.getAtk() / 10
            }]
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":24,
            "power":12,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":24,
            "power":12,
            "attackKind":"physics"
         };
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 4,gc.frameClips * 8];
         this.skillCD2 = [gc.frameClips * 4,gc.frameClips * 10];
         this.skillCD3 = [gc.frameClips * 4,gc.frameClips * 15];
         this.skillCD4 = [gc.frameClips * 30,gc.frameClips * 60];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("PetMonkeyBmd4");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(-8,-5);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,8],[2,9,15],[10],[1,1],[2,2,2]]);
            bbdc.setFrameCount([6,4,1,5,3,3,1,20,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("PetMonkeyBmd4--BitmapData Error!");
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
               this.hit5Times = 0;
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
         var randMonsterArray:* = null;
         var rect:* = null;
         var randMonster:* = null;
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
               if(this.hit5Times > 0)
               {
                  this.setAction("hit5");
               }
               else
               {
                  this.setAction("wait");
               }
               break;
            case "hit2":
               if(this.hit5Times > 0)
               {
                  this.setAction("hit5");
               }
               else
               {
                  this.setAction("wait");
               }
               break;
            case "hit3":
               this.setAction("wait");
               break;
            case "hit4":
               if(this.hit5Times > 0)
               {
                  this.setAction("hit5");
               }
               else
               {
                  this.setAction("wait");
               }
               break;
            case "hit5":
               if(this.hit5Times > 0)
               {
                  randMonsterArray = [];
                  for each(var bm in gc.pWorld.monsterArray)
                  {
                     rect = bm.colipse.getBounds(gc.gameSence.parent);
                     if(rect.x > 20 && rect.x < 920)
                     {
                        randMonsterArray.push(bm);
                     }
                  }
                  if(randMonsterArray.length > 0)
                  {
                     randMonster = randMonsterArray[int(RandomControllor.getIns().getRandom() * randMonsterArray.length)];
                     if(RandomControllor.getIns().getRandom() < 0.5)
                     {
                        this.x = randMonster.x - 50;
                     }
                     else
                     {
                        this.x = randMonster.x + 50;
                     }
                     this.y = randMonster.y - 30;
                     this.curAttackTarget = randMonster;
                     if(this.hit5Times > 1)
                     {
                        if(this._petInfo.findHasStudySkill("xj"))
                        {
                           this.releSkill2NoUseMana();
                        }
                        if(this._petInfo.findHasStudySkill("lj"))
                        {
                           this.releSkill3NoUseMana();
                        }
                        else
                        {
                           this.normalHit();
                        }
                     }
                     else if(this._petInfo.findHasStudySkill("lyq"))
                     {
                        this.releSkill1NoUseMana();
                     }
                     else
                     {
                        this.normalHit();
                     }
                     this.hit5Times--;
                  }
                  else
                  {
                     this.hit5Times = 0;
                     this.x = this.sourceRole.x;
                     this.y = this.sourceRole.y - 50;
                     this.setAction("wait");
                  }
               }
               else
               {
                  this.x = this.sourceRole.x;
                  this.y = this.sourceRole.y - 50;
                  this.setAction("wait");
               }
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
                     if(this.bbdc.getCurFrameCount() == 8)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 100;
                        }
                        else
                        {
                           point.x = this.x + 100;
                        }
                        point.y = this.y - 40;
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
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 35;
                        }
                        else
                        {
                           point.x = this.x + 35;
                        }
                        point.y = this.y - 60;
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
                     if(this.bbdc.getCurFrameCount() == 10)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 45;
                        }
                        else
                        {
                           point.x = this.x + 45;
                        }
                        point.y = this.y - 50;
                        this.doHit3(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit3",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit4":
               if(gc.isSingleGame() || gc.sid == this.sourceRole.sid)
               {
                  if(p.x == 0)
                  {
                     if(this.bbdc.getCurFrameCount() == 1)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x;
                        }
                        else
                        {
                           point.x = this.x;
                        }
                        point.y = this.y - 15;
                        this.doHit4_1(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit4_1",this.getBBDC().getDirect(),point.x,point.y,[]);
                        if(direct == 0)
                        {
                           point.x = this.x - 10;
                        }
                        else
                        {
                           point.x = this.x + 10;
                        }
                        point.y = this.y - 15;
                        this.doHit4_2(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit4_2",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit5":
         }
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("lj") && this.skill3Release && this._petInfo.findHasStudySkill("lj");
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("lyq") && AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= 400 && this._petInfo.findHasStudySkill("lyq");
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("xj") && this._petInfo.findHasStudySkill("xj");
      }
      
      override protected function beforeSkill4Start() : Boolean
      {
         return this.curAttackTarget != null && this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("jgaoyi") && this._petInfo.findHasStudySkill("jgaoyi");
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,canHurt);
         this.skill3Release = true;
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
         this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("lyq"));
      }
      
      private function releSkill1NoUseMana() : void
      {
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit2Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this.setYourFather(24);
         this.newAttackId();
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      private function releSkill2NoUseMana() : void
      {
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit3Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this.setYourFather(24);
         this.newAttackId();
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      private function releSkill3NoUseMana() : void
      {
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit4Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this.setYourFather(24);
         this.newAttackId();
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      override protected function releSkill2() : void
      {
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit3Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this.setYourFather(20);
         this.newAttackId();
         this.setAction("hit3");
         this.lastHit = "hit3";
         this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("xj"));
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
         this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("lj"));
      }
      
      override protected function releSkill4() : void
      {
         this.addAoyiBuff();
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit5Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this.setYourFather(20);
         this.hit5Times = 5;
         this.newAttackId();
         this.setAction("hit5");
         this.lastHit = "hit5";
         this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("jgaoyi"));
      }
      
      private function doHit1(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetMonkey3Bullet1");
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
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetMonkey3Bullet2");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4_1(direct:uint, point:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("PetMonkey3Bullet3_1");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit4");
         var idx:int = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(b,idx);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4_2(direct:uint, point:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("PetMonkey3Bullet3_2");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3(direct:uint, point:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("PetMonkey1Bullet2");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDestroyWhenLastFrame(false);
         b.setHurtCanCutDownEffect(false);
         b.setDestroyInCount(gc.frameClips * 4);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         this.skill3Release = false;
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
            case "hit4_1":
               this.doHit4_1(direct,point);
               break;
            case "hit4_2":
               this.doHit4_2(direct,point);
               break;
            case "hit5Action":
               this.releSkill4();
               break;
            case "hit4Action":
               this.releSkill3();
               break;
            case "hit3Action":
               this.releSkill2();
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
         this.setYourFather(12);
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
               obj = this._petInfo.getPetHarmObj("lyq");
               if(obj)
               {
                  return (obj.first + hurtAdd) * critValue * wsAdd * this.hurtBaseEffectRate();
               }
               return 0;
               break;
            case "hit3":
               obj = this._petInfo.getPetHarmObj("xj");
               if(obj)
               {
                  return obj.first * wsAdd * this.hurtBaseEffectRate();
               }
               return 0;
               break;
            case "hit4":
               obj = this._petInfo.getPetHarmObj("lj");
               if(obj)
               {
                  return (obj.first + hurtAdd) * critValue * wsAdd * this.hurtBaseEffectRate();
               }
               return 0;
               break;
            case "hit5":
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
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override protected function move() : void
      {
         if(!(this.curAction == "hit2" || this.curAction == "hit4" || this.curAction == "hit1"))
         {
            super.move();
         }
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3";
      }
   }
}
