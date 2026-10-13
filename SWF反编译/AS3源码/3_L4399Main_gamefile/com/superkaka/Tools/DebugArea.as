package com.superkaka.Tools
{
   import fl.controls.TextInput;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class DebugArea extends Sprite
   {
      
      public static const ROLE_1:uint = 0;
      
      private static var _instance:DebugArea;
       
      
      private var _saveData:Object;
      
      private var textarea:TextField;
      
      private var background:Sprite;
      
      private var commond:TextInput;
      
      private var isPDown:Boolean = false;
      
      private var isODown:Boolean = false;
      
      private var _callback:Function;
      
      public function DebugArea()
      {
         super();
         background = new Sprite();
         this.addChild(background);
         background.mouseEnabled = false;
         background.mouseChildren = false;
         textarea = new TextField();
         textarea.y = 30;
         textarea.height = 300;
         textarea.multiline = true;
         textarea.wordWrap = false;
         textarea.border = false;
         textarea.mouseEnabled = false;
         this.addChild(textarea);
         commond = new TextInput();
         commond.x = 0;
         commond.y = 0;
         this.addChild(commond);
         commond.addEventListener("keyDown",__keyDown);
         this.addEventListener("addedToStage",__added);
         this.addEventListener("mouseDown",__onMouseDown);
         this.addEventListener("mouseUp",__onMouseUp);
      }
      
      public static function getIns() : DebugArea
      {
         if(!_instance)
         {
            _instance = new DebugArea();
         }
         return _instance;
      }
      
      protected function __onMouseUp(evt:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      protected function __onMouseDown(evt:MouseEvent) : void
      {
         this.startDrag();
      }
      
      public function initSaveData(saveData:Object) : void
      {
         _saveData = saveData;
      }
      
      protected function __keyDown(evt:KeyboardEvent) : void
      {
         var comm:* = null;
         var params:* = null;
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
               this.textarea.htmlText = "";
               this.commond.text = "";
            }
            else if(comm.indexOf("-offsetx") != -1)
            {
               params = comm.split(" ");
               this.x += int(params[1]);
            }
            else if(comm.indexOf("-offsety") != -1)
            {
               params = comm.split(" ");
               this.y += int(params[1]);
            }
            else if(comm == "-hide")
            {
               textarea.visible = false;
               background.visible = false;
               this.commond.text = "";
            }
            else if(comm == "-show")
            {
               textarea.visible = true;
               background.visible = true;
               this.commond.text = "";
            }
            else if(comm.indexOf("-config") != -1)
            {
               params = comm.split(" ");
               _callback(params);
            }
            else if(comm.indexOf("-add") != -1 || comm.indexOf("-money") != -1 || comm.indexOf("-soul") != -1 || comm.indexOf("-exp") != -1 || comm.indexOf("-mission") != -1 || comm.indexOf("-sign") != -1 || comm.indexOf("-weather") != -1 || comm.indexOf("-autofight") != -1 || comm.indexOf("-bagua") != -1 || comm.indexOf("-baguapai") != -1 || comm.indexOf("-fashion") != -1 || comm.indexOf("-recharge") != -1 || comm.indexOf("-hero") != -1 || comm.indexOf("-resetrate") != -1 || comm.indexOf("-title") != -1)
            {
               params = comm.split(" ");
               _callback(params);
            }
            else
            {
               showResult("参数错误","#FF0000");
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
         if(evt.keyCode == 79)
         {
            this.isPDown = false;
         }
         else if(evt.keyCode == 80)
         {
            this.isODown = false;
         }
         else if(this.isODown && this.isPDown && evt.keyCode == 81)
         {
            DebugArea.getIns().visible = !DebugArea.getIns().visible;
         }
      }
      
      protected function __keydown(evt:KeyboardEvent) : void
      {
         if(evt.keyCode == 79)
         {
            this.isPDown = true;
         }
         if(evt.keyCode == 80)
         {
            this.isODown = true;
         }
      }
      
      public function init(container:DisplayObjectContainer, callback:Function) : void
      {
         container.addChild(_instance);
         _callback = callback;
         DebugArea.getIns().visible = false;
      }
      
      public function initWithContainer(container:DisplayObjectContainer) : void
      {
         container.addChild(_instance);
      }
      
      public function showResult(info:String, color:String) : void
      {
         var addText:* = null;
      }
      
      public function showInfo(info:String, color:String = "#00FF00") : void
      {
         var addText:* = null;
      }
      
      public function traceOut(obj:Object, roleId:uint = 0) : void
      {
      }
   }
}
