package mvc.control.net.rm
{
   import com.superkaka.mvc.Control.net.rm.GameReceiveControl;
   import flash.utils.ByteArray;
   
   public class MyCommonReceiveControl extends GameReceiveControl
   {
       
      
      public function MyCommonReceiveControl()
      {
         super();
      }
      
      public function GetMsg(body:ByteArray) : void
      {
         trace("-------GetMsg----------");
         var str:String = body.readUTFBytes(body.bytesAvailable);
         trace("str:" + str);
         var jObj:Object = JSON.parse(str);
      }
   }
}
