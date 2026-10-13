package export.alliance
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import export.pack.PackThings;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.MyEquipObj;
   import user.User;
   
   public class AllianceShowThing extends Sprite
   {
       
      
      private var gc:Config;
      
      private var packThing:PackThings;
      
      private var thisEquipment:MyEquipObj;
      
      private var player:User;
      
      private var amoney:uint;
      
      private var _anti:Antiwear;
      
      public var btn_buy:SimpleButton;
      
      public var txt_name:TextField;
      
      public var txt_price:TextField;
      
      public var bgmc:Sprite;
      
      private var buyclick:Boolean = false;
      
      public function AllianceShowThing()
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         txt_name.selectable = false;
         txt_price.selectable = false;
         this._anti.thingnum = 0;
         this._anti.allmoney = 0;
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         this.removeEventListener("addedToStage",added);
         btn_buy.addEventListener("click",buyClick);
         gc.eventManger.addEventListener("AllianceChangePlayer",changePlayer);
         gc.eventManger.addEventListener("ALLIANCEBUYCHANGLE",buychange);
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         btn_buy.removeEventListener("click",buyClick);
         gc.eventManger.removeEventListener("AllianceChangePlayer",changePlayer);
         gc.eventManger.addEventListener("ALLIANCEBUYCHANGLE",buychange);
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
         this._anti.thingnum = this.thisEquipment.getENum();
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
      }
      
      private function visibleTrue() : void
      {
         this.txt_name.text = thisEquipment.ename;
         this.txt_price.text = gc.honorData.findPriceByFillName(thisEquipment.getFillName()) + "贡献";
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
         var si:* = null;
         if(this._anti.thingnum > 0)
         {
            buyclick = true;
            si = new AllianceSumInterface(this.amoney,gc.honorData.findPriceByFillName(thisEquipment.getFillName()),this._anti.thingnum,thisEquipment.ename,thisEquipment.color);
            this.parent.addChild(si);
         }
      }
      
      private function setPlayer() : void
      {
         if(this.parent)
         {
            this.player = AllianceShop(this.parent).getUser();
         }
      }
      
      private function setMoney() : void
      {
         if(this.parent)
         {
            this._anti.allmoney = AllianceShop(this.parent).getAllMoney();
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
         this._anti.thingnum = this.thisEquipment.getENum();
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
      }
   }
}
