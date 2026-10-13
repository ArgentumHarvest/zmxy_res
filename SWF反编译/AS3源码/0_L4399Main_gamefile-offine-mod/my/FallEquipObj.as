package my
{
   import base.BaseHero;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import config.Config;
   import flash.display.MovieClip;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class FallEquipObj extends BaseObject
   {
       
      
      private var numTf:TextField;
      
      private var tcount:int = 0;
      
      private var bosslist:Array;
      
      var isfirst:Boolean = true;
      
      public function FallEquipObj(obj:Object)
      {
         var ttf:* = null;
         bosslist = ["tdlzjzzs","shsjt","wpqhs1","tlzsp","llzsp","hlzsp","flzsp","slzsp"];
         super();
         gc = Config.getInstance();
         this._anti.ename = obj.name;
         this._anti.bigtype = obj.bigtype;
         this._anti.num = !!obj.num ? obj.num : 1;
         var img:* = AUtils.getImageObj("fall_" + this._anti.ename);
         img.x = -img.width / 2;
         img.y = -img.height / 2;
         this.colipse = new MovieClip();
         this.colipse.addChild(img);
         addChild(this.colipse);
         if(this._anti.num > 1)
         {
            ttf = new TextFormat();
            ttf.color = 16777215;
            ttf.size = 18;
            this.numTf = new TextField();
            this.numTf.defaultTextFormat = ttf;
            this.numTf.selectable = false;
            this.numTf.text = this._anti.num + "";
            this.numTf.width = this.numTf.textWidth + 5;
            this.numTf.height = this.numTf.textHeight + 5;
            this.numTf.x = img.width * 0.5 - this.numTf.width;
            this.numTf.y = img.height * 0.5 - this.numTf.height;
            this.addChild(this.numTf);
            this.numTf.filters = [new GlowFilter(0,1,2,2,255,2,false,false)];
         }
         if(obj.contimeTime == -1)
         {
            tcount = -999999;
         }
      }
      
      public function getEName() : String
      {
         return this._anti.ename;
      }
      
      override public function step() : void
      {
         var who:* = null;
         var i:int = 0;
         this.checkCanMove();
         var plen:uint = gc.getPlayerArray().length;
         while(plen-- > 0)
         {
            who = gc.getPlayerArray()[plen];
            if(!(Math.abs(this.x - who.x) > 700 || who.isDead()))
            {
               if(who.getPlayer() != gc.player3)
               {
                  if(Math.abs(this.y - who.y) < 200)
                  {
                     this.colwho(who);
                  }
               }
            }
         }
         if(tcount++ >= gc.frameClips * 25)
         {
            tcount = 0;
            i = this.bosslist.indexOf(this._anti.ename);
            if(i == -1)
            {
               this.remove();
            }
         }
      }
      
      protected function colwho(who:BaseHero) : void
      {
         var newMyEquip:* = null;
         var newMyEquip2:* = null;
         newMyEquip = null;
         var newPetEquip:* = null;
         newMyEquip2 = null;
         if(this.isfirst)
         {
            if(who.body)
            {
               if(!this.hitTestObject(who.colipse))
               {
                  return;
               }
               if(HitTest.complexHitTestObject(this,who.colipse))
               {
                  switch(this._anti.bigtype)
                  {
                     case "zb":
                        if(who.getPlayer().zblist.length < who.getPlayer().getMax())
                        {
                           newMyEquip = gc.allEquip.findByName(this._anti.ename);
                           if(newMyEquip)
                           {
                              if(newMyEquip.getFillName() == "shsjt")
                              {
                                 if(who.getPlayer().getSomeEquipInPackBackByName("shsjt") != null || who.getPlayer().getCurEquipByType("zbsp") && who.getPlayer().getCurEquipByType("zbsp").getFillName() == "shsjt")
                                 {
                                    return;
                                 }
                                 who.getPlayer().zblist.push(newMyEquip);
                              }
                              else if(newMyEquip.getFillName() == "clj")
                              {
                                 if(who.getPlayer().getSomeEquipInPackBackByName("clj") != null || who.getPlayer().getCurEquipByType("zbsp") && who.getPlayer().getCurEquipByType("zbsp").getFillName() == "clj")
                                 {
                                    return;
                                 }
                                 if(who.getPlayer().getSomeEquipInPackBackByName("psdclj") != null || who.getPlayer().getCurEquipByType("zbsp") && who.getPlayer().getCurEquipByType("zbsp").getFillName() == "psdclj")
                                 {
                                    return;
                                 }
                                 who.getPlayer().zblist.push(newMyEquip);
                              }
                              else
                              {
                                 who.getPlayer().zblist.push(newMyEquip);
                              }
                           }
                           break;
                        }
                        return;
                        break;
                     case "dj":
                        newMyEquip2 = gc.allEquip.findByName(this._anti.ename);
                        if(who.getPlayer().djlist.length < who.getPlayer().getMax())
                        {
                           if(gc.findOneTimeGoodsByFillName(newMyEquip2.getFillName()))
                           {
                              gc.putQhsInBackPack(who.getPlayer(),this._anti.ename,this._anti.num,false,true);
                           }
                           else
                           {
                              gc.putQhsInBackPack(who.getPlayer(),this._anti.ename,this._anti.num);
                           }
                        }
                        else
                        {
                           if(who.getPlayer().getSomeOneEquipNumberByName(this._anti.ename) <= 0)
                           {
                              return;
                           }
                           if(gc.findOneTimeGoodsByFillName(newMyEquip2.getFillName()))
                           {
                              gc.putQhsInBackPack(who.getPlayer(),this._anti.ename,this._anti.num,false,true);
                           }
                           else
                           {
                              gc.putQhsInBackPack(who.getPlayer(),this._anti.ename,this._anti.num);
                           }
                        }
                        break;
                     case "sz":
                        if(who.getPlayer().djlist.length < who.getPlayer().getMax())
                        {
                           newMyEquip = gc.allEquip.findByName(this._anti.ename);
                           if(newMyEquip)
                           {
                              who.getPlayer().szlist.push(newMyEquip);
                           }
                           break;
                        }
                        return;
                        break;
                     case "cwzb":
                        if(who.getPlayer().plist.length < who.getPlayer().getMax())
                        {
                           newPetEquip = gc.allEquip.findByName(this._anti.ename);
                           if(newPetEquip)
                           {
                              who.getPlayer().plist.push(newPetEquip);
                           }
                        }
                        break;
                     case "formationStone":
                        gc.setCliffordStone(this._anti.ename,1);
                        break;
                     case "jns":
                        newMyEquip2 = gc.allEquip.findByName(this._anti.ename);
                        if(who.getPlayer().jnslist.length < who.getPlayer().getMax())
                        {
                           if(gc.findOneTimeGoodsByFillName(newMyEquip2.getFillName()))
                           {
                              gc.putQhsInBackPack(who.getPlayer(),this._anti.ename,this._anti.num,false,true);
                           }
                           else
                           {
                              gc.putQhsInBackPack(who.getPlayer(),this._anti.ename,this._anti.num);
                           }
                        }
                        else
                        {
                           if(who.getPlayer().getSomeOneEquipNumberByName(this._anti.ename) <= 0)
                           {
                              return;
                           }
                           if(gc.findOneTimeGoodsByFillName(newMyEquip2.getFillName()))
                           {
                              gc.putQhsInBackPack(who.getPlayer(),this._anti.ename,this._anti.num,false,true);
                           }
                           else
                           {
                              gc.putQhsInBackPack(who.getPlayer(),this._anti.ename,this._anti.num);
                           }
                        }
                  }
                  isfirst = false;
                  TweenMax.to(this,0.8,{
                     "y":this.y - 100,
                     "alpha":0,
                     "onComplete":this.remove
                  });
               }
            }
         }
      }
      
      private function remove() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         var idx:int = gc.otherList.indexOf(this);
         if(idx != -1)
         {
            gc.otherList.splice(idx,1);
            this.bosslist = null;
         }
      }
      
      override protected function checkOver() : void
      {
         this.remove();
      }
   }
}
