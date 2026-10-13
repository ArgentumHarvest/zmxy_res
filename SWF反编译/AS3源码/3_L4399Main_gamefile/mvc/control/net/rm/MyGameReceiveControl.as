package mvc.control.net.rm
{
   import com.superkaka.game.Const.GameConst;
   import com.superkaka.mvc.Control.net.rm.GameReceiveControl;
   import flash.utils.ByteArray;
   
   public class MyGameReceiveControl extends GameReceiveControl
   {
       
      
      public function MyGameReceiveControl()
      {
         super();
      }
      
      public function LeftFb(body:ByteArray) : void
      {
         trace("-------LeftFb----------");
         var str:String = body.readUTFBytes(body.bytesAvailable);
         trace("str:" + str);
         var jObj:Object = JSON.parse(str);
         var result:int = jObj.result;
         if(result == 1)
         {
         }
      }
      
      public function FbTimeout(body:ByteArray) : void
      {
         trace("-------FbTimeout----------");
         var str:String = body.readUTFBytes(body.bytesAvailable);
         trace("str:" + str);
         var jObj:Object = JSON.parse(str);
         if(GameConst.isAutoTest)
         {
         }
      }
      
      public function StartGameAfterLoading(body:ByteArray) : void
      {
         trace("-------StartGameAfterLoading----------");
         var str:String = body.readUTFBytes(body.bytesAvailable);
         trace("str:" + str);
         var jObj:Object = JSON.parse(str);
      }
      
      public function ByondLoading(body:ByteArray) : void
      {
         trace("-------ByondLoading----------");
         var str:String = body.readUTFBytes(body.bytesAvailable);
         trace("str:" + str);
         var jObj:Object = JSON.parse(str);
      }
   }
}
