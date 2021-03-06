package chenbo.LLK;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import chenbo.LLK.R;
import android.content.Context;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Paint.Cap;
import android.graphics.Paint.Style;
import android.graphics.RectF;
import android.graphics.drawable.BitmapDrawable;
import android.media.MediaPlayer;
import android.util.AttributeSet;
import android.view.View;

public class GameView extends View {

	public static int ROW = 6;           //行数
	public static int COL = 6;           //列数
	public int iconWidth = 32;           //图标大小
	public int iconHeight = 32;
	public int picCount = 12;            //图标个数

	protected int[][] map,sign;          //记录每个位置的图标
	protected Bitmap[] icons = new Bitmap[picCount];

	protected int curX = 0, curY = 0, lastX = 0, lastY = 0; // 记录当前点击以及上次点击的位置
	protected float width;
	protected float height;
	protected boolean isLose;           //记录胜负
	protected boolean isWin;
	protected boolean isKeyDown;
	boolean isLine;
	protected int count= 1;
	public int score = 0;
	public int process_value = 1000;
	public int noticeCount = 0;
	private int style = DataSet.style;

	public List<Integer> type = new ArrayList<Integer>();

	chenbo.LLK.CtrlView.Point[] p;
	public int lineType = 0;
	public final int V_LINE = 1;
	public final int H_LINE = 1;
	public final int ONE_C_LINE = 2;
	public final int TWO_C_LINE = 3;
	public Resources r = this.getContext().getResources();
	//依据不同条件光标呈现不同特性
	Bitmap cursor1 = ((BitmapDrawable) r.getDrawable(R.drawable.cursor1)).getBitmap();
	Bitmap cursor2 = ((BitmapDrawable) r.getDrawable(R.drawable.cursor2)).getBitmap();
	Bitmap cursor3 = ((BitmapDrawable) r.getDrawable(R.drawable.cursor3)).getBitmap();
	Bitmap back = ((BitmapDrawable) r.getDrawable(R.drawable.logo)).getBitmap();
	int logo_x = -back.getWidth(),logo_y = 0 , logo_width = 0 , logo_height = 0;
	public MediaPlayer clickPlayer;
	public MediaPlayer okPlayer;
	public boolean musicOn = false;

	public int ishelped=1;
	
	public GameView(Context context, AttributeSet attr) {
		super(context, attr);
		okPlayer = MediaPlayer.create(context, R.raw.ok);
		clickPlayer = MediaPlayer.create(context, R.raw.select);
		loadIcons();
		randomIcons();
		this.setFocusable(true);
		this.setFocusableInTouchMode(true);
	}	

	@Override
	protected void onDraw(Canvas canvas) {
		logo_y = getHeight() / 2 - 60;              //设置背景云朵动画效果
		logo_width = back.getWidth();
		logo_height = back.getHeight();
		RectF rDst0 = new RectF(logo_x, logo_y, logo_x+logo_width ,logo_y+logo_height);
		canvas.drawBitmap(back, null, rDst0, null);
		isWin = true;
		for(int i = 1;i<ROW-1;i++){
			for(int j = 1;j<COL-1;j ++){
				if(map[i][j] != -1){
					isWin = false;
				}
			}
		}
		width = getWidth() / ROW;
		height = getHeight() / COL;
		if(style == 1){
			iconHeight = ((BitmapDrawable) r.getDrawable(R.drawable.p1)).getBitmap().getHeight();
			iconWidth = ((BitmapDrawable) r.getDrawable(R.drawable.p1)).getBitmap().getWidth();
		}else{
			iconHeight = ((BitmapDrawable) r.getDrawable(R.drawable.p21)).getBitmap().getHeight();
			iconWidth = ((BitmapDrawable) r.getDrawable(R.drawable.p21)).getBitmap().getWidth();
		}
		if(ishelped==0){
		for(int i=1;i<ROW-1;i++)
			for(int j=1;j<COL-1;j++)
			{
				if(sign[i][j]==1&&map[i][j]!=-1)
					{
					canvas.drawBitmap(cursor3, null, new RectF(j * width, i * height, j
						* width + iconWidth, i * height + iconHeight), null);

			}
	     }
		}
	    
		RectF rDst = null;
		for (int x = 0; x < ROW; x++) {
			for (int y = 0; y < COL; y++) {
				if (map[x][y] > -1) {
					if((curX == x && curY == y) || lastX == x && lastY == y){
						rDst = new RectF(x * width, y * height, x * width
								+ iconWidth + 3, y * height + iconHeight + 3);
					}else rDst = new RectF(x * width, y * height, x * width
							+ iconWidth, y * height + iconHeight);
					canvas.drawBitmap(icons[map[x][y]], null, rDst, null);
				}
			}
		}
		if (lastX < ROW && lastY < COL && curX < ROW && curY < COL) {
			RectF rDst1 = new RectF(curX * width, curY * height, curX
					* width + iconWidth, curY * height + iconHeight);
			RectF rDst2 = new RectF(lastX * width, lastY * height, lastX
					* width + iconWidth, lastY * height + iconHeight);
		
			if (map[curX][curY] != -1) {
				canvas.drawBitmap(cursor1, null, rDst1, null);
			}
			if(isKeyDown && map[lastX][lastY] != -1){
				canvas.drawBitmap(cursor2, null, rDst2, null);
			}
		}
	
		drawLine(canvas);	
		
		super.onDraw(canvas);
	}

