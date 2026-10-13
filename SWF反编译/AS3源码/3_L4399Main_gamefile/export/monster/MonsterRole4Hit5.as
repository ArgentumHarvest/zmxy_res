package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import base.BaseObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class MonsterRole4Hit5 extends BaseMonster
   {
       
      
      private var followObject:BaseObject;
      
      private var sourceRole:BaseObject;
      
      private var timeCount:uint;
      
      public function MonsterRole4Hit5(f:BaseObject, s:BaseObject)
      {
         super();
         this.sourceRole = s;
         this.followObject = f;
         this.horizenSpeed = 3;
         this.setHp(9999999);
         this.setSHp(9999999);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 4;
         this._anti.exp = 6;
         this._anti.gxp = 2;
         this.isBoss = false;
         this.timeCount = gc.frameClips * 10;
         this.setAction("walk");
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Role4Hit5");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],116,120,new Point(0,0));
            bbdc.setOffsetXY(0,0);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,6],[2,2,2,9],[2,2,2,2,32]]);
            bbdc.setFrameCount([6,4,1,5,4,5]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("wuduwawa--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         str = "walk";
         super.setAction(str);
         var curPoint:Point = this.bbdc.getCurPoint();
         var _loc3_:* = str;
         if("walk" === _loc3_)
         {
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
         var _loc3_:* = state;
         if("walk" === _loc3_)
         {
            this.bbdc.setFramePointX(0);
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         var hurt:* = int(0);
         if(this.followObject is Monster123)
         {
            hurt = int(re * (this.followObject as Monster123).fightingScoreDiff);
         }
         else if(this.followObject is Monster124)
         {
            hurt = int(re * (this.followObject as Monster124).fightingScoreDiff);
         }
         else if(this.followObject is Monster121)
         {
            hurt = int(re * (this.followObject as Monster121).fightingScoreDiff);
         }
         else if(this.followObject is Monster122)
         {
            hurt = int(re * (this.followObject as Monster122).fightingScoreDiff);
         }
         else
         {
            hurt = re;
         }
         if(hurt < 1)
         {
            hurt = int(1);
         }
         super.reduceHp(hurt,canHurt);
         if(this.sourceRole && this.followObject)
         {
            if(gc.sid == this.sourceRole.sid || gc.isSingleGame())
            {
               if(this.followObject)
               {
                  if(this.followObject is BaseMonster)
                  {
                     this.followObject.reduceHp(re,false);
                  }
                  else if(this.followObject is BaseHero)
                  {
                     this.followObject.reduceHp(re,false);
                  }
                  if(this.followObject is BaseHero && gc.isInRoom())
                  {
                     gc.sendHurt(re,this.followObject.sid,this.followObject.getRoleId() * 10 + this.sourceRole.getRoleId(),"",0,0,0,false,false);
                  }
               }
            }
         }
      }
      
      override public function setAttackBack(p:Point) : void
      {
      }
      
      override protected function checkOver() : void
      {
         if(this.y >= 3000)
         {
            this.destroy();
         }
      }
      
      override protected function myIntelligence() : void
      {
         if(this.timeCount > 0)
         {
            this.timeCount--;
         }
         if(this.followObject)
         {
            if(AUtils.GetDisBetweenTwoObj(this,this.followObject) > 100)
            {
               if(this.timeCount % gc.frameClips == 0)
               {
                  if(this.x > this.followObject.x)
                  {
                     this.turnLeft();
                  }
                  else
                  {
                     this.turnRight();
                  }
               }
            }
            else
            {
               this.setStatic();
            }
            if(this.followObject.isDead() || this.timeCount == 0)
            {
               this.destroy();
            }
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.followObject = null;
         this.sourceRole = null;
      }
      
      public function getSourceRole() : BaseObject
      {
         return this.sourceRole;
      }
   }
}
