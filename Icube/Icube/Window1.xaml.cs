using System;
using System.Collections;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Media.Media3D;
using Microsoft.Win32;
using System.Xml;
using System.IO;
using Microsoft.DirectX;
using Microsoft.DirectX.AudioVideoPlayback;
using PlayerInformation;
using System.Collections.Generic;
using System.Drawing;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Windows.Controls.Primitives;
using System.Runtime.InteropServices;
using MyCube;//录音


namespace MojaKocka
{
    public partial class Window1 : Window
    {
        #region 定义变量
        private ArrayList userList = new ArrayList();
        System.Windows.Threading.DispatcherTimer clock = new System.Windows.Threading.DispatcherTimer();
        System.Windows.Threading.DispatcherTimer mediaClock = new System.Windows.Threading.DispatcherTimer();
        private bool login = false;

        public enum PlayMode { Single, SingleCycle, Order, Cycle, Random };
        private PlayMode m_currentPlayMode = PlayMode.Order; // 播放模式
        private string m_strFilePath;  // 媒体文件路径
        private string m_title;  // 播放媒体文件名称
        private bool m_blnAutoMove = true; // 自动播放标记
        private bool m_blnNewPlay = true;  // 开始一次新的播放
        private int des_Angle = 0;//目标角度
        private int current_Angle = 0;//记录当前角度
        private bool if_play = true;//记录播放状态
        private double vol = 1;//记录音量

        //播放列表中的变量
        private int m_incrementId = 0;
        private int m_lastPlayIndex = -1;
        private int m_currentPlayIndex = -1;
        mFileInfo deleteFile = null;
        ObservableCollection<mFileInfo> updates = new ObservableCollection<mFileInfo>();
        private Dictionary<int, mFileInfo> m_mediaFileTable=new Dictionary<int,mFileInfo>();

        //录音中变量
        private SoundRecord recorder = null;
        private string wavfile = null;
        private bool ifRecording = false;
        private bool ifRecordPlay = false;
        #endregion

        #region 调用函数

        #region 窗体
        public Window1()
        {
            //user list
            userList.Add(new User("c#大作业", "Icube", "软件竞赛作业"));
            userList.Add(new User("赵晓韵", "沈锦如", "周毓哲"));
            userList.Add(new User("郑贵文", "陈庆鹏", "周汉龙"));
            InitializeComponent();
            //将用户列表绑定到listview中
           System.Windows.Data.Binding bind = new System.Windows.Data.Binding();
          
           lsvPlayList.ItemsSource = updates;
           bind.Source = updates;
            lsvPlayList.SetBinding(ListView.ItemsSourceProperty, bind);
       
            this.Loaded += new RoutedEventHandler(Window1_Loaded);
            this.MouseWheel += new MouseWheelEventHandler(Global_MouseWheel);

            //录音
            recorder = new SoundRecord();
            wavfile = "test.wav";
        }
        
        void Window1_Loaded(object sender, RoutedEventArgs e)
        {
           
            //旋转时钟
            clock.Tick += new EventHandler(clock_Tick);
            clock.Interval = new TimeSpan(0,0,0,0,1);
            //mediaPlayer 时钟
            mediaClock.Tick += new EventHandler(mediaClock_Tick);
            mediaClock.Interval = new TimeSpan(0,0,0,0,1);
            button_ifenable(false);         
        }
 #endregion

