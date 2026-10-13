package union.view
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextField;
   import union.model.EventManager;
   import union.model.LoadManager;
   import union.model.TextManager;
   import union.model.Unify;
   
   public class BasicView extends Sprite
   {
       
      
      protected var mainPanel:MovieClip;
      
      protected var assetName:String;
      
      protected var isCloseMain:Boolean = false;
      
      protected var btnNames:Array;
      
      protected var items:Array;
      
      protected var onePageNum:int = 6;
      
      protected var pageCurr:int = 1;
      
      protected var pageTotal:int = 1;
      
      public function BasicView()
      {
         btnNames = [];
         items = [];
         super();
         initialization();
         this.addEventListener("addedToStage",init);
      }
      
      protected function initialization() : void
      {
      }
      
      protected function init(event:Event) : void
      {
         this.removeEventListener("addedToStage",init);
         render();
      }
      
      protected function render() : void
      {
      }
      
      public function addBtnEvent(... arg) : void
      {
         var i:int = 0;
         var btn:* = null;
         if(mainPanel)
         {
            for(i = 0; i < arg.length; )
            {
               btnNames.push(arg[i]);
               btn = mainPanel[arg[i]];
               if(btn)
               {
                  btn.addEventListener("click",onClick);
               }
               i++;
            }
         }
      }
      
      public function removeBtnEvent() : void
      {
         var i:int = 0;
         var btn:* = null;
         if(mainPanel)
         {
            for(i = 0; i < btnNames.length; )
            {
               btn = mainPanel[btnNames[i]];
               if(btn)
               {
                  btn.removeEventListener("click",onClick);
               }
               i++;
            }
         }
      }
      
      protected function onClick(e:MouseEvent) : void
      {
         var target:DisplayObject = e.target as DisplayObject;
         this.onBtnName(target.name);
      }
      
      protected function onBtnName(name:String) : void
      {
         if(name == "btnClose")
         {
            this.onClose();
         }
         else if(name == "btnPrev" || name == "btnNext")
         {
            this.updateList(name);
         }
      }
      
      public function onClose() : void
      {
         if(this.isCloseMain)
         {
            EventManager.emit("CLOSE_MAIN");
         }
         else
         {
            this.removeFromParent();
         }
      }
      
      public function getClass(linkage:String) : Class
      {
         var a:Loader = LoadManager.getLoader(assetName);
         return a.contentLoaderInfo.applicationDomain.getDefinition(linkage) as Class;
      }
      
      public function getMovieClip(linkName:String) : MovieClip
      {
         var c:Class = getClass(linkName);
         return new c();
      }
      
      public function getBitmap(linkName:String) : Bitmap
      {
         var c:Class = getClass(linkName);
         var bitmapData:BitmapData = new c();
         return new Bitmap(bitmapData);
      }
      
      public function getSimpleButton(linkName:String) : SimpleButton
      {
         var c:Class = getClass(linkName);
         return new c();
      }
      
      public function addMovieClip(linkName:String, x:Number = 0, y:Number = 0, parent:Sprite = null) : MovieClip
      {
         var mc:MovieClip = getMovieClip(linkName);
         mc.x = x;
         mc.y = y;
         if(parent)
         {
            parent.addChild(mc);
         }
         else
         {
            this.addChild(mc);
         }
         return mc;
      }
      
      public function addMovieClipAt(linkName:String, index:int = 0) : MovieClip
      {
         var mc:MovieClip = addMovieClip(linkName);
         this.addChildAt(mc,index);
         return mc;
      }
      
      public function removeFromParent(dispose:Boolean = false) : void
      {
         var _parent:DisplayObjectContainer = this.parent as DisplayObjectContainer;
         if(dispose)
         {
            this.dispose();
         }
         if(_parent && _parent.contains(this))
         {
            _parent.removeChild(this);
         }
         _parent = null;
      }
      
      public function initListItem() : void
      {
         this.addBtnEvent("btnPrev","btnNext");
      }
      
      protected function updateList(name:*) : void
      {
         if(name == "btnPrev")
         {
            pageCurr--;
            pageCurr = pageCurr <= 1 ? 1 : pageCurr;
         }
         else if(name == "btnNext")
         {
            pageCurr++;
            pageCurr = pageCurr >= pageTotal ? pageTotal : pageCurr;
         }
         this.sendPage();
      }
      
      protected function sendPage() : void
      {
         updateArrowButton();
      }
      
      protected function updateArrowButton() : void
      {
         buttonIsGray(mainPanel["btnPrev"],pageCurr == 1);
         buttonIsGray(mainPanel["btnNext"],pageCurr == pageTotal);
         updatePageShow();
      }
      
      public function imageIsGray(image:DisplayObject, boo:Boolean) : void
      {
         var matrix:* = null;
         var myfilter:* = null;
         if(boo == false)
         {
            image.filters.length = 0;
            image.filters = null;
         }
         else
         {
            matrix = [0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0];
            myfilter = new ColorMatrixFilter(matrix);
            image.filters = [myfilter];
         }
      }
      
      public function buttonIsGray(btn:SimpleButton, boo:Boolean) : void
      {
         imageIsGray(btn,boo);
         btn.mouseEnabled = !boo;
      }
      
      protected function updatePage(arr:Array) : void
      {
         var i:int = 0;
         var item:* = null;
         Unify.hide(items);
         for(i = 0; i < arr.length; )
         {
            if(i < items.length)
            {
               item = items[i];
               item.setData(arr[i]);
               item.visible = true;
            }
            i++;
         }
         updateArrowButton();
      }
      
      protected function button(name:*) : SimpleButton
      {
         return mainPanel[name];
      }
      
      protected function text(name:String) : TextField
      {
         return mainPanel[name];
      }
      
      public function show(... arg) : void
      {
         var array:* = null;
         var i:int = 0;
         var item:* = null;
         if(mainPanel)
         {
            array = [];
            for(i = 0; i < arg.length; )
            {
               item = mainPanel[arg[i]];
               if(item)
               {
                  array.push(item);
               }
               i++;
            }
            if(array.length)
            {
               Unify.show(array);
            }
         }
      }
      
      public function hide(... arg) : void
      {
         var array:* = null;
         var i:int = 0;
         var item:* = null;
         if(mainPanel)
         {
            array = [];
            for(i = 0; i < arg.length; )
            {
               item = mainPanel[arg[i]];
               if(item)
               {
                  array.push(item);
               }
               i++;
            }
            if(array.length)
            {
               Unify.hide(array);
            }
         }
      }
      
      protected function updatePageShow() : void
      {
         if(mainPanel["txtPageShow"])
         {
            text("txtPageShow").text = pageCurr + "/" + pageTotal;
         }
      }
      
      protected function createTextField(x:int, y:int, w:int = 1, h:int = 1, auto:String = "center", size:int = 16, color:uint = 16777215, isGlowFilter:Boolean = false, glowColor:uint = 0, str:String = "") : TextField
      {
         var txt:TextField = TextManager.createTextField(x,y,w,h,auto,size,color,isGlowFilter,glowColor);
         txt.text = str;
         this.addChild(txt);
         return txt;
      }
      
      public function updateView() : void
      {
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         var item:* = null;
         this.removeBtnEvent();
         if(items)
         {
            for(i = 0; i < items.length; )
            {
               item = items[i];
               item.dispose();
               item = null;
               i++;
            }
            items = null;
         }
      }
   }
}
