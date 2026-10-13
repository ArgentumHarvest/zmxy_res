package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import com.superkaka.Tools.ColorAdjust;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster201 extends BaseMonster
   {
       
      
      private var isAoyi:Boolean = false;
      
      private var baseHurt:int = 100;
      
      public function Monster201()
      {
         super();
         this.horizenSpeed = 5;
         this.baseHurt = 320 + 1.6 * gc.hero1.roleProperies.getHurt();
         this._anti.def = 60 + gc.hero1.roleProperies.getDefense();
         this._anti.exp = 6;
         this._anti.gxp = 2;
         this.setHp(45000 + 2 * gc.hero1.roleProperies.getLevel() * gc.hero1.roleProperies.getSHHP());
         this.setSHp(this.getHp());
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":this.baseHurt * 3,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":5,
            "power":this.baseHurt * 3,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":999,
            "power":this.baseHurt * 4,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":999,
            "power":this.baseHurt * 4,
            "attackKind":"magic"
         };
         this.attackRange = 200;
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 5,gc.frameClips * 10];
         this.skillCD2 = [gc.frameClips * 6,gc.frameClips * 12];
         this.skillCD3 = [gc.frameClips * 8,gc.frameClips * 15];
         this.skillCD4 = [gc.frameClips * 15,gc.frameClips * 35];
         this.isBoss = true;
         this.monsterName = "邪.朱雀";
         this._anti.fallProbability = 0.1;
         var kind:int = 5 + Math.ceil(RandomControllor.getIns().getRandom() * 4);
         this._anti.fallList = [{
            "name":"p_cylhjl",
            "bigtype":"cwzb"
         },{
            "name":"lssp_" + kind,
            "bigtype":"dj"
         }];
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
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("PetPhoenixBmd4");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
            bbdc.setOffsetXY(8,-40);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8,120],[2,2,2,2,10],[2,2,2,10],[2,2,2,24],[2,2,10],[22],[3,3,50]]);
            bbdc.setFrameCount([6,4,[1,1],5,4,3,3,1,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("PetPhoenixBmd4--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite4") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      private function doWhenAoyiOver() : void
      {
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":5,
            "power":12,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":999,
            "power":12,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":999,
            "power":12,
            "attackKind":"magic"
         };
      }
      
      private function doWhenAoyiStart() : void
      {
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":5,
            "power":12,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.PETMONKEY_FIRE,
               "time":5 * gc.frameClips,
               "hurt":this.baseHurt
            }]
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":999,
            "power":12,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.PETMONKEY_FIRE,
               "time":5 * gc.frameClips,
               "hurt":this.baseHurt
            }]
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":999,
            "power":12,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.PETMONKEY_FIRE,
               "time":5 * gc.frameClips,
               "hurt":this.baseHurt
            }]
         };
      }
      
      override public function setAction(str:String) : void
      {
         if(this.curAction == "hit2")
         {
            if(str == "hurt")
            {
               return;
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
               this.isAoyi = false;
               this.doWhenAoyiOver();
               if(curPoint.x != 0 && curPoint.y != 2)
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
               if(curPoint.x != 1 && curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(1);
                  this.bbdc.setFramePointY(2);
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
               this.doHit2_2(this.getBBDC().getDirect(),new Point(this.x,this.y));
               this.setHp(this.getSHp() / 2);
               this.setAction("wait");
               break;
            case "hit3":
               this.isAoyi = false;
               this.doWhenAoyiOver();
               this.setAction("wait");
               break;
            case "hit4":
               this.setAction("wait");
               break;
            case "hit5":
               this.setStatic();
               this.setAction("hit6");
               break;
            case "hit6":
               this.isAoyi = false;
               this.doWhenAoyiOver();
               this.setAction("wait");
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
         var randHero:* = null;
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
                        point.x = this.x - 75;
                     }
                     else
                     {
                        point.x = this.x + 75;
                     }
                     point.y = this.y - 30;
                     this.doHit1(direct,point);
                  }
               }
               break;
            case "hit2":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 120)
                  {
                     if(direct == 0)
                     {
                        point.x = this.x;
                     }
                     else
                     {
                        point.x = this.x;
                     }
                     point.y = this.y - 60;
                     this.doHit2_1(direct,point);
                  }
               }
               break;
            case "hit3":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(direct == 0)
                     {
                        point.x = this.x - 130;
                     }
                     else
                     {
                        point.x = this.x + 130;
                     }
                     point.y = this.y - 95;
                     this.doHit3(direct,point);
                  }
               }
               break;
            case "hit4":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     point.y = this.y - 95;
                     this.doHit4(direct,point);
                  }
               }
               break;
            case "hit5":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 22)
                  {
                     point.x = this.x;
                     point.y = this.y;
                     this.doHit5(direct,point);
                  }
               }
               this.speed.x = 0;
               this.speed.y = -6;
               break;
            case "hit6":
               if(p.x == 0 || p.x == 1)
               {
                  if(p.x == 0)
                  {
                     if(this.bbdc.getCurFrameCount() == 3)
                     {
                        if(gc.pWorld.monsterArray.length > 0)
                        {
                           randHero = gc.getRandomPlayer();
                           if(randHero)
                           {
                              this.x = randHero.x;
                           }
                        }
                     }
                  }
                  this.speed.x = 0;
                  this.speed.y = 25;
               }
               else if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 50)
                  {
                     this.doHit6(direct,point);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         if(this.curAction != "hit2")
         {
            if(this.getHp() / this.getSHp() <= 0.2)
            {
               return true;
            }
         }
         return false;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         if(this.curAttackTarget)
         {
            if(AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= 400)
            {
               return true;
            }
         }
         return false;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         if(this.curAttackTarget)
         {
            if(AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= 500)
            {
               return true;
            }
         }
         return false;
      }
      
      override protected function beforeSkill4Start() : Boolean
      {
         if(this.curAttackTarget)
         {
            if(AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= 500)
            {
               return true;
            }
         }
         return false;
      }
      
      override protected function releSkill1() : void
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
         this.setYourFather(30);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      private function releSkill2WithoutMana() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(30);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(10);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      override protected function releSkill4() : void
      {
         this.isAoyi = true;
         this.doWhenAoyiStart();
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(48);
         this.setAction("hit5");
         this.lastHit = "hit5";
      }
      
      private function doHit1(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetPhoenix1Bullet1");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2_1(direct:uint, point:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("PetPhoenix1Bullet2_1");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDisable();
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 5);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2_2(direct:uint, point:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("PetPhoenix1Bullet2_2");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3(direct:uint, point:Point) : void
      {
         var b:* = null;
         b = new SpecialEffectBullet("PetPhoenix2Bullet3");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         if(this.isAoyi)
         {
            b = new SpecialEffectBullet("PetPhoenix4Bullet3_2");
            b.x = this.x;
            b.y = this.y - 200;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit3");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
            b = new SpecialEffectBullet("PetPhoenix4Bullet3_2");
            b.x = this.x + 200;
            b.y = this.y - 200;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit3");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
            b = new SpecialEffectBullet("PetPhoenix4Bullet3_2");
            b.x = this.x - 200;
            b.y = this.y - 200;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit3");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
         }
      }
      
      private function doHit4(direct:uint, point:Point) : void
      {
         this.doSingleHit4(3,direct);
      }
      
      private function doHit5(direct:uint, point:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("PetPhoenix4Bullet5");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setHurtCanCutDownEffect(false);
         b.setAction("hit5");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit6(direct:uint, point:Point) : void
      {
         this.doSingleHit4(3,direct);
      }
      
      private function doSingleHit4(idx:uint, direct:uint) : void
      {
         idx = idx;
         direct = direct;
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetPhoenix3Bullet4");
         b.x = this.x - 110 - (3 - idx) * 110;
         b.y = this.y + 30;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("PetPhoenix3Bullet4");
         b.x = this.x + 110 + (3 - idx) * 110;
         b.y = this.y + 30;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         if(this.isAoyi)
         {
            b = new SpecialEffectBullet("PetPhoenix4Bullet6");
            b.x = this.x - 110 - (3 - idx) * 110;
            b.y = this.y + 30;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit4");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
            b = new SpecialEffectBullet("PetPhoenix4Bullet6");
            b.x = this.x + 110 + (3 - idx) * 110;
            b.y = this.y + 30;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit4");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
         }
         if(idx > 0)
         {
            TweenMax.delayedCall(0.3,function(_idx:uint, _direct:uint, _self:Monster201):*
            {
               _idx--;
               if(!_self.isDead())
               {
                  _self.doSingleHit4(_idx,_direct);
               }
            },[idx,direct,this]);
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
               this.doHit2_1(direct,point);
               break;
            case "hit2Action":
               this.releSkill1();
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function setAttackBack(p:Point) : void
      {
         if(this.curAction == "hit2")
         {
            return;
         }
         super.setAttackBack(p);
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         if(this.curAction == "hit2")
         {
            re /= 3;
         }
         super.reduceHp(re,canHurt);
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
         return this.curAction == "hit6" || this.curAction == "hit5";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5" || this.curAction == "hit6";
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
      }
   }
}
