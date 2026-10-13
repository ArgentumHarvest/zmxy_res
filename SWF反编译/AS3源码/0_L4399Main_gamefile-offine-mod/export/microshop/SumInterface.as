package export.microshop
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class SumInterface extends Sprite
   {
       
      
      protected var gc:Config;
      
      private var pay:PayMoneyVar;
      
      protected var tname:String;
      
      protected var color:String;
      
      protected var allmoney:int;
      
      public var btn_change:SimpleButton;
      
      public var btn_ok:SimpleButton;
      
      public var txtfield:TextField;
      
      protected var newTextField:TextField;
      
      private var _anti:Antiwear;
      
      public function SumInterface(mtotal:int, _price:int, _num:int, _name:String, _color:String)
      {
         this._anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         pay = PayMoneyVar.getInstance();
         allmoney = mtotal;
         this.setTnum(_num);
         this.tname = _name;
         this.setPrice(_price);
         this.color = _color;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      protected function added(e:Event) : void
      {
         btn_change.addEventListener("click",changeClick);
         btn_ok.addEventListener("click",okClick);
         if(this.txtfield && this.contains(this.txtfield))
         {
            this.removeChild(this.txtfield);
         }
         var txtformat:TextFormat = new TextFormat();
         txtformat.font = "FZCuYuan-M03S";
         txtformat.color = 16777215;
         txtformat.size = 14;
         this.newTextField = new TextField();
         this.newTextField.embedFonts = true;
         this.newTextField.wordWrap = true;
         this.newTextField.defaultTextFormat = txtformat;
         this.newTextField.x = 392;
         this.newTextField.y = 253;
         this.newTextField.width = 181;
         this.newTextField.height = 52;
         this.addChild(this.newTextField);
         this.setText();
      }
      
      protected function removed(e:Event) : void
      {
         btn_change.removeEventListener("click",changeClick);
         btn_ok.removeEventListener("click",okClick);
      }
      
      protected function setText() : void
      {
         this.newTextField.text = "你确定要购买" + this.getTnum() + "个" + this.tname + "总共花费" + this.getPrice() * this.getTnum() + "造梦点券";
      }
      
      protected function changeClick(e:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new Event("BUYCHANGLE"));
         this.destory();
      }
      
      protected function okClick(e:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[100000]));
         this.destory();
      }
      
      protected function destory() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      protected function setPrice(v:int) : void
      {
         this._anti.price = v;
      }
      
      protected function getPrice() : int
      {
         return this._anti.price;
      }
      
      protected function setTnum(v:int) : void
      {
         this._anti.tnum = v;
      }
      
      protected function getTnum() : int
      {
         return this._anti.tnum;
      }
      
      protected function getDeCodeValue(v:Number) : int
      {
         return Math.round(v * 100 + 1302);
      }
      
      protected function enCodeValue(v:int) : Number
      {
         return (v - 1302) / 100;
      }
   }
}
