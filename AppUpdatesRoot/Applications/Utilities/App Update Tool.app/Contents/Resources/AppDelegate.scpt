FasdUAS 1.101.10   ��   ��    k             l     ��������  ��  ��        l     �� 	 
��   	    AppDelegate.applescript    
 �   2     A p p D e l e g a t e . a p p l e s c r i p t      l     ��  ��       LL App Update Tool     �   (     L L   A p p   U p d a t e   T o o l      l     ��������  ��  ��        l     ��  ��    9 3  Created by Houle, Todd - 1170 - MITLL on 11/6/15.     �   f     C r e a t e d   b y   H o u l e ,   T o d d   -   1 1 7 0   -   M I T L L   o n   1 1 / 6 / 1 5 .      l     ��  ��    2 ,  Copyright � 2015 MIT. All rights reserved.     �   X     C o p y r i g h t   �   2 0 1 5   M I T .   A l l   r i g h t s   r e s e r v e d .      l     ��������  ��  ��         l     ��������  ��  ��      ! " ! h     �� #�� 0 appdelegate AppDelegate # k       $ $  % & % j     �� '
�� 
pare ' 4     �� (
�� 
pcls ( m     ) ) � * *  N S O b j e c t &  + , + l     ��������  ��  ��   ,  - . - l     �� / 0��   /  
 IBOutlets    0 � 1 1    I B O u t l e t s .  2 3 2 j   	 �� 4�� 0 	thewindow 	theWindow 4 m   	 
��
�� 
msng 3  5 6 5 j    �� 7�� 0 
atableview 
aTableView 7 m    ��
�� 
msng 6  8 9 8 j    �� :�� (0 thearraycontroller theArrayController : m    ��
�� 
msng 9  ; < ; j    �� =�� 0 thedata theData = m    ��
�� 
msng <  > ? > j    �� @�� 0 
statustext 
statusText @ m     A A � B B   ?  C D C j    �� E�� 0 lastscanranon lastScanRanOn E m     F F � G G   D  H I H l     ��������  ��  ��   I  J K J i     L M L I      �� N���� B0 applicationwillfinishlaunching_ applicationWillFinishLaunching_ N  O�� O o      ���� 0 anotification aNotification��  ��   M k      P P  Q R Q l     �� S T��   S R L Insert code here to initialize your application before any files are opened    T � U U �   I n s e r t   c o d e   h e r e   t o   i n i t i a l i z e   y o u r   a p p l i c a t i o n   b e f o r e   a n y   f i l e s   a r e   o p e n e d R  V W V I     �������� 0 refreshtime_ refreshTime_��  ��   W  X�� X r     Y Z Y I   �� [��
�� .sysoexecTEXT���     TEXT [ m     \ \ � ] ] � d e f a u l t s   r e a d   / L i b r a r y / P r e f e r e n c e s / e d u . m i t . l l . u p d a t e T o o l . p l i s t   l a s t R e f r e s h��   Z n      ^ _ ^ o    ���� 0 lastscanranon lastScanRanOn _  f    ��   K  ` a ` l     ��������  ��  ��   a  b c b i    " d e d I      �� f���� :0 applicationshouldterminate_ applicationShouldTerminate_ f  g�� g o      ���� 
0 sender  ��  ��   e k      h h  i j i l     �� k l��   k M G Insert code here to do any housekeeping before your application quits     l � m m �   I n s e r t   c o d e   h e r e   t o   d o   a n y   h o u s e k e e p i n g   b e f o r e   y o u r   a p p l i c a t i o n   q u i t s   j  n�� n L      o o n     p q p o    ����  0 nsterminatenow NSTerminateNow q m     ��
�� misccura��   c  r s r l     ��������  ��  ��   s  t u t i   # & v w v I      �� x���� 0 	quittime_ 	quitTime_ x  y�� y o      ���� 
0 sender  ��  ��   w O    
 z { z I   	������
�� .aevtquitnull��� ��� null��  ��   {  f      u  | } | l     ��������  ��  ��   }  ~  ~ i   ' * � � � I      �������� 0 refreshtime_ refreshTime_��  ��   � l    � � � � � k     � � �  � � � I    �� ���
�� .ascrcmnt****      � **** � m      � � � � � J R e f r e s h i n g   l i s t   o f   u p d a t e s   t o   d i s p l a y��   �  � � � Q     � ��� � I  	 �� ���
�� .sysoexecTEXT���     TEXT � m   	 
 � � � � � ^ r m   / u s r / l o c a l / u p d a t e T o o l / u p d a t e T o o l T o u c h F i l e s / *��   � R      ������
�� .ascrerr ****      � ****��  ��  ��   �  � � � r     � � � J    ����   � o      ���� 0 listofupdates listOfUpdates �  � � � r      � � � m     � � � � � J / u s r / l o c a l / u p d a t e T o o l / u p d a t e r I n f o . t x t � o      ���� 0 theupdatefile theUpdateFile �  � � � Q   ! ~ � ��� � k   $ u � �  � � � r   $ + � � � I  $ )�� ���
�� .rdwropenshor       file � o   $ %���� 0 theupdatefile theUpdateFile��   � o      ���� 0 
filehandle 
fileHandle �  � � � r   , 5 � � � n   , 3 � � � 2  1 3��
�� 
cpar � l  , 1 ����� � I  , 1�� ���
�� .rdwrread****        **** � o   , -���� 0 
filehandle 
fileHandle��  ��  ��   � o      ���� 0 updates Updates �  ��� � X   6 u ��� � � Z   F p � ����� � ?  F K � � � n   F I � � � 1   G I��
�� 
leng � o   F G���� 0 nextline nextLine � m   I J���� 
 � k   N l � �  � � � r   N U � � � I  N S�� ���
