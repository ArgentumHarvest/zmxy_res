package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.bullet.FollowBaseObjectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import my.HitTest;
   
   public class Monster118 extends BaseMonster
   {
       
      
      private var fenshenArray:Array;
      
      public var targetPoint:Point;
      
      public var isFenshen:Boolean = false;
      
      private var disappearCountWhenIsFenshen:uint = 80;
      
      public function Monster118()
      {
         fenshenArray = [];
         super();
         this.horizenSpeed = 4;
         this.setHp(1500000);
         this.setSHp(1500000);
         this._anti.def = 300;
         this._anti.exp = 3000;
         this._anti.gxp = 1000;
         this._anti.mDef = 0.15;
         this.attackBackInfoDict["hit1"] = {
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
            "power":17,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":17,
            "attackKind":"magic"
         };
         this.attackRange = 250;
         this.alertRange = 1000;
         this.isBoss = true;
         this.monsterName = "花豹圣者";
         this.setAction("wait");
         this.setToCountSuppressLevel(60);
         this.skillCD1 = [gc.frameClips * 5,gc.frameClips * 10];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 15];
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"p_cyyf",
            "bigtype":"cwzb"
         }];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster118");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
            bbdc.setOffsetXY(-10,-40);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[2,2,2,2],[2,2,30]]);
            bbdc.setFrameCount([6,4,1,5,4,40,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster118--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite2") as Sprite;
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
               if(this.isFenshen)
               {
                  this.destroy();
               }
               this.setAction("wait");
               break;
            case "hit2":
               this.setAction("wait");
               break;
            case "hit3":
               this.hit3Over();
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
         var keyFrameIdx:* = 0;
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
               keyFrameIdx = uint(this.bbdc.getCurKeyFrameIndex());
               if(!this.isFenshen)
               {
                  if(keyFrameIdx == 0)
                  {
                     this.createShallow(5,new Point(this.x,this.y));
                  }
               }
               if(direct == 0)
               {
                  this.speed.x = -keyFrameIdx / 2 - 10;
               }
               else
               {
                  this.speed.x = keyFrameIdx / 2 + 10;
               }
               if(!this.isFenshen)
               {
                  var _loc10_:int = 0;
                  var _loc9_:* = gc.getPlayerArray();
                  for each(var bh in _loc9_)
                  {
                     if(HitTest.complexHitTestObject(this.colipse,bh))
                     {
                        this.setYourFather(18);
                        this.attackTarget();
                        for each(var m118 in this.fenshenArray)
                        {
                           m118.targetPoint = new Point(this.x,this.y);
                        }
                     }
                  }
               }
               else if(this.targetPoint)
               {
                  if(AUtils.GetDisBetweenTwoPoint(this.targetPoint,new Point(this.x,this.y)) <= 20)
                  {
                     this.attackTarget();
                     this.setStatic();
                     this.targetPoint = null;
                  }
               }
               break;
            case "hit3":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 30)
                  {
                     this.doHi3(direct);
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
         return this.curAttackTarget != null;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(80);
         this.doHi2();
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(38);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster118Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 155;
         }
         else
         {
            b.x = this.x + 155;
         }
         b.y = this.y - 50;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2() : void
      {
         trace("gc.pworld:" + gc.pWorld.monsterArray.length);
         this.fenshenArray.length = 0;
         var _loc3_:int = 0;
         var _loc2_:* = gc.getPlayerArray();
         for each(var bh in _loc2_)
         {
            if(this.x < bh.x)
            {
               this.turnRight();
            }
            else
            {
               this.turnLeft();
            }
         }
      }
      
      private function createShallow(count:uint, point:Point) : void
      {
         count = count;
         point = point;
         if(count > 0)
         {
            count--;
            this.createSingleShallow(point);
            TweenMax.delayedCall(0.2,function(_self:Monster118, _count:uint, _point:Point):*
            {
               if(!_self.isDead() && _self.curAction == "hit2")
               {
                  _self.createShallow(_count,_point);
               }
            },[this,count,point]);
         }
      }
      
      private function createSingleShallow(point:Point) : void
      {
         var m118:Monster118 = new Monster118();
         m118.x = point.x;
         m118.y = point.y;
         m118.isFenshen = true;
         m118.alpha = 0.5;
         m118.setYourFather(gc.frameClips * 99);
         m118.setAction("hit2");
         m118.isBoss = false;
         m118.getBBDC().setDirect(this.getBBDC().getDirect());
         this.fenshenArray.push(m118);
         gc.pWorld.monsterArray.push(m118);
         var minIdx:int = gc.getMinIdxInHeroAndPet();
         gc.gameSence.addChildAt(m118,minIdx);
      }
      
      private function doHi3(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster118Bullet3Buff");
         if(direct == 0)
         {
            b.x = this.x + 30;
         }
         else
         {
            b.x = this.x - 30;
         }
         b.y = this.y - 140;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function hit3Over() : void
      {
         for each(var bh in gc.getPlayerArray())
         {
            bh.addCurAddEffect([{
               "name":BaseAddEffect.MONSTER118GELIE,
               "time":gc.frameClips * 9,
               "point":new Point(bh.x,bh.y)
            }]);
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         if(this.isFenshen)
         {
            if(this.disappearCountWhenIsFenshen > 0)
            {
               this.disappearCountWhenIsFenshen--;
               if(this.disappearCountWhenIsFenshen == 0)
               {
                  this.destroy();
               }
            }
         }
         else
         {
            super.myIntelligence();
         }
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit2";
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         if(this.isFenshen)
         {
            this.setHp(0);
         }
         super.destroy();
         this.fenshenArray.length = 0;
         if(this.isBoss && !this.isFenshen)
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
