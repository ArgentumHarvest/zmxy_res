package export.monster.Monster191Children
{
   import base.BaseHero;
   import base.BaseMonster;
   import base.BaseObject;
   import event.CommonEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   
   public class LineEffect extends Sprite
   {
       
      
      private var color:uint;
      
      private var _targetObject1:BaseObject;
      
      private var _targetObject2:BaseObject;
      
      private const OFFSETVALUE:uint = 40;
      
      private var _offsetYVal:int = -40;
      
      private var _direct:int = -1;
      
      private var glow:GlowFilter;
      
      public var continueCount:int = 240;
      
      private var perSecondCount:uint = 24;
      
      public var isDestroy:Boolean = false;
      
      private var lashHp:int = 0;
      
      public function LineEffect()
      {
         super();
         color = 16711680;
         this.glow = new GlowFilter(color,1,15,15,1.5,3,false,false);
         this.filters = [this.glow];
      }
      
      public function step() : void
      {
         var controlPoint:* = null;
         var disX:Number = NaN;
         var disY:Number = NaN;
         var dis:Number = NaN;
         var offsetX:Number = NaN;
         var offsetY:Number = NaN;
         var cure:int = 0;
         if(this.isDestroy)
         {
            return;
         }
         if(continueCount > 0)
         {
            continueCount--;
            if(continueCount == 0)
            {
               this.destroy();
            }
         }
         if(!_targetObject1 || !_targetObject2)
         {
            this.destroy();
            return;
         }
         if(_targetObject1.isDead() || _targetObject2.isDead())
         {
            this.destroy();
            return;
         }
         var point1:Point = new Point(_targetObject1.x,_targetObject1.y);
         var point2:Point = new Point(_targetObject2.x,_targetObject2.y);
         var averX:Number = (point1.x + point2.x) / 2;
         var averY:Number = (point1.y + point2.y) / 2;
         if(point1.x != point2.x && point1.y != point2.y)
         {
            disX = Math.abs(point1.x - point2.x);
            disY = Math.abs(point1.y - point2.y);
            dis = AUtils.GetDisBetweenTwoObj(point1,point2);
            offsetX = _offsetYVal * disY / dis;
            offsetY = _offsetYVal * disX / dis;
            controlPoint = new Point(averX + offsetX,averY + offsetY);
         }
         else if(point1.x == point2.x)
         {
            controlPoint = new Point(averX + _offsetYVal,averY);
         }
         else
         {
            controlPoint = new Point(averX,averY + _offsetYVal);
         }
         this.graphics.clear();
         graphics.lineStyle(3,color);
         this.graphics.moveTo(point1.x,point1.y);
         this.graphics.curveTo(controlPoint.x,controlPoint.y,point2.x,point2.y);
         if(_direct == -1)
         {
            _offsetYVal += 12;
            if(_offsetYVal > 40)
            {
               _offsetYVal = 40;
               _direct = 1;
            }
         }
         else
         {
            _offsetYVal -= 12;
            if(_offsetYVal < -40)
            {
               _offsetYVal = -40;
               _direct = -1;
            }
         }
         var newlashHp:int = this.getNowHp();
         if(lashHp > 0 && newlashHp > 0)
         {
            if(newlashHp > lashHp)
            {
               cure = newlashHp - lashHp;
               this.dispatchEvent(new CommonEvent("cure",cure));
               _targetObject2.reduceHp(cure);
            }
         }
         lashHp = newlashHp;
      }
      
      private function getNowHp() : int
      {
         if(_targetObject2 is BaseHero)
         {
            if(BaseHero(_targetObject2).roleProperies)
            {
               return BaseHero(_targetObject2).roleProperies.getHHP();
            }
         }
         else if(_targetObject2 is BaseMonster)
         {
            return BaseMonster(_targetObject2).getHp();
         }
         return lashHp;
      }
      
      public function destroy() : void
      {
         this.dispatchEvent(new Event("destroy"));
         this._targetObject1 = null;
         this._targetObject2 = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this.isDestroy = true;
      }
      
      public function get targetObject1() : BaseObject
      {
         return _targetObject1;
      }
      
      public function set targetObject1(value:BaseObject) : void
      {
         _targetObject1 = value;
      }
      
      public function get targetObject2() : BaseObject
      {
         return _targetObject2;
      }
      
      public function set targetObject2(value:BaseObject) : void
      {
         _targetObject2 = value;
         lashHp = this.getNowHp();
      }
      
      public function get offsetYVal() : int
      {
         return _offsetYVal;
      }
      
      public function set offsetYVal(value:int) : void
      {
         _offsetYVal = value;
      }
      
      public function get direct() : uint
      {
         return _direct;
      }
      
      public function set direct(value:uint) : void
      {
         _direct = value;
      }
   }
}
