package mvc.net.sm
{
   import com.superkaka.mvc.Control.net.SMessage;
   import mvc.vo.Player;
   
   public class ChoosePlayer extends SMessage
   {
       
      
      private var _player:Player;
      
      public function ChoosePlayer(player:Player)
      {
         _player = player;
         super("RMConnector.Route");
      }
      
      override protected function writeBody() : void
      {
         var jObj:Object = {
            "route":{
               "module":"Game",
               "path":"RMLogin.ChoosePlayer"
            },
            "data":{"index":_player.index}
         };
         body.writeUTFBytes(JSON.stringify(jObj));
         _player = null;
      }
   }
}
