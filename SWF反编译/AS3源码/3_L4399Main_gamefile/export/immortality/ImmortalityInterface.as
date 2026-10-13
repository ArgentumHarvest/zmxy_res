package export.immortality
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import user.User;
   
   public class ImmortalityInterface extends Sprite
   {
       
      
      public var x_btn:SimpleButton;
      
      public var addtxt:TextField;
      
      public var im1_1:SingleImmortality;
      
      public var im1_2:SingleImmortality;
      
      public var im2_1:SingleImmortality;
      
      public var im2_2:SingleImmortality;
      
      public var im2_3:SingleImmortality;
      
      public var im3_1:SingleImmortality;
      
      public var im3_2:SingleImmortality;
      
      public var im3_3:SingleImmortality;
      
      public var im3_4:SingleImmortality;
      
      public var im4_1:SingleImmortality;
      
      public var im4_2:SingleImmortality;
      
      public var im4_3:SingleImmortality;
      
      public var im4_4:SingleImmortality;
      
      public var im4_5:SingleImmortality;
      
      public var im5_1:SingleImmortality;
      
      public var im5_2:SingleImmortality;
      
      public var im5_3:SingleImmortality;
      
      public var im5_4:SingleImmortality;
      
      public var im5_5:SingleImmortality;
      
      public var im5_6:SingleImmortality;
      
      private var gc:Config;
      
      private var player:User;
      
      private var immname:String = "wpsmd";
      
      public function ImmortalityInterface(_player:User)
      {
         super();
         gc = Config.getInstance();
         this.player = _player;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         x_btn.addEventListener("click",xClick);
         this.initImmortalityShow();
      }
      
      private function removed(e:Event) : void
      {
         x_btn.removeEventListener("click",xClick);
      }
      
      private function initImmortalityShow() : void
      {
         var ilen:* = 0;
         var iname:* = null;
         var i:* = 0;
         var elen:* = 0;
         var j:* = 0;
         var k:* = 0;
         if(this.player)
         {
            ilen = uint(this.player.immortalitylist.length);
            iname = "";
            for(i = uint(0); i < ilen; )
            {
               this.setRowList(i + 1);
               if(this.player.immortalitylist[i].canuse == true || this.player.immortalitylist[i].canuse == "true")
               {
                  elen = uint(this.player.immortalitylist[i].usenum);
                  for(j = uint(1); j <= elen; )
                  {
                     this["im" + (i + 1) + "_" + j].setImage(immname + (i + 1));
                     j++;
                  }
                  if(this.player.getSomeOneEquipNumberByName(immname + (i + 1)) > 0)
                  {
                     if(elen < i + 2)
                     {
                        trace("im" + (i + 1) + "_" + (elen + 1));
                        this["im" + (i + 1) + "_" + (elen + 1)].setBtnVisible(true);
                     }
                  }
               }
               else
               {
                  for(k = uint(1); k <= i + 2; )
                  {
                     this["im" + (i + 1) + "_" + k].setUnUseable();
                     k++;
                  }
               }
               i++;
            }
         }
         this.setTxt();
      }
      
      private function setTxt() : void
      {
         var alladd:int = this.player.findAllImmortalityAddHp();
         this.addtxt.text = alladd + " ";
      }
      
      private function setRowList(row:uint) : void
      {
         var i:* = 0;
         for(i = uint(1); i <= row + 1; )
         {
            this["im" + row + "_" + i].setImmortalityId(row,this.immname);
            this["im" + row + "_" + i].setUser(this.player);
            i++;
         }
      }
      
      public function refreshInterface() : void
      {
         this.initImmortalityShow();
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
