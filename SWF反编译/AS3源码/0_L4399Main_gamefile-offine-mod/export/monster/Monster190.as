package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import export.pet.PetNian5Children.PetNian5Bullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster190 extends BaseMonster
   {
       
      
      private var hit4Counts:int = 4;
      
      private var isHit4:Boolean = false;
      
      private var linghunArr:Array;
      
      private var hit4Count:uint = 72;
      
      public function Monster190()
      {
         linghunArr = [];
         super();
         this.horizenSpeed = 3;
         this.setHp(600000);
         this.setSHp(600000);
         this._anti.def = 125;
         this._anti.exp = 625;
         this._anti.gxp = 250;
         this._anti.mDef = 0.6;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":500,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":500,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":15,
            "power":500,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.STUN,
               "time":gc.frameClips * 3
            }]
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":999,
            "power":500,
            "attackKind":"physics"
         };
         this.isBoss = true;
         this.monsterName = "大年兽";
         this.attackRange = 150;
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 4,gc.frameClips * 10];
         this.skillCD2 = [gc.frameClips * 10,gc.frameClips * 15];
         this.skillCD3 = [gc.frameClips * 3,gc.frameClips * 20];
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"nianjhd",
            "bigtype":"dj"
         }];
         var averLevel:int = gc.getAverageLevel();
         if(averLevel > 90)
         {
            averLevel = 90;
         }
         hit4Counts = Math.ceil(averLevel / 10);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("PetNianBmd5");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
            bbdc.setOffsetXY(30,-50);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[2,10],[30],[30]]);
            bbdc.setFrameCount([6,4,1,5,4,2,1,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("PetNianBmd5--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("Monster155Sprite") as Sprite;
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
                        point.x = this.x - 30;
                     }
                     else
                     {
                        point.x = this.x + 30;
                     }
                     point.y = this.y;
                     this.doHit1(direct,point);
                  }
               }
               break;
            case "hit2":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     if(direct == 0)
                     {
                        point.x = this.x - 30;
                     }
                     else
                     {
                        point.x = this.x + 30;
                     }
                     point.y = this.y;
                     this.doHit2(direct,point);
                  }
               }
               break;
            case "hit3":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 30)
                  {
                     if(direct == 0)
                     {
                        point.x = this.x - 85;
                     }
                     else
                     {
                        point.x = this.x + 85;
                     }
                     point.y = this.y - 55;
                     this.doHit3(direct,point);
                  }
               }
               break;
            case "hit4":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 30)
                  {
                     if(direct == 0)
                     {
                        point.x = this.x - 85;
                     }
                     else
                     {
                        point.x = this.x + 85;
                     }
                     point.y = this.y - 55;
                     this.doHit4(direct,point);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         var dis:Number = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget);
         return dis <= 400;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         var dis:Number = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget);
         return dis <= 500;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         var rate:Number = this.getHp() / this.getSHp();
         var bool:Boolean = !isHit4 && rate < 0.4;
         if(bool)
         {
            isHit4 = true;
         }
         return bool;
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,canHurt);
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
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
         this.setYourFather(30);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      private function doHit1(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster155Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 160;
         }
         else
         {
            b.x = this.x + 160;
         }
         b.y = this.y - 110;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2(direct:uint, point:Point) : void
      {
         this.doSingleHit2(7);
      }
      
      private function doSingleHit2(nums:uint) : void
      {
         nums = nums;
         if(nums > 0)
         {
            nums--;
            var randMonster:BaseMonster = gc.pWorld.monsterArray[int(RandomControllor.getIns().getRandom() * gc.pWorld.monsterArray.length)];
            if(randMonster)
            {
               var b:EnemyMoveBullet = new EnemyMoveBullet("Monster155Bullet2");
               b.x = randMonster.x;
               b.y = 100;
               b.setRole(this);
               b.setDestroyWhenLastFrame(false);
               b.setDistance(1000);
               b.setSpeed(0,2);
               b.setAddSpeed(0,1);
               b.setDirect(0);
               b.setAction("hit2");
               gc.gameSence.addChild(b);
               this.magicBulletArray.push(b);
               TweenMax.delayedCall(1,function(_self:Monster190, _nums:uint):*
               {
                  if(!_self.isDead())
                  {
                     _self.doSingleHit2(_nums);
                  }
               },[this,nums]);
            }
         }
      }
      
      private function doHit3(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster155Bullet3");
         b.x = this.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster155Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 50;
         }
         else
         {
            b.x = this.x + 50;
         }
         b.y = this.y - 55;
         b.setRole(this);
         if(direct == 0)
         {
            direct = 1;
         }
         else
         {
            direct = 0;
         }
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4(direct:uint, point:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("PetNian5Bullet4_1");
         if(direct == 0)
         {
            b.x = this.x - 110;
         }
         else
         {
            b.x = this.x + 110;
         }
         b.y = this.y - 95;
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(30);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b.setFuncWhenDestroy(hit4Over);
      }
      
      private function hit4Over(bb:BaseBullet) : void
      {
         var i:* = 0;
         var b:* = null;
         var num:int = this.hit4Counts;
         for(i = uint(0); i < num; )
         {
            b = new PetNian5Bullet("PetNian5Bullet4_2");
            b.x = this.x;
            b.y = this.y;
            b.setDestroyWhenLastFrame(false);
            b.setDestroyInCount(gc.frameClips * 999999);
            b.offsetPoint.x = (RandomControllor.getIns().getRandom() - 0.5) * 300;
            b.offsetPoint.y = -RandomControllor.getIns().getRandom() * 150;
            b.setRole(this);
            b.setDistance(9999999);
            b.setDirect(0);
            b.setDisable();
            b.setAction("hit4");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
            linghunArr.push(b);
            i++;
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         var hit4Bullet:* = null;
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
         if(hit4Count > 0)
         {
            hit4Count--;
            if(hit4Count == 0)
            {
               if(this.getHp() / this.getSHp() < 0.4)
               {
                  hit4Bullet = linghunArr.pop();
                  if(hit4Bullet)
                  {
                     hit4Bullet.gogo();
                  }
               }
               hit4Count = 72;
            }
         }
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         super.destroy();
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
         this.linghunArr = null;
      }
   }
}
