package mvc.control.net.rm
{
   import com.superkaka.mvc.Control.net.rm.LoginReceiveControl;
   import flash.utils.ByteArray;
   
   public class MyPlayerReceiveControl extends LoginReceiveControl
   {
       
      
      public function MyPlayerReceiveControl()
      {
         super();
      }
      
      public function UpgradeLevelTo(body:ByteArray) : void
      {
         trace("-------UpgradeLevelTo----------");
      }
      
      public function PlayerExp(body:ByteArray) : void
      {
         trace("-------PlayerExp----------");
      }
      
      public function PlayerProperty(body:ByteArray) : void
      {
         trace("-------PlayerProperty----------");
      }
      
      public function PlayerEquipmentChange(body:ByteArray) : void
      {
         trace("-------PlayerEquipmentChange----------");
      }
      
      public function GetBag(body:ByteArray) : void
      {
         trace("-------GetBag----------");
      }
   }
}
