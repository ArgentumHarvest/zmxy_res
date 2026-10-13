package mvc.net.sm
{
   import com.superkaka.mvc.Control.net.SMessage;
   import mvc.vo.Player;
   
   public class NewPlayer extends SMessage
   {
       
      
      private var _player:Player;
      
      public function NewPlayer(player:Player)
      {
         _player = player;
         super("RMConnector.Route");
      }
      
      override protected function writeBody() : void
      {
         var jObj:Object = {
            "route":{
               "module":"Game",
               "path":"RMLogin.NewPlayer"
            },
            "data":{"name":_player.name}
         };
         body.writeUTFBytes(JSON.stringify(jObj));
         _player = null;
      }
   }
}
