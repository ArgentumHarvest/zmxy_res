package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class Monster204 extends BaseMonster
   {
       
      
      public function Monster204()
      {
         super();
         var averLv:int = gc.getAverageLevel();
         this.horizenSpeed = 3;
         this.normalAttackRate = 0.7;
         this._anti.def = 28 + gc.hero1.roleProperies.getDefense();
         this._anti.exp = 6;
         this._anti.gxp = 2;
         this._anti.mDef = 0.4;
         this.setHp(6000 + averLv * gc.hero1.roleProperies.getSHHP());
         this.setSHp(this.getHp());
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":12,
            "power":80 + 0.6 * gc.hero1.roleProperies.getHurt(),
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":80 + 0.6 * gc.hero1.roleProperies.getHurt(),
            "attackKind":"magic"
         };
         this.attackRange = 250;
         this.alertRange = 1000;
         this.isBoss = true;
         this.monsterName = "白骨精";
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 3,gc.frameClips * 10];
         this.skillCD2 = [gc.frameClips * 3,gc.frameClips * 15];
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"bgqmtx",
            "bigtype":"zb"
         }];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster204");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(22,-49);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1],[2,2,2,2,10],[2,2,2,10],[2,2,2,10]]);
            bbdc.setFrameCount([6,4,1,9,9,5,4,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster204--BitmapData Error!");
      }
      
      override public function setLevel(v:uint) : void
      {
         super.setLevel(v);
         if(gc.curStageAndCurLevel.curStage == 54)
         {
            this._anti.def = 15 * v;
            this._anti.exp = 100;
            this._anti.gxp = 30;
            this._anti.mDef = 0.06 * v;
            this.setHp(250000 * v);
            this.setSHp(this.getHp());
            this.attackBackInfoDict["hit1"] = {
               "hitMaxCount":99,
               "attackBackSpeed":[6,-5],
               "attackInterval":4,
               "power":220 * v,
               "attackKind":"magic"
            };
            this._anti.fallProbability = 0.07;
            this._anti.fallList = [{
               "name":"kly1",
               "bigtype":"dj"
            }];
            this.curAddEffect.add([{
               "name":"father",
               "time":gc.frameClips * 1,
               "interval":1000,
               "isForever":1
            }]);
         }
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
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
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
               if(p.x == 4)
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
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi3(direct);
                  }
               }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster204Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 85;
         }
         else
         {
            b.x = this.x + 85;
         }
         b.y = this.y - 10;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         this.doSingleHit2(direct,4,0);
      }
      
      private function doSingleHit2(direct:int, count:int, index:int) : void
      {
         direct = direct;
         count = count;
         index = index;
         if(count > 0)
         {
            var b:SpecialEffectBullet = new SpecialEffectBullet("Monster204Bullet2");
            if(direct == 0)
            {
               b.x = this.x - 65 - index * 80;
            }
            else
            {
               b.x = this.x + 65 + index * 80;
            }
            b.y = this.y - 10;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit1");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
            count--;
            index++;
            setTimeout(function(_self:Monster204):*
            {
               if(!_self.isDead())
               {
                  _self.doSingleHit2(direct,count,index);
               }
            },300,this);
         }
      }
      
      private function doHi3(direct:uint) : void
      {
         var isFix:Boolean = false;
         for each(var bh in gc.getPlayerArray())
         {
            isFix = false;
            if(bh.x > this.x)
            {
               if(bh.getBBDC().getDirect() == 0 && this.getBBDC().getDirect() == 1)
               {
                  isFix = true;
               }
            }
            else if(bh.getBBDC().getDirect() == 1 && this.getBBDC().getDirect() == 0)
            {
               isFix = true;
            }
            if(isFix)
            {
               if(!bh.isDead() && !bh.isYourFather())
               {
                  bh.addCurAddEffect([{
                     "name":BaseAddEffect.EYEFIX,
                     "time":gc.frameClips * 3
                  }]);
               }
            }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 300;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget;
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
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
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
         super.destroy();
      }
   }
}
