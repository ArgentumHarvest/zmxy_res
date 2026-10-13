package export.muti.MyComponent
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   
   public class MyComboBox extends Sprite
   {
      
      public static var MYCOMBOBOX_ALL:String = "MyComboBox_ALL";
      
      public static var MYCOMBOBOX_HUNZHAN:String = "MyComboBox_HUNZHAN";
      
      public static var MYCOMBOBOX_DANTIAO:String = "MyComboBox_DANTIAO";
      
      public static var MYCOMBOBOX_FUBEN1:String = "MYCOMBOBOX_FUBEN1";
      
      public static var MYCOMBOBOX_FUBEN2:String = "MYCOMBOBOX_FUBEN2";
       
      
      private const MYCOMBOBOX_CUR:String = "MYCOMBOBOX_CUR";
      
      private var dataArray:Array;
      
      private var curShowSprite:Sprite;
      
      private var curShowIndex:uint = 0;
      
      private var state:uint = 0;
      
      public function MyComboBox()
      {
         dataArray = [];
         super();
      }
      
      public function setData(data:Array) : void
      {
         var sprite:* = null;
         var type:* = null;
         for each(var dataObj in data)
         {
            type = dataObj.label;
            if(type == MYCOMBOBOX_ALL)
            {
               sprite = this.getNewObj("MyComboBox_ALL") as MyComboBoxSingleLine;
            }
            else if(type == MYCOMBOBOX_HUNZHAN)
            {
               sprite = this.getNewObj("MyComboBox_HUNZHAN") as MyComboBoxSingleLine;
            }
            else if(type == MYCOMBOBOX_DANTIAO)
            {
               sprite = this.getNewObj("MyComboBox_DANTIAO") as MyComboBoxSingleLine;
            }
            else if(type == MYCOMBOBOX_FUBEN1)
            {
               sprite = this.getNewObj("MYCOMBOBOX_FUBEN1") as MyComboBoxSingleLine;
            }
            else if(type == MYCOMBOBOX_FUBEN2)
            {
               sprite = this.getNewObj("MYCOMBOBOX_FUBEN2") as MyComboBoxSingleLine;
            }
            sprite.value = dataObj.value;
            sprite.name = type;
            sprite.scaleX = 0.9;
            sprite.scaleY = 0.9;
            this.dataArray.push(sprite);
            this.addChild(sprite);
         }
         this.curShowSprite = this.getNewObj((this.dataArray[0] as Sprite).name) as Sprite;
         this.curShowSprite.name = "MYCOMBOBOX_CUR";
         this.curShowIndex = 0;
         this.addChild(this.curShowSprite);
         this.buttonMode = true;
         this.addEventListener("click",__mouseClick);
         this.addEventListener("mouseOver",__mouseOver);
         this.addEventListener("mouseOut",__mouseOut);
      }
      
      private function __mouseClick(evt:MouseEvent) : void
      {
         var sp:* = null;
         var idx:int = 0;
         var glow:* = null;
         var clickIdx:int = this.dataArray.indexOf(evt.target);
         if(evt.target.name == "MYCOMBOBOX_CUR")
         {
            if(this.state == 0)
            {
               for each(sp in this.dataArray)
               {
                  idx = this.dataArray.indexOf(sp);
                  TweenMax.to(sp,0.5,{"y":28 + idx * 28});
                  if(this.curShowIndex == idx)
                  {
                     glow = new GlowFilter(16777215,1,5,5,1.5,3,false,false);
                     sp.filters = [glow];
                  }
                  else
                  {
                     sp.filters = [];
                  }
               }
               this.state = 1;
            }
            else
            {
               this.allHide();
            }
         }
         if(clickIdx != -1)
         {
            this.curShowIndex = clickIdx;
            this.removeChild(this.curShowSprite);
            this.curShowSprite = this.getNewObj(evt.target.name) as Sprite;
            this.curShowSprite.name = "MYCOMBOBOX_CUR";
            this.addChild(this.curShowSprite);
            this.allHide();
         }
      }
      
      private function allHide() : void
      {
         var idx:int = 0;
         for each(var sp in this.dataArray)
         {
            idx = this.dataArray.indexOf(sp);
            sp.filters = [];
            TweenMax.to(sp,0,{
               "x":0,
               "y":0
            });
         }
         this.state = 0;
      }
      
      private function __mouseOver(evt:MouseEvent) : void
      {
         var glow:* = null;
         var temp:* = null;
         var sp:Sprite = evt.target as Sprite;
         var clickIdx:int = this.dataArray.indexOf(evt.target);
         if(clickIdx != -1)
         {
            glow = new GlowFilter(16711680,1,5,5,1.5,3,false,false);
            temp = sp.filters;
            temp.push(glow);
            sp.filters = temp;
         }
      }
      
      private function __mouseOut(evt:MouseEvent) : void
      {
         var temp:* = null;
         var sp:Sprite = evt.target as Sprite;
         var clickIdx:int = this.dataArray.indexOf(evt.target);
         if(clickIdx != -1)
         {
            temp = sp.filters;
            temp.pop();
            sp.filters = temp;
         }
      }
      
      public function getCurValue() : uint
      {
         var sp:MyComboBoxSingleLine = this.dataArray[curShowIndex];
         return sp.value;
      }
      
      public function destroy() : void
      {
         this.removeEventListener("click",__mouseClick);
      }
      
      public function getNewObj(name:*) : *
      {
         var cls:Class = getDefinitionByName(name) as Class;
         return new cls();
      }
      
      public function clone(source:Object) : Object
      {
         var r:ByteArray = new ByteArray();
         r.writeObject(source);
         r.position = 0;
         return r.readObject();
      }
   }
}