        #region 多媒体操作
        void mediaClock_Tick(object sender, EventArgs e)
        {
            PositionSlider.Value+=100;
            mediaPlayer.ToolTip = TimeSpan.FromMilliseconds(PositionSlider.Value);
            //在此时间间隔中显示当前播放媒体的当前时间
            nowPlaying.Content = string.Format(GetMediaTimeLen((int)mediaPlayer.Position.TotalSeconds) + " - " + GetMediaTimeLen((int)PositionSlider.Maximum / 1000));
        } 
        //得到当前播放的时间
        string GetMediaTimeLen(int Len)  
        {
            int Hour;
            int Min;
            int Sec;
            string Re = "";
            Hour = Len / 3600;
            Len = Len - Hour * 3600;
            Min = Len / 60;
            Len = Len - Min * 60;
            Sec = Len;
            Re = string.Format("{0:D2}:{1:D2}:{2:D2}", Hour, Min, Sec);
            return Re;
        }
        //将一个媒体对象同mediaPlayer对象关联并播放
        void AddResourceToMediaPlayer(string Name)
        {
            if (mediaPlayer.Source != null)
            {
                mediaPlayer.Close();
                PositionSlider.Value = 0;
            }
            mediaPlayer.Source = new Uri(Name, UriKind.Absolute);
            mediaElement1.Source = new Uri(Name, UriKind.Absolute);
            System.IO.FileInfo fileInfo = new System.IO.FileInfo(Name);
            mediaPlayer.Play();
            mediaElement1.Play();
            mediaElement1.IsMuted = true;
            mediaElement1.Visibility = Visibility.Hidden;
            mediaClock.Start();         
           Playing.Content =fileInfo.Name.Substring(0, (fileInfo.Name.Length - fileInfo.Extension.Length));
        }
        //按键可否操作       
        private void button_ifenable(bool b)
        {
            playBtn.IsEnabled = b;
            stopBtn.IsEnabled = b;
            screenShotBtn.IsEnabled = b;
            volumeBtn.IsEnabled = b;
            VolSlider.IsEnabled = b;
            PositionSlider.IsEnabled = b;
        }
        //暂停或开始播放
        private void ppfuc()
        {
            if (!if_play)
            {
                 mediaClock.Start();
                 mediaPlayer.Play();
                 mediaElement1.Play();
                 if_play = true;
                 playBtn.Content = "||";
                 playBtn.ToolTip = "Pause";
            }
            else
            {
                 mediaClock.Stop();
                 mediaPlayer.Pause();
                 mediaElement1.Pause();
                 if_play = false;
                 playBtn.Content = "▶";
                 playBtn.ToolTip = "Play";
            }
        }
        #endregion

