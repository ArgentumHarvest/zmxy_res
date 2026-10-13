package com.superkaka.mvc.Control.net.sm
{
   import com.superkaka.mvc.Control.net.SMessage;
   
   public class SendDelay extends SMessage
   {
       
      
      private var _delay:int;
      
      public function SendDelay(delay:int)
      {
         this._delay = delay;
         super("RMConnector.Route");
      }
      
      override protected function writeBody() : void
      {
         var jObj:Object = {
            "route":{
               "module":"Game",
               "path":"RMPlayer.GD"
            },
            "data":this._delay
         };
         body.writeUTF(JSON.stringify(jObj));
      }
   }
}
