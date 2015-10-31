package chenbo.LLK;




import chenbo.LLK.R;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.view.animation.AnimationSet;
import android.view.animation.RotateAnimation;
import android.view.animation.ScaleAnimation;
import android.view.animation.Animation.AnimationListener;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ImageView;

public class LoadingActivity extends Activity implements AnimationListener{

	private ImageView me;
	private RotateAnimation rotate;
	private ScaleAnimation scale ;
	private AlphaAnimation alpha ;
	private	AnimationSet set;
	
	public void onAnimationEnd(Animation animation) {
		// TODO Auto-generated method stub
		Intent intent = new Intent();
		intent.setClass(this,WelcomeActivity.class);
		startActivity(intent);
		finish();
	}
	public void onAnimationRepeat(Animation animation) {
		// TODO Auto-generated method stub
		
	}

	public void onAnimationStart(Animation animation) {
		// TODO Auto-generated method stub
		
	}
	
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setFullScreen();
		setContentView(R.layout.loading);
		me = (ImageView) findViewById(R.id.me);
		rotate = new RotateAnimation(0, 720,
				Animation.RELATIVE_TO_SELF, 0.5f, Animation.RELATIVE_TO_SELF,
				0.5f);   //设置旋转
		scale = new ScaleAnimation(0.2f, 1.0f, 0.2f, 1.0f,
				Animation.RELATIVE_TO_SELF, 0.5f, Animation.RELATIVE_TO_SELF,
				0.5f);   //设置大小变化
		
	   alpha = new AlphaAnimation(0.2f, 1.0f);	  //设置透明度变化
		set = new AnimationSet(true);	
		set.setAnimationListener(this);
		set.addAnimation(rotate);
		set.addAnimation(scale);
		set.addAnimation(alpha);
		set.setDuration(4000);
		me.setAnimation(set);
		set.startNow();     //开启动画
	
	}
	
	//设置全屏
		public void setFullScreen() {
			requestWindowFeature(Window.FEATURE_NO_TITLE);
			getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
					WindowManager.LayoutParams.FLAG_FULLSCREEN);
		}
		/**
		 * 获得屏幕宽
		 * 
		 * @return int 宽
		 */
		protected int getScreenWidth() {
			DisplayMetrics dm = new DisplayMetrics();
			getWindowManager().getDefaultDisplay().getMetrics(dm);
			return dm.widthPixels;
		}

		/**
		 * 获得屏幕高
		 * 
		 * @return int 高
		 */
		protected int getScreenHeight() {
			DisplayMetrics dm = new DisplayMetrics();
			getWindowManager().getDefaultDisplay().getMetrics(dm);
			return dm.heightPixels;
		}
	
	
}
