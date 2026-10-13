package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster173 extends BaseMonster
   {
       
      
      private var tw:TweenMax;
      
      private var averLevel:uint = 0;
      
      public function Monster173()
      {
         super();
         this.horizenSpeed = 3;
         averLevel = gc.getAverageLevel();
         if(averLevel > 85)
         {
            averLevel = 85;
         }
         this.setHp(500 * averLevel);
         this.setSHp(this.getHp());
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 0;
         this._anti.exp = 0;
         this._anti.gxp = 0;
         this.isBoss = true;
         this.monsterName = "太阳";
         this._anti.fallList = [];
         this._anti.fallProbability = 0;
         this.setAction("wait");
      }
      
      override public function setLevel(v:uint) : void
      {
         super.setLevel(v);
         this.setHp(this._anti.level * 500 * averLevel);
         this.setSHp(this._anti.level * 500 * averLevel);
         if(v == 9)
         {
            this._anti.fallProbability = 1;
            this._anti.fallList = [{
               "name":"_sryxpt",
               "bigtype":"zb"
            }];
         }
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster173");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
            bbdc.setOffsetXY(0,-5);
            bbdc.setFrameStopCount([[1]]);
            bbdc.setFrameCount([1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            this.tweenDown();
            return;
         }
         throw new Error("Monster173--BitmapData Error!");
      }
      
      private function tweenUp() : void
      {
         tw = TweenMax.to(this.body,0.3,{
            "y":this.body.y - 10,
            "onComplete":function(_self:Monster173):*
            {
               _self.tweenDown();
            },
            "onCompleteParams":[this]
         });
      }
      
      private function tweenDown() : void
      {
         tw = TweenMax.to(this.body,0.3,{
            "y":this.body.y + 10,
            "onComplete":function(_self:Monster173):*
            {
               _self.tweenUp();
            },
            "onCompleteParams":[this]
         });
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
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
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
         super.destroy();
         if(this._anti.level == 9)
         {
            ta = gc.pWorld.getTransferDoorArray();
            for(i = 0; i < ta.length; )
            {
               mc = ta[i];
               mc.visible = true;
               i++;
            }
         }
         if(this.tw)
         {
            this.tw = null;
         }
      }
   }
}
