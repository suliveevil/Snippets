FasdUAS 1.101.10   ��   ��    k             l        	  x     �� 
 ��   
 1      ��
�� 
ascr  �� ��
�� 
minv  m         �    2 . 4��       Yosemite (10.10) or later    	 �   4   Y o s e m i t e   ( 1 0 . 1 0 )   o r   l a t e r      x    �� ����    2  	 ��
�� 
osax��        l     ��������  ��  ��        l     ��  ��    5 / http://veritrope.com/code/toggle-an-app-on-off     �   ^   h t t p : / / v e r i t r o p e . c o m / c o d e / t o g g l e - a n - a p p - o n - o f f      l     ��  ��      ENTER THE NAME OF THE APP      �   4 E N T E R   T H E   N A M E   O F   T H E   A P P         l     �� ! "��   ! # THAT YOU WOULD LIKE TO TOGGLE    " � # # : T H A T   Y O U   W O U L D   L I K E   T O   T O G G L E    $ % $ l     �� & '��   &  IN THE PROPERTY BELOW...    ' � ( ( 0 I N   T H E   P R O P E R T Y   B E L O W . . . %  ) * ) l     ��������  ��  ��   *  + , + l     �� - .��   -  property app_Name : ""    . � / / , p r o p e r t y   a p p _ N a m e   :   " " ,  0 1 0 l     ��������  ��  ��   1  2 3 2 l     ��������  ��  ��   3  4 5 4 l     �� 6 7��   6 $ if appIsRunning(app_Name) then    7 � 8 8 < i f   a p p I s R u n n i n g ( a p p _ N a m e )   t h e n 5  9 : 9 l     �� ; <��   ; = 7	do shell script "killall " & (quoted form of app_Name)    < � = = n 	 d o   s h e l l   s c r i p t   " k i l l a l l   "   &   ( q u o t e d   f o r m   o f   a p p _ N a m e ) :  > ? > l     �� @ A��   @ 
 else    A � B B  e l s e ?  C D C l     �� E F��   E = 7	do shell script "open -a " & (quoted form of app_Name)    F � G G n 	 d o   s h e l l   s c r i p t   " o p e n   - a   "   &   ( q u o t e d   f o r m   o f   a p p _ N a m e ) D  H I H l     �� J K��   J  end if    K � L L  e n d   i f I  M N M l     ��������  ��  ��   N  O P O l     �� Q R��   Q  on appIsRunning(appName)    R � S S 0 o n   a p p I s R u n n i n g ( a p p N a m e ) P  T U T l     �� V W��   V O I	tell application "System Events" to (name of processes) contains appName    W � X X � 	 t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   ( n a m e   o f   p r o c e s s e s )   c o n t a i n s   a p p N a m e U  Y Z Y l     �� [ \��   [  end appIsRunning    \ � ] ]   e n d   a p p I s R u n n i n g Z  ^ _ ^ l     ��������  ��  ��   _  `�� ` l     a���� a O      b c b k     d d  e f e r     g h g 6    i j i 4   �� k
�� 
prcs k m    ����  j =  	  l m l 1   
 ��
�� 
pisf m m    ��
�� boovtrue h o      ���� 0 frontprocess frontProcess f  n�� n r     o p o m    ��
�� boovfals p n       q r q 1    ��
�� 
pvis r o    ���� 0 frontprocess frontProcess��   c m      s s�                                                                                  sevs  alis    \  Macintosh HD                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  ��  ��  ��       �� t u v w����   t ��������
�� 
pimr
�� .aevtoappnull  �   � ****�� 0 frontprocess frontProcess��   u �� x��  x   y z y �� ��
�� 
vers��   z �� {��
�� 
cobj {  | |   ��
�� 
osax��   v �� }���� ~ ��
�� .aevtoappnull  �   � **** } k      � �  `����  ��  ��   ~     s�� �������
�� 
prcs �  
�� 
pisf�� 0 frontprocess frontProcess
�� 
pvis�� � *�k/�[�,\Ze81E�Of��,FU w  � �  s�� �
�� 
pcap � � � �  S c r i p t   D e b u g g e r��   ascr  ��ޭ