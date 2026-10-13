package export
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ChatSprite extends Sprite
   {
       
      
      public var chatTextArea:TextField;
      
      public var chatInput:TextField;
      
      private var chatArray:Array;
      
      private const MAX_CHAT_LEN:uint = 20;
      
      private var gc:Config;
      
      public function ChatSprite()
      {
         chatArray = [];
         super();
         this.chatTextArea = new TextField();
         this.chatTextArea.x = 10;
         this.chatTextArea.y = 10;
         this.chatTextArea.width = 450;
         this.chatTextArea.height = 100;
         this.chatTextArea.wordWrap = true;
         this.chatTextArea.multiline = true;
         this.chatTextArea.visible = false;
         this.addChild(this.chatTextArea);
         this.chatInput = new TextField();
         this.chatInput.type = "input";
         this.chatInput.x = 125;
         this.chatInput.y = 125;
         this.chatInput.width = 330;
         this.addChild(this.chatInput);
         this.chatInput.addEventListener("keyDown",__keyDown);
         this.chatInput.text = "";
         this.chatInput.defaultTextFormat = new TextFormat(null,14,16777215);
         this.chatInput.maxChars = 30;
         this.chatInput.visible = false;
         gc = Config.getInstance();
      }
      
      private function __updateChat(evt:CommonEvent) : void
      {
         var data:* = evt.data;
         this.updateData(data[0],data[1]);
      }
      
      public function updateData(name:String, str:String) : void
      {
         var info:String = "<font size=\'16\' color=\'#ffffff\'>[" + name + "] :" + str + "</font>";
         chatArray.push(info);
         if(chatArray.length > 20)
         {
            chatArray.shift();
         }
         this.chatTextArea.htmlText = chatArray.join("<br>");
         this.chatTextArea.scrollV = this.chatTextArea.maxScrollV;
      }
      
      private function __keyDown(evt:KeyboardEvent) : void
      {
         if(this.chatInput.text != "")
         {
            if(evt.keyCode == 13)
            {
               gc.sendChat(this.chatInput.text);
               this.chatInput.text = "";
            }
         }
      }
      
      public function destroy() : void
      {
         chatInput.removeEventListener("keyDown",__keyDown);
      }
   }
}
