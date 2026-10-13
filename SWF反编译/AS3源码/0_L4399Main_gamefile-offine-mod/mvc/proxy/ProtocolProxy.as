package mvc.proxy
{
   import com.superkaka.mvc.Base.BaseProxy;
   import mvc.configs.ProtocalData;
   
   public class ProtocolProxy extends BaseProxy
   {
       
      
      public function ProtocolProxy()
      {
         super();
      }
      
      public function getProtocolJson() : Object
      {
         return ProtocalData.data;
      }
   }
}