        #region 播放列表操作
        private void AddOpenFiles()
        {
            OpenFileDialog openFileDlg = new OpenFileDialog();

            openFileDlg.Title = "请选择文件...";
            openFileDlg.Multiselect = true;
            openFileDlg.Filter = "常见音乐文件(*.*)|*.wma;*.mp3;*.wav;*.ogg" + "|常见媒体文件(*.*)|*.rmvb;*avi;*mp4"; 
            if (true == openFileDlg.ShowDialog())
            {
                string[] fileNames = openFileDlg.FileNames;
                if (fileNames != null)
                {
                    this.InitFileInfoandPlay(fileNames);
                    button_ifenable(true);
                }
            }
        }      
        // 打开文件夹
        private void AddOpenFolder()
        {
            System.Windows.Forms.FolderBrowserDialog folderBrowserDlg = new System.Windows.Forms.FolderBrowserDialog();
            folderBrowserDlg.Description = "请选择一个文件夹：";
            folderBrowserDlg.ShowNewFolderButton = false;

            if (System.Windows.Forms.DialogResult.OK == folderBrowserDlg.ShowDialog())
            {
                string folderName = folderBrowserDlg.SelectedPath;
                string[] fileNames = System.IO.Directory.GetFiles(folderName, "*.mp3");           
                if (fileNames != null && fileNames.Length > 0)
                {
                    InitFileInfoandPlay(fileNames);
                }
                else
                {
                    MessageBox.Show("所选文件夹下没有可供播放的文件！", "信息提示", MessageBoxButton.OK);
                }
            }
        }
        private void InitFileInfoandPlay(string[] fileNames)
        {
            int instant =m_incrementId+1;
            foreach (string fileName in fileNames)
            {   
                m_incrementId++;
                mFileInfo aFileInfo = new mFileInfo();
                FileInfo fi = new System.IO.FileInfo(fileName);
                aFileInfo.ID = m_incrementId;
                aFileInfo.Title = Util.GetFileName(fi.Name);
                aFileInfo.Size = Util.GetSizeInfo(fi.Length);
                aFileInfo.Path = fileName;            
                this.AddToMediaPlayList(aFileInfo);
                
            }
            
            {
                m_lastPlayIndex = m_currentPlayIndex = instant;
                Play();
            }
        }
        // 添加文件到播放列表
        private void AddToMediaPlayList(mFileInfo afileInfo)
        {
            updates.Add(afileInfo);
            lsvPlayList.ItemsSource =updates;
        }
     private void Play()
      {
          if (m_blnNewPlay)  // 开始一次新的播放
          {
              mFileInfo aFileInfo = null;
              aFileInfo = updates[m_currentPlayIndex-1];
              if (aFileInfo != null)
              {
                  m_strFilePath = aFileInfo.Path;
                  Playing.Content = aFileInfo.Title;
                  m_title = aFileInfo.Title;
                  m_lastPlayIndex = m_currentPlayIndex;
              }
              if (mediaPlayer.Source != null)
              {
                  mediaPlayer.Close();
                  PositionSlider.Value = 0;

              }
          System.IO.FileInfo fileInfo = new System.IO.FileInfo(aFileInfo.Path);          
          mediaPlayer.Source = new Uri(aFileInfo.Path, UriKind.Absolute);
          if (mediaPlayer.Source != null) mediaClock.Start();
          if (mediaPlayer.Source != null) mediaPlayer.Play();
          Playing.Content = aFileInfo.Title;
          }
      }
      private void Next()
      {
          switch (m_currentPlayMode)
          {
              case PlayMode.Single:  // 单曲播放
                  if (m_blnAutoMove)
                  {
                      mediaPlayer.Stop();
                      mediaClock.Stop();
                      PositionSlider.Value = 0;
                      m_currentPlayIndex = 0;
                  }                
                  break;
              case PlayMode.SingleCycle:  // 单曲循环
                  if (m_blnAutoMove)
                  {
                      m_currentPlayIndex = m_lastPlayIndex;
                  }
                  break;
              case PlayMode.Order:  // 顺序播放
                  if (m_currentPlayIndex == lsvPlayList.Items.Count)
                  {
                      m_currentPlayIndex = 0; // 已移到最后面
                  }
                  else
                  {
                      m_currentPlayIndex++;
                  }
                  break;

              case PlayMode.Cycle:  // 循环播放
                  if (m_currentPlayIndex == lsvPlayList.Items.Count )
                  {
                      m_currentPlayIndex = 1;
                  }
                  else
                  {
                      m_currentPlayIndex++;
                  }
                  break;

              case PlayMode.Random:  // 随机播放
                  Random random = new Random();
                  m_currentPlayIndex = random.Next(lsvPlayList.Items.Count+1);
                  break;

              default:  // 默认顺序播放
                  if (m_currentPlayIndex == lsvPlayList.Items.Count)
                  {
                      m_currentPlayIndex = lsvPlayList.Items.Count; // 已移到最后面
                  }
                  else
                  {
                      m_currentPlayIndex += 1;
                  }
                  break;
          }
          if (m_currentPlayIndex != 0)
          {
              m_blnNewPlay = true;
              this.Play();
          }
      }
      private void CancelItemSelected()
      {
          foreach (System.Windows.Forms.ListViewItem lvi in lsvPlayList.SelectedItems)
          {
              lvi.Selected = false;
          }
      }
        // 删除所选文件
      private void DeleteSelected()
      {
          if (deleteFile==null)
          {
              MessageBox.Show("请选择要删除的文件！", "信息提示", MessageBoxButton.OK);
          }
          else
          {
              RemoveItemsFormMediaPlayList(deleteFile);
          }
      }
        // 删除所有文件
      private void DeleteAll()
      {
          if (m_mediaFileTable != null)
          {
              m_mediaFileTable.Clear();
          }
          updates.Clear();
          lsvPlayList.ItemsSource = updates;
          m_incrementId = 1;
          m_lastPlayIndex = 0;
          m_currentPlayIndex = 0;
      }
      // 从播放列表移除选中的文件
      private void RemoveItemsFormMediaPlayList(mFileInfo a)
      {
          if (a.ID == m_currentPlayIndex)
          {
              MessageBox.Show("正在播放无法删除");
          }
          else
          {
              updates.Remove(a);
              m_mediaFileTable.Remove(a.ID);
              m_incrementId--;
              for (int i = m_incrementId-1; i >=a.ID-1 ; i--)
              {
                  updates[i].ID --;                
              }
              lsvPlayList.ItemsSource = updates;
              if (m_currentPlayIndex > a.ID)
                  m_currentPlayIndex--;
          }
      }
        #endregion

        #endregion

        #region 录音界面
      //开始
        private void RecordStart(object sender, RoutedEventArgs e)
        {
           if (ifRecordPlay)
           {

           }
           if (ifRecording)
           {
               recorder.RecStop();
               recorder = null;
               recorder = new SoundRecord();
           }

            mediaPlayer.Stop();
            recorder.SetFileName(wavfile);

            recorder.RecStart();
            ifRecording = true;
       }
        //停止
        private void RecordStop(object sender, RoutedEventArgs e)
       {
           if (ifRecording)
           {
               recorder.RecStop();
               ifRecording = false;
           }
           else
           {
               return;
           }
       }
        //试听
       private void RecordPlay(object sender, RoutedEventArgs e)
       {
           string recordPathStr = System.Environment.CurrentDirectory;
           recordPathStr = recordPathStr + "\\" + wavfile;

           mediaPlayer.Source = new Uri(recordPathStr, UriKind.Absolute);
           mediaPlayer.Play();
       }
        //保存
       private void RecordSave(object sender, RoutedEventArgs e)
       {
           mediaPlayer.Stop();
           recorder.RecSave(wavfile);
       }

