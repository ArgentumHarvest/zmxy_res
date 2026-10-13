package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import com.superkaka.Tools.ColorAdjust;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class Monster199 extends BaseMonster
   {
       
      
      public var continueCount:int = 0;
      
      public var totalHurt:int = 0;
      
      private var type:int = 0;
      
      private var fenshenArray:Array;
      
      public var isAoyi:Boolean = false;
      
      private var baseHurt:int = 100;
      
      private var ti:int;
      
      public function Monster199()
      {
         fenshenArray = [];
         super();
         this.horizenSpeed = 5;
         this._anti.def = 80 + 1.4 * gc.hero1.roleProperies.getDefense();
         this._anti.exp = 6;
         this._anti.gxp = 2;
         this.setHp(40000 + 2 * gc.hero1.roleProperies.getLevel() * gc.hero1.roleProperies.getSHHP());
         this.setSHp(this.getHp());
         this.baseHurt = 300 + 1.8 * gc.hero1.roleProperies.getHurt();
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":10,
            "power":this.baseHurt * 1.5,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":8,
            "power":this.baseHurt * 1.5,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":999,
            "power":this.baseHurt * 3,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":999,
            "power":this.baseHurt * 3,
            "attackKind":"magic"
         };
         this.attackRange = 200;
         this.isBoss = true;
         this.monsterName = "邪.青龙";
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 2,gc.frameClips * 20];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 10];
         this.skillCD3 = [gc.frameClips * 8,gc.frameClips * 16];
         this.skillCD4 = [gc.frameClips * 15,gc.frameClips * 20];
         this._anti.fallProbability = 0.1;
         var kind:int = 5 + Math.ceil(RandomControllor.getIns().getRandom() * 4);
         this._anti.fallList = [{
            "name":"p_cykljl",
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
         this.ti = setTimeout(wudi,20000);
      }
      
      private function wudi() : void
      {
         if(this.fatherCount < gc.frameClips * 10)
         {
            this.setYourFather(gc.frameClips * 10);
         }
         this.ti = setTimeout(wudi,20000);
      }
      
      public function setContinueTime(v:int) : void
      {
         this.continueCount = v;
         if(v > 0)
         {
            this.isBoss = false;
            type = 1;
            this._anti.fallList = [];
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
                  this.releSkill3WithoutMana();
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
                  this.releSkill2WithoutMana();
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
                  }
               }
               break;
            case "hit2":
               if(p.x == 4)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHit2(direct,point);
                  }
               }
               break;
            case "hit3":
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
               break;
            case "hit4":
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
                  }
               }
               break;
            case "hit5":
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
                  }
               }
               break;
            case "hit6":
               if(this.standInObj)
               {
                  this.releSkill3WithoutMana();
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         if(this.type == 0)
         {
            return this.curAttackTarget != null;
         }
         return false;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget != null && AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= 300;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.curAttackTarget != null && AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= 500;
      }
      
      override protected function beforeSkill4Start() : Boolean
      {
         var dis:Number = NaN;
         if(this.type == 0)
         {
            if(this.curAttackTarget)
            {
               dis = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget);
               if(dis <= 200)
               {
                  return true;
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
         this.faceToTarget();
         this.newAttackId();
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      public function releSkill2WithoutMana() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      public function releSkill3WithoutMana() : void
      {
         if(this.type == 0)
         {
            this.faceToTarget();
         }
         this.newAttackId();
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      override protected function releSkill4() : void
      {
         this.isAoyi = true;
         this.faceToTarget();
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
         var pd4:Monster199 = this.createFenshen();
      }
      
      private function createFenshen() : Monster199
      {
         var pd1:Monster199 = MainGame.getInstance().createMonster(199,this.x,this.y) as Monster199;
         pd1.setContinueTime(gc.frameClips * 12);
         pd1.type = 1;
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
         TweenMax.delayedCall(0.2,function(_self:Monster199, _direct:uint, _point:Point):*
         {
            if(!_self.isDead())
            {
               _self.doSingleHit4(_direct,new Point(_point.x - 150,_point.y - 10));
               _self.doSingleHit4(_direct,new Point(_point.x + 90,_point.y - 25));
            }
         },[this,direct,point]);
         TweenMax.delayedCall(0.4,function(_self:Monster199, _direct:uint, _point:Point):*
         {
            if(!_self.isDead())
            {
               _self.doSingleHit4(_direct,new Point(_point.x - 90,_point.y - 25));
               _self.doSingleHit4(_direct,new Point(_point.x + 150,_point.y - 10));
            }
         },[this,direct,point]);
         TweenMax.delayedCall(0.6,function(_self:Monster199, _direct:uint, _point:Point):*
         {
            if(!_self.isDead())
            {
               _self.doSingleHit4(_direct,new Point(_point.x - 270,_point.y - 25));
               _self.doSingleHit4(_direct,new Point(_point.x + 210,_point.y - 10));
            }
         },[this,direct,point]);
         TweenMax.delayedCall(0.8,function(_self:Monster199, _direct:uint, _point:Point):*
         {
            if(!_self.isDead())
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
         var pd4:Monster199 = this.createFenshen();
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
         pd4.releSkill2WithoutMana();
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
                  this.setHp(0);
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
               if(pd.continueCount == 0 || pd.getHp() <= 0)
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
         clearTimeout(this.ti);
         if(this.type == 0)
         {
            if(this.isBoss)
            {
               var ta:Array = gc.pWorld.getTransferDoorArray();
               for(var i:int = 0; i < ta.length; )
               {
                  var mc:MovieClip = ta[i];
                  mc.visible = true;
                  i++;
               }
            }
            if(this.isDead())
            {
               gc.bossChallenge[5] = 1;
            }
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
               "onComplete":function(_self:Monster199):*
               {
                  if(_self.parent)
                  {
                     _self.parent.removeChild(_self);
                  }
               },
               "onCompleteParams":[this]
            });
            for(i = 0; i < this.magicBulletArray.length; )
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
