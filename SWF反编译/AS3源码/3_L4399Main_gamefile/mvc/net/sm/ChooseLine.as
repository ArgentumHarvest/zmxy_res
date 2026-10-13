package mvc.net.sm
{
   import com.superkaka.mvc.Control.net.SMessage;
   import mvc.vo.Line;
   
   public class ChooseLine extends SMessage
   {
       
      
      private var _line:Line;
      
      public function ChooseLine(line:Line)
      {
         this._line = line;
         super("RMConnector.Route",1,1,1);
      }
      
      override protected function writeBody() : void
      {
         var jObj:Object = {
            "route":{
               "module":"Game",
               "path":"RMLine.ChooseLine"
            },
            "data":{"id":_line.id}
         };
         body.writeUTFBytes(JSON.stringify(jObj));
         _line = null;
      }
   }
}
