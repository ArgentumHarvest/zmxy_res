package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import export.monster.Monster145Children.ShengdanPresent;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster148 extends BaseMonster
   {
       
      
      private var sdPresent:ShengdanPresent;
      
      public function Monster148()
      {
         super();
         this.horizenSpeed = 10;
         this.setHp(1500000);
         this.setSHp(1500000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 4;
         this._anti.exp = 6;
         this._anti.gxp = 2;
         this.isBoss = false;
         this.setAction("wait");
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster148");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(3,-10);
            bbdc.setFrameStopCount([[4,4,4,4],[15]]);
            bbdc.setFrameCount([4,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            this.turnRight();
            return;
         }
         throw new Error("Monster148--BitmapData Error!");
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
               this.fallPresent();
               this.setYourFather(99999);
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
         }
      }
      
      private function fallPresent() : void
      {
         if(!this.sdPresent)
         {
            this.sdPresent = new ShengdanPresent();
            this.sdPresent.x = this.x;
            this.sdPresent.y = this.y - 40;
            gc.gameSence.addChild(this.sdPresent);
            gc.otherList.push(this.sdPresent);
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
               this.setAction("walk");
               this.turnRight();
               break;
            case "dead":
               this.destroy();
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         var _loc4_:* = state;
         if("hurt" === _loc4_)
         {
            this.setStatic();
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(0,canHurt);
      }
      
      override protected function myIntelligence() : void
      {
         if(this.isBeAttacking())
         {
         }
         var point:Point = this.parent.localToGlobal(new Point(this.x,this.y));
         if(point.x > 1000)
         {
            this.destroy();
         }
      }
      
      override protected function normalWalk() : void
      {
         if(!this.isBeAttacking())
         {
            this.setAction("walk");
         }
      }
      
      override public function destroy() : void
      {
         this.sdPresent = null;
         super.destroy();
      }
   }
}
