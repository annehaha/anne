package chenbo.LLK;

import java.util.Date;
import java.util.Random;

import chenbo.LLK.R;






import android.app.Activity;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.Typeface;
import android.graphics.drawable.BitmapDrawable;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Vibrator;
import android.view.KeyEvent;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ProgressBar;
import android.widget.TextView;


public class LLKanActivity extends Activity {
	private ProgressBar pb;        //������
	private CtrlView cv;           //����Ϸ�ؼ�
	private TextView msg;          //��¼����
    private ImageButton addtime;   //��ʱ����
    private ImageButton change;    //���ŵ���
	private ImageButton help;      //��������
	private EditText text;         //������߷�
	
	private boolean isRun = true;  //��Ϸ�Ƿ�����
	private Intent mediaServiceIntent;
	private RefreshHandler mRedrawHandler;
	Animation animation;
	private UserData data = new UserData();//��߷ּ�¼
	private Configuration config = new Configuration();
	public static final int MAX_VALUE = 1000; // ���ý��������ֵ
	public Resources r;
	Bitmap help2,addtime2,change2;            
	int taddtime=0,tchangetime=0,thelptime=0; //ʹ��һ��
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		super.requestWindowFeature(Window.FEATURE_NO_TITLE);   
		super.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);   
		super.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
		setContentView(R.layout.main);
		mRedrawHandler = new RefreshHandler();
		mediaServiceIntent= new Intent();
		mediaServiceIntent.setClass(this, MediaService.class);	
		r = this.getBaseContext().getResources();
	    help2 = ((BitmapDrawable) r.getDrawable(R.drawable.help2)).getBitmap();
	    addtime2=((BitmapDrawable) r.getDrawable(R.drawable.addtime2)).getBitmap();
	    change2=((BitmapDrawable) r.getDrawable(R.drawable.change2)).getBitmap();
		setViews();		
		mRedrawHandler.sleep(200);
		data = config.load();
		
	}

	// ��ʼ���ؼ�
	private void setViews() {
		cv = (CtrlView) findViewById(R.id.cv);
		cv.initGame();
		cv.invalidate();
		pb = (ProgressBar) findViewById(R.id.pb);	
		msg = (TextView) findViewById(R.id.msg);
		addtime = (ImageButton)findViewById(R.id.addtime);
		change = (ImageButton)findViewById(R.id.change);
		help = (ImageButton)findViewById(R.id.help);
	    cv.randomIcons();
		pb.setMax(MAX_VALUE- ((cv.count - 1) * 125)<=0?100:MAX_VALUE- ((cv.count - 1) * 125));
		pb.setProgress(pb.getMax());
		/*
		 * �������� ���������ļ�fonts/lcd2mono.ttf
		 */
		Typeface lcdFont = Typeface.createFromAsset(getAssets(),"fonts/MINYN.TTF");
		msg.setTypeface(lcdFont);
		cv.musicOn = DataSet.music;
		if (cv.musicOn) {
			this.startService(mediaServiceIntent);
		}
		/**
		 * �����ʱ��ť������ʱ��
		 */
		addtime.setOnClickListener(new Button.OnClickListener() {
			public void onClick(View v) {
				if(taddtime==0)
				{
				cv.process_value += 5 * (4 + cv.count/2);
				addtime.setImageBitmap(addtime2);
				taddtime=1;
				}
				else
				{
					new AlertDialog.Builder(LLKanActivity.this).setIcon(R.drawable.p7).setTitle(R.string.error).setMessage(R.string.unable).setPositiveButton("ȷ��",
							new DialogInterface.OnClickListener() {
					
								public void onClick(DialogInterface dialog, int which) {
									dialog.dismiss();
								}
							}).create().show();
				}
			}
		});
		/**
		 * ������Ű�ť����������
		 */
		change.setOnClickListener(new Button.OnClickListener() {
			public void onClick(View v) {
				if(tchangetime==0)
				{
				cv.process_value -= 5 * (4 + cv.count/2);
				cv.rearrange();
				//�����к���Ϊ���֣����������
				while(cv.isDead()){
					cv.rearrange();
					MyControl.showDialog(R.string.isDeadNotice, 500, 1,getApplicationContext());
					cv.process_value += 10;
				}
				change.setImageBitmap(change2);
				tchangetime=1;
				}
				else
				{
					new AlertDialog.Builder(LLKanActivity.this).setIcon(R.drawable.p7).setTitle(R.string.error).setMessage(R.string.unable).setPositiveButton("ȷ��",
							new DialogInterface.OnClickListener() {
					
								public void onClick(DialogInterface dialog, int which) {
									dialog.dismiss();
								}
							}).create().show();
				}
			}
		});
		
		/**
		 * ���������ť��������ʾ
		 */
		help.setOnClickListener(new Button.OnClickListener() {
			public void onClick(View v) {
				if(thelptime==0)
				{	
				help.setImageBitmap(help2);
				cv.help();
				thelptime=1;
				}
				else
				{
					new AlertDialog.Builder(LLKanActivity.this).setIcon(R.drawable.p7).setTitle(R.string.error).setMessage(R.string.unable).setPositiveButton("ȷ��",
							new DialogInterface.OnClickListener() {
					
								public void onClick(DialogInterface dialog, int which) {
									dialog.dismiss();
								}
							}).create().show();
				}
			}
		});
	}
	
	// ��Ϸ��ʱ
	class RefreshHandler extends Handler {
		@Override
		public void handleMessage(Message msg) {
			run();
		}

		public void sleep(long delayMillis) {
			this.removeMessages(0);// �Ƴ���Ϣ�������������Ϣ���Ӷ���ȡ����Ϣ��
			sendMessageDelayed(obtainMessage(0), delayMillis);// ��ö�����Ϣ����ʱ����
		}
	};
    //��ʼ��Ϸ
	private void run() {
		if (isRun) {
			if (pb.getProgress() > 0) {
				cv.logo_x=cv.logo_x<cv.getWidth()?cv.logo_x+5:-cv.getWidth();
				cv.invalidate();
				cv.process_value -= 2;
				pb.setProgress(cv.process_value);
				msg.setText("" + cv.score);
				if ((double)pb.getProgress()/(double)pb.getMax() < 0.25) {
					cv.noticeCount++;
					if(cv.noticeCount==1){
						animation = AnimationUtils.loadAnimation(this,R.anim.progress);
						animation.setRepeatCount(3);
						if(DataSet.vibrator){
							new Thread(){
								public void run() {
									Vibrator vibrator = (Vibrator) getSystemService(VIBRATOR_SERVICE);   
									long[] pattern = {300, 400, 300, 400,300,400}; // OFF/ON/OFF/ON...   
									vibrator.vibrate(pattern, 3);
									try {
										Thread.sleep(2100);
									} catch (InterruptedException e) {}
									vibrator.cancel();
								}
							}.start();
						}
						pb.setAnimation(animation);
						Random r = new Random();
						int i = r.nextInt(10);
						if (i > 6) {
							String notime_msg = getText(R.string.notime_msg).toString()
									+ "\n" + "��˵����Ʒ�ã������" + i * 10 + "��ʱ�䣡";
							cv.process_value += i * 11;
							MyControl.showDialog(notime_msg, 1000, 1,getApplicationContext());
						}
					}
				}
			}

			if (pb.getProgress() <= 0) {
				if(DataSet.vibrator){
					new Thread(){
						public void run() {
							Vibrator vibrator = (Vibrator) getSystemService(VIBRATOR_SERVICE);   
							long[] pattern = {0, 2000}; // OFF/ON/OFF/ON...   
							vibrator.vibrate(pattern, 1);
							try {
								Thread.sleep(2000);
							} catch (InterruptedException e) {}
							vibrator.cancel();
						}
					}.start();
				}
				text = new EditText(LLKanActivity.this);
				//������а�Ϊ�ջ��ߵ÷ֳ�����¼��߷֣�����
				if (data.getHiScore() == null|| Integer.parseInt(msg.getText().toString().trim()) > Integer.parseInt(data.getHiScore().trim())) {
					isRun = false;
					Builder builder = MyControl.showAlert(R.string.victory_title, R.string.victory_msg, R.drawable.p10, LLKanActivity.this,text);
					AlertDialog alert = builder.setPositiveButton(
							R.string.ok_btn, new OnClickListener() {
								public void onClick(DialogInterface dialog,int which) {
									data.setName(text.getText().toString());
									data.setDate(new Date().toLocaleString());
									data.setHiScore(msg.getText().toString());
									config.save(data);
									isRun = true;
									finish();
								}
							}).create();
					alert.show();
				} else {
					String message = getText(R.string.overnotice).toString()+msg.getText().toString()+"�֣�";
					MyControl.showDialog(message, 3000, 1,getApplicationContext());
					finish();
				}
			} else if (cv.process_value != 0 && cv.isWin) {
				if(DataSet.vibrator){
					new Thread(){
						public void run() {
							Vibrator vibrator = (Vibrator) getSystemService(VIBRATOR_SERVICE);   
							long[] pattern = {0, 800, 400, 500}; // OFF/ON/OFF/ON...   
							vibrator.vibrate(pattern, 2);
							try {
								Thread.sleep(2000);
							} catch (InterruptedException e) {}
							vibrator.cancel();
						}
					}.start();
				}
				cv.score += (cv.process_value * cv.count / 5);
				cv.count++;
				if(cv.count >= 9) pb.setMax(100);
				else pb.setMax(MAX_VALUE - ((cv.count - 1) * 125));
				pb.setProgress(pb.getMax());
				cv.initGame();
				String message = getText(R.string.next).toString()+cv.count+"�أ�";
				MyControl.showDialog(message, 1000, 1,LLKanActivity.this);
				cv.process_value += 10;
			}
		}
		mRedrawHandler.sleep(200);
	}
	
	
	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		if(keyCode == KeyEvent.KEYCODE_BACK){
			isRun = false;
			Builder builder = MyControl.showAlert(R.string.exit_title, R.string.exit_msg, R.drawable.p10, LLKanActivity.this);
			AlertDialog alert = builder.setNegativeButton(R.string.cancel_btn, new OnClickListener() {
						public void onClick(DialogInterface arg0,int arg1) {
							isRun = true;
						}
					}).setPositiveButton(R.string.ok_btn,new OnClickListener() {
						public void onClick(DialogInterface arg0,int arg1) {
							finish();
						}
					}).create();
			alert.show();
		}
		return super.onKeyDown(keyCode, event);
	}
	

	@Override
	protected void onPause() {
		isRun = false;
		super.onPause();
	}
	
	@Override
	protected void onStart() {
		isRun = true;
		super.onStart();
	}
	
	@Override
	protected void onResume() {
		isRun = true;
		super.onResume();
	}
	
	@Override
	protected void onDestroy() {
		this.stopService(mediaServiceIntent);
		super.onDestroy();
	}
	
	@Override
	public void finish() {
		this.stopService(mediaServiceIntent);
		onStop();
		super.finish();
	}
	
	//��ͣ��Ϸ
	@Override
	protected void onStop() {
		isRun = false;
		super.onStop();
	}
	
}