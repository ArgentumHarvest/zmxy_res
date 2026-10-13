package export.pill
{
   import base.BaseHero;
   import event.CommonEvent;
   
   public class Pill
   {
      
      public static var PILL_HP:uint = 0;
       
      
      private var _type:uint = 0;
      
      private var _value:uint = 0;
      
      private var _bh:BaseHero;
      
      public function Pill(type:uint, bh:BaseHero)
      {
         super();
         this._type = type;
         this._bh = bh;
         this.addPill();
      }
      
      public function addPill() : void
      {
         var rate:Number = NaN;
         if(_type == PILL_HP)
         {
            this._value = this._bh.getPlayer().findAllImmortalityAddHp();
            rate = 0;
            if(_bh.roleProperies.getSHHP() > 0)
            {
               rate = _bh.roleProperies.getHHP() / _bh.roleProperies.getSHHP();
            }
            else
            {
               rate = 0;
            }
            _bh.roleProperies.dispatchEvent(new CommonEvent("SetSHHp",[_bh.roleProperies.getSHHP() + this._value]));
            _bh.roleProperies.dispatchEvent(new CommonEvent("SetHHp",[_bh.roleProperies.getHHP() + this._value * rate]));
         }
      }
      
      public function refreshPill() : void
      {
         this.removePill();
         this.addPill();
      }
      
      public function removePill() : void
      {
         var removeHp:int = this._value;
         var rate:Number = 0;
         if(_bh.roleProperies.getSHHP() > 0)
         {
            rate = _bh.roleProperies.getHHP() / _bh.roleProperies.getSHHP();
         }
         else
         {
            rate = 0;
         }
         _bh.roleProperies.dispatchEvent(new CommonEvent("SetSHHp",[_bh.roleProperies.getSHHP() - removeHp]));
         _bh.roleProperies.dispatchEvent(new CommonEvent("SetHHp",[_bh.roleProperies.getHHP() - removeHp * rate]));
      }
      
      public function get type() : uint
      {
         return _type;
      }
      
      public function set type(value:uint) : void
      {
         _type = value;
      }
      
      public function get value() : uint
      {
         return _value;
      }
      
      public function set value(value:uint) : void
      {
         _value = value;
      }
   }
}
