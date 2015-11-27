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
gmtset TICK_LENGTH = 0.1c
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
set ParentPath=H:\Study\1-��ʿ����\2_����ӡ��������\1-��������׼��\12-���ˮ׼�����\
set infile_nc=%ParentPath%����\Geoid_EGM96_cut.nc
set RANGE=-20/80/-65/-20
set outpsfile=%ParentPath%��ͼ\Geoid_SWIR.ps
set ImageSize=14c
set PsScalePos_x=7
set gradientf=gradientf_temp.nc
set basecpt=%ParentPath%����\out.cpt
set realcptfile=%ParentPath%����\realcpt.cpt
rem ��ʱ�򽫵�λ��Сһǧ�������Ե���Ϊpsscale����һ��cpt�ļ�����realcptfile��Ӧ
set scalecptfile=%realcptfile%
del %outpsfile%
rem -------------------------------------------------------��ͼ����------------------------------------------------------------------------
rem 1. basemap
gmt psbasemap -JM30/-40/%ImageSize% -R%RANGE% -B20/10 --BASEMAP_TYPE=fancy -K -P>> %outpsfile%
REM ****************************************************�������ͼ��*************************************************************************
rem. ������ʾ�����
gmt grdgradient %infile_nc% -A0/270 -Ne0.2 -G%gradientf%
rem. image
gmt grd2cpt %infile_nc% -C%basecpt% -Z >%realcptfile%
gmt grdimage %infile_nc% -J -R -C%realcptfile% -I%gradientf% -O -K  -E150 -V >> %outpsfile%
REM ColorScale
gmt psscale -D%PsScalePos_x%/-1/8/.3h -C%scalecptfile% -Ba10f2g10 -By+lmGal -O -P -K -I -V -T60+ggrey -E>> %outpsfile%
rem *****************************************************�ָ���********************************************************************************

del gmt.conf *.history 
del %gradientf%
exit 