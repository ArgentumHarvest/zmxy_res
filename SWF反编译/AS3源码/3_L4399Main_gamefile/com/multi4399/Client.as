package com.multi4399
{
   import config.Config;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.ProgressEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   [Event(name="connect",type="Event.CONNECT")]
   [Event(name="close",type="Event.CLOSE")]
   [Event(name="ioError",type="IOErrorEvent.IO_ERROR")]
   [Event(name="securityError",type="SecurityErrorEvent.SECURITY_ERROR")]
   [Event(name="packet",type="com.multi4399.ResponseEvent.PACKET")]
   public class Client extends EventDispatcher
   {
       
      
      protected var _sock:Socket;
      
      protected var _host:String;
      
      protected var _port:int;
      
      protected var _request:RequestPacket;
      
      protected var _response:ByteArray;
      
      public function Client()
      {
         _sock = new Socket();
         _request = new RequestPacket();
         _response = new ByteArray();
         super();
         _response.endian = "littleEndian";
         _sock.addEventListener("connect",onSocket,false,0,true);
         _sock.addEventListener("close",onSocket,false,0,true);
         _sock.addEventListener("ioError",onSocket,false,0,true);
         _sock.addEventListener("securityError",onSocket,false,0,true);
         _sock.addEventListener("socketData",onSocketData,false,0,true);
      }
      
      public function connect(host:String, port:int) : void
      {
         if(_sock.connected)
         {
            _sock.close();
         }
         _host = host;
         _port = port;
         _response.length = _response.position = 0;
         _sock.connect(_host,_port);
      }
      
      public function get connected() : Boolean
      {
         return _sock.connected;
      }
      
      public function close() : void
      {
         _sock.close();
      }
      
      public function get socket() : Socket
      {
         return _sock;
      }
      
      public function submit(mark:uint) : void
      {
         if(mark >= 4096)
         {
            throw new Error("自定义标记号码必须在4096的数值以下!");
         }
         _request.pack(mark);
         _sock.writeBytes(_request);
         _sock.flush();
         _request.reset();
      }
      
      private function onSocket(e:Event) : void
      {
         this.dispatchEvent(e);
      }
      
      private function onSocketData(e:ProgressEvent) : void
      {
         var bytesAvailable:* = 0;
         var symbol:* = null;
         var version:* = 0;
         var preserve:* = 0;
         var packetSize:* = 0;
         var mark:* = 0;
         var bodySize:* = 0;
         var response:* = null;
         var oprand:* = 0;
         var type:* = 0;
         var size:* = 0;
         var byteLength:* = 0;
         var year:int = 0;
         var month:int = 0;
         var mday:int = 0;
         var hour:int = 0;
         var minute:int = 0;
         var second:int = 0;
         var millisecond:int = 0;
         var date:* = null;
         var bytes:* = null;
         var tmp:* = null;
         _sock.readBytes(_response,_response.length);
         while(bytesAvailable = uint(_response.bytesAvailable))
         {
            if(bytesAvailable < 10)
            {
               trace("bytesAvailable < RESPONSE_HEADER_SIZE");
               break;
            }
            symbol = _response.readUTFBytes(4);
            if(symbol != "YMP")
            {
               trace("Error packet protocol!");
               _response.length = _response.position = 0;
               break;
            }
            version = uint(_response.readUnsignedByte());
            if(version != 65)
            {
               trace("Error packet protocol version!");
               _response.length = _response.position = 0;
               break;
            }
            preserve = uint(_response.readUnsignedByte());
            packetSize = uint(_response.readUnsignedShort());
            Config.getInstance().nodeInfo.totalGetBytesLen = Config.getInstance().nodeInfo.totalGetBytesLen + packetSize;
            trace("总共收到数据：" + Config.getInstance().nodeInfo.totalGetBytesLen);
            trace("持续时间：" + (getTimer() - Config.getInstance().nodeInfo.startTime));
            if(packetSize > 65535)
            {
               trace("Packet overflow!");
               _response.length = _response.position = 0;
               break;
            }
            if(bytesAvailable < packetSize)
            {
               trace("bytesAvailable < PACKET_SIZE");
               _response.position -= 8;
               break;
            }
            mark = uint(_response.readUnsignedShort());
            bodySize = uint(packetSize - 10);
            if(mark.toString(16) != "10")
            {
               trace("GET--mark:" + mark.toString(16) + "--length:" + bodySize);
            }
            response = new ResponseEvent("packet");
            response.mark = mark;
            while(bodySize)
            {
               oprand = uint(_response.readByte());
               bodySize--;
               type = uint(oprand & 248);
               size = uint(oprand & 7);
               if(size == 0)
               {
                  response.values.push(_response.readUnsignedByte());
                  bodySize -= 1;
               }
               else if(size == 1)
               {
                  response.values.push(_response.readUnsignedShort());
                  bodySize -= 2;
                  if(type == 248)
                  {
                     response.errors.push(response.values.length - 1);
                  }
               }
               else if(size == 2)
               {
                  response.values.push(_response.readUnsignedInt());
                  bodySize -= 4;
               }
               else if(size == 3)
               {
                  response.values.push(_response.readDouble());
                  bodySize -= 8;
               }
               else if(size == 4)
               {
                  byteLength = uint(_response.readUnsignedShort());
                  bodySize -= 2 + byteLength;
                  if(type == 232)
                  {
                     year = _response.readUnsignedShort();
                     month = _response.readUnsignedByte();
                     mday = _response.readUnsignedByte();
                     hour = _response.readUnsignedByte();
                     minute = _response.readUnsignedByte();
                     second = _response.readUnsignedByte();
                     millisecond = _response.readUnsignedShort();
                     date = new Date(year,month,mday,hour,minute,second,millisecond);
                     response.values.push(date);
                  }
                  else if(type == 24)
                  {
                     response.values.push(_response.readInt());
                  }
                  else if(type == 32)
                  {
                     response.values.push(_response.readDouble());
                  }
                  else if(type == 240)
                  {
                     response.values.push(_response.readUTFBytes(byteLength));
                  }
                  else if(type == 224)
                  {
                     response.values.push(new XML(_response.readUTFBytes(byteLength)));
                  }
                  else
                  {
                     bytes = new ByteArray();
                     byteLength && _response.readBytes(bytes,0,byteLength);
                     response.values.push(bytes);
                  }
               }
               else
               {
                  trace("unsupport size",size);
               }
            }
            this.dispatchEvent(response);
         }
         if(_response.bytesAvailable == 0)
         {
            _response.length = _response.position = 0;
         }
         else if(_response.position != 0)
         {
            tmp = new ByteArray();
            _response.readBytes(tmp);
            _response.length = _response.position = 0;
            _response.writeBytes(tmp);
            _response.position = 0;
         }
      }
      
      protected function getOprandType(variable:*) : int
      {
         var varType:String = getQualifiedClassName(variable);
         var oprandType:int = 0;
         switch(varType)
         {
            case "int":
               oprandType = 24;
               break;
            case "Number":
               oprandType = 32;
               break;
            case "String":
               oprandType = 240;
               break;
            case "XML":
               oprandType = 224;
               break;
            case "flash.utils::ByteArray":
               break;
            default:
               throw new Error("尚不支持的类型");
         }
         return oprandType;
      }
      
      public function ins_auto_goto_child(type:uint = 0) : void
      {
         _request.addInstruction(17,0,type);
      }
      
      public function ins_auto_goto_sibling(type:uint = 0) : void
      {
         _request.addInstruction(49,0,type);
      }
      
      public function ins_bo_node(mark:uint, data:*, butThis:Boolean = false) : void
      {
         trace("SEND->ins_bo_node->mark:" + mark.toString(16) + "--length:" + data.length + "--butThis:" + butThis + ",time:" + getTimer());
         if(butThis == false)
         {
            _request.addInstruction(274,1,mark,4 | this.getOprandType(data),data);
         }
         else
         {
            _request.addInstruction(290,1,mark,4 | this.getOprandType(data),data);
         }
      }
      
      public function ins_bo_global(mark:uint, data:*) : void
      {
         _request.addInstruction(258,1,mark,4 | this.getOprandType(data),data);
      }
      
      public function ins_goto_child(index:uint, type:uint = 0, password:String = null) : void
      {
         if(password == null)
         {
            _request.addInstruction(1026,1,index,0,type);
         }
         else
         {
            _request.addInstruction(1043,1,index,0,type,240 | 4,password);
         }
      }
      
      public function ins_goto_parent() : void
      {
         _request.addInstruction(1280);
      }
      
      public function ins_goto_sibling(index:uint, type:uint = 0, password:String = null) : void
      {
         if(password == null)
         {
            _request.addInstruction(4354,1,index,0,type);
         }
         else
         {
            _request.addInstruction(4371,1,index,0,type,240 | 4,password);
         }
      }
      
      public function ins_goto_sibling_x(index:int, type:uint = 0) : void
      {
         _request.addInstruction(34,1,index,0,type);
      }
      
      public function ins_fetch_page(size:uint, index:uint, type:uint = 0) : void
      {
         _request.addInstruction(1603,1,size,1,index,0,type);
      }
      
      public function ins_fetch_page_count(size:uint) : void
      {
         _request.addInstruction(1666,1,size,0,0);
      }
      
      public function ins_fetch_child_node(keys:uint, index:int) : void
      {
         _request.addInstruction(1682,2,keys,1,index);
      }
      
      public function ins_fetch_child_nodes(keys:uint, indices:ByteArray) : void
      {
         _request.addInstruction(1538,2,keys,4,indices);
      }
      
      public function ins_get_game(keys:uint) : void
      {
         _request.addInstruction(1553,2,keys);
      }
      
      public function ins_get_user(keys:uint) : void
      {
         _request.addInstruction(1569,2,keys);
      }
      
      public function ins_get_node(keys:uint) : void
      {
         _request.addInstruction(1585,2,keys);
      }
      
      public function ins_get_server(keys:uint) : void
      {
         _request.addInstruction(1617,2,keys);
      }
      
      public function ins_fetch_users(keys:uint, ids:ByteArray) : void
      {
         _request.addInstruction(1634,2,keys,4,ids);
      }
      
      public function ins_fetch_user(keys:uint, id:uint) : void
      {
         _request.addInstruction(1650,2,keys,2,id);
      }
      
      public function ins_kick_user(id:uint) : void
      {
         _request.addInstruction(1793,2,id);
      }
      
      public function ins_login(gameId:int, checkCode:int = 0, customUserId:int = 0) : void
      {
         if(checkCode == 0)
         {
            _request.addInstruction(2305,2,gameId);
         }
         else if(customUserId == 0)
         {
            _request.addInstruction(2322,2,gameId,2,checkCode);
         }
         else
         {
            _request.addInstruction(2339,2,gameId,2,checkCode,2,customUserId);
         }
      }
      
      public function ins_nop() : void
      {
         _request.addInstruction(2560);
      }
      
      public function ins_ok() : void
      {
         _request.addInstruction(2576);
      }
      
      public function ins_return_to_param(index:uint, back:Boolean) : void
      {
         _request.addInstruction(4098,0,index,0,back);
      }
      
      public function ins_set_time_out(delay:uint, action:uint) : void
      {
         _request.addInstruction(3858,1,delay,0,action);
      }
      
      public function ins_clear_time_out(timerId:uint) : void
      {
         _request.addInstruction(3873,2,timerId);
      }
      
      public function ins_set_response_filter(masks:int) : void
      {
         _request.addInstruction(2817,1,masks);
      }
      
      public function ins_send(mark:uint, data:*, id:uint, ccThis:Boolean = false) : void
      {
         if(ccThis == false)
         {
            _request.addInstruction(3075,1,mark,4 | this.getOprandType(data),data,2,id);
         }
         else
         {
            _request.addInstruction(3091,1,mark,4 | this.getOprandType(data),data,2,id);
         }
      }
      
      public function ins_send_multi(mark:uint, data:*, ids:ByteArray) : void
      {
         _request.addInstruction(3107,1,mark,4 | this.getOprandType(data),data,4,ids);
      }
      
      public function ins_set_user(key:uint, value:*) : void
      {
         var oprand:int = 0;
         switch(key)
         {
            case 4:
               oprand = 4 | getOprandType(value);
               break;
            case 16:
               oprand = 4 | 8;
               break;
            case 32:
               oprand = 4 | 24;
               break;
            default:
               throw new Error("此Key不在支持列表中!");
         }
         _request.addInstruction(3330,2,key,oprand,value);
      }
      
      public function ins_set_events(keys:uint) : void
      {
         _request.addInstruction(3361,2,keys);
      }
      
      public function ins_set_node(key:uint, value:*) : void
      {
         var oprand:int = 0;
         switch(key)
         {
            case 4:
               oprand = 4 | getOprandType(value);
               break;
            case 16:
               oprand = 4 | 240;
               break;
            case 4096:
               oprand = 4 | 16;
               break;
            case 8192:
               oprand = 4 | 8;
               break;
            default:
               throw new Error("此Key不在支持列表中!");
         }
         _request.addInstruction(3346,2,key,oprand,value);
      }
      
      public function ins_set_pseudo_node(type:int) : void
      {
         _request.addInstruction(3841,2,type);
      }
   }
}
