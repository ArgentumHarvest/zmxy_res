package my
{
   import config.Config;
   import event.CommonEvent;
   import export.ChatInHostSprite;
   
   public class ChatInFb extends Singleton
   {
       
      
      private var chatSprite:ChatInHostSprite;
      
      private var gc:Config;
      
      public function ChatInFb()
      {
         super();
         gc = Config.getInstance();
      }
      
      public static function getIns() : ChatInFb
      {
         return Singleton.getIns(ChatInFb);
      }
      
      public function init() : void
      {
      }
      
      private function __sendChat(evt:CommonEvent) : void
      {
         var str:String = evt.data[0];
         gc.sendChat(str);
      }
      
      public function clearChat() : void
      {
         if(this.chatSprite)
         {
            this.chatSprite.clearChat();
         }
      }
      
      public function show() : void
      {
         if(this.chatSprite)
         {
            chatSprite.visible = true;
         }
      }
      
      public function hide() : void
      {
         if(this.chatSprite)
         {
            chatSprite.visible = false;
         }
      }
   }
}
