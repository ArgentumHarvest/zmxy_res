package mvc.controllor
{
   import com.superkaka.Tools.Singleton;
   import mvc.vo.Player;
   
   public class MyUserManager extends Singleton
   {
       
      
      private var _socketPlayer:Player;
      
      public function MyUserManager()
      {
         super();
      }
      
      public static function getIns() : MyUserManager
      {
         return Singleton.getIns(MyUserManager);
      }
      
      public function get socketPlayer() : Player
      {
         return _socketPlayer;
      }
      
      public function set socketPlayer(value:Player) : void
      {
         _socketPlayer = value;
      }
   }
}
