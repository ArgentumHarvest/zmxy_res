package export.huodong.mysterious
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
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   
   public class SingleShop extends Sprite
   {
       
      
      public var buy_btn:SimpleButton;
      
      public var txt_price:TextField;
      
      public var txt_name:TextField;
      
      private var packThings:PackThings;
      
      private var thingsnum1:int;
      
      private var thingsnum2:int;
      
      private var thingsnum3:Number;
      
      private var price1:int;
      
      private var price2:int;
      
      private var price3:Number;
      
      private var gc:Config;
      
      private var mynum1:int;
      
      private var mynum2:int;
      
      private var mynum3:Number;
      
      private var maskmc:Sprite;
      
      private var dataObject:Antiwear;
      
      public function SingleShop()
      {
         super();
         gc = Config.getInstance();
         this.dataObject = new Antiwear(new binaryEncrypt());
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
         maskmc = AUtils.getNewObj("singleShopMask") as Sprite;
         maskmc.name = "maskmc";
         this.addChild(maskmc);
      }
      
      private function added(e:Event) : void
      {
         this.buy_btn.addEventListener("click",buyClick);
      }
      
      private function removed(e:Event) : void
      {
         this.buy_btn.removeEventListener("click",buyClick);
      }
      
      private function buyClick(e:MouseEvent) : void
      {
         var buyequip:* = null;
         buyequip = null;
         if(this.packThings.getSobj().getMyEquipObj().type == "zbsz")
         {
            if(this.judgeSZBackPack())
            {
               return;
            }
         }
         else if(this.packThings.getSobj().getMyEquipObj().type == "zbwp" || this.packThings.getSobj().getMyEquipObj().type == "wpqhs")
         {
            if(this.judgeDJBackPack(this.packThings.getSobj().getMyEquipObj().getFillName()))
            {
               return;
            }
         }
         if(gc.dataObject.mysteriousshoptimes > 0)
         {
            if(gc.player1.getLhValue() >= this.getPrice())
            {
               gc.player1.setLhValue(gc.player1.getLhValue() - this.getPrice());
            }
            else
            {
               if(gc.player2.roleid <= 0)
               {
                  gc.ts.setTxt("灵魂不够");
                  gc.stage.addChild(gc.ts);
                  return;
               }
               if(gc.player2.getLhValue() + gc.player1.getLhValue() < this.getPrice())
               {
                  gc.ts.setTxt("灵魂不够");
                  gc.stage.addChild(gc.ts);
                  return;
               }
               gc.player2.setLhValue(gc.player2.getLhValue() - (this.getPrice() - gc.player1.getLhValue()));
               gc.player1.setLhValue(0);
            }
            gc.dataObject.mysteriousshoptimes -= 1;
            if(this.packThings.getSobj().getMyEquipObj().type == "zbsz")
            {
               buyequip = this.packThings.getSobj().getMyEquipObj();
               buyequip.setFashionTime(gc.dataObjectInstance.curDate);
               gc.player1.szlist.push(buyequip);
            }
            else if(this.packThings.getSobj().getMyEquipObj().type == "zbtx")
            {
               buyequip = this.packThings.getSobj().getMyEquipObj();
               gc.player1.zblist.push(buyequip);
            }
            else
            {
               gc.putQhsInBackPack(gc.player1,this.packThings.getSobj().getMyEquipObj().getFillName(),this.getThingsNum());
            }
            gc.eventManger.dispatchEvent(new CommonEvent("MysteriousShopBuySuccess",[this.getMynum()]));
            gc.ts.setTxt("购买成功");
            gc.stage.addChild(gc.ts);
         }
         else
         {
            gc.ts.setTxt("次数不够");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function judgeSZBackPack() : Boolean
      {
         var bool:Boolean = false;
         if(gc.player1)
         {
            if(gc.player1.szlist.length >= gc.player1.getMax())
            {
               bool = true;
               gc.ts.setTxt(gc.player1.controlPlayer + 1 + "P时装栏已满");
               gc.stage.addChild(gc.ts);
            }
         }
         return bool;
      }
      
      private function judgeDJBackPack(fillname:String) : Boolean
      {
         var bool:Boolean = false;
         if(gc.player1.getSomeOneEquipNumberByName(fillname) <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
         {
            bool = true;
            gc.ts.setTxt(gc.player1.controlPlayer + 1 + "P道具栏已满");
            gc.stage.addChild(gc.ts);
         }
         return bool;
      }
      
      public function setTheShopNum(num:uint) : void
      {
         var _name:* = null;
         if(this.getChildByName("packThings"))
         {
            this.removeChild(this.getChildByName("packThings"));
            this.packThings = null;
         }
         if(num == 1)
         {
            this.removedMask();
         }
         this.setMynum(num);
         var equip:MyEquipObj = this.findThingBySign(num);
         if(equip)
         {
            if(equip.getFillName() == "lyfbjns2" || equip.getFillName() == "tjgljns2" || equip.getFillName() == "xgqjns2" || equip.getFillName() == "tkjjns2")
            {
               _name = equip.ename.substr(0,equip.ename.length - 5);
               this.txt_name.text = "2级" + _name;
            }
            else
            {
               this.txt_name.text = equip.ename + "x" + this.getThingsNum();
            }
            this.txt_price.text = this.getPrice() + "灵魂";
            if(packThings == null)
            {
               packThings = new PackThings();
               packThings.name = "packThings";
               packThings.x = 23;
               packThings.y = 18;
               this.addChild(packThings);
               if(this.getChildByName("maskmc") != null)
               {
                  if(this.getChildIndex(packThings) > this.getChildIndex(this.maskmc))
                  {
                     this.swapChildren(this.packThings,this.maskmc);
                  }
               }
            }
            this.packThings.setObj(equip,gc.player1.getControlPlayer(),2);
         }
      }
      
      private function findThingBySign(num:uint) : MyEquipObj
      {
         var mary:* = null;
         var rd:int = 0;
         rd = 0;
         rd = 0;
         rd = 0;
         rd = 0;
         var _anti:Antiwear = new Antiwear(new binaryEncrypt());
         _anti.wpsc = "wpsc";
         _anti.wpxt = "wpxt";
         _anti.wptm = "wptm";
         _anti.sms1 = "sms1";
         _anti.mfs1 = "mfs1";
         _anti.gjs1 = "gjs1";
         _anti.fys1 = "fys1";
         _anti.tlzsp = "tlzsp";
         _anti.llzsp = "llzsp";
         _anti.hlzsp = "hlzsp";
         _anti.flzsp = "flzsp";
         _anti.slzsp = "slzsp";
         _anti.wpbsz = "wpbsz";
         _anti.mpyj = "mpyj";
         _anti.css6 = "css6";
         _anti.wpqhs1 = "wpqhs1";
         _anti.ptsmsrsz = "ptsmsrsz";
         _anti.lyfbjns2 = "lyfbjns2";
         _anti.tjgljns2 = "tjgljns2";
         _anti.xgqjns2 = "xgqjns2";
         _anti.tkjjns2 = "tkjjns2";
         _anti.wpygs = "wpygs";
         _anti._ssggjtg2015 = "_ssggjtg2015";
         if(num == 1)
         {
            mary = [_anti.wpsc,_anti.wpxt,_anti.wptm];
            rd = Math.round(RandomControllor.getIns().getRandom() * 2);
            this.setPrice(500);
            this.setThingsNum(5);
            return gc.allEquip.findByName(mary[rd]);
         }
         if(num == 2)
         {
            mary = [_anti.wpsc,_anti.wpxt,_anti.wptm];
            rd = Math.round(RandomControllor.getIns().getRandom() * 2);
            this.setPrice(1000);
            this.setThingsNum(10);
            return gc.allEquip.findByName(mary[rd]);
         }
         if(num == 3)
         {
            mary = [_anti.wpsc,_anti.wpxt,_anti.wptm];
            rd = Math.round(RandomControllor.getIns().getRandom() * 2);
            this.setPrice(2000);
            this.setThingsNum(20);
            return gc.allEquip.findByName(mary[rd]);
         }
         if(num == 4)
         {
            mary = [_anti.sms1,_anti.mfs1,_anti.gjs1,_anti.fys1,_anti.wpqhs1,_anti.mpyj,_anti.css6];
            rd = Math.round(RandomControllor.getIns().getRandom() * 6);
            this.setPrice(4000);
            this.setThingsNum(1);
            return gc.allEquip.findByName(mary[rd]);
         }
         if(num == 5)
         {
            mary = [_anti.tlzsp,_anti.llzsp,_anti.hlzsp,_anti.flzsp,_anti.slzsp,_anti.lyfbjns2,_anti.tjgljns2,_anti.xgqjns2,_anti.tkjjns2,_anti.ptsmsrsz,_anti.wpygs,_anti._ssggjtg2015];
            if(RandomControllor.getIns().getRandom() <= 0.05)
            {
               rd = mary.length - 1;
            }
            else
            {
               rd = Math.round(RandomControllor.getIns().getRandom() * (mary.length - 2));
            }
            this.setPrice(8000);
            this.setThingsNum(1);
            return gc.allEquip.findByName(mary[rd]);
         }
         return null;
      }
      
      public function removedMask() : void
      {
         if(this.getChildByName("maskmc") != null)
         {
            this.removeChild(maskmc);
         }
      }
      
      public function addMask() : void
      {
         if(this.getChildByName("maskmc") == null)
         {
            this.addChild(maskmc);
         }
      }
      
      public function setThingsNum(v:int) : void
      {
         this.dataObject.thingsnum = v;
      }
      
      public function getThingsNum() : int
      {
         return this.dataObject.thingsnum;
      }
      
      public function setPrice(v:int) : void
      {
         this.dataObject.price = v;
      }
      
      public function getPrice() : int
      {
         return this.dataObject.price;
      }
      
      public function setMynum(v:int) : void
      {
         this.dataObject.mynum = v;
      }
      
      public function getMynum() : int
      {
         return this.dataObject.mynum;
      }
   }
}
