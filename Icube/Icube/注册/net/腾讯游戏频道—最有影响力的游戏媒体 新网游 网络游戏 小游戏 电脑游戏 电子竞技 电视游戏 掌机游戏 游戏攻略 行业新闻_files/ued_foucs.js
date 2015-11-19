function uedFoucs(Content,imgShowId, titShowId,dotShowId,arrLeftId, arrRightId,curOnclass,curOverclass, onEffect,onEvents,isAuto,autoInt) {
    this.Content = Content;
	this.imgShowId = imgShowId;
    this.titShowId = titShowId;
	this.dotShowId = dotShowId;
    this.arrLeftId = arrLeftId;
	this.arrRightId = arrRightId;
	this.curOnclass = curOnclass;
	this.curOverclass = curOverclass;
	this.onEffect = onEffect;
	this.onEvents = onEvents;
	this.isAuto = false;
	this.autoInt = 3;
	this.currentIndex = 0;
	this.opacity = 0;
	this.imgArr =[];
	this.titArr = [];
	this.dotArr = [];
	this.imgDotArr = [];
    if (!uedFoucs.childs) {
        uedFoucs.childs = []
    };
    this.ID = uedFoucs.childs.length;
    uedFoucs.childs.push(this);
	this.init = function(){
	    this.total = this.Content.length;
		this.imgShowDiv = uedCommon.fn.getEbyId(this.imgShowId);
	    this.titShowDiv = uedCommon.fn.getEbyId(this.titShowId);
	    this.dotShowDiv = uedCommon.fn.getEbyId(this.dotShowId);
		this.arrLeftObj = uedCommon.fn.getEbyId(this.arrLeftId);
	    this.arrRightObj = uedCommon.fn.getEbyId(this.arrRightId);
		for(i=0;i < this.total;i++){
			if(i==0){
				this.imgCurr = ' class="'+this.curOnclass.imgC+'"';
				this.titCurr = ' class="'+this.curOnclass.titC+'"';
				this.dotCurr = ' class="'+this.curOnclass.dotC+'"';
			}else{
				this.imgCurr = this.titCurr = this.dotCurr = '';
			}
			if(this.Content[i].img1 != '' && this.Content[i].img1 && this.imgShowDiv){
			  this.imgArr[i] = '<a href="'+this.Content[i].slink+'"'+this.imgCurr+' target="_blank"><img src="'+this.Content[i].img1+'" /></a>';
			  this.imgShowDiv.innerHTML += this.imgArr[i];
			}else{
			  this.imgArr[i] = "<a style='display:none'></a>";
			  this.imgShowDiv.innerHTML += this.imgArr[i];
			}
			if(this.Content[i].title != '' && this.Content[i].title && this.titShowDiv){
			  this.titArr[i] = '<a href="'+this.Content[i].slink+'"'+this.titCurr+' target="_blank">'+this.Content[i].title+'</a>';
			  this.titShowDiv.innerHTML += this.titArr[i];
			}else{
			  this.titArr[i] = "<a style='display:none'></a>";
			  this.titShowDiv.innerHTML += this.titArr[i];
			}
			if(this.Content[i].img2 != '' && this.Content[i].img2 && this.dotShowDiv){
				this.imgDotArr[i] = '<img src="'+this.Content[i].img2+'" />';
			}else{
				this.imgDotArr[i] = '';
			};
			if(this.dotShowDiv){
				this.dotArr[i] = '<a href="javascript:void(0)" hidefocus="true"'+this.dotCurr+' target="_self"><i>'+(i+1)+'</i>'+this.imgDotArr[i]+'</a>';
			    this.dotShowDiv.innerHTML += this.dotArr[i];
			}else{
				this.dotArr[i] = '<a style="display:none"></a>';
			    this.dotShowDiv.innerHTML += this.dotArr[i];
			};
		};
		uedCommon.fn.addEvent(this.imgShowDiv.parentNode, "mouseover", Function("uedFoucs.childs[" + this.ID + "].clearAuto()"));
		uedCommon.fn.addEvent(this.imgShowDiv.parentNode, "mouseout", Function("uedFoucs.childs[" + this.ID + "].autoPlays()"));
		for(i=0;i < this.total;i++){
		  uedCommon.fn.addEvent(this.dotShowDiv.getElementsByTagName("a")[i], this.onEvents, Function("uedFoucs.childs[" + this.ID + "].clickGo("+i+")"));
		}
		if(this.arrLeftObj){
		  uedCommon.fn.addEvent(this.arrLeftObj, "click", Function("uedFoucs.childs[" + this.ID + "].goPrev()"));
		}
		if(this.arrRightObj){
		  uedCommon.fn.addEvent(this.arrRightObj, "click", Function("uedFoucs.childs[" + this.ID + "].goNext()"));
		}
		if(this.isAuto){
			this.autoPlays();
		};
		this.imgArr = this.titArr = this.dotArr =this.imgCurr=this.titCurr=this.dotCurr= this.imgDotArr = null;
	};
	this.clickGo = function(n){
		for(i=0;i < this.total;i++){
			if(this.dotShowDiv.getElementsByTagName("a")[i] == this.dotShowDiv.getElementsByTagName("a")[n]){
			    if(this.onEffect){
				  this.showEffect();
				}
				this.imgShowDiv.getElementsByTagName("a")[i].className = this.curOnclass.imgC;
				this.titShowDiv.getElementsByTagName("a")[i].className = this.curOnclass.titC;
				this.dotShowDiv.getElementsByTagName("a")[i].className = this.curOnclass.dotC;
				this.currentIndex = i;
			}else{
				this.imgShowDiv.getElementsByTagName("a")[i].className = "";
				this.titShowDiv.getElementsByTagName("a")[i].className = "";
				this.dotShowDiv.getElementsByTagName("a")[i].className = "";
			}
		}
	};
	this.goPrev = function(){
		if(this.currentIndex > 0){
			this.currentIndex --;
		}else{
			this.currentIndex = this.total - 1;
		}
		this.clickGo(this.currentIndex);
	};
	this.goNext = function(){
		if(this.currentIndex < this.total-1){
			this.currentIndex ++;
		}else{
			this.currentIndex = 0;
		}
		this.clickGo(this.currentIndex);
	};
	this.showEffect = function(){
	if(this.opacity < 100){
	  this.opacity += 10;
	  this.imgShowDiv.style.filter = "alpha(opacity:"+this.opacity+")";
	  this.imgShowDiv.style.opacity = this.opacity / 100;
	  this.effectId = setTimeout('uedFoucs.childs[' + this.ID + '].showEffect()',50);
	}else{
	  clearTimeout(this.effectId);
	  this.opacity = 0;
	};
	};
	this.autoPlays = function(){
		if(this.isAuto){
			this.autoId = setInterval('uedFoucs.childs[' + this.ID + '].goNext()',this.autoInt*1000)
		}
	};
	this.clearAuto = function(){
		clearInterval(this.autoId);
	};
	
}/*  |xGv00|21d0d59313944f1175d411e76f7878ea */