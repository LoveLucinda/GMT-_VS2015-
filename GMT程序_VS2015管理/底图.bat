rem ----------------------------------------------------------------------------------------------------------------------------

rem ����ӡ����������GMT��ͼ���룬��־ظ��2015.11.06
rem 2015.11.25��ֲ��vs2015�Ͻ�����Ŀ����ͳһ�������а汾���ƣ�
rem Ϊ�˷���������ݼ�����ͼ����������Ҫ����һ����·������·������Ȼ�����������·���½��в���
rem --------------------------------------------------�����������---------------------------------------------------------------
REM plain ��ʾ����߿�fancy ��ʾ���𳵵��߿�
gmtset BASEMAP_TYPE fancy
gmtset MAP_FRAME_PEN thicker
gmtset PLOT_DEGREE_FORMAT ddd:mm:ssF
gmtset FRAME_PEN 0.1p
gmtset FRAME_WIDTH 0.1
gmtset TICK_LENGTH = 0c
gmtset ANNOT_FONT_PRIMARY = Times-Roman
gmtset LABEL_FONT=Times-Roman 
gmtset LABEL_FONT_SIZE=8p
gmtset ANNOT_FONT_SIZE_PRIMARY = 9p
gmtset LABEL_OFFSET=0.1c
REM ����������߿�ֻ�������б�ע WSen
gmtset BASEMAP_AXES WSen
REM ͼ���ļ���ʽ
gmtset PSIMAGE_FORMAT hex
cls
rem -----------------------------------------------------���������ͼ������---------------------------------------------------------------
set ParentPath=H:\Study\1-��ʿ����\2_����ӡ��������\0-������-GMT��ͼ\
set RANGE=-20/80/-65/-20
set outpsfile=%ParentPath%�о�����ͼ.ps
set ImageSize=14c
set PreviewSize=3c
set PreviewMove_X=11c
set PsTextPath=%ParentPath%���켰�����ĵ�ַ��Ԫ���������ע
del %outpsfile%
rem -------------------------------------------------------��ͼ����------------------------------------------------------------------------
rem 1. basemap
gmt psbasemap -JM30/-40/%ImageSize% -R%RANGE% -B20/10 --BASEMAP_TYPE=fancy -K -P>> %outpsfile%

REM ****************************************************�������ͼ��*************************************************************************
rem 2. coast
rem ���Ʊ����ߺͷ�λָ��ı���
echo 28 -61>>tmp
echo 50 -61>>tmp
echo 50 -64.5>>tmp
echo 28 -64.5>>tmp
gmt psxy tmp -R -J -Ggrey -t60 -L -A -O -K>> %outpsfile%
gmt pscoast -R -J -Glightblue -Df -N1 -W0.2,lightblue -A10000 -Lf35/-62.5/-45/1000+l --ANNOT_FONT_SIZE_PRIMARY=8p -Tf46.5/-62.9/0.9c:: -O -K >> %outpsfile%
echo 48 -61.5 N |gmt pstext -R -J -F+f8p,black -O -K>> %outpsfile%
rem gmt pscoast -R -J -Glightblue -Df -N1 -W0.2,lightblue -A10000 -Tf45/-62/1c:: -O -K >> %outpsfile%
rem 3. ���м�
gmt psxy %ParentPath%����\SWIR�ֶ�\BTJ-SH_SWIR.txt -R -J -W1p,ROYALBLUE -A -O -K>> %outpsfile%
gmt psxy %ParentPath%����\SWIR�ֶ�\SH-16E_SWIRб�򳬼����Ŷ�.txt -R -J -W1p,MAGENTA1 -A -O -K>> %outpsfile%
gmt psxy %ParentPath%����\SWIR�ֶ�\16E-25E_SWIR���򳬼����Ŷ�.txt -R -J -W1p,ROYALBLUE -A -O -K>> %outpsfile%
gmt psxy %ParentPath%����\SWIR�ֶ�\DT-PE_���Ķ�_SWIR.txt -R -J -W1p,MAGENTA1 -A -O -K>> %outpsfile%
gmt psxy %ParentPath%����\SWIR�ֶ�\ES-GA_SWIR�����.txt -R -J -W1p,ROYALBLUE -A -O -K>> %outpsfile%
gmt psxy %ParentPath%����\SWIR�ֶ�\GA-64E_SWIR������.txt -R -J -W1p,MAGENTA1 -A -O -K>> %outpsfile%
gmt psxy %ParentPath%����\CIR����.txt -R -J -W1p,red -A -O -K>> %outpsfile%
gmt psxy %ParentPath%����\SEIR����.txt -R -J -W1p,red2 -A -O -K>> %outpsfile%
gmt psxy %ParentPath%����\AAR����.txt -R -J -W1p,red2 -A -O -K>> %outpsfile%
gmt psxy %ParentPath%����\MAR����.txt -R -J -W1p,red2 -A -O -K>> %outpsfile%
REM 4. ���ѷֲ�
rem gmt psxy ����\����GPlates������\FZ_cookiecut.xy -R -J -W0.4p,grey -A -O -K>> %outpsfile%
rem ���ת���ϲ㼰�����������
gmt pstext -R -J -F+f12p,black -Gwhite@70 %PsTextPath%\��Ҫ��ת���ϲ㼰�������.dat -O -K>> %outpsfile%
rem �����Ҫ�ĵر�ķ���
gmt psxy -R -J %ParentPath%����\ȫ���ȵ�ֲ�.dat -St0.5p -Gred -W0.1c,red -O -K -V >> %outpsfile%

rem ----------------------------------��Ӵ���������ͼ�������ط������--------------------------------------------------------------------
gmt psbasemap -R-180/180/-70/70 -JM%PreviewSize% -B0 -Gwhite --BASEMAP_TYPE=plain  -X%PreviewMove_X% -O -K -P>> %outpsfile%
rem ��Ӱ��߽�
gmt psxy %ParentPath%����\����GPlates������\Seton_etal_ESR2012_Ridges_2012.1.xy -R -J -W0.2p,red -A -O -K>> %outpsfile%
gmt psxy -R -J %ParentPath%����\ȫ���ȵ�ֲ�.dat -St0.8p -Gred -W0.01p,red -O -K -V >> %outpsfile%

rem ������+½��
gmt pscoast -R -J -A50000 -W0.1 -Glightblue -Di -O -K >> %outpsfile%
gmt psxy %ParentPath%�о�����Χ.txt -R -J -W0.5p,blue -L -A -O -K>> %outpsfile%
rem ----------------------------------��Ӵ���������ͼ�������ط������--------------------------------------------------------------------
del gmt.conf *.history 
del tmp
exit
