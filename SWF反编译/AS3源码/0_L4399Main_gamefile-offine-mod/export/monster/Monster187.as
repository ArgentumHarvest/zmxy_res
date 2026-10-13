package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.bullet.EnemyMoveBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster187 extends BaseMonster
   {
       
      
      private var _target:BaseHero;
      
      private var tw:TweenMax;
      
      private var isFallDown:Boolean = false;
      
      public function Monster187()
      {
         super();
         this.normalAttackRate = 0.8;
         this.horizenSpeed = 3;
         this.setHp(400000);
         this.setSHp(400000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 0;
         this._anti.exp = 70;
         this._anti.gxp = 35;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":10,
            "power":80,
            "attackKind":"physics"
         };
         this.isBoss = false;
         this.setAction("wait");
         this.setToCountSuppressLevel(80);
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster187");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],100,50,new Point(0,0));
            bbdc.setOffsetXY(0,5);
            bbdc.setFrameStopCount([[4,4],[8],[2,2,2,10]]);
            bbdc.setFrameCount([2,1,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster187--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite2") as Sprite;
         this.colipse.height = 20;
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
            case "dead":
               this.setStatic();
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
         var _loc4_:* = state;
         if("hit1" === _loc4_)
         {
            if(p.x == 3)
            {
               if(this.bbdc.getCurFrameCount() == 10)
               {
                  this.doHi1(direct);
               }
            }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:EnemyMoveBullet = new EnemyMoveBullet("Monster187Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 60;
            b.setSpeed(-10,0);
         }
         else
         {
            b.x = this.x + 60;
            b.setSpeed(10,0);
         }
         b.y = this.y - 20;
         b.setHurtCanCutDownEffect(false);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(20);
         b.setDistance(9999);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,canHurt);
         if(this.isFallDown)
         {
            if(this._target)
            {
               this._target.reduceHp(re,false);
            }
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         var arr:* = null;
         if(!_target)
         {
            if(!this.isBeAttacking())
            {
               super.myIntelligence();
            }
            arr = gc.getPlayerArray();
            for each(var bh in arr)
            {
               if(AUtils.GetDisBetweenTwoObj(this,bh) <= 80)
               {
                  _target = bh;
                  this.tw = TweenMax.delayedCall(8,fallDown);
                  break;
               }
            }
         }
         else if(_target.isDead())
         {
            if(this.tw)
            {
               this.tw.kill();
               this.tw = null;
            }
            _target = null;
         }
         else if(!this.isFallDown)
         {
            this.x = _target.x + 30;
            this.y = _target.y;
         }
         else if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      private function fallDown() : void
      {
         this.isFallDown = true;
         if(_target)
         {
            this.setSHp(_target.roleProperies.getSHHP());
            this.setHp(this.getSHp());
            this.x = _target.x;
            this.y = _target.y - 10;
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         if(this.tw)
         {
            this.tw.kill();
            this.tw = null;
         }
         this._target = null;
      }
   }
}
