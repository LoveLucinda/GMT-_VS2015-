rem ----------------------------------------------------------------------------------------------------------------------------

rem 西南印度洋大区域的GMT绘图代码，郭志馗，2015.11.06
rem 2015.11.25移植到vs2015上进行项目管理（统一管理并进行版本控制）
rem 为了方便访问数据及生成图件，首先需要设置一个总路径（父路径），然后在扎个大的路径下进行操作
rem --------------------------------------------------整体参数设置---------------------------------------------------------------
REM plain 表示常规边框；fancy 表示画火车道边框
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
REM 设置坐标轴边框只有左，下有标注 WSen
gmtset BASEMAP_AXES WSen
REM 图形文件格式
gmtset PSIMAGE_FORMAT hex
cls
rem -----------------------------------------------------针对区域主图的设置---------------------------------------------------------------
set ParentPath=H:\Study\1-博士课题\2_西南印度洋数据\0-大区域-GMT底图\
set RANGE=-20/80/-65/-20
set outpsfile=%ParentPath%研究区底图.ps
set ImageSize=14c
set PreviewSize=3c
set PreviewMove_X=11c
set PsTextPath=%ParentPath%构造及其他的地址单元的坐标与标注
del %outpsfile%
rem -------------------------------------------------------底图绘制------------------------------------------------------------------------
rem 1. basemap
gmt psbasemap -JM30/-40/%ImageSize% -R%RANGE% -B20/10 --BASEMAP_TYPE=fancy -K -P>> %outpsfile%

REM ****************************************************添加其他图件*************************************************************************
rem 2. coast
rem 绘制比例尺和方位指向的背景
echo 28 -61>>tmp
echo 50 -61>>tmp
echo 50 -64.5>>tmp
echo 28 -64.5>>tmp
gmt psxy tmp -R -J -Ggrey -t60 -L -A -O -K>> %outpsfile%
gmt pscoast -R -J -Glightblue -Df -N1 -W0.2,lightblue -A10000 -Lf35/-62.5/-45/1000+l --ANNOT_FONT_SIZE_PRIMARY=8p -Tf46.5/-62.9/0.9c:: -O -K >> %outpsfile%
echo 48 -61.5 N |gmt pstext -R -J -F+f8p,black -O -K>> %outpsfile%
rem gmt pscoast -R -J -Glightblue -Df -N1 -W0.2,lightblue -A10000 -Tf45/-62/1c:: -O -K >> %outpsfile%
rem 3. 洋中脊
gmt psxy %ParentPath%数据\SWIR分段\BTJ-SH_SWIR.txt -R -J -W1p,ROYALBLUE -A -O -K>> %outpsfile%
gmt psxy %ParentPath%数据\SWIR分段\SH-16E_SWIR斜向超级扩张段.txt -R -J -W1p,MAGENTA1 -A -O -K>> %outpsfile%
gmt psxy %ParentPath%数据\SWIR分段\16E-25E_SWIR正向超级扩张段.txt -R -J -W1p,ROYALBLUE -A -O -K>> %outpsfile%
gmt psxy %ParentPath%数据\SWIR分段\DT-PE_第四段_SWIR.txt -R -J -W1p,MAGENTA1 -A -O -K>> %outpsfile%
gmt psxy %ParentPath%数据\SWIR分段\ES-GA_SWIR第五段.txt -R -J -W1p,ROYALBLUE -A -O -K>> %outpsfile%
gmt psxy %ParentPath%数据\SWIR分段\GA-64E_SWIR第六段.txt -R -J -W1p,MAGENTA1 -A -O -K>> %outpsfile%
gmt psxy %ParentPath%数据\CIR脊轴.txt -R -J -W1p,red -A -O -K>> %outpsfile%
gmt psxy %ParentPath%数据\SEIR脊轴.txt -R -J -W1p,red2 -A -O -K>> %outpsfile%
gmt psxy %ParentPath%数据\AAR脊轴.txt -R -J -W1p,red2 -A -O -K>> %outpsfile%
gmt psxy %ParentPath%数据\MAR脊轴.txt -R -J -W1p,red2 -A -O -K>> %outpsfile%
REM 4. 断裂分布
rem gmt psxy 数据\来自GPlates的数据\FZ_cookiecut.xy -R -J -W0.4p,grey -A -O -K>> %outpsfile%
rem 添加转换断层及三联点等名称
gmt pstext -R -J -F+f12p,black -Gwhite@70 %PsTextPath%\主要的转换断层及三联点等.dat -O -K>> %outpsfile%
rem 添加主要的地标的符号
gmt psxy -R -J %ParentPath%数据\全球热点分布.dat -St0.5p -Gred -W0.1c,red -O -K -V >> %outpsfile%

rem ----------------------------------添加大区域缩略图（这个务必放在最后）--------------------------------------------------------------------
gmt psbasemap -R-180/180/-70/70 -JM%PreviewSize% -B0 -Gwhite --BASEMAP_TYPE=plain  -X%PreviewMove_X% -O -K -P>> %outpsfile%
rem 添加板块边界
gmt psxy %ParentPath%数据\来自GPlates的数据\Seton_etal_ESR2012_Ridges_2012.1.xy -R -J -W0.2p,red -A -O -K>> %outpsfile%
gmt psxy -R -J %ParentPath%数据\全球热点分布.dat -St0.8p -Gred -W0.01p,red -O -K -V >> %outpsfile%

rem 海岸线+陆地
gmt pscoast -R -J -A50000 -W0.1 -Glightblue -Di -O -K >> %outpsfile%
gmt psxy %ParentPath%研究区域范围.txt -R -J -W0.5p,blue -L -A -O -K>> %outpsfile%
rem ----------------------------------添加大区域缩略图（这个务必放在最后）--------------------------------------------------------------------
del gmt.conf *.history 
del tmp
exit
