(function () {
    var divid = "t_test";//上层div的id
    var max = 16;//下拉菜单的行数
    var oc = "#FFFFFF";//下拉菜单每行的初始颜色
    var nc = "#ffe9f1";//下拉菜单每行的突出颜色
    var ti = -1;//鼠标当前的行的index
    var FirstUpDown =true;
    var scrollValue=0;
    var strText="";
    var flag=0;

    $ = function(i){
        return document.getElementById(i);
    }                                     
    
    H={ 
        setId : function(id){
             H._txtId = id;
            },

        setWidth : function(w){
             H._width = w;
            },
        setTbId : function(t){
            H._tbId = t;
        },
        setNdId :function(n){
            H._nodeId = n;
        },
        
        addEl : function (o){
          if($(o.id) == null){
            var t = document.createElement(o.tag);
            
            t.id = o.id;
            
            t.style.position=o.css.position;
            t.style.left=o.css.left;
            t.style.height = o.css.height;
            //t.style.border = "1px solid #f00";
            // alert(t.style.left);
            //t.style.z-index = o.css.zindex;
            //t.style.overflow = o.css.hidden;
            t.style.top = o.css.top;
            
            t.innerHTML = o.html;
            
            $(divid).appendChild(t);
          }
    },
          
        addEvent : function(id,ev,f){ 

            if(typeof id == "undefined" ||$(id)==null){
                return;
            }
          
            if ($(id).addEventListener){
                $(id).addEventListener(ev.substr(2), f, false);
            }
            else if ($(id).attachEvent){
                $(id).attachEvent(ev,f);
            
            }
           
        },      
        
        getData : function(v){
               
            UI.getScript(v,function(){
                if( typeof r == 'undefined' ){
                    return;
                }
               
                if( r.smart.length > 0 ){
                    H.av = r.smart;
                }
                else
                {
                    $(H._nodeId).style.display = "none";
                    return;
                }

                H.MakTab();

                H.fp();
                });
        },                 
        
        MakTab : function(){
        
            FirstUpDown = true;
            var tb = $(H._tbId);
            tb.style.display="";
            if(tb.childNodes.length>0){
                tb.removeChild(tb.childNodes[0]);
            }
 
            var header = tb.createTHead();

            var i = 0;

            for(; i < H.av.length && i < max; i++)
            {
                var rv = H.av[i].words;
                
                var bodyRow = header.insertRow(i);
                bodyRow.id = "bodyRow" + parseInt(i);

                if ($(H._txtId).addEventListener){
                    bodyRow.addEventListener("click", H.click,false);
                    
                    bodyRow.addEventListener("mousemove", H.mm,false);
                }
                else if ($(H._txtId).attachEvent){
                    bodyRow.attachEvent("onclick", H.click);
                    bodyRow.attachEvent("onmousemove", H.mm);
                }

                bodyRow.style.cursor = "hand";
                bodyRow.style.padding = "0 3px 0 3px";
                bodyRow.style.backgroundColor = oc;
                bodyRow.style.textAlign = "left";
                bodyRow.style.cursor = "pointer";

                var cell = bodyRow.insertCell(0);
                cell.style.padding = "4px 0 4x 2px";
                cell.style.fontSize = "12px";
                cell.innerHTML = rv;  
            }
            
            var bodyRow = header.insertRow(i);
            bodyRow.style.backgroundColor = oc;
            var cell = bodyRow.insertCell(0);
            cell.style.padding = "1px 0 1px 5px";
            cell.style.fontSize = "12px";
            cell.className = "td_body_row";
            var strHint = "";

            if(H.av.length > max)
            {
                strHint = "还有" + (H.av.length - max) + "条记录未显示 ";
            }
            else
            {
                strHint = "";
            }
            
            cell.innerHTML = "<table style='z-index:9999;' align='left' width=100% border='0'"
                + " cellpadding='0' cellspacing='0'><tr><td class='fontblue' align=left width=80%>" 
                + strHint + "</td><td align=right width=20% class='fontblue'><a href='#' onclick='document.getElementById(\""
                + H._nodeId +"\").style.display = \"none\";document.getElementById(\""
                + H._txtId +"\").focus();return false;' class='fontblue red'>隐藏</a></td></tr></table>";    
            bodyRow.style.padding = "0 3px 0 3px";
            bodyRow.style.backgroundColor = H.oc;
        },

        fp : function(){

            $(H._nodeId).style.position = "absolute";
            $(H._nodeId).style.display = "";

            $(H._nodeId).style.top = parseInt($(H._txtId).getBoundingClientRect().top)
                                     - parseInt($(divid).getBoundingClientRect().top)
                                     + parseInt($(H._txtId).clientHeight) + 4;
            $(H._nodeId).style.left =  parseInt($(H._txtId).getBoundingClientRect().left)
                                     - parseInt($(divid).getBoundingClientRect().left);
            
            $(H._nodeId).style.width = H._Width;
    },

        click :function(e){
            var eventId = H.getID(e);
            var eventIndex = eventId.substring(7,eventId.length);
            
            var tbobj = $(H._tbId);

            var trobj = tbobj.getElementsByTagName("tr");
           
            ti = parseInt(eventIndex);

            if(trobj.length > ti + 1){
              trobj[ti].style.backgroundColor = oc;
            }

             if( !!trobj[ti].style ){
               trobj[ti].style.backgroundColor = nc;
            }
            
            var txt = $(H._txtId);
            txt.focus();
            $(H._nodeId).style.display = "none";

            var i = trobj[ti].id.substr(7);
            
            var t = H.av[i].num >> 30;
            
            if(t == 0)
            {
                var grp = Math.ceil(H.av[i].num / 1000);
                window.open("http://lady.qq.com/d/product/" + grp + "/"+H.av[i].num);
            }
            else if(t == 1)
            {
                 var id = H.av[i].num  - (1<<30);
                 var grp = Math.ceil(id / 1000);
                 window.open("http://lady.qq.com/d/brand/" + grp + "/"+id);
            }
    
    },
        getID:function(e){
            if(!e){
                e = window.event;
            }

            var tg;

            if (e.target)
            {
                tg = e.target.parentNode;
            }
            else if (e.srcElement)
            {
                tg = e.srcElement.parentElement;
            }

            return tg.id;
    },
        mm :function(e){
            var eventId = H.getID(e);
              
            var eventIndex = eventId.substring(7,eventId.length);
            var tbobj = $(H._tbId);
            var trobj = tbobj.getElementsByTagName("tr");

            if(ti  == -1)
            {
                ti = 0;
            }

            if(trobj.length != 0)
            {
                trobj[ti].style.backgroundColor = oc;
                ti = parseInt(eventIndex);
                trobj[ti].style.backgroundColor = nc;
            }
    },
        g:function(e){
            alert(e.which);
    },
        m : function(e){
                    
            if(window.event) // IE
            {
                keycode = e.keyCode;
            }
            else if(e.which) // Netscape/Firefox/Opera
            {
                keycode = e.which;
            }
            
            if(keycode == '13' && ($(H._nodeId).style.display == "" /*|| ti == -1*/))
            {
                 //window.open("http://lady.qq.com/d/product/1/1/");         
                 return;
            }
              
            if(keycode == '38')
            {
                H.mu();
                return;
            }
            if(keycode == '40')
            {
                H.md();
                return;
            }
           
            var t = $(H._txtId).value.replace(/　/g, " ").replace(/^\s*/g, "");

            if(t == "")
            {
                $(H._nodeId).style.display = "none";
                ti = -1;
                scrollValue = 0;
            }
            else
            {
                ti = -1;
                url = n.hintUrl+t; 
                
                H.getData(url);            
            }
            
        },                     
     
        mu:function(){
            var tbobj = $(H._tbId);
            var trobj = tbobj.getElementsByTagName("tr");
            if(trobj.length  == 0){
                return;
            }
            else
            {
                trobj[ti].style.backgroundColor = oc;
                if(ti == 0){
                    ti = trobj.length - 3;
                }
                else{
                    ti = ti - 1;
                }

                FirstUpDown = false;
                trobj[ti].focus();
                trobj[ti].style.backgroundColor = nc;
                scrollValue = (ti + 1) * 22 - 135;
                $(H._nodeId).scrollTop = scrollValue;
            }

    },
        md:function(){
            if(ti == -1)
            {
                ti = 0;
            }

            var tbobj = $(H._tbId);
            var trobj = tbobj.getElementsByTagName("tr");
            if(trobj.length  == 0)
            {
                return;
            }
            else
            {
                trobj[ti].style.backgroundColor = oc;

                if(ti < trobj.length - 3 && FirstUpDown == false){
                        ti = ti + 1;
                }
                else{
                    ti = 0;
                }
                 
                FirstUpDown = false;
                trobj[ti].style.backgroundColor = nc;
                trobj[ti].focus();
                scrollValue = (ti + 1) * 22 - 135;
                $(H._nodeId).scrollTop = scrollValue;
            }

    },
        dn : function(){
    
            $(H._nodeId).style.display = "none";
            ti = -1;
            scrollValue = 0;
        },
    
        dp : function(){
    
        },
      
        getLeft :function(){
    
               return $(H._txtId).getBoundingClientRect().left;
        },
        getTop :function(){
            return $(H._txtId).getBoundingClientRect().top; 
        }
           
    }
    
    n = {
        hintUrl : "http://app.data.qq.com/?mod=sm&act=b&type=smart&format=2&tx="
        }

    H.setId('kvalue');
    H.setTbId('smList');
    H.setNdId('smdiv');
    H.setWidth(160);
    H.addEvent(H._txtId,"onkeyup",H.m);
    
    document.body.onclick=H.dn;

    H.addEl({
    tag:"div",
    id:"smdiv",
    css:{position:"absolute",
         height:"auto",
         zindex:"9999",
         overflow:"hidden",
         left: "0px",
         top: "-1px"
         },
    html:"<table style='border:#cecece 1px solid;display:none;width:"+H._Width+"px' cellpadding='0' cellspacing='0' id='smList' style=''></table>"
    //html:"<table style='border:#cecece 1px solid;display:none;' cellpadding='0' cellspacing='0' id='smList' style=''></table>"
     });

})();
/*  |xGv00|088206d6d6a13d41da38fc6d41c8d409 */