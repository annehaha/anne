package chenbo.LLK;

import java.io.File;
import java.io.IOException;
import chenbo.LLK.R;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.app.ListActivity;
import android.app.PendingIntent;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.Intent;
import android.os.Bundle;
import android.telephony.SmsManager;
import android.text.InputType;
import android.view.KeyEvent;
import android.view.View;
import android.view.animation.AnimationSet;
import android.view.animation.AnimationUtils;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;
/**
* 游戏设置的Activity
* 
*/ 
public class SetGameActivity extends ListActivity{
	private String[] items;
	private boolean music = DataSet.music;
	private int count = DataSet.count;
	private int style = DataSet.style;
	private boolean vibrator = DataSet.vibrator;
	
	private EditText text;
	private SmsManager smsManager;
	private String[] users;
	private UserData data = new UserData();
	private Configuration config = new Configuration();
	
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.menu);
		setList();
	}
	
	private void setList(){
		items = getResources().getStringArray(R.array.menu);
		ArrayAdapter<String> itemList = 
			new ArrayAdapter<String>(SetGameActivity.this,R.layout.menu_row, items);
		setListAdapter(itemList);
		AnimationSet animation = (AnimationSet) AnimationUtils.loadAnimation(this, R.anim.list);
		getListView().startAnimation(animation);
		
	}
	
	@Override
	protected void onListItemClick(ListView l, View v, int position, long id) {
		super.onListItemClick(l, v, position, id);
		switch (position) {
		//打开音乐选项
		case 0:
			int i = music == true ? 0 : 1;
			new AlertDialog.Builder(SetGameActivity.this).setIcon(R.drawable.p2).setTitle(R.string.music).setSingleChoiceItems(
					R.array.musicItem, i,
					new DialogInterface.OnClickListener() {
						
						public void onClick(DialogInterface dialog, int which) {
							if(which==0){
								music = true;
							}else music=false;
							System.out.println(music);
							dialog.dismiss();
						}
					}).setNegativeButton(R.string.cancel_btn, null).show();
			break;
		case 1:
			int s = vibrator == true ? 0 : 1;
			new AlertDialog.Builder(SetGameActivity.this).setIcon(R.drawable.p2).setTitle(R.string.vibrator).setSingleChoiceItems(
					R.array.vibratorItem, s,
					new DialogInterface.OnClickListener() {
						public void onClick(DialogInterface dialog, int which) {
							if(which==0){
								vibrator = true;
							}else vibrator=false;
							dialog.dismiss();
						}
					}).setNegativeButton(R.string.cancel_btn, null).show();
			break;
		//打开关卡选项
		case 2:
			new AlertDialog.Builder(SetGameActivity.this).setIcon(R.drawable.p2).setTitle(R.string.count).setSingleChoiceItems(
					R.array.countItem, count-1,
					new DialogInterface.OnClickListener() {
						
						public void onClick(DialogInterface dialog, int which) {
							count = which + 1;
							dialog.dismiss();
						}
					}).setNegativeButton(R.string.cancel_btn, null).show();
			break;
		//打开风格选项
		case 3:
			new AlertDialog.Builder(SetGameActivity.this).setIcon(R.drawable.p2).setTitle(R.string.style).setSingleChoiceItems(
					R.array.styleItem, style - 1,
					new DialogInterface.OnClickListener() {
						public void onClick(DialogInterface dialog, int which) {
							style = which + 1;
							dialog.dismiss();
						}
					}).setNegativeButton(R.string.cancel_btn, null).show();
			break;
		//恢复默认选项
		case 4:
			Builder builder0 = MyControl.showAlert(R.string.recovery_title, R.string.recovery_msg, R.drawable.p24, SetGameActivity.this);
			AlertDialog alert0 = builder0.setNegativeButton(R.string.cancel_btn, new OnClickListener() {
						public void onClick(DialogInterface arg0,int arg1) {
						}
					}).setPositiveButton(R.string.ok_btn,new OnClickListener() {
						public void onClick(DialogInterface arg0,int arg1) {
							count = 1;
							music = false;
							style = 1;
							save();
							MyControl.showDialog(R.string.recovery_ok, 2000, 0, SetGameActivity.this);
						}
					}).create();
			alert0.show();
			break;
		
		  //显示最高分
			case 5:
				data = config.load();
				MyControl.showDialog("姓名：" +data.getName()+ "\n得分：" + data.getHiScore()+
						"\n时间：" + data.getDate(), 10000 , 1, getApplicationContext());
				break;
			//删除排行信息
			case 6:
				Builder builder= MyControl.showAlert(R.string.del_title, R.string.del_msg, R.drawable.p20, SetGameActivity.this);
				AlertDialog alert = builder.setNegativeButton(R.string.cancel_btn, new OnClickListener() {
							public void onClick(DialogInterface arg0,int arg1) {
							}
						}).setPositiveButton(R.string.ok_btn,new OnClickListener() {
							public void onClick(DialogInterface arg0,int arg1) {
								File file = new File("/sdcard/llk.dat");
								file.delete();
								MyControl.showDialog(R.string.del_ok, 1000, 1, SetGameActivity.this);
							}
						}).create();
				alert.show();
				break;
			//分享给好友
			case 7:
				text = new EditText(getApplicationContext());
				text.setInputType(InputType.TYPE_CLASS_PHONE);
				smsManager = SmsManager.getDefault();
				Configuration config = new Configuration();
				UserData data = config.load();
				//发送的消息内容
				final String message = getText(R.string.tofriend_notice).toString()+data.getHiScore()+"分！";
				Builder builder3 = MyControl.showAlert(R.string.tofriend_title, R.string.tofriend_msg, R.drawable.p5, SetGameActivity.this,text);
				AlertDialog alert3 = builder3.setPositiveButton(R.string.ok_btn,new OnClickListener() {
							public void onClick(DialogInterface arg0,int arg1) {
								users = text.getText().toString().split(" ");
								try{
								for(int i=0;i<users.length;i++){
									System.out.println(users[i]);
									PendingIntent pintent = PendingIntent.getBroadcast(SetGameActivity.this, 0, new Intent(), 0);
									smsManager.sendTextMessage(users[i], null,message, pintent, null);
								}
								MyControl.showDialog(R.string.tofriend_ok, 1000, 1, SetGameActivity.this);
								}catch (Exception e) {
									MyControl.showDialog(R.string.msg_error, 1000, 1, SetGameActivity.this);
								}
							}
						}).setNegativeButton(R.string.cancel_btn, new OnClickListener() {
							public void onClick(DialogInterface dialog, int which) {}
						}).create();
				alert3.show();
				break;
			//反馈给我们
			case 8:
				text = new EditText(getApplicationContext());
				text.setLines(5);
				smsManager = SmsManager.getDefault();
				Builder builder2 = MyControl.showAlert(R.string.tome_title, R.string.tome_msg, R.drawable.p2, SetGameActivity.this,text);
				AlertDialog alert2 = builder2.setPositiveButton(R.string.ok_btn,new OnClickListener() {
							public void onClick(DialogInterface arg0,int arg1) {
								try{
									PendingIntent pintent = PendingIntent.getBroadcast(SetGameActivity.this, 0, new Intent(), 0);
									smsManager.sendTextMessage("15260168797", null, text.getText().toString(), pintent, null);
									MyControl.showDialog(R.string.tome_ok, 1000, 1,SetGameActivity.this);
								}catch (Exception e) {
									MyControl.showDialog(R.string.msg_error, 1000, 1, SetGameActivity.this);
								}
							}
						}).setNegativeButton(R.string.cancel_btn, new OnClickListener() {
							public void onClick(DialogInterface dialog, int which) {}
						}).create();
				alert2.show();
				break;
		  //阅读游戏规则
			case 9:
				try {
					config = new Configuration();
					String msg = config.readFile(getAssets().open("rule"));
					Builder builder1 = MyControl.showAlert(R.string.ctrl_title, msg, R.drawable.p15, SetGameActivity.this);
					
					AlertDialog alert1 = builder1.setPositiveButton(R.string.ok_btn,new OnClickListener() {
								public void onClick(DialogInterface arg0,int arg1) {}
							}).create();
					alert1.show();
				} catch (IOException e) {
					e.printStackTrace();
				} 
				break;
		//保存退出
			case 10:
				Builder builder5 = MyControl.showAlert(R.string.exit_msg, R.string.exit_title, R.drawable.p24, SetGameActivity.this);
				AlertDialog alert5 = builder5.setNegativeButton(R.string.cancel_btn, new OnClickListener() {
							public void onClick(DialogInterface arg0,int arg1) {
							}
						}).setPositiveButton(R.string.ok_btn,new OnClickListener() {
							public void onClick(DialogInterface arg0,int arg1) {
								count = 1;
								music = false;
								style = 1;
								save();
								SetGameActivity.this.finish();
							}
						}).create();
				builder5.setNegativeButton(R.string.ok_btn, new OnClickListener()
				{

					public void onClick(DialogInterface dialog, int which) {
						SetGameActivity.this.finish();
					}
					
				});
				alert5.show();	
				
				break;
			default:
				break;
			}
		}
		
	
	//按下返回键时，提示是否保存退出
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		if(keyCode == KeyEvent.KEYCODE_BACK){
			Builder builder = MyControl.showAlert(R.string.save_title, R.string.save_msg, R.drawable.p10, SetGameActivity.this);
			AlertDialog alert = builder.setNegativeButton(R.string.cancel_btn, new OnClickListener() {
						public void onClick(DialogInterface arg0,int arg1) {
							finish();
						}
					}).setPositiveButton(R.string.ok_btn,new OnClickListener() {
						public void onClick(DialogInterface arg0,int arg1) {
							save();
							finish();
							MyControl.showDialog(R.string.save_ok, 1000, 0, SetGameActivity.this);
						}
					}).create();
			alert.show();
		}
		return super.onKeyDown(keyCode, event);
	}
	
	/**
	 * 保存游戏设置
	 */
	private void save(){
		DataSet.count = count;
		DataSet.music = music;
		DataSet.style = style;
		DataSet.vibrator = vibrator;
	}

}
