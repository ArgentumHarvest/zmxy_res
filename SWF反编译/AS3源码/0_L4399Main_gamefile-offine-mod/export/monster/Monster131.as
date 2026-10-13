package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class Monster131 extends BaseMonster
   {
       
      
      public function Monster131()
      {
         super();
         this.normalAttackRate = 0.8;
         this.horizenSpeed = 3;
         this.setHp(2000000);
         this.setSHp(2000000);
         this.attackRange = 400;
         this.alertRange = 2000;
         this._anti.def = 300;
         this._anti.exp = 2000;
         this._anti.gxp = 500;
         this._anti.mDef = 0.25;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":1800,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":80,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":24,
            "power":1500,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":1,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":1000,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "琼霄";
         this.setAction("wait");
         this.isFly = true;
         this.graity = 0;
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"zhhzzzs",
            "bigtype":"dj"
         }];
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 8];
         this.skillCD2 = [gc.frameClips * 7,gc.frameClips * 12];
         this.skillCD3 = [gc.frameClips * 8,gc.frameClips * 15];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster131");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
            bbdc.setOffsetXY(0,-15);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,10],[2,2,2,10],[2,10],[2,10],[2,2,10]]);
            bbdc.setFrameCount([6,1,5,4,2,2,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster131--BitmapData Error!");
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
               this.setStatic();
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
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 1)
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
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 200;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return true;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(70);
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
         this.setYourFather(35);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster131Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 115;
         }
         else
         {
            b.x = this.x + 115;
         }
         b.y = this.y - 55;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var maxLen:uint = 0;
         for each(var bm in gc.pWorld.monsterArray)
         {
            if(bm is Monster132)
            {
               maxLen++;
            }
         }
         if(maxLen < 2)
         {
            MainGame.getInstance().createMonster(132,this.x,this.y);
         }
      }
      
      private function doHi3(direct:uint) : void
      {
         var b1:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster131Bullet3");
         b1.x = this.x;
         b1.y = this.y;
         b1.setHurtCanCutDownEffect(false);
         b1.setRole(this);
         b1.setDirect(direct);
         b1.setAction("hit3");
         gc.gameSence.addChild(b1);
         this.magicBulletArray.push(b1);
      }
      
      private function doHi4(direct:uint) : void
      {
         var i:* = 0;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster131Bullet4");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setDisable();
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         var rand:uint = 5 + RandomControllor.getIns().getRandom() * 6;
         for(i = uint(0); i < rand; )
         {
            this.createRandomMusic();
            i++;
         }
         if(RandomControllor.getIns().getRandom() < 0.5)
         {
            this.addCurAddEffect([{
               "name":BaseAddEffect.MONSTER131MUSIC1,
               "time":gc.frameClips * 10
            }]);
         }
         else
         {
            this.addCurAddEffect([{
               "name":BaseAddEffect.MONSTER131MUSIC2,
               "time":gc.frameClips * 10
            }]);
         }
      }
      
      private function createRandomMusic() : void
      {
         var b:* = null;
         if(RandomControllor.getIns().getRandom() < 0.5)
         {
            b = new EnemyMoveBullet("Monster131Bullet4Music1");
            this.attackBackInfoDict["hit4"] = {
               "hitMaxCount":99,
               "attackBackSpeed":[-3,0],
               "attackInterval":12,
               "power":80,
               "attackKind":"magic",
               "addEffect":[{
                  "name":BaseAddEffect.MONSTER131MUSIC1,
                  "time":gc.frameClips * 10
               }]
            };
         }
         else
         {
            b = new EnemyMoveBullet("Monster131Bullet4Music2");
            this.attackBackInfoDict["hit4"] = {
               "hitMaxCount":99,
               "attackBackSpeed":[-3,0],
               "attackInterval":12,
               "power":80,
               "attackKind":"magic",
               "addEffect":[{
                  "name":BaseAddEffect.MONSTER131MUSIC2,
                  "time":gc.frameClips * 10
               }]
            };
         }
         b.x = this.x + (RandomControllor.getIns().getRandom() - 0.5) * 800;
         b.y = (RandomControllor.getIns().getRandom() - 0.5) * 200 + 50;
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 8);
         b.setDistance(1000);
         b.setSpeed(0,5);
         b.setRole(this);
         b.setDirect(0);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         var dis:Number = NaN;
         var boMusic1:* = null;
         var boMusic2:* = null;
         var targetPoint:* = null;
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
         var music1:Object = this.curAddEffect.getBuffByName(BaseAddEffect.MONSTER131MUSIC1);
         var music2:Object = this.curAddEffect.getBuffByName(BaseAddEffect.MONSTER131MUSIC2);
         if(music1 || music2)
         {
            for each(var bo in gc.getPlayerAndPetArray())
            {
               dis = AUtils.GetDisBetweenTwoObj(bo,this);
               if(dis < 500)
               {
                  boMusic1 = bo.curAddEffect.getBuffByName(BaseAddEffect.MONSTER131MUSIC1);
                  boMusic2 = bo.curAddEffect.getBuffByName(BaseAddEffect.MONSTER131MUSIC2);
                  targetPoint = new Point(0,0);
                  if(music1 && boMusic1 || music2 && boMusic2)
                  {
                     if(bo.x > this.x)
                     {
                        targetPoint.x = bo.x - 200;
                     }
                     else
                     {
                        targetPoint.y = bo.x + 200;
                     }
                     if(targetPoint.x < 40)
                     {
                        targetPoint.x = 40;
                     }
                     else if(targetPoint.x > 1100)
                     {
                        targetPoint.x = 1100;
                     }
                     if(boMusic1)
                     {
                        bo.curAddEffect.remove(boMusic1);
                     }
                     if(boMusic2)
                     {
                        bo.curAddEffect.remove(boMusic2);
                     }
                     TweenMax.to(bo,1.5,{"x":targetPoint.x});
                  }
                  else if(music1 && boMusic2 || music2 && boMusic1)
                  {
                     if(bo.x > this.x)
                     {
                        targetPoint.x = bo.x + 200;
                     }
                     else
                     {
                        targetPoint.x = bo.x - 200;
                     }
                     if(targetPoint.x < 40)
                     {
                        targetPoint.x = 40;
                     }
                     else if(targetPoint.x > 1100)
                     {
                        targetPoint.x = 1100;
                     }
                     if(boMusic1)
                     {
                        bo.curAddEffect.remove(boMusic1);
                     }
                     if(boMusic2)
                     {
                        bo.curAddEffect.remove(boMusic2);
                     }
                     TweenMax.to(bo,1.5,{"x":targetPoint.x});
                  }
               }
            }
         }
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
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
      }
   }
}
