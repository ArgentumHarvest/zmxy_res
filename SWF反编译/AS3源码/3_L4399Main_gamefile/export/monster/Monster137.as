package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import base.BaseObject;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster137 extends BaseMonster
   {
       
      
      private var averLevel:uint = 0;
      
      private var bingoRate:Number = 0;
      
      private var isReturnHurt:Boolean = false;
      
      private var returnHurtObject:BaseObject;
      
      var iii:uint = 24;
      
      public function Monster137()
      {
         super();
         averLevel = gc.getAverageLevel();
         if(averLevel > 90)
         {
            averLevel = 90;
         }
         this.normalAttackRate = 0.6;
         this.horizenSpeed = 6;
         var temp:uint = Math.ceil(averLevel / 10);
         this.setHp(temp * temp * 10000 * (0.4 + averLevel * 0.01));
         this.setSHp(this.getHp());
         if(averLevel >= 50)
         {
            this.bingoRate = 0.02;
            if(averLevel <= 60)
            {
               this.bingoRate = 0.04;
            }
            else if(averLevel <= 70)
            {
               this.bingoRate = 0.06;
            }
            else if(averLevel <= 80)
            {
               this.bingoRate = 0.08;
            }
         }
         var baseHurt:int = averLevel * 20 - 150;
         if(baseHurt < 20)
         {
            baseHurt = 20;
         }
         this.attackRange = 200;
         this.alertRange = 1000;
         this._anti.def = averLevel * 5;
         this._anti.exp = 500;
         this._anti.gxp = 250;
         this._anti.mDef = averLevel / 400;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":baseHurt,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.MONSTER137BUFF,
               "time":gc.frameClips * 7
            }]
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":10,
            "power":baseHurt * 0.8,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-25,0],
            "attackInterval":999,
            "power":baseHurt,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.MONSTER137BUFF,
               "time":gc.frameClips * 7
            }]
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-25,0],
            "attackInterval":24,
            "power":baseHurt * 2,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "金吒";
         this.setAction("wait");
         this._anti.fallProbability = 0.5;
         if(averLevel > 20)
         {
            this._anti.fallList = [{
               "name":"p_czzx",
               "bigtype":"cwzb"
            },{
               "name":"p_czst",
               "bigtype":"cwzb"
            }];
         }
         else
         {
            this._anti.fallList = [];
         }
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 15];
         this.skillCD2 = [gc.frameClips * 3,gc.frameClips * 8];
         this.skillCD3 = [gc.frameClips * 5,gc.frameClips * 15];
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
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster137");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
            bbdc.setOffsetXY(30,-50);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[5,2,10],[2,2,2,10],[48]]);
            bbdc.setFrameCount([6,4,1,5,4,3,4,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster137--BitmapData Error!");
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
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHit1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHit2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHit3(direct);
                  }
               }
               break;
            case "hit4":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 48)
                  {
                     this.doHit4(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 400;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return false;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(20);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(20);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.setYourFather(20);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      private function doHit1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster137Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 190;
         }
         else
         {
            b.x = this.x + 190;
         }
         b.y = this.y - 115;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster137Bullet2");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDisable();
         b.setHurtCanCutDownEffect(false);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 5);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3(direct:uint) : void
      {
         var b:* = null;
         var i:* = 0;
         for(i = uint(0); i < 6; )
         {
            b = new SpecialEffectBullet("Monster137Bullet3");
            if(direct == 0)
            {
               b.x = this.x - 135 - (i - 1) * 90;
            }
            else
            {
               b.x = this.x + 135 + (i - 1) * 90;
            }
            b.y = this.y + 50;
            b.setRole(this);
            b.setDirect(direct);
            b.setBingoRate(this.bingoRate);
            b.setAction("hit3");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
            i++;
         }
      }
      
      private function doHit4(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster137Bullet4");
         if(direct == 0)
         {
            b.x = this.x - 90;
         }
         else
         {
            b.x = this.x + 90;
         }
         b.y = this.y - 80;
         b.setRole(this);
         b.setDisable();
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 2);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         this.isReturnHurt = false;
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster137Bullet2")
            {
               this.returnHurtObject = sr;
               this.isReturnHurt = true;
               break;
            }
         }
         return Boolean(super.beMagicAttack(_target,sr,force));
      }
      
      override public function setAttackBack(p:Point) : void
      {
         if(this.curAction == "hit4")
         {
            return;
         }
         super.setAttackBack(p);
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         if(this.isReturnHurt)
         {
            this.returnHurtObject.reduceHp(re);
            this.isReturnHurt = false;
         }
         if(this.curAction == "hit4")
         {
            canHurt = false;
            re *= 0.1;
         }
         super.reduceHp(re,canHurt);
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
         if(averLevel > 50)
         {
            if(iii > 0)
            {
               iii--;
               if(iii == 0)
               {
                  this.cureHp(this.getSHp() / 1000);
                  iii = gc.frameClips;
               }
            }
         }
         for each(var bh in gc.getPlayerArray())
         {
            if(AUtils.GetDisBetweenTwoObj(bh,this) >= 300)
            {
               for each(var bb in bh.magicBulletArray)
               {
                  if(AUtils.GetDisBetweenTwoObj(bb,this) <= 150)
                  {
                     if(!this.isAttacking() && !this.isBeAttacking())
                     {
                        this.releSkill3();
                        break;
                     }
                  }
               }
            }
         }
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         super.destroy();
         this.returnHurtObject = null;
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
