   M S B A M L   `   `   `  ����F  BPointOfSale, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null5clr-namespace:PointOfSale.ViewsPointOfSale.Views  5   	   !    PointOfSale.Views.LoginView   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   1localclr-namespace:PointOfSale.Views     5   	   -   5        $��loginWindow��5   	    	  Login  � DataContext#  [  5	   	    �� BitmapScalingMode$ HighQuality=�5
       � 
ResizeMode$ NoResize=�5   	    � WindowStartupLocation$ CenterScreen=�5   	    � Title$ 
MainWindow��5   	   $	��450��6   $	��800��6)   .��5      � ��5   
   �� 5       �� ImageSource$) #/Resource/Image/background_main.png��6    � ColumnDefinitions 5   
   �� 5      $	��150 �6   �� 5      $��3* �6   �� 5      $	��150 �6   �� 5      $��* �6   .+�5   
   �� $��/Resource/Image/logo.png��6   $	��Top=�5      $��25 20q�5      �� 5   
   $!��/Resource/Image/setting.png��6   $��Bottom=�5      $��35 20q�5      $��60��6    � ToolTip$$ Cài đặt thay đổi Server��5       �� 5!   
   $$��/Resource/Image/image-item.png��6   $��3��68   $��10q�5"      $��Right=�5#      $	��Top=�5$      �� 5&   
   $��1��6   $	��Top=�6%   $��30 40q�5'      .+�5(      �� $��LOGIN��6   $
��Bold"�6&   $��35(�68   ���#5B4DCD5)      �� 5*      -   5        $��UsernameTitle��5*      $��Username��6-   $��15(�6=   $��Light"�5+      ���#5B4DCD6+   �� 5-      $��40��6   .+�5.      �� -   5        $��Username��5.      $��0 0 0 1q�5/      ���#5B4DCD$��Center=�52      
������  K� ZIndex$ 10��53   3   ���#5B4DCD$��16(�54   /   $	��315��6=   $��40��6I   �� 55      -   5        $��
Text_Focus��55      $��Italic$�6.   $��Type your username...��56      
	 �� Top$	 10��69   ���#5B4DCD
 J� Opacity$
 .6Q�58      $��14(�6)    �� Left$ 2��67   59      �� 5;      -   5        $��PasswordTitle��5;      $��Password��6-   $��15(�6=   $��0 30 0 0q�6K   $��Light"�5<      ���#5B4DCD6+   �� 5=      $��40��6   .+�5>      G� -   5        $��Password��5>      $��0 0 0 1q�5?      ���#5B4DCD$��Center=�5A      
������ $ 10��5B   7   ���#5B4DCD$��16(�5C   3   $	��315��5D      $��40��6*   �� 5E      -   5        $��Text_Focus_Password��5E      $��Italic$�67   $��Type your password...��5F      $	 10��69   ���#5B4DCD$
 .6Q�5H      $��14(�6)   $ 2��67   5I      5J      �� 5L   
   $��40��6   $��1��6    �� CornerRadius$ 20��6-   ���#8360F7$	��100��5M   &   $��Right=�62   $��Bottom=�5N      $��	0 0 20 90q�6,   ._�5O      �� $��Submit��6   $��0q�6&   
������ $
��Bold"�5P   .   $��20(�5Q      ���#F3EAF5��5R      �� *LoginCommand+��5S      ��  �� ElementName$ loginWindow��5T      �� 5V   
   $��40��6   $��2��6   $ 20��6-   ���#8360F7$��80��5W   &   $��Bottom=�5X      $��0 0 0 90q�6,   ._�5Y      �� $
��Exit��6   $��0q�6$   
������ $
��Bold"�5Z   .   $��20(�5[      ���#F3EAF56#   5\      �� 5^   
   -   5        $��versionLabel��5^       $��3��6   $��v1.1.1.2��64   $��Bottom=�5_      $��Center=�6,   ���#5B4DCD$��0 0 0 10q�5`   %   5b      5c      