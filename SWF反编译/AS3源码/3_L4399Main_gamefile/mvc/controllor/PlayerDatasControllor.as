package mvc.controllor
{
   import com.superkaka.Tools.Singleton;
   
   public class PlayerDatasControllor extends Singleton
   {
       
      
      public var playerDatas:Array;
      
      public function PlayerDatasControllor()
      {
         playerDatas = [];
         super();
      }
      
      public static function getIns() : PlayerDatasControllor
      {
         return Singleton.getIns(PlayerDatasControllor);
      }
   }
}
