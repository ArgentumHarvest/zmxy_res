package export.monster
{
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
   
   public class Monster182 extends BaseMonster
   {
       
      
      private var tx:TweenMax;
      
      private var tx2:TweenMax;
      
      public function Monster182()
      {
         super();
         this.horizenSpeed = 4;
         this.normalAttackRate = 0.6;
         this.horizenSpeed = 6;
         this.setHp(9000 + 0.5720000000000001 * (gc.hero1.roleProperies.getSMMP() + gc.hero1.roleProperies.getSHHP()) * gc.hero1.roleProperies.getLevel() * gc.getPlayerArray().length);
         this.setSHp(9000 + 0.5720000000000001 * (gc.hero1.roleProperies.getSMMP() + gc.hero1.roleProperies.getSHHP()) * gc.hero1.roleProperies.getLevel() * gc.getPlayerArray().length);
         this.normalAttackRate = 0.7;
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.exp = 500;
         this._anti.gxp = 250;
         this._anti.def = 56 + gc.hero1.roleProperies.getDefense();
         this._anti.mDef = 0.2;
         var baseHurt:uint = gc.hero1.roleProperies.getHurt() * 0.9 + 120;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":baseHurt,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[1,0],
            "attackInterval":30,
            "power":baseHurt,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[1,0],
            "attackInterval":30,
            "power":baseHurt,
            "attackKind":"physics"
         };
         this.isBoss = true;
         this.monsterName = "白面猿猴";
         this.setAction("wait");
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"hyjjjns3",
            "bigtype":"jns"
         },{
            "name":"sxjns2",
            "bigtype":"jns"
         },{
            "name":"p_cyzsjl",
            "bigtype":"cwzb"
         },{
            "name":"p_cycnjl",
            "bigtype":"cwzb"
         }];
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 9];
         this.skillCD2 = [gc.frameClips * 8,gc.frameClips * 11];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster182");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
            bbdc.setOffsetXY(-5,-5);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,10],[2,2,10],[20]]);
            bbdc.setFrameCount([6,4,1,5,3,3,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster182--BitmapData Error!");
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
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 2)
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
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     this.doHi3(direct);
                  }
               }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster182Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 150;
         }
         else
         {
            b.x = this.x + 150;
         }
         b.y = this.y - 105;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster182Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 160;
         }
         else
         {
            b.x = this.x + 160;
         }
         b.y = this.y - 65;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b.setFuncWhenHit(hit2Hit);
      }
      
      private function hit2Hit(bb:BaseBullet) : void
      {
         this.cureHp(this.getSHp() / 10);
      }
      
      private function doHi3(direct:*) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster182Bullet3_1");
         if(direct == 0)
         {
            b.x = this.x - 35;
         }
         else
         {
            b.x = this.x + 35;
         }
         b.y = this.y - 27;
         b.setDisable();
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new FollowBaseObjectBullet("Monster182Bullet3_2");
         if(direct == 0)
         {
            b.x = this.x - 80;
         }
         else
         {
            b.x = this.x + 80;
         }
         b.y = this.y - 35;
         b.setDisable();
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         var target:BaseObject = gc.getRandomPlayer();
         if(target)
         {
            this.diSingleHit3(target,2);
         }
      }
      
      private function diSingleHit3(target:BaseObject, num:int) : void
      {
         if(target.isDead())
         {
            return;
         }
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster182Bullet3_3");
         b.x = target.x + 0;
         b.y = target.y - 0;
         b.setRole(this);
         b.setDirect(0);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         if(num > 0)
         {
            num--;
            tx2 = TweenMax.delayedCall(1.5,this.diSingleHit3,[target,num]);
         }
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,canHurt);
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.standInObj && this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 200;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.standInObj && this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
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
         if(this.tx2)
         {
            this.tx2.kill();
            this.tx2 = null;
         }
         super.destroy();
         if(this.tx)
         {
            this.tx.kill();
            this.tx = null;
         }
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