        //点击“列表”按钮
        private void PlayMovie_Click(object sender, RoutedEventArgs e)
        {
            des_Angle = 180;
            clock.Start();
        }
        //点击“播放”按钮
        private void SeeOthers_Click(object sender, RoutedEventArgs e)
        {
            des_Angle = 240;
            clock.Start();
        }
        //退出
        private void exit_Click(object sender, RoutedEventArgs e)
       {
            Application.Current.Shutdown();
       }
        //最小化
        private void mini_Click(object sender, RoutedEventArgs e)
       {
            this.WindowState = WindowState.Minimized;
       }
        #endregion

        #region 播放界面
        //播放事件   
        private void play_Click(object sender, RoutedEventArgs e)
        {
            ppfuc();
        }
        //停止
        private void stop_Click(object sender, RoutedEventArgs e)
        {

            if (mediaPlayer.Source != null)
            {
                mediaPlayer.Close();
                mediaElement1.Close();
                PositionSlider.Value = 0;
                VolSlider.Value = 1;
                nowPlaying.Content = "";
                mediaClock.Stop();
                playBtn.Content = "||";
                playBtn.ToolTip = "Pause";
                button_ifenable(false);
                if_play = false;
            }
        }
      //截图
      private void screenShotBtn_Click(object sender, RoutedEventArgs e)
      {
          string path = null;
          SaveFileDialog saveFileDialog = new SaveFileDialog();
          saveFileDialog.Filter = "JPG图片(*.*)|*.jpg";
          if (saveFileDialog.ShowDialog() == true)
          {
              path = saveFileDialog.FileName;
              byte[] screenshot = mediaPlayer.GetScreenShot(10, 90);
              FileStream fileStream = new FileStream(path, FileMode.Create, FileAccess.ReadWrite);
              BinaryWriter binaryWriter = new BinaryWriter(fileStream);
              binaryWriter.Write(screenshot);
              binaryWriter.Close();
          }
      }
      //音量键
      private void volumeBtn_Click(object sender, RoutedEventArgs e)
      {
          if (mediaPlayer.IsMuted)
          {
              mediaPlayer.IsMuted = false;
              VolSlider.Value = vol;
          }
          else
          {
              mediaPlayer.IsMuted = true;
              vol = VolSlider.Value;
              VolSlider.Value = 0;
          }            
      }
        //点击跳跃播放进度
        private void PositionSlider_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            mediaPlayer.Position = TimeSpan.FromMilliseconds(PositionSlider.Value);
            mediaElement1.Position = TimeSpan.FromMilliseconds(PositionSlider.Value);
        }
        //拖动跳跃播放进度
        private void PositionSlider_DragCompleted(object sender, System.Windows.Controls.Primitives.DragCompletedEventArgs e)
        {
            mediaPlayer.Position = TimeSpan.FromMilliseconds(PositionSlider.Value);
            mediaElement1.Position = TimeSpan.FromMilliseconds(PositionSlider.Value);
        }
        //载入多媒体时响应，将进度条的长度设置为多媒体的时间长度
        private void Element_MediaOpened(object sender, RoutedEventArgs e)
        {
            PositionSlider.Maximum = mediaPlayer.NaturalDuration.TimeSpan.TotalMilliseconds;
        }
        //结束多媒体时响应,归零
        private void Element_MediaEnded(object sender, RoutedEventArgs e)
        {
            PositionSlider.Value = 0;
            m_blnAutoMove = true;
            this.Next();         
        } 
        //双击退出全屏，单击暂停
      private void mediaElement1_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
      {
          if (e.ClickCount == 2)
          {
              ppfuc();
              mediaPlayer.IsMuted = false;
              BackPanel.Visibility = Visibility.Visible;
              LeftPanel.Visibility = Visibility.Visible;
              mediaElement1.IsMuted = true;
              mediaElement1.Visibility = Visibility.Hidden;
              this.WindowState = WindowState.Normal;             
          }
          else if (e.ClickCount == 1)
          {
              ppfuc();
          }
      }
      //双击全屏，单击暂停
      private void mediaPlayer_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
      {
          if (e.ClickCount == 2)
          {           
              ppfuc();
              mediaPlayer.IsMuted = true;
              BackPanel.Visibility = Visibility.Hidden;
              LeftPanel.Visibility = Visibility.Hidden;
              mediaElement1.IsMuted = false;
              mediaElement1.Visibility = Visibility.Visible;
              this.WindowState = WindowState.Maximized;
              
          }
          else if (e.ClickCount == 1)
          {
              ppfuc();
          }
      }
        private void BackPanel_MouseMove(object sender, MouseEventArgs e)
      {
          stopBtn.Visibility = Visibility.Visible;
          playBtn.Visibility = Visibility.Visible;
          screenShotBtn.Visibility = Visibility.Visible;
          volumeBtn.Visibility = Visibility.Visible;
          PositionSlider.Visibility = Visibility.Visible;
          VolSlider.Visibility = Visibility.Visible;
      }

