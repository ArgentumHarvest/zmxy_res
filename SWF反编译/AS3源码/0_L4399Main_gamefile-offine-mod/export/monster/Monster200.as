package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import com.superkaka.Tools.ColorAdjust;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster200 extends BaseMonster
   {
       
      
      private var aoyiStep:uint = 0;
      
      private var isAtkUp:Boolean = false;
      
      private var baseHurt:int = 100;
      
      public function Monster200()
      {
         super();
         this.horizenSpeed = 5;
         this._anti.def = 80 + 1.5 * gc.hero1.roleProperies.getDefense();
         this._anti.exp = 6;
         this._anti.gxp = 2;
         this.setHp(50000 + 2 * gc.hero1.roleProperies.getLevel() * gc.hero1.roleProperies.getSHHP());
         this.setSHp(this.getHp());
         this.baseHurt = 300 + 1.7 * gc.hero1.roleProperies.getHurt();
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":this.baseHurt * 2,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":7,
            "power":this.baseHurt * 2,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3_1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":this.baseHurt * 2,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.Pet_TIGER_SXHZ,
               "time":gc.frameClips * 2,
               "direct":0
            }]
         };
         this.attackBackInfoDict["hit3_2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":this.baseHurt * 2,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-8,0],
            "attackInterval":3,
            "power":this.baseHurt * 2,
            "attackKind":"magic"
         };
         this.attackRange = 40;
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 4,gc.frameClips * 8];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 9];
         this.skillCD3 = [gc.frameClips * 6,gc.frameClips * 10];
         this.skillCD4 = [gc.frameClips * 15,gc.frameClips * 35];
         this._anti.fallProbability = 0.1;
         var kind:int = 5 + Math.ceil(RandomControllor.getIns().getRandom() * 4);
         this._anti.fallList = [{
            "name":"p_cybxjl",
            "bigtype":"cwzb"
         },{
            "name":"lssp_" + kind,
            "bigtype":"dj"
         }];
         this.isBoss = true;
         this.monsterName = "邪.白虎";
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
         var ca:ColorAdjust = new ColorAdjust();
         ca.adjustHue(-150);
         var cmf:ColorMatrixFilter = new ColorMatrixFilter(ca);
         bbdc.filters = [cmf];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("PetTigerBmd4");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
            bbdc.setOffsetXY(15,-15);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[2,2,10],[2,2,2,2,10],[3,3,3],[2,2,2,50,2,2]]);
            bbdc.setFrameCount([6,4,1,5,4,3,5,3,6]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("PetTigerBmd4--BitmapData Error!");
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
               this.aoyiStep = 0;
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
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "hit4":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit5":
               if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(str);
               break;
            case "hit6":
               this.isAtkUp = true;
               if(curPoint.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               this.aoyiStep = 0;
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
               if(this.aoyiStep == 1)
               {
                  this.releSkill4WithoutMp();
               }
               if(this.aoyiStep == 2)
               {
                  this.doBeforeHit5_3();
               }
               break;
            case "hit2":
               if(this.aoyiStep == 1)
               {
                  this.releSkill4WithoutMp();
               }
               else
               {
                  this.setAction("wait");
               }
               break;
            case "hit3":
               if(this.aoyiStep == 2)
               {
                  this.doBeforeHit5_3();
               }
               else
               {
                  this.setAction("wait");
               }
               break;
            case "hit4":
               if(this.aoyiStep > 0)
               {
                  this.aoyiStep = 0;
               }
               this.setAction("wait");
               break;
            case "hit5":
               this.setAction("wait");
               break;
            case "hit6":
               this.doHit5_3();
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
               this.fallEquip();
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
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     if(direct == 0)
                     {
                        point.x = this.x - 130;
                     }
                     else
                     {
                        point.x = this.x + 130;
                     }
                     point.y = this.y - 70;
                     this.doHit1(direct,point);
                  }
               }
               break;
            case "hit2":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     if(direct == 0)
                     {
                        point.x = this.x - 190;
                     }
                     else
                     {
                        point.x = this.x + 190;
                     }
                     point.y = this.y - 80;
                     this.doHit2(direct,point);
                  }
               }
               break;
            case "hit3":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     if(direct == 0)
                     {
                        point.x = this.x - 50;
                     }
                     else
                     {
                        point.x = this.x + 50;
                     }
                     point.y = this.y - 65;
                     this.doHit3_1(direct,point);
                  }
                  else if(this.bbdc.getCurFrameCount() == 1)
                  {
                     if(direct == 0)
                     {
                        point.x = this.x - 200;
                     }
                     else
                     {
                        point.x = this.x + 200;
                     }
                     point.y = this.y - 200;
                     this.doHit3_2(direct,point);
                  }
               }
               break;
            case "hit4":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(direct == 0)
                     {
                        point.x = this.x - 85;
                     }
                     else
                     {
                        point.x = this.x + 85;
                     }
                     point.y = this.y - 130;
                     this.doHit4_1(direct,point);
                  }
               }
               if(p.x == 4)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     if(direct == 0)
                     {
                        point.x = this.x - 105;
                     }
                     else
                     {
                        point.x = this.x + 105;
                     }
                     point.y = this.y - 2;
                     this.doHit4_2(direct,point);
                  }
               }
               break;
            case "hit5":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     this.doHit5();
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         var dis:Number = NaN;
         if(this.curAttackTarget)
         {
            dis = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget);
            return dis >= 50 && dis <= 100;
         }
         return false;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         var dis:Number = NaN;
         if(this.curAttackTarget)
         {
            dis = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget);
            return dis <= 80;
         }
         return false;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         var dis:Number = NaN;
         if(this.curAttackTarget)
         {
            dis = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget);
            return dis <= 450;
         }
         return false;
      }
      
      override protected function beforeSkill4Start() : Boolean
      {
         return this.curAttackTarget != null;
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,canHurt);
      }
      
      override protected function releSkill1() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      private function releSkill1WithoutMp() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      private function releSkill2WithoutMp() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      override protected function releSkill4() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit5");
         this.lastHit = "hit5";
      }
      
      private function releSkill4WithoutMp() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit5");
         this.lastHit = "hit5";
      }
      
      private function releSkill3WithoutMp() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      private function doHit1(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetTiger2Bullet1");
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
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetTiger1Bullet2");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3_1(dir:uint, point:Point) : void
      {
         this.attackBackInfoDict["hit3_1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":12,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.Pet_TIGER_SXHZ,
               "time":gc.frameClips * 2,
               "direct":dir
            }]
         };
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetTiger2Bullet3_1");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(dir);
         b.setAction("hit3_1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3_2(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetTiger2Bullet3_2");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3_2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b.setFuncWhenHit(doWhenHit3_2hit);
      }
      
      private function doWhenHit3_2hit(bb:BaseBullet) : void
      {
         this.cureHp(this.getSHp() * 0.05);
      }
      
      private function doHit4_1(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetTiger3Bullet4_1");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setDisable();
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4_2(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetTiger3Bullet4_2");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit5() : void
      {
         this.setYourFather(gc.frameClips * 1);
         if(this.aoyiStep == 0)
         {
            this.aoyiStep = 1;
            if(this.curAttackTarget)
            {
               if(RandomControllor.getIns().getRandom() < 0.5)
               {
                  this.x = this.curAttackTarget.x - 80;
               }
               else
               {
                  this.x = this.curAttackTarget.x + 80;
               }
               this.faceToTarget();
               this.releSkill1WithoutMp();
            }
         }
         else if(this.aoyiStep == 1)
         {
            if(this.curAttackTarget)
            {
               if(RandomControllor.getIns().getRandom() < 0.5)
               {
                  this.x = this.curAttackTarget.x - 80;
               }
               else
               {
                  this.x = this.curAttackTarget.x + 80;
               }
               this.faceToTarget();
               this.doHit5_2();
            }
         }
      }
      
      private function doHit5_2() : void
      {
         this.setYourFather(gc.frameClips * 1);
         this.aoyiStep = 2;
         this.releSkill2WithoutMp();
      }
      
      private function doBeforeHit5_3() : void
      {
         this.setYourFather(gc.frameClips * 4);
         this.setAction("hit6");
         this.lastHit = "hit6";
      }
      
      private function doHit5_3() : void
      {
         trace("doHit5_3");
         this.aoyiStep = 3;
         this.releSkill3WithoutMp();
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
            case "hit3_1":
               this.doHit3_1(direct,point);
               break;
            case "hit3_2":
               this.doHit3_2(direct,point);
               break;
            case "hit4":
               this.doHit4_2(direct,point);
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
            case "hit6Action":
               this.doBeforeHit5_3();
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
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6";
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6";
      }
   }
}
