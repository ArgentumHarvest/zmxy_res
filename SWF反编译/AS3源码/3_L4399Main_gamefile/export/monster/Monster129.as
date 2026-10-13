package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster129 extends BaseMonster
   {
       
      
      private var isFirstLow90Persent:Boolean = false;
      
      private var isFirstLow60Persent:Boolean = false;
      
      private var isFirstLow30Persent:Boolean = false;
      
      var iii:uint = 24;
      
      public function Monster129()
      {
         super();
         this.normalAttackRate = 0.6;
         this.horizenSpeed = 6;
         this.setHp(2000000);
         this.setSHp(this.getHp());
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 300;
         this._anti.exp = 5000;
         this._anti.gxp = 500;
         this._anti.mDef = 0.24;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":1700,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":3000,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.SIDATIANWANG_SAN_MP_LOST,
               "time":gc.frameClips * 6
            }]
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":24,
            "power":100,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-25,0],
            "attackInterval":999,
            "power":1000,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":1,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "吕岳";
         this.setAction("wait");
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"cs_fj_dz_zzs",
            "bigtype":"dj"
         },{
            "name":"cs_fj_zt_zzs",
            "bigtype":"dj"
         },{
            "name":"cs_fj_jt_zzs",
            "bigtype":"dj"
         },{
            "name":"cs_fj_js_zzs",
            "bigtype":"dj"
         }];
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 12];
         this.skillCD2 = [gc.frameClips * 3,gc.frameClips * 8];
         this.skillCD3 = [gc.frameClips * 5,gc.frameClips * 10];
         this.skillCD4 = [gc.frameClips * 10,gc.frameClips * 20];
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster129");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
            bbdc.setOffsetXY(10,-25);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,10],[14,2,2,1,1,5],[10],[2,2],[20]]);
            bbdc.setFrameCount([6,4,1,5,3,6,1,10,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster129--BitmapData Error!");
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
               this.setStatic();
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
            case "hit1":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHit1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 14)
                  {
                     this.doHit2_1(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHit3(direct);
                  }
               }
               break;
            case "hit4":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHit4_2(direct);
                  }
               }
               else if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     if(this.bbdc.getCurKeyFrameIndex() == 0)
                     {
                        this.doHit4_1(direct);
                     }
                  }
               }
               break;
            case "hit5":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     this.doHit5(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         if(!this.isFirstLow60Persent)
         {
            return false;
         }
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return false;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         if(!this.isFirstLow90Persent)
         {
            return false;
         }
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 400;
      }
      
      override protected function beforeSkill4Start() : Boolean
      {
         if(!this.isFirstLow30Persent)
         {
            return false;
         }
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 400;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(20);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(20);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(20);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      override protected function releSkill4() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(24);
         this.setAction("hit5");
         this.lastHit = "hit5";
      }
      
      private function doHit1(direct:uint) : void
      {
         var b:* = null;
         b = new SpecialEffectBullet("Monster129Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 50;
         }
         else
         {
            b.x = this.x + 50;
         }
         b.y = this.y + 40;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster129Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 150;
         }
         else
         {
            b.x = this.x + 150;
         }
         b.y = this.y + 40;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster129Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 250;
         }
         else
         {
            b.x = this.x + 250;
         }
         b.y = this.y + 40;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override public function doWhenSetYourFatherByFatherCount() : void
      {
         if(!this.isDead())
         {
            this.releSkill2();
         }
      }
      
      private function doHit2_1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster129Bullet2_1");
         if(direct == 0)
         {
            b.x = this.x - 130;
         }
         else
         {
            b.x = this.x + 130;
         }
         b.y = this.y - 80;
         b.setFuncWhenDestroy(doHit2_2);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2_2(bb:BaseBullet) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster129Bullet2_2");
         if(this.bbdc.getDirect() == 0)
         {
            b.x = this.x - 160;
         }
         else
         {
            b.x = this.x + 160;
         }
         b.y = this.y - 20;
         b.setRole(this);
         b.setDirect(this.bbdc.getDirect());
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster129Bullet3");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         b.setDestroyInCount(gc.frameClips * 5);
         b.setDestroyWhenLastFrame(false);
         b.setHurtCanCutDownEffect(false);
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4_1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster129Bullet4_1");
         if(this.bbdc.getDirect() == 0)
         {
            b.x = this.x - 40;
         }
         else
         {
            b.x = this.x + 40;
         }
         b.y = this.y - 20;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4_2(direct:uint) : void
      {
         var targetPoint:* = null;
         var point:* = null;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster129Bullet4_2");
         if(direct == 0)
         {
            b.x = this.x - 145;
         }
         else
         {
            b.x = this.x + 145;
         }
         b.y = this.y - 20;
         b.setRole(this);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 2);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         if(this.curAttackTarget)
         {
            point = new Point();
            point.x = (this.x + this.curAttackTarget.x) / 2;
            point.y = 350 + RandomControllor.getIns().getRandom() * 100;
            targetPoint = new Point();
            if(direct == 0)
            {
               targetPoint.x = this.curAttackTarget.x - 400;
            }
            else
            {
               targetPoint.x = this.curAttackTarget.x + 400;
            }
            targetPoint.y = this.curAttackTarget.y;
            TweenMax.to(b,2,{"bezierThrough":[{
               "x":point.x,
               "y":point.y
            },{
               "x":targetPoint.x,
               "y":targetPoint.y
            }]});
         }
         else
         {
            targetPoint = new Point();
            if(direct == 0)
            {
               targetPoint.x = this.x - 400;
            }
            else
            {
               targetPoint.x = this.x + 400;
            }
            TweenMax.to(b,2,{"x":targetPoint.x});
         }
      }
      
      private function doHit5(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster129Bullet5");
         if(this.bbdc.getDirect() == 0)
         {
            b.x = this.x - 20;
         }
         else
         {
            b.x = this.x + 20;
         }
         b.y = this.y - 145;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit5");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         this.addCurAddEffect([{
            "name":BaseAddEffect.DEADLINK,
            "time":gc.frameClips * 7
         }]);
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         var obj:* = null;
         var flag:Boolean = super.beMagicAttack(_target,sr,force);
         if(flag)
         {
            obj = this.curAddEffect.getBuffByName(BaseAddEffect.DEADLINK);
            if(obj)
            {
               if(this.curAttackTarget)
               {
                  this.curAttackTarget.reduceHp(_target.hurt,false);
               }
            }
         }
         return flag;
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,canHurt);
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
         if(!this.isFirstLow90Persent)
         {
            if(this.getHp() / this.getSHp() < 0.9)
            {
               this.attackBackInfoDict["hit1"] = {
                  "hitMaxCount":99,
                  "attackBackSpeed":[-6,-5],
                  "attackInterval":999,
                  "power":1700,
                  "attackKind":"physics",
                  "addEffect":[{
                     "name":BaseAddEffect.MONSTER129Buff,
                     "time":gc.frameClips * 4
                  }]
               };
               this.attackBackInfoDict["hit2"] = {
                  "hitMaxCount":99,
                  "attackBackSpeed":[-3,0],
                  "attackInterval":999,
                  "power":3000,
                  "attackKind":"physics",
                  "addEffect":[{
                     "name":BaseAddEffect.SIDATIANWANG_SAN_MP_LOST,
                     "time":gc.frameClips * 6
                  },{
                     "name":BaseAddEffect.MONSTER129Buff,
                     "time":gc.frameClips * 4
                  }]
               };
               this.attackBackInfoDict["hit3"] = {
                  "hitMaxCount":99,
                  "attackBackSpeed":[0,0],
                  "attackInterval":24,
                  "power":100,
                  "attackKind":"magic",
                  "addEffect":[{
                     "name":BaseAddEffect.MONSTER129Buff,
                     "time":gc.frameClips * 4
                  }]
               };
               this.attackBackInfoDict["hit4"] = {
                  "hitMaxCount":99,
                  "attackBackSpeed":[-25,0],
                  "attackInterval":999,
                  "power":1000,
                  "attackKind":"magic",
                  "addEffect":[{
                     "name":BaseAddEffect.MONSTER129Buff,
                     "time":gc.frameClips * 4
                  }]
               };
               this.isFirstLow90Persent = true;
            }
         }
         if(!this.isFirstLow60Persent)
         {
            if(this.getHp() / this.getSHp() < 0.6)
            {
               this.isFirstLow60Persent = true;
            }
         }
         if(!this.isFirstLow30Persent)
         {
            if(this.getHp() / this.getSHp() < 0.3)
            {
               this.isFirstLow30Persent = true;
            }
         }
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         super.destroy();
         if(this.getHp() <= 0)
         {
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
}
