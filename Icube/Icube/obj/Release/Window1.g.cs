﻿#pragma checksum "..\..\Window1.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "48B61D35045AE422175FA3FCCD0AF94A"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.4963
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using MojaKocka;
using System;
using System.Collections;
using System.Diagnostics;
using System.Windows;
using System.Windows.Automation;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Effects;
using System.Windows.Media.Imaging;
using System.Windows.Media.Media3D;
using System.Windows.Media.TextFormatting;
using System.Windows.Navigation;
using System.Windows.Shapes;


namespace MojaKocka {
    
    
    /// <summary>
    /// Window1
    /// </summary>
    public partial class Window1 : System.Windows.Window, System.Windows.Markup.IComponentConnector {
        
        
        #line 122 "..\..\Window1.xaml"
        internal System.Windows.Controls.Viewport3D view;
        
        #line default
        #line hidden
        
        
        #line 125 "..\..\Window1.xaml"
        internal System.Windows.Media.Media3D.PerspectiveCamera camera;
        
        #line default
        #line hidden
        
        
        #line 127 "..\..\Window1.xaml"
        internal System.Windows.Media.Media3D.RotateTransform3D rot;
        
        #line default
        #line hidden
        
        
        #line 130 "..\..\Window1.xaml"
        internal System.Windows.Media.Media3D.AxisAngleRotation3D camRotation;
        
        #line default
        #line hidden
        
        
        #line 152 "..\..\Window1.xaml"
        internal System.Windows.Controls.Grid FrontPanel;
        
        #line default
        #line hidden
        
        
        #line 168 "..\..\Window1.xaml"
        internal System.Windows.Controls.TextBox textBox1;
        
        #line default
        #line hidden
        
        
        #line 169 "..\..\Window1.xaml"
        internal System.Windows.Controls.PasswordBox passwordBox1;
        
        #line default
        #line hidden
        
        
        #line 170 "..\..\Window1.xaml"
        internal System.Windows.Controls.Label label1;
        
        #line default
        #line hidden
        
        
        #line 171 "..\..\Window1.xaml"
        internal System.Windows.Controls.Label label2;
        
        #line default
        #line hidden
        
        
        #line 173 "..\..\Window1.xaml"
        internal System.Windows.Controls.Label label3;
        
        #line default
        #line hidden
        
        
        #line 190 "..\..\Window1.xaml"
        internal System.Windows.Controls.Grid RightPanel;
        
        #line default
        #line hidden
        
        
        #line 210 "..\..\Window1.xaml"
        internal System.Windows.Controls.Button mini;
        
        #line default
        #line hidden
        
        
        #line 211 "..\..\Window1.xaml"
        internal System.Windows.Controls.Button playMovie;
        
        #line default
        #line hidden
        
        
        #line 212 "..\..\Window1.xaml"
        internal System.Windows.Controls.Button otherUsers;
        
        #line default
        #line hidden
        
        
        #line 213 "..\..\Window1.xaml"
        internal System.Windows.Controls.Image ima;
        
        #line default
        #line hidden
        
        
        #line 214 "..\..\Window1.xaml"
        internal System.Windows.Controls.Button exit;
        
        #line default
        #line hidden
        
        
        #line 228 "..\..\Window1.xaml"
        internal System.Windows.Controls.Grid LeftPanel;
        
        #line default
        #line hidden
        
        
        #line 246 "..\..\Window1.xaml"
        internal System.Windows.Controls.ListView lsvPlayList;
        
        #line default
        #line hidden
        
        
        #line 267 "..\..\Window1.xaml"
        internal System.Windows.Controls.Grid BackPanel;
        
        #line default
        #line hidden
        
        
        #line 270 "..\..\Window1.xaml"
        internal System.Windows.Controls.RowDefinition playCtr;
        
        #line default
        #line hidden
        
        
        #line 281 "..\..\Window1.xaml"
        internal System.Windows.Controls.MediaElement mediaPlayer;
        
        #line default
        #line hidden
        
        
        #line 283 "..\..\Window1.xaml"
        internal System.Windows.Controls.Button playBtn;
        
        #line default
        #line hidden
        
        
        #line 284 "..\..\Window1.xaml"
        internal System.Windows.Controls.Button stopBtn;
        
        #line default
        #line hidden
        
        
        #line 285 "..\..\Window1.xaml"
        internal System.Windows.Controls.Button muteBtn;
        
        #line default
        #line hidden
        
        
        #line 286 "..\..\Window1.xaml"
        internal System.Windows.Controls.Slider VolSlider;
        
        #line default
        #line hidden
        
        
        #line 287 "..\..\Window1.xaml"
        internal System.Windows.Controls.Slider PositionSlider;
        
