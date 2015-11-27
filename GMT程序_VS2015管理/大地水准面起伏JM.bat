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
gmtset TICK_LENGTH = 0.1c
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
set ParentPath=H:\Study\1-博士课题\2_西南印度洋数据\1-基本数据准备\12-大地水准面起伏\
set infile_nc=%ParentPath%数据\Geoid_EGM96_cut.nc
set RANGE=-20/80/-65/-20
set outpsfile=%ParentPath%成图\Geoid_SWIR.ps
set ImageSize=14c
set PsScalePos_x=7
set gradientf=gradientf_temp.nc
set basecpt=%ParentPath%数据\out.cpt
set realcptfile=%ParentPath%数据\realcpt.cpt
rem 有时候将单位缩小一千倍，可以单独为psscale设置一个cpt文件，与realcptfile对应
set scalecptfile=%realcptfile%
del %outpsfile%
rem -------------------------------------------------------底图绘制------------------------------------------------------------------------
rem 1. basemap
gmt psbasemap -JM30/-40/%ImageSize% -R%RANGE% -B20/10 --BASEMAP_TYPE=fancy -K -P>> %outpsfile%
REM ****************************************************添加其他图件*************************************************************************
rem. 求导数显示立体感
gmt grdgradient %infile_nc% -A0/270 -Ne0.2 -G%gradientf%
rem. image
gmt grd2cpt %infile_nc% -C%basecpt% -Z >%realcptfile%
gmt grdimage %infile_nc% -J -R -C%realcptfile% -I%gradientf% -O -K  -E150 -V >> %outpsfile%
REM ColorScale
gmt psscale -D%PsScalePos_x%/-1/8/.3h -C%scalecptfile% -Ba10f2g10 -By+lmGal -O -P -K -I -V -T60+ggrey -E>> %outpsfile%
rem *****************************************************分割线********************************************************************************

del gmt.conf *.history 
del %gradientf%
exit 