�� .sysodsct****        scpt � o   N O���� 0 nextline nextLine��   � o      ���� 0 myrecord myRecord �  � � � s   V Z � � � o   V W���� 0 myrecord myRecord � l      ����� � n       � � �  ;   X Y � o   W X���� 0 listofupdates listOfUpdates��  ��   �  ��� � I  [ l�� ���
�� .ascrcmnt****      � **** � b   [ h � � � b   [ d � � � m   [ ^ � � � � �  A d d i n g   � l  ^ c ����� � n   ^ c � � � o   _ c���� 0 appname appName � o   ^ _���� 0 myrecord myRecord��  ��   � m   d g � � � � �     t o   i n s t a l l   L i s t��  ��  ��  ��  �� 0 nextline nextLine � o   9 :���� 0 updates Updates��   � R      ������
�� .ascrerr ****      � ****��  ��  ��   �  � � � l   ��������  ��  ��   �  � � � l   ��~�}�  �~  �}   �  � � � l   �| � ��|   � H BtheData is the table that shows in the GUI.  Set everything there.    � � � � � t h e D a t a   i s   t h e   t a b l e   t h a t   s h o w s   i n   t h e   G U I .     S e t   e v e r y t h i n g   t h e r e . �  � � � r    � � � � o    ��{�{ 0 listofupdates listOfUpdates � n      � � � o   � ��z�z 0 thedata theData �  f   � � �  � � � I  � ��y ��x
�y .rdwrclosnull���     **** � o   � ��w�w 0 
filehandle 
fileHandle�x   �  ��v � r   � � � � � m   � � � � � � �  R e a d y . � n      � � � o   � ��u�u 0 
statustext 
statusText �  f   � ��v   � 1 +load the list of required updates at bootup    � � � � V l o a d   t h e   l i s t   o f   r e q u i r e d   u p d a t e s   a t   b o o t u p   � � � l     �t�s�r�t  �s  �r   �  � � � l     �q�p�o�q  �p  �o   �  � � � l     �n � ��n   � ) #disabled as there's no JSS anymore.    � � � � F d i s a b l e d   a s   t h e r e ' s   n o   J S S   a n y m o r e . �  � � � l     �m � ��m   �  on reloadApps_(sender)    � � � � , o n   r e l o a d A p p s _ ( s e n d e r ) �  � � � l     �l � ��l   � i c    do shell script ("touch '/usr/local/updateTool/updateToolTouchFiles/JSS+updateapps4+rebootNo'")    � � � � �         d o   s h e l l   s c r i p t   ( " t o u c h   ' / u s r / l o c a l / u p d a t e T o o l / u p d a t e T o o l T o u c h F i l e s / J S S + u p d a t e a p p s 4 + r e b o o t N o ' " ) �  � � � l     �k �k    x r    display dialog "Please reopen this application once the refresh has finished." buttons "Quit" default button 1    � �         d i s p l a y   d i a l o g   " P l e a s e   r e o p e n   t h i s   a p p l i c a t i o n   o n c e   t h e   r e f r e s h   h a s   f i n i s h e d . "   b u t t o n s   " Q u i t "   d e f a u l t   b u t t o n   1 �  l     �j�j        tell me to quit    � &         t e l l   m e   t o   q u i t 	 l     �i
�i  
  end reloadApps_    �  e n d   r e l o a d A p p s _	  l     �h�g�f�h  �g  �f    i   + . I      �e�d�e 0 updateapps_ updateApps_ �c o      �b�b 
0 sender  �c  �d   k      r      m     �a�a   o      �`�` 0 adoberuncount adobeRunCount  r     m    �_
�_ boovfals o      �^�^ 0 rebootok rebootOK  X    [ �]!  Z    V"#�\�[" l   #$�Z�Y$ =   #%&% l   !'�X�W' c    !()( n    *+* o    �V�V 0 appinstallchk appInstallChk+ o    �U�U 0 	onerecord 	oneRecord) m     �T
�T 
bool�X  �W  & m   ! "�S
�S boovtrue�Z  �Y  # Z   & R,-�R�Q, l  & -.�P�O. =  & -/0/ l  & +1�N�M1 c   & +232 n   & )454 o   ' )�L�L 
0 reboot  5 o   & '�K�K 0 	onerecord 	oneRecord3 m   ) *�J
�J 
bool�N  �M  0 m   + ,�I
�I boovtrue�P  �O  - k   0 N66 787 r   0 @9:9 n   0 >;<; 1   < >�H
�H 
bhit< l  0 <=�G�F= I  0 <�E>?
�E .sysodlogaskr        TEXT> m   0 1@@ �AA ^ A   r e b o o t   i s   r e q u i r e d   t o   i n s t a l l   t h e s e   u p d a t e s .  ? �DBC
�D 
btnsB J   2 6DD EFE m   2 3GG �HH  C a n c e lF I�CI m   3 4JJ �KK  R e b o o t�C  C �BL�A
�B 
dfltL m   7 8�@�@ �A  �G  �F  : o      �?�? 0 
the_button  8 M�>M Z   A NNO�=PN =  A DQRQ o   A B�<�< 0 
the_button  R m   B CSS �TT  C a n c e lO  S   G H�=  P r   K NUVU m   K L�;
�; boovtrueV o      �:�: 0 rebootok rebootOK�>  �R  �Q  �\  �[  �] 0 	onerecord 	oneRecord! o    �9�9 0 thedata theData WXW l  \ \�8�7�6�8  �7  �6  X YZY Z   \ �[\�5�4[ =  \ _]^] o   \ ]�3�3 0 rebootok rebootOK^ m   ] ^�2
�2 boovfals\ k   b �__ `a` r   b vbcb n   b tded 1   r t�1
�1 
bhite l  b rf�0�/f I  b r�.gh
�. .sysodlogaskr        TEXTg m   b cii �jj j A p p l i c a t i o n s   w i l l   b e   c l o s e d   a s   n e c e s s a r y   t o   i n s t a l l .  h �-kl
�- 
btnsk J   d lmm non m   d gpp �qq  C a n c e lo r�,r m   g jss �tt  C o n t i n u e�,  l �+u�*
�+ 
dfltu m   m n�)�) �*  �0  �/  c o      �(�( 0 
the_button  a v�'v Z   w �wx�&�%w =  w |yzy o   w x�$�$ 0 
the_button  z m   x {{{ �||  C a n c e lx  S    ��&  �%  �'  �5  �4  Z }~} l  � ��#�"�!�#  �"  �!  ~ � X   � ��� �� Z   � ������ l  � ����� =  � ���� l  � ����� c   � ���� n   � ���� o   � ��� 0 appinstallchk appInstallChk� o   � ��� 0 	onerecord 	oneRecord� m   � ��
� 
bool�  �  � m   � ��
� boovtrue�  �  � Z   � ������ l  � ����� =  � ���� l  � ����� c   � ���� n   � ���� o   � ��� 
0 reboot  � o   � ��� 0 	onerecord 	oneRecord� m   � ��
� 
bool�  �  � m   � ��
� boovtrue�  �  � I  � ����
� .sysoexecTEXT���     TEXT� l  � ���
�	� b   � ���� b   � ���� b   � ���� b   � ���� m   � ��� ��� d t o u c h   ' / u s r / l o c a l / u p d a t e T o o l / u p d a t e T o o l T o u c h F i l e s /� n   � ���� o   � ��� 
0 source  � o   � ��� 0 	onerecord 	oneRecord� m   � ��� ���  +� n   � ���� o   � ��� 0 	jsspolicy 	jssPolicy� o   � ��� 0 	onerecord 	oneRecord� m   � ��� ���  + r e b o o t Y e s '�
  �	  �  �  � I  � ����
� .sysoexecTEXT���     TEXT� l  � ����� b   � ���� b   � ���� b   � ���� b   � ���� m   � ��� ��� d t o u c h   ' / u s r / l o c a l / u p d a t e T o o l / u p d a t e T o o l T o u c h F i l e s /� n   � ���� o   � �� �  
0 source  � o   � ����� 0 	onerecord 	oneRecord� m   � ��� ���  +� n   � ���� o   � ����� 0 	jsspolicy 	jssPolicy� o   � ����� 0 	onerecord 	oneRecord� m   � ��� ���  + r e b o o t N o '�  �  �  �  �  �  0 	onerecord 	oneRecord� o   � ����� 0 thedata theData� ��� l  � ���������  ��  ��  � ��� r   � ���� m   � ��� ��� , U p d a t e s   i n   P r o g r e s s . . .� n     ��� o   � ����� 0 
statustext 
statusText�  f   � �� ��� l  � ���������  ��  ��  � ���� O  ���� I ������
�� .aevtquitnull��� ��� null��  ��  �  f   � ���   ��� l     ��������  ��  ��  � ���� l     ��������  ��  ��  ��   " ���� l     ��������  ��  ��  ��       ������  � ���� 0 appdelegate AppDelegate� �� #���� 0 appdelegate AppDelegate� �� �����
�� misccura
�� 
pcls� ���  N S O b j e c t� ������������� A F�������  � ������������������������
�� 
pare�� 0 	thewindow 	theWindow�� 0 
atableview 
aTableView�� (0 thearraycontroller theArrayController�� 0 thedata theData�� 0 
statustext 
statusText�� 0 lastscanranon lastScanRanOn�� B0 applicationwillfinishlaunching_ applicationWillFinishLaunching_�� :0 applicationshouldterminate_ applicationShouldTerminate_�� 0 	quittime_ 	quitTime_�� 0 refreshtime_ refreshTime_�� 0 updateapps_ updateApps_��  
�� 
msng
�� 
msng
�� 
msng
�� 
msng� �� M���������� B0 applicationwillfinishlaunching_ applicationWillFinishLaunching_�� ����� �  ���� 0 anotification aNotification��  � ���� 0 anotification aNotification� �� \������ 0 refreshtime_ refreshTime_
�� .sysoexecTEXT���     TEXT�� 0 lastscanranon lastScanRanOn�� *j+  O�j )�,F� �� e���������� :0 applicationshouldterminate_ applicationShouldTerminate_�� ����� �  ���� 
0 sender  ��  � ���� 
0 sender  � ����
�� misccura��  0 nsterminatenow NSTerminateNow�� ��,E� �� w���������� 0 	quittime_ 	quitTime_�� ����� �  ���� 
0 sender  ��  � ���� 
0 sender  � ��
�� .aevtquitnull��� ��� null�� ) *j  U� �� ����������� 0 refreshtime_ refreshTime_��  ��  � �������������� 0 listofupdates listOfUpdates�� 0 theupdatefile theUpdateFile�� 0 
filehandle 
fileHandle�� 0 updates Updates�� 0 nextline nextLine�� 0 myrecord myRecord�  ��� ������� ������������������� ��� ����� ���
�� .ascrcmnt****      � ****
�� .sysoexecTEXT���     TEXT��  ��  
�� .rdwropenshor       file
�� .rdwrread****        ****
�� 
cpar
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
leng�� 

�� .sysodsct****        scpt�� 0 appname appName�� 0 thedata theData
�� .rdwrclosnull���     ****�� 0 
statustext 
statusText�� ��j O 
�j W X  hOjvE�O�E�O V�j E�O�j �-E�O >�[��l kh ��,� #�j E�O��6GOa �a ,%a %j Y h[OY��W X  hO�)a ,FO�j Oa )a ,F� ������������ 0 updateapps_ updateApps_�� ����� �  ���� 
0 sender  ��  � ������������ 
0 sender  �� 0 adoberuncount adobeRunCount�� 0 rebootok rebootOK�� 0 	onerecord 	oneRecord�� 0 
the_button  � ������������@��GJ��������Sips{���������������~
�� 
kocl
�� 
cobj
�� .corecnte****       ****�� 0 appinstallchk appInstallChk
�� 
bool�� 
0 reboot  
�� 
btns
�� 
dflt�� 
�� .sysodlogaskr        TEXT
�� 
bhit�� 
0 source  �� 0 	jsspolicy 	jssPolicy
�� .sysoexecTEXT���     TEXT� 0 
statustext 
statusText
�~ .aevtquitnull��� ��� null��	jE�OfE�O Rb  [��l kh ��,�&e  1��,�&e  #����lv�l� �,E�O��  Y eE�Y hY h[OY��O�f  '��a a lv�l� �,E�O�a   Y hY hO ib  [��l kh ��,�&e  H��,�&e   a �a ,%a %�a ,%a %j Y a �a ,%a %�a ,%a %j Y h[OY��Oa )a ,FO) *j Uascr  ��ޭ