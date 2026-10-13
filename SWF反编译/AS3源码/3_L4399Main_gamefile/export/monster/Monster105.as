package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import export.level.StageListener171Children.Monster105Aura;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster105 extends BaseMonster
   {
       
      
      public function Monster105()
      {
         super();
         this.normalAttackRate = 0.7;
         this.horizenSpeed = 6;
         this.setHp(1500000);
         this.setSHp(1500000);
         this.attackRange = 300;
         this.alertRange = 1000;
         this._anti.def = 300;
         this._anti.exp = 1000;
         this._anti.gxp = 500;
         this._anti.mDef = 0.2;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":1000,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":80,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-25,0],
            "attackInterval":999,
            "power":1000,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.STUN,
               "time":gc.frameClips * 1
            }]
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[10,0],
            "attackInterval":999,
            "power":1000,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[10,0],
            "attackInterval":999,
            "power":700,
            "attackKind":"physics"
         };
         this.isBoss = true;
         this.monsterName = "牛魔王";
         this.setAction("wait");
         this.setToCountSuppressLevel(50);
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"nmwdnh",
            "bigtype":"zb"
         }];
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 15];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 10];
         this.skillCD3 = [gc.frameClips * 8,gc.frameClips * 12];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster105");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
            bbdc.setOffsetXY(20,-15);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,1,1,10],[2,2,2,10],[13],[2,2,10]]);
            bbdc.setFrameCount([6,4,1,5,6,4,1,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster105--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite2") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         if(str == "hurt")
         {
            if(RandomControllor.getIns().getRandom() < 0.1)
            {
               str = "hit3";
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
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               this.setYourFather(10);
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               this.setYourFather(10);
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               this.setStatic();
               this.setYourFather(13);
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit4":
               this.setYourFather(24);
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
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     this.doHit1_1(direct);
                  }
               }
               else if(p.x == 5)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHit1_2(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHit2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 13)
                  {
                     this.doHit3(direct);
                  }
               }
               this.speed.x = 0;
               this.speed.y = 0;
               break;
            case "hit4":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHit4(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.standInObj && this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return true;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 400;
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
         this.doBuff(this.getBBDC().getDirect());
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      private function doHit1_1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster105Bullet1_1");
         if(direct == 0)
         {
            b.x = this.x - 130;
         }
         else
         {
            b.x = this.x + 130;
         }
         b.y = this.y - 20;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit1_2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster105Bullet1_2");
         if(direct == 0)
         {
            b.x = this.x - 185;
         }
         else
         {
            b.x = this.x + 185;
         }
         b.y = this.y - 40;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2(direct:uint) : void
      {
         var dis:Number = NaN;
         var nums:* = 0;
         var i:* = 0;
         var aura:* = null;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster105Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 30;
         }
         else
         {
            b.x = this.x + 30;
         }
         b.y = this.y - 10;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         for each(var bh in gc.getPlayerArray())
         {
            dis = AUtils.GetDisBetweenTwoObj(bh,this);
            nums = uint(10);
            if(dis < 200)
            {
               nums = uint(4);
            }
            else if(dis < 400)
            {
               nums = uint(6);
            }
            else if(dis < 600)
            {
               nums = uint(8);
            }
            for(i = uint(0); i < nums; )
            {
               aura = new Monster105Aura(this,bh,5000);
               aura.x = bh.x + (RandomControllor.getIns().getRandom() - 0.5) * 20;
               aura.y = bh.y + (RandomControllor.getIns().getRandom() - 0.5) * 20;
               gc.gameSence.addChild(aura);
               gc.pWorld.getAuraArray().push(aura);
               i++;
            }
            bh.reduceHp(nums * 100);
         }
      }
      
      private function doBuff(direct:uint) : void
      {
         direct = direct;
         this.doSingleBuff(direct);
         TweenMax.delayedCall(1.2,function(_self:Monster105, _direct:uint):*
         {
            if(!_self.isDead())
            {
               _self.doSingleBuff(_direct);
            }
         },[this,direct]);
         TweenMax.delayedCall(2.4,function(_self:Monster105, _direct:uint):*
         {
            if(!_self.isDead())
            {
               _self.doSingleBuff(_direct);
            }
         },[this,direct]);
      }
      
      private function doSingleBuff(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster103Bullet3");
         if(direct == 0)
         {
            b.x = this.x + 15;
         }
         else
         {
            b.x = this.x - 15;
         }
         b.y = this.y - 50;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit5");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster105Bullet4");
         if(direct == 0)
         {
            b.x = this.x - 15;
         }
         else
         {
            b.x = this.x + 15;
         }
         b.y = this.y + 50;
         b.setRole(this);
         b.setHurtCanCutDownEffect(false);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4(direct:uint) : void
      {
         var b:* = null;
         b = new SpecialEffectBullet("Monster104Bullet2_2");
         b.x = this.x - 150;
         b.y = 500;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster104Bullet2_2");
         b.x = this.x - 50;
         b.y = 520;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster104Bullet2_2");
         b.x = this.x + 50;
         b.y = 520;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster104Bullet2_2");
         b.x = this.x + 150;
         b.y = 520;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster104Bullet2_2");
         b.x = this.x + 250;
         b.y = 520;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster104Bullet2_2");
         b.x = this.x - 250;
         b.y = 520;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
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
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit3";
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
