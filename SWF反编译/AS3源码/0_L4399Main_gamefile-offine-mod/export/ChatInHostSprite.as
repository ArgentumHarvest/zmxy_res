package export
{
   import com.greensock.TweenMax;
   import config.Config;
   import event.CommonEvent;
   import fl.controls.TextArea;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ChatInHostSprite extends Sprite
   {
       
      
      public var chatTextArea:TextArea;
      
      public var chatInput:TextField;
      
      public var confirmBtn:SimpleButton;
      
      public var rightBtn:SimpleButton;
      
      public var leftBtn:SimpleButton;
      
      private var chatTextFiled:TextField;
      
      private var chatArray:Array;
      
      private const MAX_CHAT_LEN:uint = 40;
      
      private var gc:Config;
      
      public function ChatInHostSprite()
      {
         chatArray = [];
         super();
         this.chatInput.addEventListener("keyDown",__keyDown);
         this.chatInput.text = "";
         this.chatInput.visible = false;
         this.chatTextArea.visible = false;
         chatTextFiled = new TextField();
         chatTextFiled.multiline = true;
         chatTextFiled.wordWrap = true;
         chatTextFiled.width = 270;
         chatTextFiled.height = 230;
         chatTextFiled.x = 10;
         chatTextFiled.y = 10;
         this.addChild(chatTextFiled);
         chatTextFiled.visible = false;
         this.confirmBtn.addEventListener("click",__sendChat);
         this.rightBtn.addEventListener("click",__show);
         this.leftBtn.addEventListener("click",__hide);
         this.leftBtn.visible = false;
         gc = Config.getInstance();
      }
      
      private function __show(evt:MouseEvent) : void
      {
         TweenMax.to(this,1,{"x":-8});
         this.rightBtn.visible = false;
         this.leftBtn.visible = true;
      }
      
      private function __hide(evt:MouseEvent) : void
      {
         TweenMax.to(this,1,{"x":-293});
         this.rightBtn.visible = true;
         this.leftBtn.visible = false;
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
         if(chatArray.length > 40)
         {
            chatArray.shift();
         }
         this.chatTextFiled.htmlText = chatArray.join("<br>");
         this.chatTextFiled.scrollV = this.chatTextFiled.maxScrollV;
      }
      
      private function __sendChat(evt:MouseEvent) : void
      {
         if(this.chatInput.text != "")
         {
            gc.sendChat(this.chatInput.text);
            this.chatInput.text = "";
            stage.focus = null;
         }
      }
      
      private function __keyDown(evt:KeyboardEvent) : void
      {
         if(this.chatInput.text != "")
         {
            if(evt.keyCode == 13)
            {
               gc.sendChat(this.chatInput.text);
               this.chatInput.text = "";
               stage.focus = null;
            }
         }
      }
      
      public function clearChat() : void
      {
         this.chatInput.text = "";
         this.chatTextArea.text = "";
         this.chatArray.length = 0;
      }
      
      public function destroy() : void
      {
         this.confirmBtn.removeEventListener("click",__sendChat);
         chatInput.removeEventListener("keyDown",__keyDown);
         gc.eventManger.removeEventListener("NormalChat",__updateChat);
         this.rightBtn.removeEventListener("click",__show);
         this.leftBtn.removeEventListener("click",__hide);
      }
   }
}