        #line default
        #line hidden
        
        
        #line 288 "..\..\Window1.xaml"
        internal System.Windows.Controls.Button cutBtn;
        
        #line default
        #line hidden
        
        
        #line 289 "..\..\Window1.xaml"
        internal System.Windows.Controls.Label nowPlaying;
        
        #line default
        #line hidden
        
        
        #line 292 "..\..\Window1.xaml"
        internal System.Windows.Controls.Label Playing;
        
        #line default
        #line hidden
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Uri resourceLocater = new System.Uri("/MyCube;component/window1.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\Window1.xaml"
            System.Windows.Application.LoadComponent(this, resourceLocater);
            
            #line default
            #line hidden
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes")]
        void System.Windows.Markup.IComponentConnector.Connect(int connectionId, object target) {
            switch (connectionId)
            {
            case 1:
            this.view = ((System.Windows.Controls.Viewport3D)(target));
            return;
            case 2:
            this.camera = ((System.Windows.Media.Media3D.PerspectiveCamera)(target));
            return;
            case 3:
            this.rot = ((System.Windows.Media.Media3D.RotateTransform3D)(target));
            return;
            case 4:
            this.camRotation = ((System.Windows.Media.Media3D.AxisAngleRotation3D)(target));
            return;
            case 5:
            this.FrontPanel = ((System.Windows.Controls.Grid)(target));
            
            #line 152 "..\..\Window1.xaml"
            this.FrontPanel.MouseLeftButtonDown += new System.Windows.Input.MouseButtonEventHandler(this.FrontPanel_MouseLeftButtonDown);
            
            #line default
            #line hidden
            return;
            case 6:
            
            #line 166 "..\..\Window1.xaml"
            ((System.Windows.Controls.Button)(target)).Click += new System.Windows.RoutedEventHandler(this.Button_Click);
            
            #line default
            #line hidden
            return;
            case 7:
            
            #line 167 "..\..\Window1.xaml"
            ((System.Windows.Controls.Button)(target)).Click += new System.Windows.RoutedEventHandler(this.Button_Click_1);
            
            #line default
            #line hidden
            return;
            case 8:
            this.textBox1 = ((System.Windows.Controls.TextBox)(target));
            return;
            case 9:
            this.passwordBox1 = ((System.Windows.Controls.PasswordBox)(target));
            return;
            case 10:
            this.label1 = ((System.Windows.Controls.Label)(target));
            return;
            case 11:
            this.label2 = ((System.Windows.Controls.Label)(target));
            return;
            case 12:
            
            #line 172 "..\..\Window1.xaml"
            ((System.Windows.Controls.Button)(target)).Click += new System.Windows.RoutedEventHandler(this.Button_Click_2);
            
            #line default
            #line hidden
            return;
            case 13:
            this.label3 = ((System.Windows.Controls.Label)(target));
            return;
            case 14:
            this.RightPanel = ((System.Windows.Controls.Grid)(target));
            
            #line 190 "..\..\Window1.xaml"
            this.RightPanel.MouseLeftButtonDown += new System.Windows.Input.MouseButtonEventHandler(this.RightPanel_MouseLeftButtonDown);
            
            #line default
            #line hidden
            return;
            case 15:
            this.mini = ((System.Windows.Controls.Button)(target));
            
            #line 210 "..\..\Window1.xaml"
            this.mini.Click += new System.Windows.RoutedEventHandler(this.mini_Click);
            
            #line default
            #line hidden
            return;
            case 16:
            this.playMovie = ((System.Windows.Controls.Button)(target));
            
            #line 211 "..\..\Window1.xaml"
            this.playMovie.Click += new System.Windows.RoutedEventHandler(this.PlayMovie_Click);
            
            #line default
            #line hidden
            return;
            case 17:
            this.otherUsers = ((System.Windows.Controls.Button)(target));
            
            #line 212 "..\..\Window1.xaml"
            this.otherUsers.Click += new System.Windows.RoutedEventHandler(this.SeeOthers_Click);
            
            #line default
            #line hidden
            return;
            case 18:
            this.ima = ((System.Windows.Controls.Image)(target));
            return;
            case 19:
            this.exit = ((System.Windows.Controls.Button)(target));
            
            #line 214 "..\..\Window1.xaml"
            this.exit.Click += new System.Windows.RoutedEventHandler(this.exit_Click);
            
            #line default
            #line hidden
            return;
            case 20:
            this.LeftPanel = ((System.Windows.Controls.Grid)(target));
            
            #line 228 "..\..\Window1.xaml"
            this.LeftPanel.MouseLeftButtonDown += new System.Windows.Input.MouseButtonEventHandler(this.LeftPanel_MouseLeftButtonDown);
            
            #line default
            #line hidden
            return;
            case 21:
            
            #line 240 "..\..\Window1.xaml"
            ((System.Windows.Controls.Button)(target)).Click += new System.Windows.RoutedEventHandler(this.out_Click);
            
            #line default
            #line hidden
            return;
            case 22:
            
            #line 241 "..\..\Window1.xaml"
            ((System.Windows.Controls.Button)(target)).Click += new System.Windows.RoutedEventHandler(this.Button_Click_4);
            
            #line default
            #line hidden
            return;
            case 23:
            
            #line 242 "..\..\Window1.xaml"
            ((System.Windows.Controls.StackPanel)(target)).AddHandler(System.Windows.Controls.MenuItem.ClickEvent, new System.Windows.RoutedEventHandler(this.StackPanel_Click));
            
            #line default
            #line hidden
            return;
            case 24:
            this.lsvPlayList = ((System.Windows.Controls.ListView)(target));
            
            #line 245 "..\..\Window1.xaml"
            this.lsvPlayList.MouseDoubleClick += new System.Windows.Input.MouseButtonEventHandler(this.ListView_click);
            
            #line default
            #line hidden
            
            #line 245 "..\..\Window1.xaml"
            this.lsvPlayList.SelectionChanged += new System.Windows.Controls.SelectionChangedEventHandler(this.lsvPlayList_SelectionChanged);
            
            #line default
            #line hidden
            return;
            case 25:
            this.BackPanel = ((System.Windows.Controls.Grid)(target));
            
            #line 267 "..\..\Window1.xaml"
            this.BackPanel.MouseLeftButtonDown += new System.Windows.Input.MouseButtonEventHandler(this.BackPanel_MouseLeftButtonDown);
            
            #line default
            #line hidden
            
            #line 267 "..\..\Window1.xaml"
            this.BackPanel.MouseEnter += new System.Windows.Input.MouseEventHandler(this.BackPanel_MouseEnter);
            
            #line default
            #line hidden
            
            #line 267 "..\..\Window1.xaml"
            this.BackPanel.MouseLeave += new System.Windows.Input.MouseEventHandler(this.BackPanel_MouseLeave);
            
            #line default
            #line hidden
            return;
            case 26:
            this.playCtr = ((System.Windows.Controls.RowDefinition)(target));
            return;
            case 27:
            this.mediaPlayer = ((System.Windows.Controls.MediaElement)(target));
            
            #line 282 "..\..\Window1.xaml"
            this.mediaPlayer.MediaOpened += new System.Windows.RoutedEventHandler(this.Element_MediaOpened);
            
            #line default
            #line hidden
            
            #line 282 "..\..\Window1.xaml"
            this.mediaPlayer.MediaEnded += new System.Windows.RoutedEventHandler(this.Element_MediaEnded);
            
            #line default
            #line hidden
            return;
            case 28:
            this.playBtn = ((System.Windows.Controls.Button)(target));
            
            #line 283 "..\..\Window1.xaml"
            this.playBtn.Click += new System.Windows.RoutedEventHandler(this.play_Click);
            
            #line default
            #line hidden
            return;
            case 29:
            this.stopBtn = ((System.Windows.Controls.Button)(target));
            
            #line 284 "..\..\Window1.xaml"
            this.stopBtn.Click += new System.Windows.RoutedEventHandler(this.stop_Click);
            
            #line default
            #line hidden
            return;
            case 30:
            this.muteBtn = ((System.Windows.Controls.Button)(target));
            
            #line 285 "..\..\Window1.xaml"
            this.muteBtn.Click += new System.Windows.RoutedEventHandler(this.muteBtn_Click);
            
            #line default
            #line hidden
            return;
            case 31:
            this.VolSlider = ((System.Windows.Controls.Slider)(target));
            return;
            case 32:
            this.PositionSlider = ((System.Windows.Controls.Slider)(target));
            
            #line 287 "..\..\Window1.xaml"
            this.PositionSlider.AddHandler(System.Windows.Controls.Primitives.Thumb.DragCompletedEvent, new System.Windows.Controls.Primitives.DragCompletedEventHandler(this.PositionSlider_DragCompleted));
            
            #line default
            #line hidden
            return;
            case 33:
            this.cutBtn = ((System.Windows.Controls.Button)(target));
            
            #line 288 "..\..\Window1.xaml"
            this.cutBtn.Click += new System.Windows.RoutedEventHandler(this.cut_Click);
            
            #line default
            #line hidden
            return;
            case 34:
            this.nowPlaying = ((System.Windows.Controls.Label)(target));
            return;
            case 35:
            this.Playing = ((System.Windows.Controls.Label)(target));
            return;
            }
            this._contentLoaded = true;
        }
    }
}
