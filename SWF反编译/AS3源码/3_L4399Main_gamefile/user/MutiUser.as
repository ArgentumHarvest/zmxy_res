package user
{
   import base.BaseHero;
   import flash.geom.Point;
   
   public class MutiUser
   {
       
      
      private var _sid:int;
      
      private var _hp:uint;
      
      private var _shp:uint;
      
      private var _equpId:uint;
      
      private var _weaponId:uint;
      
      private var _roleId:uint;
      
      private var _mDef:uint;
      
      private var _def:uint;
      
      private var _level:uint;
      
      private var _pos:Point;
      
      private var _direct:int;
      
      private var _index:uint;
      
      private var _hero:BaseHero;
      
      private var _petName:String;
      
      private var _petHp:int;
      
      private var _petMp:int;
      
      private var _petLevel:uint;
      
      private var _bmwId:uint;
      
      private var _uName:String = "";
      
      private var _honorName:String = "";
      
      private var _jobName:String = "";
      
      public function MutiUser()
      {
         super();
      }
      
      public function get petLevel() : uint
      {
         return _petLevel;
      }
      
      public function set petLevel(value:uint) : void
      {
         _petLevel = value;
      }
      
      public function get def() : uint
      {
         return _def;
      }
      
      public function set def(value:uint) : void
      {
         _def = value;
      }
      
      public function get mDef() : uint
      {
         return _mDef;
      }
      
      public function set mDef(value:uint) : void
      {
         _mDef = value;
      }
      
      public function get uName() : String
      {
         return _uName;
      }
      
      public function set uName(value:String) : void
      {
         _uName = value;
      }
      
      public function get bmwId() : uint
      {
         return _bmwId;
      }
      
      public function set bmwId(value:uint) : void
      {
         _bmwId = value;
      }
      
      public function get petMp() : uint
      {
         return _petMp;
      }
      
      public function set petMp(value:uint) : void
      {
         _petMp = value;
      }
      
      public function get petHp() : int
      {
         return _petHp;
      }
      
      public function set petHp(value:int) : void
      {
         _petHp = value;
      }
      
      public function get petName() : String
      {
         return _petName;
      }
      
      public function set petName(value:String) : void
      {
         _petName = value;
      }
      
      public function get index() : uint
      {
         return _index;
      }
      
      public function set index(value:uint) : void
      {
         _index = value;
      }
      
      public function get hero() : BaseHero
      {
         return _hero;
      }
      
      public function set hero(value:BaseHero) : void
      {
         _hero = value;
      }
      
      public function get direct() : int
      {
         return _direct;
      }
      
      public function set direct(value:int) : void
      {
         _direct = value;
      }
      
      public function get pos() : Point
      {
         return _pos;
      }
      
      public function set pos(value:Point) : void
      {
         _pos = value;
      }
      
      public function get sid() : int
      {
         return _sid;
      }
      
      public function set sid(value:int) : void
      {
         _sid = value;
      }
      
      public function get roleId() : uint
      {
         return _roleId;
      }
      
      public function set roleId(value:uint) : void
      {
         _roleId = value;
      }
      
      public function get weaponId() : uint
      {
         return _weaponId;
      }
      
      public function set weaponId(value:uint) : void
      {
         _weaponId = value;
      }
      
      public function get equpId() : uint
      {
         return _equpId;
      }
      
      public function set equpId(value:uint) : void
      {
         _equpId = value;
      }
      
      public function get hp() : uint
      {
         return _hp;
      }
      
      public function set hp(value:uint) : void
      {
         _hp = value;
         if(_hp < 0)
         {
            _hp = 0;
         }
         else if(_hp > _shp)
         {
            _hp = _shp;
         }
      }
      
      public function get shp() : uint
      {
         return _shp;
      }
      
      public function set shp(value:uint) : void
      {
         _shp = value;
      }
      
      public function get level() : uint
      {
         return _level;
      }
      
      public function set level(value:uint) : void
      {
         _level = value;
      }
      
      public function getMutiInfo() : String
      {
         return _hp + "," + _shp + "," + _equpId + "," + _weaponId + "," + _level + "," + "," + "," + "," + "," + this.def + "," + this.mDef + "," + this.petLevel;
      }
      
      public function get honorName() : String
      {
         return _honorName;
      }
      
      public function set honorName(value:String) : void
      {
         _honorName = value;
      }
      
      public function get jobName() : String
      {
         return _jobName;
      }
      
      public function set jobName(value:String) : void
      {
         _jobName = value;
      }
   }
}
