package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import export.bullet.SpecialEffectBullet;
   import export.wall.Monster28Wall;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster28 extends BaseMonster
   {
       
      
      public function Monster28()
      {
         super();
         this.horizenSpeed = 4;
         this.setHp(6000);
         this.setSHp(6000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.mDef = 0.5;
         this._anti.def = 80;
         this._anti.exp = 100;
         this._anti.gxp = 40;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":268,
            "attackKind":"physics"
         };
         this.isBoss = false;
         this.isFly = true;
         this.graity = 0;
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 3,gc.frameClips * 3];
         this._anti.fallProbability = 0.05;
         this._anti.fallList = [{
            "name":"wptm",
            "bigtype":"dj"
         },{
            "name":"wpxt",
            "bigtype":"dj"
         },{
            "name":"wpsc",
            "bigtype":"dj"
         }];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster28");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
            bbdc.setOffsetXY(5,-17);
            bbdc.setFrameStopCount([[3,3,3,3,3,3],[8],[2,2,2,2],[20]]);
            bbdc.setFrameCount([6,1,4,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster28--BitmapData Error!");
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
         var _loc4_:* = state;
         if("hit1" === _loc4_)
         {
            if(p.x == 0)
            {
               if(this.bbdc.getCurFrameCount() == 15)
               {
                  this.doHi1(direct);
               }
            }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster26Bullet1");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 200;
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
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit1";
      }
      
      override public function destroy() : void
      {
         var idx:int = 0;
         var tBullet:Monster28Wall = new Monster28Wall();
         tBullet.setUserDataName("Monster28Futai");
         tBullet.width = 240;
         tBullet.x = this.x;
         tBullet.y = this.y;
         tBullet.visible = false;
         gc.pWorld.getWallArray().push(tBullet);
         if(gc.hero1 && !gc.hero1.isDead())
         {
            idx = gc.gameSence.getChildIndex(gc.hero1);
         }
         else if(gc.hero2 && !gc.hero2.isDead())
         {
            idx = gc.gameSence.getChildIndex(gc.hero2);
         }
         gc.gameSence.addChildAt(tBullet,idx);
         super.destroy();
      }
   }
}
