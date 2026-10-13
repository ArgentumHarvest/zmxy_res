package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster65 extends BaseMonster
   {
       
      
      public function Monster65()
      {
         super();
         this.horizenSpeed = 5;
         this.setHp(1000000);
         this.setSHp(1000000);
         this.normalAttackRate = 0.6;
         this.attackRange = 350;
         this.alertRange = 1000;
         this._anti.def = 350;
         this._anti.exp = 1000;
         this._anti.gxp = 500;
         this._anti.mDef = 0.25;
         this.attackBackInfoDict["hit1_1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":24,
            "power":1500,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit1_2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":1500,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":100,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":100,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":2000,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.MONSTER65_AOE,
               "time":gc.frameClips * 5
            }]
         };
         this.isBoss = true;
         this.monsterName = "太上老君";
         this.setAction("wait");
         this.setToCountSuppressLevel(50);
         this._anti.fallProbability = 0.3;
         this._anti.fallList = [{
            "name":"wpsh_1",
            "bigtype":"dj"
         },{
            "name":"hmzjns2",
            "bigtype":"jns"
         },{
            "name":"tmcjns2",
            "bigtype":"jns"
         },{
            "name":"mdsjns2",
            "bigtype":"jns"
         },{
            "name":"jhsjjns2",
            "bigtype":"jns"
         }];
         this.skillCD1 = [gc.frameClips * 5,gc.frameClips * 10];
         this.skillCD2 = [gc.frameClips * 6,gc.frameClips * 12];
         this.skillCD3 = [gc.frameClips * 7,gc.frameClips * 14];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster65");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
            bbdc.setOffsetXY(-10,-30);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,2,10],[2,2,10,10],[6,6],[2,2,10],[2,2,2,2,2,10]]);
            bbdc.setFrameCount([6,1,6,4,2,3,6]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster65--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite2") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         if(str == "hit1")
         {
            for each(var bb in this.magicBulletArray)
            {
               if(bb.getImcName() == "Monster65Bullet1_1")
               {
                  return;
               }
            }
         }
         else if(str == "hurt")
         {
            str = "hit2";
            this.setYourFather(12);
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
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
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
            case "dead":
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
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
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(direct == 0)
               {
                  this.speed.x = -10;
               }
               else
               {
                  this.speed.x = 10;
               }
               break;
            case "hit3":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi3(direct);
                  }
               }
               break;
            case "hit4":
               if(p.x == 5)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi4(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return false;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return true;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return true;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(10);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(30);
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
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster65Bullet1_1");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 5);
         var interval:Number = 0.8333333333333334;
         b.setFuncWhenInCount(diHit1_2,interval,interval);
         b.setDirect(direct);
         b.setAction("hit1_1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function diHit1_2() : void
      {
         var b:* = null;
         var point:* = null;
         if(this.curAttackTarget)
         {
            for each(var bb in this.magicBulletArray)
            {
               if(bb.getImcName() == "Monster65Bullet1_1")
               {
                  b = new EnemyMoveBullet("Monster65Bullet1_2");
                  b.x = bb.x;
                  b.y = bb.y - 50;
                  b.setRole(this);
                  point = AUtils.GetNextPointByTwoObj(bb,this.curAttackTarget);
                  b.setSpeed(point.x * 4,point.y * 4);
                  b.setAddSpeed(point.x,point.y);
                  b.setDistance(1000);
                  b.setDestroyWhenLastFrame(false);
                  b.setDirect(0);
                  b.setAction("hit1_2");
                  gc.gameSence.addChild(b);
                  this.magicBulletArray.push(b);
               }
            }
         }
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster65Bullet2");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster65Bullet2");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDisable();
         b.setFuncWhenDestroy(hit3over);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function hit3over(bb:BaseBullet) : void
      {
         for each(var bh in gc.getPlayerArray())
         {
            if(bh.getPet())
            {
               bh.getPet().addCurAddEffect([{
                  "name":BaseAddEffect.MONSTER65_TIED_PET,
                  "time":gc.frameClips * 10
               }]);
            }
         }
      }
      
      function doHi4(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster65Bullet3");
         b.x = this.x;
         b.y = -85;
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
         if(this.y > 1000)
         {
            var _loc3_:int = 0;
            var _loc2_:* = gc.getPlayerArray();
            for each(var bh in _loc2_)
            {
               this.y = 300;
               this.x = bh.x;
            }
         }
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit2";
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
