package export.warehouse
{
   import config.Config;
   import event.CommonEvent;
   import export.pack.PackThings;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import my.MyEquipObj;
   
   public class WareHouseElement extends Sprite
   {
       
      
      private var curPage:uint = 1;
      
      private var allPage:uint = 2;
      
      private var pageNum:uint = 25;
      
      private var which:uint = 1;
      
      private var gzSprite:Sprite;
      
      private var gc:Config;
      
      private var tag:Boolean = true;
      
      public var btn_rw:SimpleButton;
      
      public var btn_dj:SimpleButton;
      
      public var btn_zb:SimpleButton;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      private var saveObj:Object;
      
      public function WareHouseElement()
      {
         saveObj = {};
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         if(tag)
         {
            tag = false;
            btn_rw.addEventListener("click",selectType);
            btn_dj.addEventListener("click",selectType);
            btn_zb.addEventListener("click",selectType);
            btn_zb.dispatchEvent(new MouseEvent("click"));
            gc.eventManger.addEventListener("REFRESHWAREHOUSE",rebackpackage);
         }
      }
      
      private function removed(e:Event) : void
      {
         btn_rw.removeEventListener("click",selectType);
         btn_dj.removeEventListener("click",selectType);
         btn_zb.removeEventListener("click",selectType);
         gc.eventManger.removeEventListener("REFRESHWAREHOUSE",rebackpackage);
         btnState = null;
      }
      
      private function selectType(e:MouseEvent) : void
      {
         this.reSetBackPackageTile();
         switch(e.currentTarget.name)
         {
            case "btn_rw":
               this.which = 3;
               this.drawgz(gc.szlist);
               break;
            case "btn_dj":
               this.which = 2;
               this.drawgz(gc.djlist);
               break;
            case "btn_zb":
               this.which = 1;
               this.drawgz(gc.zblist);
         }
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = e.currentTarget.name;
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function rebackpackage(e:CommonEvent) : void
      {
         if(this.which == 1)
         {
            btn_zb.dispatchEvent(new MouseEvent("click"));
         }
         else if(this.which == 2)
         {
            btn_dj.dispatchEvent(new MouseEvent("click"));
         }
         else if(this.which == 3)
         {
            btn_rw.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      public function setCurPage(cp:int) : void
      {
         var lastPage:uint = this.curPage;
         this.curPage += cp;
         if(this.curPage > this.allPage)
         {
            this.curPage = this.allPage;
         }
         if(this.curPage < 1)
         {
            this.curPage = 1;
         }
         if(this.curPage != lastPage)
         {
            this.rebackpackage(null);
         }
      }
      
      private function reSetBackPackageTile() : void
      {
         if(gzSprite && contains(gzSprite))
         {
            this.removeChild(gzSprite);
            gzSprite = null;
         }
         gzSprite = new Sprite();
         gzSprite.x = 0;
         gzSprite.y = 38;
         this.addChild(gzSprite);
      }
      
      private function drawgz(list:Array) : void
      {
         var temp:* = null;
         var i:* = 0;
         var j:* = 0;
         var t:uint = 0;
         for(i = uint(0); i < 5; )
         {
            for(j = uint(0); j < 5; )
            {
               temp = AUtils.getNewObj("export.pack.PackThings") as PackThings;
               temp.x = j * (temp.width + 7);
               temp.y = i * (temp.height + 9);
               gzSprite.addChildAt(temp,0);
               if(list[t + (curPage - 1) * 25])
               {
                  temp.setObj(list[t + (curPage - 1) * 25],WareHouse(this.parent).getUser().getControlPlayer() + 1,this.which);
                  t++;
               }
               j++;
            }
            i++;
         }
      }
      
      public function addMyEquipmentToList(equip:MyEquipObj) : void
      {
         if(equip.type == "zbwq" || equip.type == "zbfj" || equip.type == "zbfb" || equip.type == "zbsp")
         {
            gc.zblist.push(equip);
         }
         else if(equip.type == "zbsz")
         {
            gc.szlist.push(equip);
         }
         else
         {
            gc.djlist = gc.putQHsInArray(equip.getFillName(),gc.djlist,equip.getENum());
         }
         this.rebackpackage(null);
      }
      
      public function getSaveObj() : Object
      {
         saveObj.bagSaveString = this.getBagEquipSaveString();
         saveObj.bagdjSaveString = this.getBagDaoJuEquipSaveString();
         saveObj.bagszSaveString = this.getBagSZEquipSaveString();
         return saveObj;
      }
      
      public function setSaveObj(readObj:Object) : void
      {
         var zlen:* = 0;
         var myEquipObj1:* = null;
         var dataArray:* = null;
         var bagSaveString:* = null;
         var dlen:* = 0;
         var myEquipObj3:* = null;
         var bagdjSaveString:* = null;
         var slen:* = 0;
         var myEquipObj4:* = null;
         var bagszSaveString:* = null;
         gc.zblist.length = 0;
         gc.djlist.length = 0;
         gc.szlist.length = 0;
         if(readObj.bagSaveString != undefined)
         {
            bagSaveString = readObj.bagSaveString;
            dataArray = bagSaveString.split("}");
            for(zlen = uint(dataArray.length); zlen-- > 0; )
            {
               if(dataArray[zlen] != "")
               {
                  myEquipObj1 = new MyEquipObj();
                  myEquipObj1.setEquipSaveObj(dataArray[zlen]);
                  gc.zblist.push(myEquipObj1);
               }
            }
         }
         trace("-------33333333-------");
         if(readObj.bagdjSaveString != undefined)
         {
            bagdjSaveString = readObj.bagdjSaveString;
            if(bagdjSaveString.charAt(bagdjSaveString.length - 1) == "}")
            {
               bagdjSaveString = bagdjSaveString.substr(0,bagdjSaveString.length - 2);
            }
            dataArray = bagdjSaveString.split("}");
            for(dlen = uint(dataArray.length); dlen-- > 0; )
            {
               if(dataArray[dlen] != "")
               {
                  myEquipObj3 = new MyEquipObj();
                  myEquipObj3.setEquipSaveObj(bagdjSaveString.split("}")[dlen]);
                  if(myEquipObj3.type == "zbtx")
                  {
                     gc.player1.zblist.push(myEquipObj3);
                  }
                  else
                  {
                     gc.djlist.push(myEquipObj3);
                  }
               }
            }
         }
         trace("-------44444444444-------");
         if(readObj.bagszSaveString != undefined)
         {
            bagszSaveString = readObj.bagszSaveString;
            if(bagszSaveString.charAt(bagszSaveString.length - 1) == "}")
            {
               bagszSaveString = bagszSaveString.substr(0,bagszSaveString.length - 2);
            }
            dataArray = bagszSaveString.split("}");
            for(slen = uint(dataArray.length); slen-- > 0; )
            {
               if(dataArray[slen] != "")
               {
                  myEquipObj4 = new MyEquipObj();
                  myEquipObj4.setEquipSaveObj(bagszSaveString.split("}")[slen]);
                  gc.szlist.push(myEquipObj4);
               }
            }
         }
         this.rebackpackage(null);
      }
      
      public function clearSaveObj() : void
      {
         gc.zblist.length = 0;
         gc.djlist.length = 0;
         gc.szlist.length = 0;
      }
      
      public function getBagEquipSaveString() : String
      {
         var str:String = "";
         for(var zlen:uint = gc.zblist.length; zlen-- > 0; )
         {
            if(gc.zblist[zlen])
            {
               str += MyEquipObj(gc.zblist[zlen]).getEquipSaveObj();
               if(zlen != 0)
               {
                  str += "}";
               }
            }
         }
         return str;
      }
      
      public function getBagDaoJuEquipSaveString() : String
      {
         var str:String = "";
         for(var zlen:uint = gc.djlist.length; zlen-- > 0; )
         {
            if(gc.djlist[zlen])
            {
               str += MyEquipObj(gc.djlist[zlen]).getEquipSaveObj();
               if(zlen != 0)
               {
                  str += "}";
               }
            }
         }
         return str;
      }
      
      public function getBagSZEquipSaveString() : String
      {
         var str:String = "";
         for(var slen:uint = gc.szlist.length; slen-- > 0; )
         {
            if(gc.szlist[slen])
            {
               str += MyEquipObj(gc.szlist[slen]).getEquipSaveObj();
               if(slen != 0)
               {
                  str += "}";
               }
            }
         }
         return str;
      }
   }
}