      private void BackPanel_MouseLeave(object sender, MouseEventArgs e)
      {
          stopBtn.Visibility = Visibility.Hidden;
          playBtn.Visibility = Visibility.Hidden;
          screenShotBtn.Visibility = Visibility.Hidden;
          volumeBtn.Visibility = Visibility.Hidden;
          PositionSlider.Visibility = Visibility.Hidden;
          VolSlider.Visibility = Visibility.Hidden;
      }
        #endregion

        #region 转动效果和键盘事件
        //鼠标轴转动
        void Global_MouseWheel(object sender, MouseWheelEventArgs e)
        {
            if (login)
            {
                double zoom = (e.Delta / 120) * 5;
                if (camera.FieldOfView + zoom >= 29 && camera.FieldOfView + zoom <= 59)
                    camera.FieldOfView += zoom;
            }
        }
        //界面转动      
        void  clock_Tick(object sender, EventArgs e)
        {
            if (current_Angle < des_Angle)
            {
                camRotation.Angle += 30;
                current_Angle += 30;
            }
            else if (current_Angle > des_Angle)
            {
                camRotation.Angle -= 30;
                current_Angle -= 30;
            }
            else
            {
                clock.Stop();
            }
        }       
        //左右键控制转动,上下键改变透明度,esc退出全屏
        protected override void OnKeyDown(System.Windows.Input.KeyEventArgs e)
        {
            base.OnKeyDown(e);
            if (login)
            {
                if (e.Key == Key.Left)
                {
                    if (current_Angle < 270)
                    {
                        if (mediaPlayer.IsVisible)
                        {
                            camRotation.Angle += 30;
                            current_Angle += 30;
                        }
                    }
                    else
                    {
                        MessageBox.Show("再转就转回登录界面了");
                    }
                }
                else if (e.Key == Key.Right)
                {
                    if (current_Angle > 90)
                    {
                        if (mediaPlayer.IsVisible)
                        {
                            camRotation.Angle -= 30;
                            current_Angle -= 30;
                        }
                    }
                    else
                    {
                        MessageBox.Show("再转就转回登录界面了");
                    }
                }
                else if (e.Key == Key.Up && BackPanel.Background.Opacity < 1)
                {
                    BackPanel.Background.Opacity += 0.1;
                }
                else if (e.Key == Key.Down && BackPanel.Background.Opacity > 0.3)
                {
                    BackPanel.Background.Opacity -= 0.1;
                }
                else if (e.Key == Key.Escape)
                {
                    if (mediaElement1.Visibility == Visibility.Visible)
                    {
                        mediaPlayer.IsMuted = false;
                        BackPanel.Visibility = Visibility.Visible;
                        LeftPanel.Visibility = Visibility.Visible;
                        mediaElement1.IsMuted = true;
                        mediaElement1.Visibility = Visibility.Hidden;
                        this.WindowState = WindowState.Normal;
                    }
                }
            }
        }
        #endregion

