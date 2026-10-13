package export.muti.MyComponent
{
   import fl.controls.Button;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MapChoose extends Sprite
   {
       
      
      private var _leftBtn:Button;
      
      private var _rightBtn:Button;
      
      private var _curMap:Sprite;
      
      private var _data:Array;
      
      private var _curIdx:uint = 0;
      
      private var _maxIdx:uint = 0;
      
      public function MapChoose()
      {
         super();
         this._leftBtn = new Button();
         this._leftBtn.setSize(30,25);
         this._leftBtn.label = "left";
         this._leftBtn.addEventListener("click",__leftClick);
         this.addChild(this._leftBtn);
         _leftBtn.visible = false;
         this._rightBtn = new Button();
         this._rightBtn.setSize(30,25);
         this._rightBtn.x = 150;
         this._rightBtn.label = "right";
         this._rightBtn.addEventListener("click",__rightClick);
         this.addChild(this._rightBtn);
         _rightBtn.visible = false;
         this._curMap = new Sprite();
         this._curMap.x = 50;
         this.addChild(this._curMap);
         this._curMap.addEventListener("click",__chooseMap);
         this._curMap.useHandCursor = true;
         this._curMap.buttonMode = true;
      }
      
      protected function __chooseMap(evt:MouseEvent) : void
      {
         this._curIdx++;
         if(this._curIdx >= _maxIdx)
         {
            this._curIdx = 0;
         }
         this.refreshShow();
      }
      
      protected function __rightClick(event:MouseEvent) : void
      {
         if(this._curIdx < this._data.length - 1)
         {
            this._curIdx++;
            this.refreshShow();
         }
      }
      
      protected function __leftClick(event:MouseEvent) : void
      {
         if(this._curIdx > 0)
         {
            this._curIdx--;
            this.refreshShow();
         }
      }
      
      public function setData(data:Array) : void
      {
         this._data = data;
         this._curIdx = 0;
         this._maxIdx = this._data.length;
         this.refreshShow();
      }
      
      private function refreshShow() : void
      {
         if(this._curIdx >= this._maxIdx)
         {
            throw new Error("--MapChoose--refreshShow error!");
         }
         var curChoose:Bitmap = this._data[this._curIdx].resource;
         while(_curMap.numChildren > 0)
         {
            _curMap.removeChildAt(0);
         }
         this._curMap.addChild(curChoose);
      }
      
      public function getChooseValue() : int
      {
         if(this._curIdx >= this._maxIdx)
         {
            throw new Error("--MapChoose--getChooseValue error!");
         }
         return this._data[this._curIdx].value;
      }
      
      public function destroy() : void
      {
         if(this._leftBtn.parent)
         {
            this._leftBtn.parent.removeChild(this._leftBtn);
            this._leftBtn = null;
         }
         if(this._rightBtn.parent)
         {
            this._rightBtn.parent.removeChild(this._rightBtn);
            this._rightBtn = null;
         }
         if(this._curMap.parent)
         {
            this._curMap.removeEventListener("click",__chooseMap);
            this._curMap.parent.removeChild(this._curMap);
            this._curMap = null;
         }
         this._data = null;
      }
   }
}
