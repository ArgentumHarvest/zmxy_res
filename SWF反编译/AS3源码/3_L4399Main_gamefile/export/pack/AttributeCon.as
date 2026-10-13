package export.pack
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import my.MyEquipObj;
   
   public class AttributeCon extends Sprite
   {
       
      
      private var attributeObj:MyEquipObj;
      
      private var bg:Sprite;
      
      private var info:Sprite;
      
      private var i:Number = 0;
      
      private var bigw:uint = 0;
      
      public function AttributeCon(obj:MyEquipObj)
      {
         bg = new Sprite();
         info = new Sprite();
         super();
         this.attributeObj = obj;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
         this.drawInfo();
         this.drawbg();
      }
      
      private function added(e:Event) : void
      {
         if(this.getChildIndex(bg) > this.getChildIndex(info))
         {
            this.swapChildren(bg,info);
         }
      }
      
      private function removed(e:Event) : void
      {
      }
      
      private function drawInfo() : void
      {
         this.addChild(info);
         info.x = 20;
         info.y = 10;
         var txtformat:TextFormat = new TextFormat();
         var txtname:TextField = new TextField();
         txtname.embedFonts = true;
         txtformat.font = "FZCuYuan-M03S";
         txtformat.color = this.attributeObj.color;
         txtformat.size = 16;
         if(this.attributeObj.getStrengthValue() == 0)
         {
            txtname.text = this.transformMutiLev(this.attributeObj.getMutiLevel()) + this.attributeObj.ename;
         }
         else
         {
            txtname.text = this.transformMutiLev(this.attributeObj.getMutiLevel()) + this.attributeObj.ename + "(+" + this.attributeObj.getStrengthValue() + ")";
         }
         txtname.setTextFormat(txtformat);
         txtname.height = 25;
         txtname.width = txtname.textWidth + 10;
         i++;
         if(this.attributeObj.quality != "")
         {
            this.drawpz("品质",this.attributeObj.color,this.attributeObj.quality);
         }
         if(this.attributeObj.user != "")
         {
            this.drawpz("类型",16777215,this.attributeObj.etype + "·" + this.attributeObj.user);
         }
         else
         {
            this.drawpz("类型",16777215,this.attributeObj.etype);
         }
         if(this.attributeObj.type == "zbfb")
         {
            if(this.attributeObj.getELevel() != 0)
            {
               this.drawpz("等级",16777215,"Lv." + this.attributeObj.getELevel());
            }
         }
         if(this.attributeObj.getEUpdata() != 0)
         {
            this.drawpz("成长率",16777215,this.attributeObj.getEUpdata() + "");
         }
         if(this.attributeObj.getWX() != "")
         {
            this.drawpz("五行",16777215,this.attributeObj.getWX());
         }
         this.drawAttribute();
         this.drawInstruction();
         this.drawValue();
         info.addChild(txtname);
      }
      
      private function drawpz(firststr:String, _color:*, secondstr:String) : void
      {
         var txtformat:TextFormat = new TextFormat();
         var txtname:TextField = new TextField();
         txtname.embedFonts = true;
         txtformat.font = "FZCuYuan-M03S";
         txtformat.color = 0;
         txtformat.size = 16;
         txtformat.bold = true;
         txtname.filters = [this.GlowEffect()];
         txtname.text = firststr;
         txtname.setTextFormat(txtformat);
         txtname.y = i * 25;
         txtname.height = 25;
         txtname.width = txtname.textWidth + 10;
         if(this.bigw < txtname.width)
         {
            this.bigw = txtname.width;
         }
         info.addChild(txtname);
         var line:Sprite = new Sprite();
         line.x = txtname.x + txtname.width - 4;
         line.y = txtname.y + txtname.height - 6;
         line.graphics.lineStyle(2,16777215);
         line.graphics.lineGradientStyle("linear",[16777215,16777215],[1,0],[120,255]);
         line.graphics.moveTo(0,0);
         line.graphics.lineTo(80,0);
         info.addChild(line);
         var txtformat2:TextFormat = new TextFormat();
         var txtname2:TextField = new TextField();
         txtname2.embedFonts = true;
         txtformat2.font = "FZCuYuan-M03S";
         txtformat2.color = _color;
         txtformat2.size = 16;
         txtname2.text = "  " + secondstr;
         txtname2.setTextFormat(txtformat2);
         txtname2.x = txtname.x + txtname.width;
         txtname2.y = txtname.y - 1;
         txtname2.height = 25;
         txtname2.width = txtname2.textWidth + 10;
         if(this.bigw < txtname2.width)
         {
            this.bigw = txtname2.width;
         }
         info.addChild(txtname2);
         i++;
      }
      
      private function drawAttribute() : void
      {
         if(this.attributeObj.getFillName() != "t" && this.attributeObj.getFillName() != "c" && this.attributeObj.getFillName() != "ch")
         {
            if(int(this.attributeObj.getehp(false)) != 0)
            {
               this.drawSimpleAttribute("生命",int(this.attributeObj.getehp(true,1)),this.attributeObj.getShpValue());
            }
            if(int(this.attributeObj.getemp(false)) != 0)
            {
               this.drawSimpleAttribute("魔法",int(this.attributeObj.getemp(true,1)),this.attributeObj.getSmpValue());
            }
            if(int(this.attributeObj.geteatt(false)) != 0)
            {
               this.drawSimpleAttribute("攻击",int(this.attributeObj.geteatt(true,1)),this.attributeObj.getSatkValue());
            }
            if(int(this.attributeObj.getedef(false)) != 0)
            {
               this.drawSimpleAttribute("防御",int(this.attributeObj.getedef(true,1)),this.attributeObj.getSdefValue());
            }
            if(int(this.attributeObj.getecrit(false) * 100) != 0)
            {
               this.drawSimpleAttribute("暴击",AUtils.changeNumber(Number(this.attributeObj.getecrit(true,1) * 100),2) + "%",AUtils.changeNumber(this.attributeObj.getScritValue() * 100,2));
            }
            if(int(this.attributeObj.getemiss(false) * 100) != 0)
            {
               this.drawSimpleAttribute("闪避",AUtils.changeNumber(Number(this.attributeObj.getemiss(true,1) * 100),2) + "%",AUtils.changeNumber(this.attributeObj.getSmissValue() * 100,2));
            }
            if(int(this.attributeObj.geteahp(false)) != 0)
            {
               this.drawSimpleAttribute("回血",int(this.attributeObj.geteahp(true,1)),this.attributeObj.getSehpValue());
            }
            if(int(this.attributeObj.geteamp(false)) != 0)
            {
               this.drawSimpleAttribute("回魔",int(this.attributeObj.geteamp(true,1)),this.attributeObj.getSempValue());
            }
            if(int(this.attributeObj.geteatblood(false) * 100) != 0)
            {
               this.drawSimpleAttribute("吸血",AUtils.changeNumber(Number(this.attributeObj.geteatblood(true,1) * 100),2) + "%",AUtils.changeNumber(this.attributeObj.getSebloValue() * 100,2));
            }
            if(int(this.attributeObj.getmagicdef(false) * 100) != 0)
            {
               this.drawSimpleAttribute("魔抗",AUtils.changeNumber(Number(this.attributeObj.getmagicdef(true,1) * 100),2) + "%",AUtils.changeNumber(this.attributeObj.getSmdefValue() * 100,2));
            }
         }
      }
      
      private function drawSimpleAttribute(_name:String, _basenum:*, _qhnum:int = 0, _fmnum:uint = 0) : void
      {
         var txtformat:TextFormat = new TextFormat();
         txtformat.font = "FZCuYuan-M03S";
         txtformat.color = 16750899;
         txtformat.size = 16;
         txtformat.bold = true;
         var txt:TextField = new TextField();
         txt.embedFonts = true;
         if(_qhnum == 0)
         {
            txt.text = _name + "： " + _basenum;
         }
         else if(_qhnum > 0)
         {
            txt.text = _name + "： " + _basenum + "(+" + _qhnum + ")";
         }
         else
         {
            txt.text = _name + "： " + _basenum + "(" + _qhnum + ")";
         }
         txt.setTextFormat(txtformat);
         txt.y = i * 25;
         txt.height = 25;
         txt.width = txt.textWidth + 10;
         info.addChild(txt);
         i++;
      }
      
      private function drawInstruction() : void
      {
         var txt:TextField = new TextField();
         txt.wordWrap = true;
         txt.embedFonts = true;
         txt.htmlText = "<font face=\'FZCuYuan-M03S\' size=\'14\' color=\'#ffffff\'>" + this.attributeObj.instruction + "</font>";
         txt.y = i * 25;
         txt.height = txt.textHeight + 10;
         txt.width = 135;
         info.addChild(txt);
         var row:Number = txt.height / 25;
         i += row;
      }
      
      private function drawValue() : void
      {
         var txtformat:TextFormat = new TextFormat();
         txtformat.font = "FZCuYuan-M03S";
         txtformat.color = 16750899;
         txtformat.size = 14;
         var txt:TextField = new TextField();
         txt.embedFonts = true;
         txt.text = "价值 : " + this.attributeObj.getValue() + " 灵魂";
         txt.setTextFormat(txtformat);
         txt.y = i * 25;
         txt.height = txt.textHeight + 10;
         txt.width = 135;
         info.addChild(txt);
      }
      
      private function drawbg() : void
      {
         this.addChild(bg);
         bg.graphics.lineStyle(1,16777215);
         bg.graphics.beginFill(0,0.7);
         bg.graphics.drawRoundRect(0,0,this.info.width + 35,this.info.height + 10,5,5);
         bg.graphics.endFill();
      }
      
      private function transformMutiLev(lev:int) : String
      {
         switch(int(lev) - 1)
         {
            case 0:
               return "一重";
            case 1:
               return "二重";
            case 2:
               return "三重";
            case 3:
               return "四重";
            case 4:
               return "五重";
            case 5:
               return "六重";
            case 6:
               return "七重";
            case 7:
               return "八重";
            case 8:
               return "九重";
            case 9:
               return "十重";
            default:
               return "";
         }
      }
      
      private function GlowEffect() : GlowFilter
      {
         return new GlowFilter(16777215,1,2,2,3,3,false,false);
      }
   }
}
