package export.microshop
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.pack.PackThings;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.MyEquipObj;
   import user.User;
   
   public class ShopThing extends Sprite
   {
       
      
      private var gc:Config;
      
      private var pay:PayMoneyVar;
      
      private var packThing:PackThings;
      
      private var thisEquipment:MyEquipObj;
      
      private var player:User;
      
      private var amoney:uint;
      
      private var _anti:Antiwear;
      
      public var btn_buy:SimpleButton;
      
      public var txt_name:TextField;
      
      public var txt_price:TextField;
      
      public var txt_num:TextField;
      
      public var btn_up:SimpleButton;
      
      public var btn_down:SimpleButton;
      
      public var bgmc:Sprite;
      
      private var buyclick:Boolean = false;
      
      public function ShopThing()
      {
         this._anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         pay = PayMoneyVar.getInstance();
         txt_name.selectable = false;
         txt_price.selectable = false;
         this.txt_price.multiline = false;
         this.txt_price.wordWrap = false;
         this._anti.thingnum = 0;
         this._anti.allmoney = 0;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         trace("shopthing--added");
         btn_buy.addEventListener("click",buyClick);
         btn_up.addEventListener("click",upClick);
         btn_down.addEventListener("click",downClick);
         gc.eventManger.addEventListener("ChangePlayer",changePlayer);
         gc.eventManger.addEventListener("BUYCHANGLE",buychange);
      }
      
      private function removed(e:Event) : void
      {
         btn_buy.removeEventListener("click",buyClick);
         btn_up.removeEventListener("click",upClick);
         btn_down.removeEventListener("click",downClick);
         gc.eventManger.removeEventListener("ChangePlayer",changePlayer);
         gc.eventManger.addEventListener("BUYCHANGLE",buychange);
      }
      
      public function setEquipment(equip:MyEquipObj) : void
      {
         var pic:* = undefined;
         this.setPlayer();
         this.setMoney();
         if(packThing == null)
         {
            packThing = new PackThings();
            packThing.x = 15;
            packThing.y = 20;
            this.addChild(packThing);
         }
         this.thisEquipment = equip;
         this._anti.thingnum = 1;
         this._anti.allmoney -= int(gc.allEquip.findSellPrice(thisEquipment.getFillName()));
         this.visibleTrue();
         packThing.setObj(this.thisEquipment,this.getPlayerId());
         if(packThing.getMyEquipType() == "zbsz")
         {
            pic = AUtils.getImageObj("thirthday");
            pic.name = "thirthdaypic";
            pic.x = 62;
            pic.y = 2;
            this.addChild(pic);
         }
      }
      
      private function visibleFalse() : void
      {
         this.txt_name.text = "";
         this.txt_price.text = "";
         this.btn_buy.visible = false;
         this.bgmc.visible = false;
         this.btn_up.visible = false;
         this.btn_down.visible = false;
         this.txt_num.text = "0";
         this.txt_num.visible = false;
      }
      
      private function visibleTrue() : void
      {
         this.txt_name.text = thisEquipment.ename;
         this.txt_num.text = this._anti.thingnum + "";
         this.txt_price.text = int(gc.allEquip.findSellPrice(thisEquipment.getFillName())) + "点券";
         this.txt_price.width = this.txt_price.textWidth + 5;
         this.txt_price.height = this.txt_price.textHeight + 5;
      }
      
      public function clearEquipment() : void
      {
         if(packThing && contains(packThing))
         {
            if(this.getChildByName("thirthdaypic"))
            {
               this.removeChild(this.getChildByName("thirthdaypic"));
            }
            buyclick = false;
            packThing.removeSobjAndNotPutInBack();
            this.thisEquipment = null;
            this.removeChild(packThing);
            packThing = null;
            if(this._anti.thingnum != 1)
            {
               this._anti.thingnum = 1;
            }
         }
      }
      
      private function buyClick(e:MouseEvent) : void
      {
         var si:SumInterface = null;
         if(this._anti.thingnum > 0)
         {
            if(thisEquipment.type == "zbsz")
            {
               if(this.judgeSZBackPack())
               {
                  return;
               }
            }
            else if(thisEquipment.type == "zbwp" || thisEquipment.type == "wpqhs")
            {
               if(thisEquipment.getFillName().indexOf("jns") != -1)
               {
                  if(this.judgeJNSBackPack())
                  {
                     return;
                  }
               }
               else if(this.judgeDJBackPack(thisEquipment.getFillName()))
               {
                  return;
               }
            }
            buyclick = true;
            gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[100000]));
            this.buySuccess();
         }
      }
      
      private function judgeZBBackPack() : Boolean
      {
         var bool:Boolean = false;
         if(this.player)
         {
            if(this.player.zblist.length >= this.player.getMax())
            {
               bool = true;
               gc.ts.setTxt(this.player.controlPlayer + 1 + "P装备栏已满");
               gc.stage.addChild(gc.ts);
            }
         }
         return bool;
      }
      
      private function judgeJNSBackPack() : Boolean
      {
         var bool:Boolean = false;
         if(this.player)
         {
            if(this.player.jnslist.length >= this.player.getMax())
            {
               bool = true;
               gc.ts.setTxt(this.player.controlPlayer + 1 + "P经书栏已满");
               gc.stage.addChild(gc.ts);
            }
         }
         return bool;
      }
      
      private function judgeSZBackPack() : Boolean
      {
         var bool:Boolean = false;
         if(this.player)
         {
            if(this.player.szlist.length >= this.player.getMax())
            {
               bool = true;
               gc.ts.setTxt(this.player.controlPlayer + 1 + "P时装栏已满");
               gc.stage.addChild(gc.ts);
            }
         }
         return bool;
      }
      
      private function judgeDJBackPack(fillname:String) : Boolean
      {
         var bool:Boolean = false;
         if(this.player.getSomeOneEquipNumberByName(fillname) <= 0 && this.player.djlist.length >= this.player.getMax())
         {
            bool = true;
            gc.ts.setTxt(this.player.controlPlayer + 1 + "P道具栏已满");
            gc.stage.addChild(gc.ts);
         }
         return bool;
      }
      
      private function upClick(e:MouseEvent) : void
      {
         if(this._anti.allmoney >= int(gc.allEquip.findSellPrice(thisEquipment.getFillName())))
         {
            this._anti.allmoney -= int(gc.allEquip.findSellPrice(thisEquipment.getFillName()));
            var _loc2_:* = this._anti;
            var _loc3_:* = Number(_loc2_.thingnum) + 1;
            _loc2_.thingnum = _loc3_;
            this.txt_num.text = this._anti.thingnum + "";
         }
      }
      
      private function downClick(e:MouseEvent) : void
      {
         if(this._anti.thingnum > 1)
         {
            this._anti.allmoney += int(gc.allEquip.findSellPrice(thisEquipment.getFillName()));
            var _loc2_:* = this._anti;
            var _loc3_:* = Number(_loc2_.thingnum) - 1;
            _loc2_.thingnum = _loc3_;
         }
         this.txt_num.text = this._anti.thingnum + "";
      }
      
      private function setPlayer() : void
      {
         if(this.parent)
         {
            this.player = Micropayment(this.parent).getUser();
         }
      }
      
      private function setMoney() : void
      {
         if(this.parent)
         {
            this._anti.allmoney = Micropayment(this.parent).getAllMoney();
            this.amoney = this._anti.allmoney;
         }
      }
      
      private function changePlayer(e:*) : void
      {
         this.setPlayer();
      }
      
      private function buychange(e:*) : void
      {
         this.buyclick = false;
      }
      
      private function getPlayerId() : uint
      {
         return this.player.getControlPlayer();
      }
      
      public function buySuccess() : void
      {
         this.buyclick = false;
         this._anti.thingnum = 1;
         this.txt_num.text = this._anti.thingnum + "";
         this.setMoney();
      }
      
      public function getNumAndEquip() : Object
      {
         var obj:Object = {
            "thingnum":0,
            "equip":null
         };
         if(buyclick)
         {
            obj.thingnum = this._anti.thingnum;
            obj.equip = thisEquipment;
         }
         return obj;
      }
      
      public function getMoneySuccess() : void
      {
         this.setMoney();
         this.txt_num.text = this._anti.thingnum + "";
      }
   }
}
