package export.level.StageListener121Child
{
   import base.BaseHero;
   import base.BaseObject;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   
   public class LineEffect extends Sprite
   {
      
      public static var LINE_RED:uint = 1;
      
      public static var LINE_BLUE:uint = 2;
       
      
      private var color:uint;
      
      private var type:uint;
      
      private var _targetObject1:BaseObject;
      
      private var _targetObject2:BaseObject;
      
      private const OFFSETVALUE:uint = 40;
      
      private var _offsetYVal:int = -40;
      
      private var _direct:int = -1;
      
      private var glow:GlowFilter;
      
      private var perSecondCount:uint = 24;
      
      public var isDestroy:Boolean = false;
      
      public function LineEffect(type:uint)
      {
         super();
         this.type = type;
         if(type == LINE_RED)
         {
            color = 16711680;
         }
         else if(type == LINE_BLUE)
         {
            color = 255;
         }
         else
         {
            color = 16777215;
         }
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
         if(this.isDestroy)
         {
            return;
         }
         if(!_targetObject1 || !_targetObject2)
         {
            return;
         }
         if(_targetObject1.isDead() || _targetObject2.isDead())
         {
            this.destroy();
            return;
         }
         if(AUtils.GetDisBetweenTwoObj(_targetObject1,_targetObject2) >= 500)
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
         if(this.perSecondCount > 0)
         {
            this.perSecondCount--;
            if(this.perSecondCount == 0)
            {
               if(this.type == LineEffect.LINE_BLUE)
               {
                  if(_targetObject1 is BaseHero)
                  {
                     if(BaseHero(_targetObject1).roleProperies)
                     {
                        BaseHero(_targetObject1).reduceMp(BaseHero(_targetObject1).roleProperies.getSMMP() * 0.02);
                     }
                  }
                  if(_targetObject2 is BaseHero)
                  {
                     if(BaseHero(_targetObject2).roleProperies)
                     {
                        BaseHero(_targetObject2).reduceMp(BaseHero(_targetObject2).roleProperies.getSMMP() * 0.02);
                     }
                  }
               }
               else if(this.type == LineEffect.LINE_RED)
               {
                  if(_targetObject1 is BaseHero)
                  {
                     if(BaseHero(_targetObject1).roleProperies)
                     {
                        _targetObject1.reduceHp(BaseHero(_targetObject1).roleProperies.getSHHP() * 0.02);
                     }
                  }
                  if(_targetObject2 is BaseHero)
                  {
                     if(BaseHero(_targetObject2).roleProperies)
                     {
                        _targetObject2.reduceHp(BaseHero(_targetObject2).roleProperies.getSHHP() * 0.02);
                     }
                  }
               }
               this.perSecondCount = 24;
            }
         }
      }
      
      public function destroy() : void
      {
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
