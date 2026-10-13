package mvc.control.net.rm
{
   import com.superkaka.mvc.Control.net.rm.LoginReceiveControl;
   import flash.utils.ByteArray;
   
   public class MyLineReceiveControl extends LoginReceiveControl
   {
       
      
      public function MyLineReceiveControl()
      {
         super();
      }
      
      public function AllRooms(body:ByteArray) : void
      {
         trace("-------AllRooms----------");
      }
      
      public function AllPlayers(body:ByteArray) : void
      {
         trace("-------AllPlayers----------");
      }
      
      public function AllPlayersInLogin(body:ByteArray) : void
      {
         trace("-------AllPlayersInLogin----------");
      }
      
      public function ChooseLineReturn(body:ByteArray) : void
      {
         trace("-------ChooseLineReturn----------");
         var str:String = body.readUTFBytes(body.bytesAvailable);
         trace("str:" + str);
         var jObj:Object = JSON.parse(str);
      }
      
      public function ChooseLineFull(body:ByteArray) : void
      {
         trace("-------ChooseLineFull----------");
         var str:String = body.readUTFBytes(body.bytesAvailable);
         trace("str:" + str);
      }
      
      public function GetLinesReturn(body:ByteArray) : void
      {
         trace("--GetLinesReturn--");
      }
      
      public function PlayerJoin(body:ByteArray) : void
      {
         trace("-------PlayerJoin----------");
      }
      
      public function PlayerLeft(body:ByteArray) : void
      {
         trace("-------PlayerLeft----------");
      }
   }
}