        #region 播放列表界面
         //最小化
         private void Button_Click_4(object sender, RoutedEventArgs e)
         {
            this.WindowState = WindowState.Minimized;
         }  
        //退出
         private void out_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }
       
      //选择菜单目录选项
      private void StackPanel_Click(object sender, RoutedEventArgs e)
      {
          MenuItem mi = e.OriginalSource as MenuItem;
          XmlElement xe = mi.Header as XmlElement;
          switch (xe.Attributes["Name"].Value)
          {
              case "打开文件": 
                  this.AddOpenFiles();
                  break;
              case "打开文件夹": this.AddOpenFolder(); break;
              case "循环播放": 
                  m_currentPlayMode = PlayMode.Cycle;
                  break;
              case "顺序播放":
                  m_currentPlayMode = PlayMode.Order;
                  break;
              case "随机播放": 
                  m_currentPlayMode = PlayMode.Random;
                  break;
              case "单曲循环":
                  m_currentPlayMode = PlayMode.SingleCycle;
                  break;
              case "单曲播放": 
                  m_currentPlayMode = PlayMode.Single;
                   break;
              case "删除单曲": 
                  this.DeleteSelected();
                   break;
              case "清空列表": 
                  this.DeleteAll();
                  break;
              default: break;
          }
      } 
        //点击播放列表
        private void ListView_click(object sender, MouseButtonEventArgs e)
       {
            DependencyObject dep = (DependencyObject)e.OriginalSource;
            while ((dep != null) && !(dep is ListViewItem))
            {
                dep = VisualTreeHelper.GetParent(dep);

            }
            if (dep == null) return;
            else
            {
                if (lsvPlayList.Items.Count > 0)
                {
                    m_blnNewPlay = true;
                    mFileInfo m = lsvPlayList.SelectedItem as mFileInfo;
                   m_currentPlayIndex = m.ID ;      
                    this.Play();
                }
            }      
       }
        //播放列表改变事件
        private void lsvPlayList_SelectionChanged(object sender, SelectionChangedEventArgs e)
      {
          mFileInfo m = lsvPlayList.SelectedItem as mFileInfo;
          deleteFile = m;
      }
        #endregion 

        #region 窗体拖动
      private void FrontPanel_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
      {
          this.DragMove();
      }

      private void RightPanel_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
      {
          this.DragMove();
      }

      private void LeftPanel_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
      {
          this.DragMove();
      }

      private void BackPanel_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
      {
          this.DragMove();
      }
      #endregion

        #region 登陆界面
      //登录中“确定”按钮
      private void Button_Click(object sender, RoutedEventArgs e)
      {
          int flag = 0;
          for (int i = 0; i < userList.Count; i++)
          {
              if (textBox1.Text.Equals(((User)userList[i]).Username) && passwordBox1.Password.Equals("123456"))
              {
                  des_Angle = 90;
                  clock.Start();
                  login = true;
                  break;
              }
              else flag++;
          }
          if (flag != 0) MessageBox.Show("sorry,密码错了哦");
      }
      //注册
      private void Button_Click_1(object sender, RoutedEventArgs e)
      {
          
          Process.Start("http://localhost:49918/注册/%E9%A6%96%E9%A1%B5.aspx");
      }
      //退出按钮
      private void Button_Click_2(object sender, RoutedEventArgs e)
      {
          Application.Current.Shutdown();

      }
        #endregion    
    }
    #region 截图类
    public static class ScreenShot
    {
        public static byte[] GetScreenShot(this UIElement source, double scale, int quality)
        {
            double actualHeight = source.RenderSize.Height;
            double actualWidth = source.RenderSize.Width;
            double renderHeight = actualHeight * scale;
            double renderWidth = actualWidth * scale;

            RenderTargetBitmap renderTarget = new RenderTargetBitmap((int)renderWidth,
                (int)renderHeight, 96, 96, PixelFormats.Pbgra32);
            VisualBrush sourceBrush = new VisualBrush(source);

            DrawingVisual drawingVisual = new DrawingVisual();
            DrawingContext drawingContext = drawingVisual.RenderOpen();

            using (drawingContext)
            {
                drawingContext.PushTransform(new ScaleTransform(scale, scale));
                //
                drawingContext.DrawRectangle(sourceBrush, null, new Rect(new System.Windows.Point(0, 0),
                    new System.Windows.Point(actualWidth, actualHeight)));
            }
            renderTarget.Render(drawingVisual);

            JpegBitmapEncoder jpgEncoder = new JpegBitmapEncoder();
            jpgEncoder.QualityLevel = quality;
            jpgEncoder.Frames.Add(BitmapFrame.Create(renderTarget));

            Byte[] imageArray;

            using (MemoryStream outputStream = new MemoryStream())
            {
                jpgEncoder.Save(outputStream);
                imageArray = outputStream.ToArray();
            }
            return imageArray;
        }
    }
    #endregion
}
