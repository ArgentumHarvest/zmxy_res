package mvc.vo
{
   import com.superkaka.game.Base.BaseVO;
   
   public class Player extends BaseVO
   {
       
      
      private var _name:String;
      
      private var _index:int;
      
      private var _level:int;
      
      private var _exp:int;
      
      private var _gameKey:String;
      
      public function Player()
      {
         super();
      }
      
      public function destroy() : void
      {
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(value:int) : void
      {
         _index = value;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(value:int) : void
      {
         _level = value;
      }
      
      public function get exp() : int
      {
         return _exp;
      }
      
      public function set exp(value:int) : void
      {
         _exp = value;
      }
      
      public function get gameKey() : String
      {
         return _gameKey;
      }
      
      public function set gameKey(value:String) : void
      {
         _gameKey = value;
      }
   }
}
