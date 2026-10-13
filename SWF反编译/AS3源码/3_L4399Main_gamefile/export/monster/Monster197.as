package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import com.superkaka.Tools.ColorAdjust;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   
   public class Monster197 extends BaseMonster
   {
       
      
      public function Monster197()
      {
         super();
         this.horizenSpeed = 3;
         this.normalAttackRate = 0.7;
         this._anti.def = 160 + gc.hero1.roleProperies.getDefense();
         this._anti.exp = 6;
         this._anti.gxp = 3;
         this.setHp(14000 + 4 * gc.hero1.roleProperies.getSHHP());
         this.setSHp(this.getHp());
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":4,
            "power":280 + gc.hero1.roleProperies.getHurt(),
            "attackKind":"physics"
         };
         this.attackRange = 250;
         this.alertRange = 1000;
         this.isBoss = false;
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 3,gc.frameClips * 3];
         this._anti.fallProbability = 0.5;
         this._anti.fallList = [{
            "name":"wpxt",
            "bigtype":"dj"
         }];
         var ca:ColorAdjust = new ColorAdjust();
         ca.adjustHue(-150);
         var cmf:ColorMatrixFilter = new ColorMatrixFilter(ca);
         bbdc.filters = [cmf];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster9");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(9,-15);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,7],[2,2,2,6]]);
            bbdc.setFrameCount([6,4,1,5,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster9--BitmapData Error!");
      }
      
      override public function setLevel(v:uint) : void
      {
         super.setLevel(v);
         if(gc.curStageAndCurLevel.curStage == 54)
         {
            this._anti.def = 20 * v;
            this._anti.exp = 100;
            this._anti.gxp = 30;
            this._anti.mDef = 0.05 * v;
            this.setHp(200000 * v);
            this.setSHp(this.getHp());
            this.attackBackInfoDict["hit1"] = {
               "hitMaxCount":99,
               "attackBackSpeed":[6,-5],
               "attackInterval":4,
               "power":200 * v,
               "attackKind":"physics"
            };
            this._anti.fallProbability = 0.01 * v;
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
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
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
            if(p.x == 3)
            {
               if(this.bbdc.getCurFrameCount() == 6)
               {
                  this.doHi1(direct);
               }
            }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster9Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 85;
         }
         else
         {
            b.x = this.x + 85;
         }
         b.y = this.y - 82;
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
   }
}
