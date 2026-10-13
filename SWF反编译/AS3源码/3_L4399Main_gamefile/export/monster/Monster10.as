package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster10 extends BaseMonster
   {
       
      
      public function Monster10()
      {
         super();
         if(gc.curStageAndCurLevel.curStage == 9)
         {
            this.horizenSpeed = 6;
            this._anti.def = 40;
            this._anti.exp = 24;
            this._anti.gxp = 12;
            this.setHp(18000);
            this.setSHp(18000);
            this.attackBackInfoDict["hit1"] = {
               "hitMaxCount":99,
               "attackBackSpeed":[6,-5],
               "attackInterval":4,
               "power":120,
               "attackKind":"physics"
            };
         }
         else
         {
            this.horizenSpeed = 3;
            this.normalAttackRate = 0.7;
            this._anti.def = 4;
            this._anti.exp = 6;
            this._anti.gxp = 2;
            this.setHp(1800);
            this.setSHp(1800);
            this.attackBackInfoDict["hit1"] = {
               "hitMaxCount":99,
               "attackBackSpeed":[6,-5],
               "attackInterval":4,
               "power":12,
               "attackKind":"physics"
            };
         }
         this.attackRange = 250;
         this.alertRange = 1000;
         this.isBoss = false;
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 3,gc.frameClips * 3];
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"wptm",
            "bigtype":"dj"
         },{
            "name":"wpxt",
            "bigtype":"dj"
         },{
            "name":"wpsc",
            "bigtype":"dj"
         },{
            "name":"ptdxzg",
            "bigtype":"zb"
         },{
            "name":"ptdxzf",
            "bigtype":"zb"
         },{
            "name":"ptdcz",
            "bigtype":"zb"
         },{
            "name":"ptdjs",
            "bigtype":"zb"
         },{
            "name":"ptddp",
            "bigtype":"zb"
         },{
            "name":"ptdcs",
            "bigtype":"zb"
         },{
            "name":"ptdyyc",
            "bigtype":"zb"
         },{
            "name":"ptdcp",
            "bigtype":"zb"
         }];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster10");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(22,-17);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,7],[2,2,2,6]]);
            bbdc.setFrameCount([6,4,1,6,6,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster10--BitmapData Error!");
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
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster10Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 65;
         }
         else
         {
            b.x = this.x + 65;
         }
         b.y = this.y - 71;
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
