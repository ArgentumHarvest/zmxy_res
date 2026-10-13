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
   
   public class DragonSingleShop extends Sprite
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
      
      public function DragonSingleShop()
      {
         super();
         gc = Config.getInstance();
         this.dataObject = new Antiwear(new binaryEncrypt());
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
         maskmc = AUtils.getNewObj("DragonSingleShopMask") as Sprite;
         maskmc.name = "Dragonmaskmc";
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
         var p2delnum:int = 0;
         var buyequip:* = null;
         if(gc.dataObject.mysteriousshoptimes > 0)
         {
            if(gc.player1.getSomeOneEquipNumberByName("wpzz") >= this.getPrice())
            {
               gc.player1.removeEquipFormBack("wpzz",2,this.getPrice());
            }
            else
            {
               if(gc.player2.roleid <= 0)
               {
                  gc.ts.setTxt("珍珠不够");
                  gc.stage.addChild(gc.ts);
                  return;
               }
               if(gc.player2.getSomeOneEquipNumberByName("wpzz") + gc.player1.getSomeOneEquipNumberByName("wpzz") < this.getPrice())
               {
                  gc.ts.setTxt("珍珠不够");
                  gc.stage.addChild(gc.ts);
                  return;
               }
               p2delnum = this.getPrice() - gc.player1.getSomeOneEquipNumberByName("wpzz");
               gc.player2.removeEquipFormBack("wpzz",2,p2delnum);
               gc.player1.removeEquipFormBack("wpzz",2,gc.player1.getSomeOneEquipNumberByName("wpzz"));
            }
            gc.dataObject.mysteriousshoptimes -= 1;
            if(this.packThings.getSobj().getMyEquipObj().type == "zbsz")
            {
               buyequip = this.packThings.getSobj().getMyEquipObj();
               buyequip.setFashionTime(gc.dataObjectInstance.curDate);
               gc.player1.szlist.push(buyequip);
            }
            else if(this.packThings.getSobj().getMyEquipObj().type == "zbfb" || this.packThings.getSobj().getMyEquipObj().type == "zbsp" || this.packThings.getSobj().getMyEquipObj().type == "zbfj" || this.packThings.getSobj().getMyEquipObj().type == "zbwq")
            {
               gc.player1.zblist.push(this.packThings.getSobj().getMyEquipObj());
            }
            else if(this.packThings.getSobj().getMyEquipObj().type == "zbjn")
            {
               gc.player1.plist.push(this.packThings.getSobj().getMyEquipObj());
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
      
      public function setTheShopNum(num:uint) : void
      {
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
         var equip:Object = this.findThingBySign(num);
         if(equip)
         {
            this.txt_name.text = equip.ename + "x" + this.getThingsNum();
            this.txt_price.text = this.getPrice() + "珍珠";
            if(packThings == null)
            {
               packThings = new PackThings();
               packThings.name = "packThings";
               packThings.x = 25;
               packThings.y = 20;
               this.addChild(packThings);
               if(this.getChildByName("Dragonmaskmc") != null)
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
      
      private function findThingBySign(num:uint) : Object
      {
         var mary:* = null;
         var rd:int = 0;
         rd = 0;
         rd = 0;
         var _anti:Antiwear = new Antiwear(new binaryEncrypt());
         _anti.wplwl = "wplwl";
         _anti.wpll = "wpll";
         _anti.wpqhs1 = "wpqhs1";
         _anti.slzsp = "slzsp";
         _anti.wplvdyl = "wplvdyl";
         _anti.wplh = "wplh";
         _anti.gcxdyy = "gcxdyy";
         _anti.p_cyzsjl = "p_cyzsjl";
         _anti.p_cycnjl = "p_cycnjl";
         if(num == 1)
         {
            mary = [_anti.wplwl,_anti.wpll];
            rd = Math.round(RandomControllor.getIns().getRandom());
            this.setPrice(1);
            this.setThingsNum(1);
            return gc.allEquip.findByName(mary[rd]);
         }
         if(num == 2)
         {
            mary = [_anti.wpqhs1];
            this.setPrice(2);
            this.setThingsNum(1);
            return gc.allEquip.findByName(mary[0]);
         }
         if(num == 3)
         {
            mary = [_anti.slzsp];
            this.setPrice(3);
            this.setThingsNum(1);
            return gc.allEquip.findByName(mary[0]);
         }
         if(num == 4)
         {
            mary = [_anti.wplvdyl,_anti.wplh];
            rd = Math.round(RandomControllor.getIns().getRandom());
            this.setPrice(5);
            this.setThingsNum(5);
            return gc.allEquip.findByName(mary[rd]);
         }
         if(num == 5)
         {
            mary = [_anti.gcxdyy];
            rd = Math.round(RandomControllor.getIns().getRandom());
            this.setPrice(10);
            this.setThingsNum(1);
            return gc.allEquip.findByName(mary[0]);
         }
         return null;
      }
      
      public function removedMask() : void
      {
         if(this.getChildByName("Dragonmaskmc") != null)
         {
            this.removeChild(maskmc);
         }
      }
      
      public function addMask() : void
      {
         if(this.getChildByName("Dragonmaskmc") == null)
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