	public void randomIcons() {
		int i = 0;
		sign=new int[ROW][COL];
		map = new int[ROW][COL];
		//所有边框的map全为-1
		for(int x=0;x<ROW;x++) {
			map[x][0]=-1;
			map[x][COL-1]=-1;
		}
		for(int y=0;y<COL;y++) {
			map[0][y]=-1;
			map[ROW-1][y]=-1;
		}
		//按顺序装在图片
		for (int x = 1; x < ROW-1; x += 1) {
			for (int y = 1; y < COL-1; y += 2) {
				map[x][y] = map[x][y + 1] = i++;
				if (i == picCount)
					i = 0;
			}
		}
		//随机打乱图片
		int tmpV, tmpX, tmpY;
		Random random = new Random();
		for (int y = 1; y < COL-1; y++) {
			for (int x = 1; x < ROW-1; x++) {
				tmpV = map[x][y];
				tmpX = random.nextInt(ROW-2)+1;
				tmpY = random.nextInt(COL-2)+1;
				map[x][y] = map[tmpX][tmpY];
				map[tmpX][tmpY] = tmpV;
			}
		}
		invalidate();
	}

	public void rearrange() {
		// Point[] p=null;
		List<Integer> temp = new ArrayList<Integer>();
		for (int i = 1; i < ROW-1; i++) {
			for (int j = 1; j < COL-1; j++) {
				if (map[i][j] != -1) {
					temp.add(map[i][j]);
				}
			}
		}
		type.clear();
		Random ad = new Random();
		for (int i = 0; i < temp.size(); i++) {
			type.add(temp.get(i));
		}
		temp.clear();
		temp = null;
		for (int i = 1; i < ROW-1; i++) {
			for (int j = 1; j < COL-1; j++) {
				if (map[i][j] != -1) {
					int index = ad.nextInt(type.size());
					map[i][j] = type.get(index);
					type.remove(index);
				}
			}
		}
		invalidate();
	}

	private void loadIcons() {
		for (int i = 0; i < picCount; i++) {
			icons[i] = ((BitmapDrawable) r.getDrawable(R.drawable.p1 + (12*(style - 1) + i))).getBitmap();
		}        //根据style加载图片
	}

	public void drawLine(Canvas canvas) {		
		if (isLine && !isWin && !isLose) {
			RectF rDst1 = new RectF(curX * width, curY * height, curX * width
					+ iconWidth, curY * height + iconHeight);
			RectF rDst2 = new RectF(lastX * width, lastY * height, lastX
					* width + iconWidth, lastY * height + iconHeight);
			
			canvas.drawBitmap(cursor1, null, rDst1, null);
			canvas.drawBitmap(cursor2, null, rDst2, null);
			
			Paint lineColor = new Paint(6);
			lineColor.setColor(Color.GREEN);
			lineColor.setStrokeWidth(2);
			lineColor.setStrokeCap(Cap.ROUND);
			lineColor.setStyle(Style.FILL_AND_STROKE);

			switch (lineType) {
			case V_LINE:
				canvas.drawLine(p[0].x * width + iconWidth / 2, p[0].y * height
						+ iconHeight / 2, p[1].x * width + iconWidth / 2, p[1].y
						* height + iconHeight / 2, lineColor);
				break;
			
			case ONE_C_LINE:
				canvas.drawLine(p[0].x * width + iconWidth / 2, p[0].y * height
						+ iconHeight / 2, p[1].x * width + iconWidth / 2, p[1].y
						* height + iconHeight / 2, lineColor);
				canvas.drawLine(p[1].x * width + iconWidth / 2, p[1].y * height
						+ iconHeight / 2, p[2].x * width + iconWidth / 2, p[2].y
						* height + iconHeight / 2, lineColor);
				break;
			case TWO_C_LINE:
				canvas.drawLine(p[0].x * width + iconWidth / 2, p[0].y * height
						+ iconHeight / 2, p[1].x * width + iconWidth / 2, p[1].y
						* height + iconHeight / 2, lineColor);
				canvas.drawLine(p[1].x * width + iconWidth / 2, p[1].y * height
						+ iconHeight / 2, p[2].x * width + iconWidth / 2, p[2].y
						* height + iconHeight / 2, lineColor);
				canvas.drawLine(p[3].x * width + iconWidth / 2, p[3].y * height
						+ iconHeight / 2, p[2].x * width + iconWidth / 2, p[2].y
						* height + iconHeight / 2, lineColor);
				break;
			default:
				break;

			}
		}
	}

}
