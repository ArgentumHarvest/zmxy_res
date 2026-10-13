package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.level.StageListener111;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster48 extends BaseMonster
   {
      
      public static var kind_write:uint = 20;
      
      public static var kind_red:uint = 21;
      
      public static var kind_hui:uint = 22;
      
      public static var kind_zi:uint = 23;
      
      public static var kind_gold:uint = 24;
       
      
      private var _kind:uint;
      
      public function Monster48()
      {
         super();
         this.horizenSpeed = 8;
         this.setHp(1000);
         this.setSHp(1000);
         this.normalAttackRate = 0.25;
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.mDef = 0;
         this._anti.def = 0;
         this._anti.exp = 4;
         this._anti.gxp = 1;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":5,
            "attackKind":"physics"
         };
         this.isBoss = false;
         this._kind = 20;
         this.setAction("wait");
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
      }
      
      public function setKind(k:uint) : void
      {
         k = k;
         this._kind = k;
         this.setAction(this.curAction);
         var lv:uint = 0;
         if(gc.hero1)
         {
            lv = gc.hero1.roleProperies.getLevel();
         }
         else if(gc.hero2)
         {
            lv = gc.hero2.roleProperies.getLevel();
         }
         if(gc.isHideDebug)
         {
            if(this._kind == 20)
            {
               this.setSHp(lv * 50);
               this.setHp(this.getSHp());
            }
            else if(this._kind == 21)
            {
               this.setSHp(lv * lv * 10);
               this.setHp(this.getSHp());
            }
            else if(this._kind == 22)
            {
               this.setSHp(lv * 70);
               this.setHp(this.getSHp());
               var mDef:Number = (lv + 23) / 100;
               if(mDef > 0.99)
               {
                  mDef = 0.99;
               }
               this._anti.mDef = mDef;
            }
            else if(this._kind == 23)
            {
               this.setSHp(1);
               this.setHp(this.getSHp());
            }
            else if(this._kind == 24)
            {
               this.setSHp(lv * lv * lv + 20000);
               this.setHp(this.getSHp());
            }
         }
         if(this._kind == kind_zi)
         {
            TweenMax.delayedCall(3,function(_self:Monster48):*
            {
               _self.destroy();
            },[this]);
         }
      }
      
      public function getKind() : uint
      {
         return this._kind;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster48");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],60,60,new Point(0,0));
            bbdc.setOffsetXY(0,10);
            bbdc.setFrameStopCount([[999],[999],[999],[999],[999]]);
            bbdc.setFrameCount([1,1,1,1,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster48--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ShaiZiObjectSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         super.setAction(str);
         var curPoint:Point = this.bbdc.getCurPoint();
         var pointY:uint = this._kind - 20;
         switch(str)
         {
            case "wait":
               if(curPoint.y != pointY)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(pointY);
               }
               this.bbdc.setState(str);
               break;
            case "walk":
               if(curPoint.y != pointY)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(pointY);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               if(curPoint.y != pointY)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(pointY);
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
         state;
      }
      
      override protected function turnLeft() : *
      {
      }
      
      override protected function turnRight() : *
      {
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,canHurt);
         if(this._kind == 24)
         {
            if(gc.pWorld.getBaseLevelListener() is StageListener111)
            {
               StageListener111(gc.pWorld.getBaseLevelListener()).setDropRateAddByGoldHurt();
            }
         }
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override protected function move() : void
      {
         this.speed.x = 0;
         super.move();
      }
      
      override public function destroy() : void
      {
         if(this.getHp() <= 0)
         {
            if(this._kind == Monster48.kind_zi)
            {
               if(this.curAttackTarget)
               {
                  if(this.curAttackTarget.curAddEffect)
                  {
                     this.curAttackTarget.curAddEffect.add([{
                        "name":BaseAddEffect.STUN,
                        "time":gc.frameClips * 2
                     }]);
                  }
               }
            }
            if(gc.pWorld.getBaseLevelListener() is StageListener111)
            {
               StageListener111(gc.pWorld.getBaseLevelListener()).setKillNumByKind(this._kind);
            }
         }
         super.destroy();
      }
   }
}
