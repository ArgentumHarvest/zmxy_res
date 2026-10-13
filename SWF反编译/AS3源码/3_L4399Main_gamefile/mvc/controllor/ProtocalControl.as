package mvc.controllor
{
   import com.superkaka.mvc.Base.BaseControl;
   import com.superkaka.mvc.ProxyFactory;
   import mvc.proxy.ProtocolProxy;
   
   public class ProtocalControl extends BaseControl
   {
       
      
      public function ProtocalControl()
      {
         super();
      }
      
      public function getProtocolJson() : Object
      {
         var pp:ProtocolProxy = ProxyFactory.getIns().initProxy(ProtocolProxy) as ProtocolProxy;
         return pp.getProtocolJson();
      }
   }
}
