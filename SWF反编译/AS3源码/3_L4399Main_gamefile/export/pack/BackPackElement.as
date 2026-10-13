package export.pack
{
   import config.Config;
   import event.CommonEvent;
   import export.strength.StrengthEquipment;
   import export.warehouse.WareHouse;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import my.MyEquipObj;
   import user.User;
   
   public class BackPackElement extends Sprite
   {
       
      
      private var curPage:uint = 1;
      
      private var allPage:uint = 3;
      
      private var pageNum:uint = 25;
      
      private var which:uint = 1;
      
      private var gzSprite:Sprite;
      
      private var gc:Config;
      
      private var player:User;
      
      private var tag:Boolean = true;
      
      public var btn_rw:SimpleButton;
      
      public var btn_dj:SimpleButton;
      
      public var btn_zb:SimpleButton;
      
      public var btn_jns:SimpleButton;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      public function BackPackElement()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:*) : void
      {
         if(tag)
         {
            tag = false;
            this.selfSetPlayer();
            btn_rw.addEventListener("click",selectType);
            btn_dj.addEventListener("click",selectType);
            btn_zb.addEventListener("click",selectType);
            btn_jns.addEventListener("click",selectType);
            btn_zb.dispatchEvent(new MouseEvent("click"));
            gc.eventManger.addEventListener("REFRESHBACKPACK",refreshBackPack);
            gc.eventManger.addEventListener("GETPACKAGEINFO",refreshBackPack);
            gc.eventManger.addEventListener("GETANDREFRESHBACKPACKAGE",rebackpackage);
         }
      }
      
      private function removed(e:*) : void
      {
         btn_rw.removeEventListener("click",selectType);
         btn_dj.removeEventListener("click",selectType);
         btn_zb.removeEventListener("click",selectType);
         btn_jns.removeEventListener("click",selectType);
         gc.eventManger.removeEventListener("REFRESHBACKPACK",refreshBackPack);
         gc.eventManger.removeEventListener("GETPACKAGEINFO",refreshBackPack);
         gc.eventManger.removeEventListener("GETANDREFRESHBACKPACKAGE",rebackpackage);
         btnState = null;
      }
      
      public function setCurPage(cp:int) : void
      {
         var lastPage:uint = this.curPage;
         this.curPage = cp;
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
      
      public function getCurPage() : int
      {
         return this.curPage;
      }
      
      public function getAllPage() : int
      {
         return this.allPage;
      }
      
      private function refreshBackPack(e:CommonEvent) : void
      {
         this.reSetBackPackageTile();
         if(this.which == 3)
         {
            this.drawgz(this.player.szlist);
         }
         else if(this.which == 2)
         {
            this.drawgz(this.player.djlist);
         }
         else if(this.which == 1)
         {
            this.drawgz(this.player.zblist);
         }
         else if(this.which == 4)
         {
            this.drawgz(this.player.jnslist);
         }
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
         else if(this.which == 4)
         {
            btn_jns.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function selectType(e:MouseEvent) : void
      {
         if(this.player == null)
         {
            return;
         }
         this.reSetBackPackageTile();
         switch(e.currentTarget.name)
         {
            case "btn_rw":
               this.which = 3;
               this.drawgz(this.player.szlist);
               break;
            case "btn_dj":
               this.which = 2;
               this.drawgz(this.player.djlist);
               break;
            case "btn_zb":
               this.which = 1;
               this.drawgz(this.player.zblist);
               break;
            case "btn_jns":
               this.which = 4;
               this.drawgz(this.player.jnslist);
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
      
      private function drawgz(list:Array) : void
      {
         var temp:* = null;
         var i:* = 0;
         var j:* = 0;
         var whoPlay:int = 0;
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
                  whoPlay = this.player.getControlPlayer();
                  if(whoPlay == 1)
                  {
                     if(gc.player2.roleid <= 0)
                     {
                        if(gc.player3.roleid > 0)
                        {
                           whoPlay = 2;
                        }
                        else
                        {
                           trace("背包找不到主人.");
                        }
                     }
                  }
                  temp.setObj(list[t + (curPage - 1) * 25],whoPlay + 1,this.which);
                  t++;
               }
               j++;
            }
            i++;
         }
      }
      
      private function removeFromBackPackage(remlist:Array) : void
      {
         var rmequip:* = null;
         var tequip:* = null;
         var i:* = 0;
         var zlen:* = 0;
         var j:* = 0;
         var sit:* = 0;
         var dlen:* = 0;
         var k:* = 0;
         var dsit:* = 0;
         var slen:* = 0;
         var l:* = 0;
         var ssit:* = 0;
         var jlen:* = 0;
         var m:* = 0;
         ssit = 0;
         var rlen:uint = remlist.length;
         var isfind:Boolean = false;
         for(i = uint(0); i < rlen; )
         {
            isfind = false;
            rmequip = remlist[i].dequip as MyEquipObj;
            zlen = uint(this.player.zblist.length);
            for(j = uint(0); j < zlen; )
            {
               tequip = this.player.zblist[j] as MyEquipObj;
               if(tequip.getbackpackid() == rmequip.getbackpackid())
               {
                  sit = uint(this.player.zblist.indexOf(tequip));
                  this.player.zblist.splice(sit,1);
                  isfind = true;
                  break;
               }
               j++;
            }
            if(!isfind)
            {
               dlen = uint(this.player.djlist.length);
               for(k = uint(0); k < dlen; )
               {
                  tequip = this.player.djlist[k] as MyEquipObj;
                  if(tequip.getbackpackid() == rmequip.getbackpackid())
                  {
                     if(tequip.getENum() > 1)
                     {
                        tequip.setNum(-1);
                     }
                     else
                     {
                        dsit = uint(this.player.djlist.indexOf(tequip));
                        if(dsit != -1)
                        {
                           this.player.djlist.splice(dsit,1);
                        }
                     }
                     isfind = true;
                     break;
                  }
                  k++;
               }
               if(!isfind)
               {
                  slen = uint(this.player.szlist.length);
                  for(l = uint(0); l < slen; )
                  {
                     tequip = this.player.szlist[l] as MyEquipObj;
                     if(tequip.getbackpackid() == rmequip.getbackpackid())
                     {
                        ssit = uint(this.player.szlist.indexOf(tequip));
                        this.player.szlist.splice(ssit,1);
                        isfind = true;
                        break;
                     }
                     l++;
                  }
                  if(!isfind)
                  {
                     jlen = uint(this.player.jnslist.length);
                     for(m = uint(0); m < jlen; )
                     {
                        tequip = this.player.jnslist[m] as MyEquipObj;
                        if(tequip.getbackpackid() == rmequip.getbackpackid())
                        {
                           ssit = uint(this.player.jnslist.indexOf(tequip));
                           this.player.jnslist.splice(ssit,1);
                           isfind = true;
                           break;
                        }
                        m++;
                     }
                  }
               }
            }
            i++;
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
      
      private function selfSetPlayer() : void
      {
         if(this.parent)
         {
            if(this.parent is BackPack)
            {
               this.player = BackPack(this.parent).getUser();
            }
            else if(this.parent is StrengthEquipment)
            {
               this.player = StrengthEquipment(this.parent).getUser();
            }
            else if(this.parent is WareHouse)
            {
               this.player = WareHouse(this.parent).getUser();
            }
         }
         else
         {
            trace("parent is not excist");
         }
      }
      
      public function setPlayer(_user:User) : void
      {
         this.player = _user;
      }
      
      public function addMyEquipmentToList(equip:MyEquipObj) : void
      {
         if(equip.type == "zbwq" || equip.type == "zbfj" || equip.type == "zbfb" || equip.type == "zbsp")
         {
            this.player.zblist.push(equip);
         }
         else if(equip.type == "zbsz")
         {
            this.player.szlist.push(equip);
         }
         else
         {
            gc.putQhsInBackPack(this.player,equip.getFillName(),equip.getENum());
         }
         this.rebackpackage(null);
      }
   }
}
