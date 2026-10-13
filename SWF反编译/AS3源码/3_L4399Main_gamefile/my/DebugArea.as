package my
{
   import fl.controls.TextInput;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   
   public class DebugArea extends Sprite
   {
      
      public static const ROLE_1:uint = 0;
      
      private static var _instance:DebugArea;
       
      
      private var textarea:TextField;
      
      private var background:Shape;
      
      private var commond:TextInput;
      
      private var isPDown:Boolean = false;
      
      private var isODown:Boolean = false;
      
      private var container:DisplayObjectContainer;
      
      public function DebugArea()
      {
         super();
         background = new Shape();
         this.addChild(background);
         textarea = new TextField();
         textarea.y = 30;
         textarea.height = 300;
         textarea.multiline = true;
         textarea.wordWrap = false;
         textarea.border = false;
         this.addChild(textarea);
         commond = new TextInput();
         commond.x = 0;
         commond.y = 0;
         this.addChild(commond);
         commond.addEventListener("keyDown",__keyDown);
         this.traceOut("342534545656767867");
         this.addEventListener("addedToStage",__added);
      }
      
      public static function getIns() : DebugArea
      {
         if(!_instance)
         {
            _instance = new DebugArea();
         }
         return _instance;
      }
      
      protected function __keyDown(evt:KeyboardEvent) : void
      {
         var comm:* = null;
         var params:* = null;
         params = null;
         if(commond.text == "")
         {
            return;
         }
         if(evt.keyCode == 13)
         {
            comm = commond.text;
            comm = comm.toLocaleLowerCase();
            if(comm == "-clear")
            {
               this.clearTxt();
               this.commond.text = "";
            }
            else if(comm.indexOf("-offsetX"))
            {
               params = comm.split(" ");
               this.x += int(params[1]);
            }
            else if(comm.indexOf("-offsetY"))
            {
               params = comm.split(" ");
               this.y += int(params[1]);
            }
         }
      }
      
      protected function __added(evt:Event) : void
      {
         this.stage.addEventListener("keyDown",__keydown);
         this.stage.addEventListener("keyUp",__keyup);
      }
      
      protected function __keyup(evt:KeyboardEvent) : void
      {
         if(evt.keyCode == 80)
         {
            this.isPDown = false;
         }
         else if(evt.keyCode == 79)
         {
            this.isODown = false;
         }
         else if(this.isODown && this.isPDown && evt.keyCode == 81)
         {
            DebugArea.getIns().visible = !DebugArea.getIns().visible;
            if(this.container)
            {
               this.container.addChild(_instance);
            }
         }
      }
      
      protected function __keydown(evt:KeyboardEvent) : void
      {
         if(evt.keyCode == 80)
         {
            this.isPDown = true;
         }
         if(evt.keyCode == 79)
         {
            this.isODown = true;
         }
      }
      
      private function clearTxt() : void
      {
         this.textarea.htmlText = "";
      }
      
      public function initWithContainer(container:DisplayObjectContainer) : void
      {
         this.container = container;
         this.container.addChild(_instance);
         this.visible = false;
      }
      
      public function traceOut(obj:Object, roleId:uint = 0) : void
      {
         if(textarea.numLines >= 500)
         {
            this.clearTxt();
         }
         var text:String = textarea.htmlText;
         var addText:String = String(obj);
         var color:String = "#00ff00";
         switch(int(roleId))
         {
            case 0:
               color = "#ff0000";
         }
         addText = "<font color=\'" + color + "\'>" + addText + "</font>" + "<br>";
         textarea.htmlText += addText;
         textarea.width = textarea.textWidth + 10;
         background.graphics.beginFill(0,0.7);
         background.graphics.drawRect(0,0,textarea.x + textarea.width,textarea.y + textarea.height);
         background.graphics.endFill();
      }
   }
}
