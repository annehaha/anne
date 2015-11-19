if(typeof(loadJS)=="undefined"){
	function loadJS(url, callback) {					
		var script = document.createElement('script');
		script.src = url;
		if (callback) {
			if (window.ActiveXObject) {
				script.onreadystatechange = function() {
					var rs = this.readyState;
					if ("loaded" === rs || "complete" === rs) {
						callback();
					}
				};
			} else {
				script.onload = callback;
			}
		}
		document.getElementsByTagName('head')[0].appendChild(script);
	};
}
function iCast_Play_1604() {
    if (mutex_lock() == -1) {
       setTimeout(iCast_Play_1604, 100);
    } else {
        iCast_Start_Enabled_1604 = true;
    }
}
if (typeof mutex_lock != "undefined") {
    iCast_Start_Enabled_1604 = false;
    iCast_Play_1604();
}
if(typeof(track_pool)=="undefined")window.track_pool=[];
(track_pool[track_pool.length]=new Image()).src='http://kw.ra.icast.cn/?pid=1604&aid=32987&cid=14846&keyword=$run:keyword1$&weight=$run:weight$&cd=1&category=$run:category$&'+Math.random();
window._iCast_Controller_init={'ad_apc':2,'ad_interval':0,'ad_life':24,'download_path':'http://adsrich.qq.com/icast/1282877/','m_name':'1.swf','m_w':400,'m_h':300,'m_rftype':14,'m_rfarea':5,'m_rfselfarea':5,'m_rfobj':'','m_xpos':0,'m_ypos':0,'m_clicktrack':'','m_volumn':0,'m_wmode':'transparent','m_zindex':2147483647,'m_closebehavior':'close','f_name':'2.swf','f_w':20,'f_h':100,'f_rftype':14,'f_rfarea':9,'f_rfselfarea':9,'f_rfobj':'','f_xpos':0,'f_ypos':0,'f_clicktrack':'','f_clickurl':'','f_wmode':'transparent','f_zindex':2147483646,'m_startcmd':'mutex_lock();','m_endcmd':'mutex_unlock();','ad_startcmd':'mutex_lock();','ad_endcmd':'','ad_showbtn':0,'top_gap':315,'top_gap_f':0,'c_name':'','c_x':0,'c_y':0,'set_replay_track':1,'f_l_name':'','f_l_w':0,'f_l_h':0,'f_l_rftype':14,'f_l_rfarea':7,'f_l_rfselfarea':7,'f_l_rfobj':'','f_l_xpos':0,'f_l_ypos':0,'f_l_clickurl':'','f_l_clicktrack':'','ad_volctrl':0,'m_timelimit':0,'ad_id':'32987','creative_id':'14846','pos_id':'1604','um_act':'','clk_url':'http://c.l.qq.com/lclick?oid=1282877&loc=Lady_RM1','um_imp':'http://us.bs.serving-sys.com/BurstingPipe/adServer.bs?cn=tf&c=19&mc=imp&pli=3603189&PluID=0&ord=[timestamp]&rtu=-1','um_clk':'','track_url':'http://track.ra.icast.cn/icast/?keyword=&cid=14846&r=[rnd]&','sm_imp':'http://post.ra.icast.cn/t/?c=14846&a=32987&t=imp&p=1604&imp=1&r=[rnd]','sm_clk':'http://post.ra.icast.cn/t/?c=14846&a=32987&t=clk&p=1604&clk=1&r=[rnd]','sm_act':''};
loadJS("http://adsrich.qq.com/icast/1282877/icast_qq.js" ,function(){_iCastAdsl(_iCast_Controller_init);});