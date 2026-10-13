package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import export.level.StageListener121Child.LineEffectControl;
   import export.level.StageListener172;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class Monster109 extends BaseMonster
   {
       
      
      private var lineControlArray:Array;
      
      private var hitCount:uint = 6;
      
      public function Monster109()
      {
         lineControlArray = [];
         super();
         this.horizenSpeed = 4;
         this.setHp(1500000);
         this.setSHp(1500000);
         this.attackRange = 500;
         this.alertRange = 1000;
         this._anti.def = 300;
         this._anti.exp = 330;
         this._anti.gxp = 150;
         this._anti.mDef = 0.4;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":1000,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-5,0],
            "attackInterval":999,
            "power":800,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-5,0],
            "attackInterval":999,
            "power":200,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-5,0],
            "attackInterval":999,
            "power":1500,
            "attackKind":"magic"
         };
         this.isFly = false;
         this.isBoss = true;
         this.monsterName = "转轮王";
         this.setAction("wait");
         this.setToCountSuppressLevel(50);
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"zlwdah",
            "bigtype":"zb"
         }];
         this.skillCD1 = [gc.frameClips * 7,gc.frameClips * 7];
         this.skillCD2 = [gc.frameClips * 7,gc.frameClips * 12];
         this.skillCD3 = [gc.frameClips * 7,gc.frameClips * 15];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster109");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
            bbdc.setOffsetXY(0,-10);
            bbdc.setFrameStopCount([[3,3,3,3,3,3],[8],[2,2,10],[2,2,2,10],[10],[2,2,10]]);
            bbdc.setFrameCount([6,1,3,4,1,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster109--BitmapData Error!");
      }
      
      override protected function __added(evt:Event) : void
      {
         super.__added(evt);
         if(gc.pWorld.getBaseLevelListener() is StageListener172)
         {
            StageListener172(gc.pWorld.getBaseLevelListener()).showStandingFloor();
         }
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite5") as Sprite;
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
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit4":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               this.dropAura();
               this.destroy();
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
               if(this.hitCount > 0)
               {
                  this.hitCount--;
                  this.setAction("hit2");
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
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
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
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi3(direct);
                  }
               }
               break;
            case "hit4":
               if(p.x == 2)
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
         return this.curAttackTarget != null;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.lineControlArray.length == 0;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.curAttackTarget != null;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(15);
         this.hitCount = 6;
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster109Bullet1");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:* = null;
         var point:* = null;
         var dis:Number = NaN;
         if(this.curAttackTarget)
         {
            b = new EnemyMoveBullet("Monster109Bullet2");
            if(direct == 0)
            {
               b.x = this.x - 125;
            }
            else
            {
               b.x = this.x + 125;
            }
            b.y = this.y - 20;
            b.setRole(this);
            point = AUtils.GetNextPointByTwoObj(this,this.curAttackTarget);
            b.setSpeed(point.x * 10,point.y * 10);
            dis = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) + 40;
            b.setDistance(dis,this.doHit2_2);
            b.setDestroyWhenLastFrame(false);
            b.setDirect(direct);
            b.setAction("hit2");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
         }
      }
      
      private function doHit2_2(xx:Number, yy:Number) : void
      {
         var b:EnemyMoveBullet = new EnemyMoveBullet("Monster109Bullet2");
         b.x = xx;
         b.y = yy;
         b.setRole(this);
         var point:Point = AUtils.GetNextPointByTwoObj(b,this);
         b.setSpeed(point.x * 10,point.y * 10);
         var dis:Number = AUtils.GetDisBetweenTwoObj(this,b) + 40;
         b.setDistance(dis);
         b.setDestroyWhenLastFrame(false);
         b.setDirect(0);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3(direct:uint) : void
      {
         var lc:* = null;
         for each(var bh in gc.getPlayerArray())
         {
            lc = new LineEffectControl();
            lc.addFirstLine(this,bh,1);
            this.lineControlArray.push(lc);
         }
      }
      
      private function doHi4(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster109Bullet4");
         b.x = this.x;
         b.y = 502;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChildAt(b,gc.gameSence.getChildIndex(this) + 1);
         this.magicBulletArray.push(b);
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
      }
      
      override protected function myIntelligence() : void
      {
         var idx:int = 0;
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
         var temp:Array = [];
         for each(var lc in this.lineControlArray)
         {
            lc.step();
            if(lc.isDestroyed)
            {
               temp.push(lc);
            }
         }
         for each(var lcTemp in temp)
         {
            idx = this.lineControlArray.indexOf(lcTemp);
            if(idx != -1)
            {
               this.lineControlArray.splice(idx,1);
            }
         }
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
         for each(var lc in this.lineControlArray)
         {
            lc.destroy();
         }
         this.lineControlArray.length = 0;
      }
   }
}
